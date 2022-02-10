module Web.View.Static.Welcome where
import Web.View.Prelude

data WelcomeView = WelcomeView

instance View WelcomeView where
    html WelcomeView = [hsx|
         <div style="background-color: #657b83; padding-top: 2rem; padding-bottom: 2rem; color:hsla(196, 13%, 96%, 1); border-radius: 4px">
            <h1 style="padding: 2rem">A Blog</h1>
            <p style="padding: 2rem">Checkout my <a href={PostsAction}>Posts</a></p>
         </div> 
|]