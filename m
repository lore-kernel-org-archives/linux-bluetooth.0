Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1360764149-26447-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1360764149-26447-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Date: Fri, 22 Feb 2013 10:45:47 +0200
Message-ID: <CABBYNZKYPancy0ncHxuAiKt9ib55MoyoZypCsurbQe=2UEc0BQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] obexd: Remove obc_session_setpath limit
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Christian,

On Wed, Feb 13, 2013 at 4:02 PM, Christian Fetzer
<christian.fetzer@oss.bmw-carit.de> wrote:
> From: Christian Fetzer <christian.fetzer@bmw-carit.de>
>
> obc_session_setpath is able to handle multiple folder changes at once.
> This removes the limit, that was introduced because of PBAP's limitation
> to 3 levels (75d32c6b3a3bddaad19b7880950f9a503afe652b).
>
> Other profiles like MAP might have deeper folder hierarchies.
> ---
>  obexd/client/session.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/obexd/client/session.c b/obexd/client/session.c
> index db37a86..f8aae5d 100644
> --- a/obexd/client/session.c
> +++ b/obexd/client/session.c
> @@ -929,7 +929,7 @@ guint obc_session_setpath(struct obc_session *session, const char *path,
>         data = g_new0(struct setpath_data, 1);
>         data->func = func;
>         data->user_data = user_data;
> -       data->remaining = g_strsplit(path, "/", 3);
> +       data->remaining = g_strsplit(path, "/", 0);
>
>         p = pending_request_new(session, NULL, setpath_complete, data);
>
> --
> 1.8.1.3

This set is now upstream, thanks.


-- 
Luiz Augusto von Dentz
