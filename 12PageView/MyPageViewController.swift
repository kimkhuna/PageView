//
//  MyPageViewController.swift
//  12PageView
//
//  Created by 김경훈 on 2022/07/12.
//

import UIKit

class MyPageViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {
 
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    override func viewDidLoad() {
        super.viewDidLoad()
        
        appDelegate.pageVC = self
        
        self.dataSource = self
        self.delegate = self // MyPageView의 Delegate는 자신이 처리하겠다
        
        if let firstVC = viewControllerList.first {
            self.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        }
        
    }
    
    //lazy 변수 : 선언 시ㅏ에 메모리 할당을 하지않고, 참조시에 메모리에 할당. 속도가 느림
    lazy var viewControllerList: [UIViewController] = {
        let sb = UIStoryboard(name: "Main", bundle: nil)
        
        let vc1 = sb.instantiateViewController(withIdentifier: "firstVC")
        let vc2 = sb.instantiateViewController(withIdentifier: "secondVC")
        let vc3 = sb.instantiateViewController(withIdentifier: "thirdVC")
        
        return [vc1, vc2, vc3]
    }()
    
    //MARK: - PageView Data Source
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = viewControllerList.firstIndex(of: viewController)
        else{
            return nil
        }
        let previousIndex = vcIndex - 1
        guard previousIndex >= 0 else {
            return nil
        }
        return viewControllerList[previousIndex]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let vcIndex = viewControllerList.firstIndex(of: viewController)
        else{
            return nil
        }
        let afterIndex = vcIndex + 1
        // Viewcontroller의 개수와 요청한 뷰 인덱스(개수-1) 같으면 nil 반환
        guard viewControllerList.count != afterIndex else {
            return nil
        }
        return viewControllerList[afterIndex]
    }
    
    //코드로 초기화시 기본설정을 할 수 있음
    required init?(coder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    //페이지 이동이 끝났을떄 호출. didFinishAnimation
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        let currentTag = pageViewController.viewControllers!.first!.view.tag
        print(currentTag)
        
        appDelegate.mainVC?.pageControl.currentPage = currentTag
    }
}
