Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1424698880-14526-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1424698880-14526-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Mon, 23 Feb 2015 16:19:46 +0200
Message-ID: <CABBYNZLn=Go80GNdoc__MPG16CJAVXB6c3ApP4EwL3r5jSQW_A@mail.gmail.com>
Subject: Re: [PATCH] audio/avdtp: Fix session list handling
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Mon, Feb 23, 2015 at 3:41 PM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
>
> Until we move to queue we shall use server->sessions, this will be
> changed in the following patches.
> ---
>  profiles/audio/avdtp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
> index f3d4087..926f01c 100644
> --- a/profiles/audio/avdtp.c
> +++ b/profiles/audio/avdtp.c
> @@ -2394,7 +2394,7 @@ struct avdtp *avdtp_new(struct avdtp_server *server, GSList *sessions,
>
>         session->version = get_version(session);
>
> -       sessions = g_slist_append(sessions, session);
> +       server->sessions = g_slist_append(server->sessions, session);
>
>         if (!chan)
>                 return session;
> --
> 2.1.0

Applied, thanks.


-- 
Luiz Augusto von Dentz
