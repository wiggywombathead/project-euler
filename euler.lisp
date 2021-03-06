(defun problem1 (n)
  "Computes the sum of multiples of 3 and/or 5 less than n"
  (let ((sum 0))
	(loop for i from 3 to n do
		  (if (or (= (mod i 3) 0) (= (mod i 5) 0))
			(incf sum i)))
	(return-from problem1 sum)))

(defun problem2 (n)
  "Computes the sum of even Fibonacci numbers less than n"
  (let ((a 1)
		(b 2)
		(c)
		(sum 2))
	(loop while (<= (+ a b) n) do
		  (setf c (+ a b))
		  (if (= (mod c 2) 0)
			(incf sum c))
		  (setf a b)
		  (setf b c))
	(return-from problem2 sum)))

(defun get-factors (n)
  "Return a list of factors of n"
  (let ((factors '()) (root (+ 1 (isqrt n))))
	(loop for i from 2 to root do
		  (if (= 0 (mod n i))
			(if (/= i (/ n i))
			  (setf factors (append (list i (/ n i)) factors))
			  (setf factors (cons i factors)))))
	(return-from get-factors (remove-duplicates (sort factors #'>)))))

(defun prime-p (n)
  "Returns whether n is prime"
  ; first check whether n == 2 or n is even
  (if (= n 2)
	(return-from prime-p t))
  (if (= 0 (mod n 2))
	(return-from prime-p nil))

  (let ((root (+ 1 (isqrt n))))
	(loop for i from 3 to root by 2 do
		(if (= 0 (mod n i))
		  (return-from prime-p nil)))
	(return-from prime-p t)))

(defun problem3 (n)
  "Computes the largest prime factor of n"
  (let ((factors (get-factors n))
		(max 0))
	(loop for f in factors do
		  (if (and (prime-p f) (> f max))
			(setf max f)))
	(return-from problem3 max)))

(defun palindrome-p (n)
  (let ((str (write-to-string n)))
	(string= str (reverse str))))

(defun largest-palindrome (n)
  "Compute largest palindrome that is product of two n-digit numbers"
  (let ((max 0)
		(start (expt 10 (- n 1)))
		(end (- (expt 10 n) 1)))
	(loop for i from start to end do
		  (loop for j from start to end do
				(let ((prod (* i j)))
				  (if (and (palindrome-p prod) (> prod max))
					(setf max prod)))))
	(return-from largest-palindrome max)))

(defun problem4 ()
  "Compute largest palindrome product of two 3-digit numbers"
  (largest-palindrome 3))

(defun problem5 (n)
  "Compute smallest number divisible by all numbers 2..n"
  (let ((a 1))
	(loop for i from 2 to n do
		  (setf a (lcm a i)))
	(return-from problem5 a)))

(defun problem6 (n)
  "Difference between sum of squares and square of sum"
  (let ((nums (loop for i from 1 to n collect i))
		(sum-squares)
		(square-sum))
	(setf sum-squares (apply '+ (mapcar (lambda (x) (* x x)) nums)))
	(setf square-sum (expt (apply '+ nums) 2))
	(- square-sum sum-squares)))

(defun problem7 (n)
  "nth prime number"
  ())

(defun main ()
  (prin1 (problem6 10)))

(main)
