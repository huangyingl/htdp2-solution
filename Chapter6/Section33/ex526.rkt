;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex526) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
(require 2htdp/image)


;; graphic constants
(define SMALL 4)
(define WIDTH 100)
(define HEIGHT 100)
(define background
  (empty-scene WIDTH HEIGHT))

(define COLOR "black")


;; data examples
(define p-a (make-posn 10 10))
(define p-b (make-posn 30 10))
(define p-c (make-posn 20 20))


;; functions
; Image Posn Posn Posn -> Image 
; add the black triangle a, b, c to scene

(check-expect (add-triangle background p-a p-b p-c)
              (scene+polygon background
                             (list p-a p-b p-c)
                             "outline"
                             COLOR))

(define (add-triangle scene a b c)
  (scene+polygon scene
                 (list a b c)
                 "outline"
                 COLOR))
 
; Posn Posn Posn -> Boolean 
; is the triangle a, b, c too small to be divided

(check-expect (too-small? p-a p-b p-c) #false)
(check-expect (too-small? (make-posn 10 5)
                          (make-posn 13 5)
                          (make-posn 13 9))
              #true)

(define (too-small? a b c)
  (local (; Posn Posn -> Number
          ; Produces the distance between the two point.
          (define (distance point-1 point-2)
            (local ((define x1 (posn-x point-1))
                    (define x2 (posn-x point-2))
                    (define y1 (posn-y point-1))
                    (define y2 (posn-y point-2)))
              (sqrt (+ (sqr (- x1 x2)) (sqr (- y1 y2)))))))
    (ormap (lambda (point-pair) (>= SMALL (apply distance point-pair)))
            `((,a ,b) (,a ,c) (,b ,c)))))
 
; Posn Posn -> Posn 
; determine the midpoint between a and b

(check-expect (mid-point p-a p-b) (make-posn 20 10))
(check-expect (mid-point p-b p-c) (make-posn 25 15))

(define (mid-point a b)
  (local ((define x1 (posn-x a))
          (define x2 (posn-x b))
          (define y1 (posn-y a))
          (define y2 (posn-y b)))
    (make-posn (/ (+ x1 x2) 2)
               (/ (+ y1 y2) 2))))
