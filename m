Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1285770456-8457-1-git-send-email-luiz.dentz@gmail.com>
References: <1285770456-8457-1-git-send-email-luiz.dentz@gmail.com>
Date: Wed, 29 Sep 2010 23:26:48 +0300
Message-ID: <AANLkTimEQ4JQ_7FH6XV+Ja2Wia0w8ZgZG+L=s2M0Z8yf@mail.gmail.com>
Subject: Re: [PATCH] Fix not detecting errors on small files
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Wed, Sep 29, 2010 at 5:27 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>
>
> When flushing the last part of buffer/file we have to wait for response
> since that can contain errors.
>
> To fix this gw_obex_xfer_close is called in order to force gwobex to
> resume the request and return any error related to it.
> ---
>  client/transfer.c |    9 +++++++--
>  1 files changed, 7 insertions(+), 2 deletions(-)
>
> diff --git a/client/transfer.c b/client/transfer.c
> index 8ceb36f..e5fcfcc 100644
> --- a/client/transfer.c
> +++ b/client/transfer.c
> @@ -360,7 +360,7 @@ static void put_xfer_progress(GwObexXfer *xfer, gpointer user_data)
>  {
>        struct transfer_data *transfer = user_data;
>        struct transfer_callback *callback = transfer->callback;
> -       gint written, err = 0;
> +       gint written = 0, err = 0;
>
>        if (transfer->buffer_len == 0) {
>                transfer->buffer_len = DEFAULT_BUFFER_SIZE;
> @@ -380,7 +380,12 @@ static void put_xfer_progress(GwObexXfer *xfer, gpointer user_data)
>                transfer->filled += len;
>
>                if (transfer->filled == 0) {
> -                       gw_obex_xfer_flush(xfer, &err);
> +                       if (written > 0) {
> +                               gw_obex_xfer_flush(xfer, &err);
> +                               return;
> +                       }
> +
> +                       gw_obex_xfer_close(xfer, &err);
>                        goto done;
>                }

Actually I might simplify even more by not returning when flushing the
transfer, at that point we don't have anything else to write so
returning and waiting for gwobex to call it again is just a wait of
time, so please ignore this for now.

-- 
Luiz Augusto von Dentz
Computer Engineer
