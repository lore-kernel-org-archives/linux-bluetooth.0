Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1411369928-14307-1-git-send-email-gowtham.ab@samsung.com>
References: <1411369928-14307-1-git-send-email-gowtham.ab@samsung.com>
Date: Mon, 22 Sep 2014 19:08:27 +0300
Message-ID: <CABBYNZJQhX7xo286JDysjeKFWOsTXpZD9ACgtxWjQXEp+1vp8w@mail.gmail.com>
Subject: Re: [PATCH v3] obexd/src/manager: Fix the double check for agent
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Mon, Sep 22, 2014 at 10:12 AM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Removes the check for NULL agent.
> ---
> agent_free() function contains the NULL check already.
> ---
>  obexd/src/manager.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/obexd/src/manager.c b/obexd/src/manager.c
> index 326e56f..97ae278 100644
> --- a/obexd/src/manager.c
> +++ b/obexd/src/manager.c
> @@ -521,8 +521,7 @@ void manager_cleanup(void)
>
>         /* FIXME: Release agent? */
>
> -       if (agent)
> -               agent_free(agent);
> +       agent_free(agent);
>
>         g_dbus_detach_object_manager(connection);
>
> --
> 1.9.1

Pushed, thanks.


-- 
Luiz Augusto von Dentz
