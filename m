Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1334065112-14966-3-git-send-email-mikel.astiz.oss@gmail.com>
References: <1334065112-14966-1-git-send-email-mikel.astiz.oss@gmail.com>
	<1334065112-14966-3-git-send-email-mikel.astiz.oss@gmail.com>
Date: Thu, 12 Apr 2012 13:31:27 +0300
Message-ID: <CABBYNZKUJaiEC4H6VXoPVPvdUwNgHK5fukvgTfLNbRbWNv2axQ@mail.gmail.com>
Subject: Re: [PATCH obexd v1 02/11] client: remove unused field
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Tue, Apr 10, 2012 at 4:38 PM, Mikel Astiz <mikel.astiz.oss@gmail.com> wrote:
> From: Mikel Astiz <mikel.astiz@bmw-carit.de>
>
> The errorcode field is set but never used, so it can safely be removed.
> In addition there is no need for such a field, because errors can be
> propagated using the available callback.
> ---
>  client/transfer.c |   22 +++++-----------------
>  1 files changed, 5 insertions(+), 17 deletions(-)
>
> diff --git a/client/transfer.c b/client/transfer.c
> index 988ec10..a609aa9 100644
> --- a/client/transfer.c
> +++ b/client/transfer.c
> @@ -70,7 +70,6 @@ struct obc_transfer {
>        int filled;
>        gint64 size;
>        gint64 transferred;
> -       int err;
>  };
>
>  static GQuark obc_transfer_error_quark(void)
> @@ -310,10 +309,8 @@ static void get_buf_xfer_complete(GObex *obex, GError *err, gpointer user_data)
>
>        transfer->xfer = 0;
>
> -       if (err) {
> -               transfer->err = err->code;
> +       if (err)
>                goto done;
> -       }
>
>        if (transfer->filled > 0 &&
>                        transfer->buffer[transfer->filled - 1] == '\0')
> @@ -407,14 +404,9 @@ static void xfer_complete(GObex *obex, GError *err, gpointer user_data)
>
>        transfer->xfer = 0;
>
> -       if (err) {
> -               transfer->err = err->code;
> -               goto done;
> -       }
> -
> -       transfer->size = transfer->transferred;
> +       if (err == NULL)
> +               transfer->size = transfer->transferred;
>
> -done:
>        if (callback)
>                callback->func(transfer, transfer->size, err, callback->data);
>  }
> @@ -431,10 +423,8 @@ static gboolean get_xfer_progress(const void *buf, gsize len,
>                gint w;
>
>                w = write(transfer->fd, transfer->buffer, transfer->filled);
> -               if (w < 0) {
> -                       transfer->err = -errno;
> +               if (w < 0)
>                        return FALSE;
> -               }
>
>                transfer->filled -= w;
>        }
> @@ -478,10 +468,8 @@ static gssize put_xfer_progress(void *buf, gsize len, gpointer user_data)
>        gssize size;
>
>        size = read(transfer->fd, buf, len);
> -       if (size <= 0) {
> -               transfer->err = -errno;
> +       if (size <= 0)
>                return size;
> -       }
>
>        if (callback)
>                callback->func(transfer, transfer->transferred, NULL,
> --
> 1.7.7.6

Ack.

-- 
Luiz Augusto von Dentz
