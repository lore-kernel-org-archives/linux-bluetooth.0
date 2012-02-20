Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1329742172-12124-1-git-send-email-jaganath.k@samsung.com>
References: <1329742172-12124-1-git-send-email-jaganath.k@samsung.com>
Date: Mon, 20 Feb 2012 15:23:56 +0200
Message-ID: <CABBYNZLNPeRkTbyoJ7a82SmVehmvTosTDqX0zjy_-eZRMS=ALA@mail.gmail.com>
Subject: Re: [PATCH obexd] client: Fix ABORT command not sending when user
 cancels the transfer
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Jaganath Kanakkassery <jaganath.k@samsung.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Mon, Feb 20, 2012 at 2:49 PM, Jaganath Kanakkassery
<jaganath.k@samsung.com> wrote:
> Issue: When user cancels the tranfer, after queuing the ABORT command
> transfer->callback() with error will be called. In that session_unref
> is called which disconnects the transport.

I don't get the issue, you don't want to disconnect immediately if the
transfer aborts and the last reference is released? IMO that is fine
in most of the cases, btw by disconnecting it also serves as an ABORT.
The only cases where we would not do it is if the session object is
created, e.g. ftp, but if that happens than the module is responsible
to hold a reference to the session preventing it to disconnect.

> diff --git a/gobex/gobex-transfer.c b/gobex/gobex-transfer.c
> index c62a91e..706952f 100644
> --- a/gobex/gobex-transfer.c
> +++ b/gobex/gobex-transfer.c
> @@ -635,6 +635,10 @@ gboolean g_obex_cancel_transfer(guint id)
>        if (transfer == NULL)
>                return FALSE;
>
> -       transfer_free(transfer);
> +       if (transfer->req_id > 0)
> +               g_obex_cancel_req(transfer->obex, transfer->req_id, FALSE);
> +       else
> +               transfer_free(transfer);
> +
>        return TRUE;
>  }

Btw, when you changing gobex please send its changes separately
starting with gobex:, so not that after g_obex_cancel_transfer the id
and callback should no longer be accessible so the application should
be able to free its resources, so if we call the callback latter it
will very likely cause a crash.

-- 
Luiz Augusto von Dentz
