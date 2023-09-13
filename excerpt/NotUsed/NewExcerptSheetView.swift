//
//  NewExcerptView.swift
//  excerpt
//
//  Created by Richard on 2023/9/10.
//

import SwiftUI

enum PasteMode {
    case auto
    case manual
}

struct NewExcerptSheetView: View {
    @Environment(\.dismiss) var dismiss

    @State private var content: String = ""
    @State private var author: String = ""
    @State private var book: String = ""

    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text(LocalizedStringKey("Content"))) {
                    TextField(LocalizedStringKey("Please enter excerpt content here."), text: $content, axis: .vertical)
                        .lineLimit(6 ... .max)
                }
                Section(header: Text(LocalizedStringKey("Book"))) {
                    TextField(LocalizedStringKey("Please enter the book name here."), text: $book, axis: .vertical)
                }
                Section(header: Text(LocalizedStringKey("Author"))) {
                    TextField(LocalizedStringKey("Please enter the author name here."), text: $author, axis: .vertical)
                }
            }
            .scrollDismissesKeyboard(.interactively)
            .navigationTitle(LocalizedStringKey("New Excerpt"))
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button(LocalizedStringKey("Cancel")) {
                        dismiss()
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button(LocalizedStringKey("Save")) {
//                        dismiss()
                    }
                }
            }
        }
        .interactiveDismissDisabled()
    }
}

#Preview {
    NewExcerptSheetView()
}
