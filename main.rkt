#lang racket/gui

; Ideias: Alterar tamanho da fonte

(define (set-canvas-background-color canvas-object r g b)
  (define color-to-canvas-background (make-object color%))
  (send color-to-canvas-background set r g b)
  (send canvas-object set-canvas-background color-to-canvas-background))

(define (set-text-color text-object r g b)
  (define style-delta (make-object style-delta%))
  (define color-to-text-color (make-object color%))
  (send color-to-text-color set r g b)
  (send style-delta set-delta-foreground color-to-text-color)
  (send style-delta set-family 'default)
  (send text-object change-style style-delta))


(define frame (new frame% 
                   [label "Rktor"] 
                   [width 700] 
                   [height 500]))

(define canvas (new editor-canvas% [parent frame]))
(define text (new text%))
(send canvas set-editor text)



(define menu-bar (new menu-bar% [parent frame]))

(define file-menu (new menu%
                       [label "File"]
                       [parent menu-bar]))

(new menu-item%
     [label "Open file"]
     [parent file-menu]
     [callback (lambda (menu event) 
                 (define file-string-content  
                   (file->string (path->string (get-file))))

                 ;TODO: Deletar conteudo existente no arquivo
                 ;Ideia: Abrir nova guia seria uma boa
                 ;(send text delete 'start 'back)
                 (send text insert file-string-content))])

(define theme-menu (new menu%
                        [label "Theme"]
                        [parent menu-bar]))

(new menu-item%
     [label "Theme 1"]
     [parent theme-menu]
     [callback (lambda (menu event) 
                 (set-canvas-background-color canvas 0 0 0)
                 (set-text-color text 255 255 255))])

(new menu-item%
     [label "Theme 2"]
     [parent theme-menu]
     [callback (lambda (menu event) 
                 (set-canvas-background-color canvas 40 42 54)
                 (set-text-color text 248 248 242))])


(set-canvas-background-color canvas 40 42 54)
(set-text-color text 248 248 242)

(send frame show #t)
