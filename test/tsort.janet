(import ../tsort :prefix "" :only [tsort])

(defn- test-scenario
  [input output]
  # For debugging
  #(pp (tuple ;(catseq [v :in (fiber/new (fn [] (tsort ;input)))] (sorted v))))
  (assert
    (=
      output
      (tuple ;(catseq [v :in (fiber/new (fn [] (tsort ;input)))] (sorted v))))))

(test-scenario
  [[:a :b]
   [:b :c]
   [:d]]
  [:c :d :b :a])

(test-scenario
  [[:a :b]
   [:a :a2]
   [:b :c]
   [:c :d]
   [:d]]
  [:a2 :d :c :b :a])

(assert
  (=
    "At least one cycle exists"
    (last
      (protect
        (test-scenario
          [[:a :b]
           [:b :a]]
          [])))))
