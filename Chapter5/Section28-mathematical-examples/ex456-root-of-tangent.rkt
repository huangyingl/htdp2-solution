;; The first three lines of this file were inserted by DrRacket. They record metadata
;; about the language level of this file in a form that our tools can easily process.
#reader(lib "htdp-intermediate-lambda-reader.ss" "lang")((modname ex456-root-of-tangent) (read-case-sensitive #t) (teachpacks ()) (htdp-settings #(#t constructor repeating-decimal #f #t none #f () #f)))
;; constants
(define EPSILON 0.5)

; Number -> Number
(define (func-1 x) (add1 x))

; Number -> Number
(define (func-2 x) (sqr (+ x 0.5)))


; functions
; [Number -> Number] Number -> Number
; maps function f and r1 to the slope of f at r1.

(check-expect (slope func-1 1.5)
              1)
(check-expect (slope func-2 1.5)
              4)

(define (slope f r1)
  (/ (- (f (+ r1 EPSILON))
        (f (- r1 EPSILON)))
     (* 2 EPSILON)))


; [Number -> Number] Number -> Number
; maps f and r1 to the root of the tangent through (r1, (f r1)).

(check-expect (root-of-tangent func-1 1.5) -1)
(check-expect (root-of-tangent func-2 1.5) 0.5)

(define (root-of-tangent f r1)
  (- r1 (/ (f r1) (slope f r1))))

