//
//  Example3.swift
//  AutosizeContainer
//
//  Created by Don Mag on 5/25/20.
//  Copyright © 2020 Don Mag. All rights reserved.
//

import UIKit

var hight = UIScreen.main.bounds.height - 140

class Example3ViewController: UIViewController {
	
	@IBOutlet var topContainerView: UIView!
	@IBOutlet var topContainerViewHeightConstraint: NSLayoutConstraint!
	var topPageViewController: TopPageViewController!
	
	@IBOutlet var bottomContainerView: UIView!
	var bottomPageViewController: BottomPageViewController!

	var layoutDone: Bool = false
	
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let dest = segue.destination as? TopPageViewController {
			topPageViewController = dest
		}
		if let dest = segue.destination as? BottomPageViewController {
			bottomPageViewController = dest
		}
    }

}

class TopPageViewController: UIPageViewController {
	
	var orderedViewControllers: [UIViewController] = [UIViewController]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		guard let vc1 = storyboard?.instantiateViewController(withIdentifier: "TopPage1"),
		let vc2 = storyboard?.instantiateViewController(withIdentifier: "TopPage2"),
		let vc3 = storyboard?.instantiateViewController(withIdentifier: "TopPage3")
		else {
			fatalError("Error instantiating top pages!")
		}
		orderedViewControllers.append(contentsOf: [vc1, vc2, vc3])
		
		dataSource = self
		
		if let firstViewController = orderedViewControllers.first {
			setViewControllers([firstViewController],
							   direction: .forward,
							   animated: true,
							   completion: nil)
		}

	}

}

extension TopPageViewController: UIPageViewControllerDataSource {
	
	func pageViewController(_ pageViewController: UIPageViewController,
							viewControllerBefore viewController: UIViewController) -> UIViewController? {
		guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
			return nil
		}
		
		let previousIndex = viewControllerIndex - 1
		
		// User is on the first view controller and swiped left to loop to
		// the last view controller.
		guard previousIndex >= 0 else {
			return orderedViewControllers.last
		}
		
		guard orderedViewControllers.count > previousIndex else {
			return nil
		}
		
		return orderedViewControllers[previousIndex]
	}
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		
		guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
			return nil
		}
		
		let nextIndex = viewControllerIndex + 1
		let orderedViewControllersCount = orderedViewControllers.count
		
		// User is on the last view controller and swiped right to loop to
		// the first view controller.
		guard orderedViewControllersCount != nextIndex else {
			return orderedViewControllers.first
		}
		
		guard orderedViewControllersCount > nextIndex else {
			return nil
		}
		
		return orderedViewControllers[nextIndex]
	}
	
}

class BottomPageViewController: UIPageViewController {
	
	var orderedViewControllers: [UIViewController] = [UIViewController]()
	
	override func viewDidLoad() {
		super.viewDidLoad()
		guard let vc1 = storyboard?.instantiateViewController(withIdentifier: "BottomPage1"),
			let vc2 = storyboard?.instantiateViewController(withIdentifier: "BottomPage2"),
			let vc3 = storyboard?.instantiateViewController(withIdentifier: "BottomPage3"),
			let vc4 = storyboard?.instantiateViewController(withIdentifier: "BottomPage4")
			else {
				fatalError("Error instantiating bottom pages!")
		}
		orderedViewControllers.append(contentsOf: [vc1, vc2, vc3, vc4])

		dataSource = self
		
		if let firstViewController = orderedViewControllers.first {
			setViewControllers([firstViewController],
							   direction: .forward,
							   animated: true,
							   completion: nil)
		}
		
	}
	
}

extension BottomPageViewController: UIPageViewControllerDataSource {
	
	func pageViewController(_ pageViewController: UIPageViewController,
							viewControllerBefore viewController: UIViewController) -> UIViewController? {
		guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
			return nil
		}
		
		let previousIndex = viewControllerIndex - 1
		
		// User is on the first view controller and swiped left to loop to
		// the last view controller.
		guard previousIndex >= 0 else {
			return orderedViewControllers.last
		}
		
		guard orderedViewControllers.count > previousIndex else {
			return nil
		}
		
		return orderedViewControllers[previousIndex]
	}
	
	func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
		
		guard let viewControllerIndex = orderedViewControllers.firstIndex(of: viewController) else {
			return nil
		}
		
		let nextIndex = viewControllerIndex + 1
		let orderedViewControllersCount = orderedViewControllers.count
		
		// User is on the last view controller and swiped right to loop to
		// the first view controller.
		guard orderedViewControllersCount != nextIndex else {
			return orderedViewControllers.first
		}
		
		guard orderedViewControllersCount > nextIndex else {
			return nil
		}
		
		return orderedViewControllers[nextIndex]
	}
	
}

// just for example - rounding corners of first subview
class BasePageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
	
    @IBOutlet weak var tableView: UITableView!
    
    let topPageHeight: CGFloat = 140
   
    override func viewDidLoad() {
		super.viewDidLoad()

		guard let bkgView = view.subviews.first else {
			fatalError("Individual Page Views not setup correctly!")
		}
        
		bkgView.layer.cornerRadius = 8.0
		bkgView.layer.shadowColor = UIColor.black.cgColor
		bkgView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
		bkgView.layer.shadowRadius = 2.0
		bkgView.layer.shadowOpacity = 0.35

	}
	
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return hight+topPageHeight
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return hight+topPageHeight
    }
}
