//
//  GridViewModel+Dijkstra.swift
//  ShortestPathVisualize
//
//  Created by Ayush Rajpal on 5/09/24.
//


import Foundation
import SwiftUI


extension GridViewModel {
    func findPathAStar() {
        findPathDijkstra { left, right -> Int in
            Hex.distance(left, right) * 20
        }
    }
}
