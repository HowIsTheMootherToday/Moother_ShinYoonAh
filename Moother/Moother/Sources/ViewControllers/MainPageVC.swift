//
//  MainPageVC.swift
//  Moother
//
//  Created by SHIN YOON AH on 2021/07/28.
//

import UIKit

import SnapKit

class MainPageVC: UIPageViewController {
    var completeHandler: ((Int) -> ())?
    
    // MARK: - Properties
    var viewsList: [UIViewController] = []
    var currentIndex: Int {
        guard let vc = viewControllers?.first else { return 0 }
        return viewsList.firstIndex(of: vc) ?? 0
    }

    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        pageInit()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
    }
    
    private func pageInit() {
        self.dataSource = self
        self.delegate = self
        
        view.backgroundColor = .clear
        
        let weatherVC = UIViewController(nibName: "WeatherVC", bundle: nil)
        
        viewsList = [weatherVC]
    }
}

extension MainPageVC: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = viewsList.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        if previousIndex < 0 { return nil }
        return viewsList[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = viewsList.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        if nextIndex == viewsList.count { return nil }
        return viewsList[nextIndex]
    }
}

extension MainPageVC: UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if completed {
            completeHandler?(currentIndex)
        }
    }
}
