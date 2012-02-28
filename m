Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1330352077-1196-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1330352077-1196-1-git-send-email-mikel.astiz.oss@gmail.com>
Date: Tue, 28 Feb 2012 14:10:53 +0200
Message-ID: <CABBYNZLVYRV2K3yvJ-cetdg-7ZzcNCYg4NHvmiPnSm1Kx-zC2A@mail.gmail.com>
Subject: Re: [PATCH obexd] client: fix unreported canceled transfers
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Mon, Feb 27, 2012 at 4:14 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> A session can be shutted down from D-Bus, and therefore the pending
> transfer callbacks must be reported.
> ---
>  client/session.c  |   15 ++++++++++++++-
>  client/transfer.c |    4 +---
>  client/transfer.h |    3 +++
>  3 files changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/client/session.c b/client/session.c
> index 417295e..f5740ce 100644
> --- a/client/session.c
> +++ b/client/session.c
> @@ -485,12 +485,25 @@ proceed:
>
>  void obc_session_shutdown(struct obc_session *session)
>  {
> +       struct pending_request *p;
> +       GError *err;
> +
>        DBG("%p", session);
>
>        obc_session_ref(session);
>
>        /* Unregister any pending transfer */
> -       g_queue_foreach(session->queue, (GFunc) pending_request_free, NULL);
> +       err = g_error_new(OBC_TRANSFER_ERROR, -ECANCELED, "%s",
> +                                                       strerror(ECANCELED));

I would use a specific error for this, OBEX_IO_DISCONNECTED or
something like that belongs to session. Btw, session->p should also be
cancelled as well.


-- 
Luiz Augusto von Dentz
