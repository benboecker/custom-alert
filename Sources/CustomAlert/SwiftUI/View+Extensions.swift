//
//  File.swift
//  
//
//  Created by Benjamin Böcker on 11.03.24.
//

import Foundation
import SwiftUI


struct AlertModifier<AlertContent: View>: ViewModifier {
	init(presentAlert: Binding<Bool>, stretchHorizontally: Bool, stretchVertically: Bool, @ViewBuilder alertContent: @escaping () -> AlertContent) {
		self._presentAlert = presentAlert
		self.alertContent = alertContent
		self.stretchHorizontally = stretchHorizontally
		self.stretchVertically = stretchVertically

	}
	
	@Binding private var presentAlert: Bool
	private let alertContent: () -> AlertContent
	private let stretchHorizontally: Bool
	private let stretchVertically: Bool
	
	func body(content: Content) -> some View {
		CustomAlertControllerRepresentable(presentAlert: $presentAlert, stretchHorizontally: stretchHorizontally, stretchVertically: stretchVertically, content: { content }, alertContent: alertContent)
			.ignoresSafeArea()
	}
}


public extension View {
	func customAlert<AlertContent: View>(
		presentAlert: Binding<Bool>,
		stretchHorizontally: Bool = false,
		stretchVertically: Bool = false,
		@ViewBuilder alertContent: @escaping () -> AlertContent
	) -> some View {
		modifier(AlertModifier(presentAlert: presentAlert, stretchHorizontally: stretchHorizontally, stretchVertically: stretchVertically, alertContent: alertContent))
	}
}
