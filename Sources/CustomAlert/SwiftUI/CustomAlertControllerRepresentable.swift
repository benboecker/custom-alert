//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 13.03.24.
//

import Foundation
import SwiftUI
import UIKit


struct CustomAlertControllerRepresentable<Content: View, AlertContent: View>: UIViewControllerRepresentable {	
	init(
		presentAlert: Binding<Bool>,
		stretchHorizontally: Bool,
		stretchVertically: Bool,
		@ViewBuilder content: @escaping () -> Content,
		@ViewBuilder alertContent: @escaping () -> AlertContent
	) {
		self.content = content
		self.alertContent = alertContent
		self.stretchHorizontally = stretchHorizontally
		self.stretchVertically = stretchVertically
		self._presentAlert = presentAlert
	}
	
	private let content: () -> Content
	private let alertContent: () -> AlertContent
	private let stretchHorizontally: Bool
	private let stretchVertically: Bool
	@Binding private var presentAlert: Bool

	func makeUIViewController(context: Context) -> some UIViewController {
		let hostingController = UIHostingController(rootView: content())		
		let viewController = UIViewController()
		viewController.addChild(hostingController)
		hostingController.view.frame = viewController.view.frame
		viewController.view.addSubview(hostingController.view)
		hostingController.didMove(toParent: viewController)

		NSLayoutConstraint.activate([
			viewController.view.leadingAnchor.constraint(equalTo: hostingController.view.leadingAnchor),
			viewController.view.topAnchor.constraint(equalTo: hostingController.view.topAnchor),
			viewController.view.bottomAnchor.constraint(equalTo: hostingController.view.bottomAnchor),
			viewController.view.trailingAnchor.constraint(equalTo: hostingController.view.trailingAnchor),
		])
		
		return viewController
	}

	func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
		if presentAlert {
			let alertController = UIHostingController(
				rootView: alertContent()
			)
			alertController.sizingOptions = .intrinsicContentSize

			AlertPresenter.shared.present(alertController, expandHorizontally: stretchHorizontally, expandVertically: stretchVertically)
		} else {
			AlertPresenter.shared.dismissAlert()
		}
	}
}


private extension CustomAlertControllerRepresentable {
	func listener() {
		
		
	}
}
