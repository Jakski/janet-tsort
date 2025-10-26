(defn tsort
  [& edges]
  (def nodes @{})
  (each edges edges
    (when (> 1 (length edges))
      (error "Node edges definition must contain at least 1 element"))
    (def node (first edges))
    (def node-deps
      (if-let [deps (nodes node)]
        deps
        (set (nodes node) @{})))
    (each dep (slice edges 1)
      (when (= nil (nodes dep))
        (set (nodes dep) @{}))
      (set (node-deps dep) true)))
  (while true
    (def ready-nodes
      (map |(first $) (filter |(= 0 (length (last $))) (pairs nodes))))
    (when (= 0 (length ready-nodes))
      (when (not= 0 (length nodes))
        (error "At least one cycle exists"))
      (break))
    (yield ready-nodes)
    (each ready-node ready-nodes
      (each deps nodes
        (put deps ready-node nil))
      (put nodes ready-node nil))))
