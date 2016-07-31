require 'spec_helper'
require_relative '../../../../apps/web/views/books/index'

describe Web::Views::Books::Index do
  let(:exposures) { Hash[books: []] }
  let(:template)  { Hanami::View::Template.new('apps/web/templates/books/index.html.erb') }
  let(:view)      { Web::Views::Books::Index.new(template, exposures) }
  let(:rendered)  { view.render }

  it 'exposes #books' do
    view.books.must_equal exposures.fetch(:books)
  end

  describe 'when there are no books' do
    it 'shows a placeholder message' do
      rendered.must_include '<p class="placeholder">There are no books yet.</p>'
    end
  end

  describe 'where there are books' do
    let(:books) do
      [
        { title: 'Refactoring', author: 'Martin Fowler' },
        { title: 'Domain Driven Design', author: 'Eric Evans' }
      ].map { |attrs| Book.new(attrs) }
    end
    let(:exposures) { Hash[books: books] }

    it 'lists all the books' do
      rendered.scan(/class="book"/).count.must_equal 2
      rendered.must_include 'Refactoring'
      rendered.must_include 'Domain Driven Design'
    end

    it 'hides the placeholder message' do
      rendered.wont_include '<p class="placeholder">There are no books yet.</p>'
    end
  end
end
