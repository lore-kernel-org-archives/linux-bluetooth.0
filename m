Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1369763123-17949-1-git-send-email-gustavo@padovan.org>
References: <1369763123-17949-1-git-send-email-gustavo@padovan.org>
Date: Wed, 29 May 2013 04:41:59 -0700
Message-ID: <CABBYNZKYyo1eGL33pbGVRFOHpQvYOejf0gT1EdKs=19KzdcAqw@mail.gmail.com>
Subject: Re: [PATCH 1/6] transport: add getsockname to transport driver
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gustavo Padovan <gustavo@padovan.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	emilio.pozuelo@collabora.co.uk,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

On Tue, May 28, 2013 at 10:45 AM, Gustavo Padovan <gustavo@padovan.org> wrote:
> From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
>
> Enable other pieces of obex to get the source Bluetooth address.
> ---
>  obexd/src/transport.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/obexd/src/transport.h b/obexd/src/transport.h
> index b81615b..97e10d0 100644
> --- a/obexd/src/transport.h
> +++ b/obexd/src/transport.h
> @@ -26,6 +26,7 @@ struct obex_transport_driver {
>         uint16_t service;
>         void *(*start) (struct obex_server *server, int *err);
>         int (*getpeername) (GIOChannel *io, char **name);
> +       int (*getsockname) (GIOChannel *io, char **name);
>         void (*stop) (void *data);
>  };
>
> --
> 1.8.1.4

Pushed, thanks.


--
Luiz Augusto von Dentz
