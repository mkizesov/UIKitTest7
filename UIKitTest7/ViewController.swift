//
//  SceneDelegate.swift
//  UIKitTest7
//
//  Created by M K on 19.02.2024.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    var damnImageView: UIImageView!
    var scrollView: UIScrollView!
    var contentView: UIView!
    let imageViewHeight: CGFloat = 270

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        setupScrollView()
        setupImageView()
    }

    func setupScrollView() {
        scrollView = UIScrollView(frame: view.bounds)
        scrollView.delegate = self
        scrollView.alwaysBounceVertical = true
        scrollView.contentInset = UIEdgeInsets(top: imageViewHeight, left: 0, bottom: 0, right: 0)
        view.addSubview(scrollView)
        contentView = UIView(frame: CGRect(x: 0, y: 0, width: scrollView.bounds.width, height: 1500))
        contentView.backgroundColor = .systemGray6
        scrollView.addSubview(contentView)
        scrollView.contentSize = contentView.bounds.size
    }

    func setupImageView() {
        damnImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: imageViewHeight))
        let url = URL(string: "https://ru.meming.world/images/ru/2/28/Short_Keanu_Reeves.jpg")
        let data = try? Data(contentsOf: url!)
        damnImageView.image = UIImage(data: data!)
        scrollView.addSubview(damnImageView)
    }
    
    override func viewDidLayoutSubviews() {
        // Adjust Y because view.safeAreaInsets contains 0 in viewDidLoad
        contentView.frame = CGRect(x: 0, y: -view.safeAreaInsets.top, width: scrollView.bounds.width, height: 1500 + view.safeAreaInsets.top + view.safeAreaInsets.bottom)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let imageView = damnImageView else { return }

        let offsetY = scrollView.contentOffset.y
        if offsetY <= -imageViewHeight - view.safeAreaInsets.top {
            let newHeight = -offsetY - view.safeAreaInsets.top
            imageView.frame = CGRect(x: 0, y: offsetY, width: view.bounds.width, height: newHeight)
            scrollView.verticalScrollIndicatorInsets.top = newHeight - view.safeAreaInsets.top
        }
    }
}
