Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1329143945-4934-2-git-send-email-mikel.astiz.oss@gmail.com>
References: <1329143945-4934-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1329143945-4934-2-git-send-email-mikel.astiz.oss@gmail.com>
Date: Tue, 14 Feb 2012 11:11:49 +0200
Message-ID: <CABBYNZKTfjHKS-jFRF+Vio2Lo08wykOvRgFnvj23bfMP_jO_HQ@mail.gmail.com>
Subject: Re: [PATCH obexd 2/6] client: fix unreported error case
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Mon, Feb 13, 2012 at 4:39 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> The authorization request of a queued transfer could fail, and this
> needs to be reported to the transfer initiator. Otherwise it would
> likely result in D-Bus timeouts.
> ---
>  client/session.c |   13 +++++++++++++
>  1 files changed, 13 insertions(+), 0 deletions(-)
>
> diff --git a/client/session.c b/client/session.c
> index cb46510..ea707b3 100644
> --- a/client/session.c
> +++ b/client/session.c
> @@ -734,6 +734,19 @@ static void session_process_queue(struct obc_session *session)
>                        return;
>                }
>
> +               if (p->func) {
> +                       GError *gerr;
> +
> +                       obc_session_ref(session);
> +                       g_set_error(&gerr, OBEX_IO_ERROR, err,
> +                                                       "Authorization failed");
> +
> +                       p->func(session, gerr, p->data);
> +
> +                       g_error_free(gerr);
> +                       obc_session_unref(session);

Im afraid the ref need to be taken before the while to protect against
the callback calling session_shutdown and end up freeing the session.

-- 
Luiz Augusto von Dentz
