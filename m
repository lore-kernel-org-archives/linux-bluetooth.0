Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1288689911-18507-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
References: <1288689911-18507-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Date: Tue, 2 Nov 2010 14:05:51 +0200
Message-ID: <AANLkTikVy3mR0ZmcUCUH5p5VMFQzLcwaP3aQoLj9GLAC@mail.gmail.com>
Subject: Re: [PATCH v2] Add support for sending small data through obex
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Tue, Nov 2, 2010 at 11:25 AM, Radoslaw Jablonski
<ext-jablonski.radoslaw@nokia.com> wrote:
> Added handling packets smaller than mtu in obex_write_stream. Now trying
> to read from source until mtu will be filled properly and not sending
> immediately data if it is smaller than mtu.
> ---
>  src/obex.c |   51 +++++++++++++++++++++++++++++++++++++++------------
>  1 files changed, 39 insertions(+), 12 deletions(-)
>
> diff --git a/src/obex.c b/src/obex.c
> index 6d4430d..4cbc1f8 100644
> --- a/src/obex.c
> +++ b/src/obex.c
> @@ -622,7 +622,7 @@ static int obex_write_stream(struct obex_session *os,
>  {
>        obex_headerdata_t hd;
>        uint8_t *ptr;
> -       ssize_t len;
> +       ssize_t len, r_len;
>        unsigned int flags;
>        uint8_t hi;
>
> @@ -642,18 +642,39 @@ static int obex_write_stream(struct obex_session *os,
>                goto add_header;
>        }
>
> -       len = os->driver->read(os->object, os->buf, os->tx_mtu, &hi);
> -       if (len < 0) {
> -               error("read(): %s (%zd)", strerror(-len), -len);
> -               if (len == -EAGAIN)
> -                       return len;
> -               else if (len == -ENOSTR)
> -                       return 0;
> +       /* Copying data from source until we reach end of the stream. Sending
> +        * data only if MTU will be filled in 100% or we reach end of data.
> +        * Remaining data in buffer will be sent with next amount of data
> +        * from source.*/
> +       do {
> +               r_len = os->driver->read(os->object, os->buf + os->pending,
> +                                               os->tx_mtu - os->pending, &hi);
>
> -               g_free(os->buf);
> -               os->buf = NULL;
> -               return len;
> -       }
> +               if (r_len == 0)
> +                       break;
> +               else if (r_len < 0) {
> +                       error("read(): %s (%zd)", strerror(-r_len), -r_len);
> +
> +                       switch(r_len) {
> +                       case -EAGAIN:
> +                               return r_len;
> +                       case -EINTR:
> +                               continue;
> +                       case -ENOSTR:
> +                               return 0;
> +                       default:
> +                               g_free(os->buf);
> +                               os->buf = NULL;
> +                               return r_len;
> +                       }
> +               }
> +
> +               /* Saving amount of data accumulated in obex buffer */
> +               os->pending += r_len;
> +       } while (os->pending < os->tx_mtu);
> +
> +       len = os->pending;
> +       os->pending = 0;
>
>        ptr = os->buf;
>
> @@ -702,6 +723,12 @@ static gboolean handle_async_io(void *object, int flags, int err,
>                ret = obex_read_stream(os, os->obex, os->obj);
>
>  proceed:
> +
> +       /* Returning TRUE to not delete current watcher - it need to be active
> +        * to handle next io flag changes (more data will be available later)*/
> +       if (ret == -EAGAIN)
> +               return TRUE;
> +
>        if (ret < 0) {
>                os_set_response(os->obj, err);
>                OBEX_CancelRequest(os->obex, TRUE);
> --
> 1.7.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>

Ack

-- 
Luiz Augusto von Dentz
Computer Engineer
