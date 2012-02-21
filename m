Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1329813983-26707-5-git-send-email-mikel.astiz.oss@gmail.com>
References: <1329813983-26707-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1329813983-26707-5-git-send-email-mikel.astiz.oss@gmail.com>
Date: Tue, 21 Feb 2012 13:27:22 +0200
Message-ID: <CABBYNZL1GWNdW-XUxZ7R4H+hknpmdpDPabGcNfOWDP5xnGzwbQ@mail.gmail.com>
Subject: Re: [PATCH obexd 4/9] client: remove unnecessary code
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, Feb 21, 2012 at 10:46 AM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> No pending requests will exist when session_free is reached, given that
> pending transfes always hold a reference to the session.
> ---
>  client/session.c |    8 +-------
>  1 files changed, 1 insertions(+), 7 deletions(-)
>
> diff --git a/client/session.c b/client/session.c
> index e113d1f..160e015 100644
> --- a/client/session.c
> +++ b/client/session.c
> @@ -179,11 +179,8 @@ static void session_free(struct obc_session *session)
>                obc_agent_free(session->agent);
>        }
>
> -       if (session->queue) {
> -               g_queue_foreach(session->queue, (GFunc) pending_request_free,
> -                                                                       NULL);
> +       if (session->queue)
>                g_queue_free(session->queue);
> -       }
>
>        if (session->watch)
>                g_dbus_remove_watch(session->conn, session->watch);
> @@ -200,9 +197,6 @@ static void session_free(struct obc_session *session)
>        if (session->conn)
>                dbus_connection_unref(session->conn);
>
> -       if (session->p)
> -               pending_request_free(session->p);
> -
>        sessions = g_slist_remove(sessions, session);
>
>        g_free(session->path);
> --
> 1.7.6.5

Maybe some error here would be better, actually it should be fine to
keep as it is to avoid leaking memory and be more robust with changes
in the references, in the other hand printing an error on unref when
it is < 0 should hint that something is broken in refcount.

-- 
Luiz Augusto von Dentz
