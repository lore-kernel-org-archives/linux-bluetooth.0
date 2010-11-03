Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1288689911-18507-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
References: <1288689911-18507-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Date: Wed, 3 Nov 2010 07:44:26 -0400
Message-ID: <AANLkTi=zQ1aKZ84HGAJ90Bwo=ugJuC7+u36oEoW=KR7C@mail.gmail.com>
Subject: Re: [PATCH v2] Add support for sending small data through obex
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, Nov 2, 2010 at 5:25 AM, Radoslaw Jablonski
<ext-jablonski.radoslaw@nokia.com> wrote:
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

Small coding style issue above: a missing space between "switch" and "(".

Regards,
-- 
Anderson Lizardo
OpenBossa Labs - INdT
Manaus - Brazil
