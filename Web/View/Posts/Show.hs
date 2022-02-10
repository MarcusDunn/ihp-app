module Web.View.Posts.Show where
import Web.View.Prelude
import Web.View.Prelude (Post'(createdAt))
import qualified Text.MMark as MMark
import IHP.MailPrelude (dateTime, timeAgo, preEscapedToHtml)

data ShowView = ShowView { post :: Include "comments" Post }

instance View ShowView where
    html ShowView { .. } = [hsx|
        {breadcrumb}
        <h1>{get #title post}</h1>
        <p>{get #createdAt post |> timeAgo}</p>
        <div>{get #body post |> renderMarkdown}</div>
        <a href={NewCommentAction (get #id post)}>Add Comment</a>
        <div>{forEach (get #comments post) renderComment}</div>
    |]
        where
            breadcrumb = renderBreadcrumb
                            [ breadcrumbLink "Posts" PostsAction
                            , breadcrumbText "Show Post"
                            ]
            renderMarkdown text = case text |> MMark.parse "" of
                    Left error -> "Something went wrong."
                    Right markdown -> MMark.render markdown |> tshow |> preEscapedToHtml
            renderComment comment = [hsx|
                <div class="mt-4">
                    <h5>{get #author comment}</h5>
                    <p>{get #createdAt comment |> timeAgo}</p>
                    <p>{get #body comment}</p>
                </div>
            |]