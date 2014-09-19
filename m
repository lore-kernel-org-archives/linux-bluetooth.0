Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1411130719-15832-1-git-send-email-gowtham.ab@samsung.com>
References: <1411130719-15832-1-git-send-email-gowtham.ab@samsung.com>
Date: Fri, 19 Sep 2014 16:01:18 +0300
Message-ID: <CABBYNZJ++9RgUU8VrZQbUW75m==akdOX7Ceo6WfVF8zPcV9dEg@mail.gmail.com>
Subject: Re: [PATCH] obexd/src/manager: Fix the double check for agent
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Fri, Sep 19, 2014 at 3:45 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Removes the check for NULL agent and fix the
> coding style for enum.
> ---
> agent_free() function contains the NULL check already.
> ---
>  obexd/src/manager.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/obexd/src/manager.c b/obexd/src/manager.c
> index 326e56f..9c6623e 100644
> --- a/obexd/src/manager.c
> +++ b/obexd/src/manager.c
> @@ -64,7 +64,7 @@ struct agent {
>  };
>
>  enum {
> -       TRANSFER_STATUS_QUEUED = 0,
> +       TRANSFER_STATUS_QUEUED =        0,
>         TRANSFER_STATUS_ACTIVE,
>         TRANSFER_STATUS_COMPLETE,
>         TRANSFER_STATUS_ERROR
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

Please split the coding style fix.


-- 
Luiz Augusto von Dentz
