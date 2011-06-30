Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1309419294-9903-1-git-send-email-nami.li@atheros.com>
References: <1309419294-9903-1-git-send-email-nami.li@atheros.com>
Date: Thu, 30 Jun 2011 11:24:44 +0300
Message-ID: <BANLkTim8jj13o8zeRawV_QpT9+rp-afrbQ@mail.gmail.com>
Subject: Re: [PATCH obexd] Return correct obex service driver in obex_session_start
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Hui Li <nami.li@atheros.com>
Cc: linux-bluetooth@vger.kernel.org, Hui Li <nami@qca.qualcomm.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

On Thu, Jun 30, 2011 at 10:34 AM, Hui Li <nami.li@atheros.com> wrote:
> From: Hui Li <nami@qca.qualcomm.com>
>
>  The original return value is NULL.
> ---
>  src/obex.c |    3 +--
>  1 files changed, 1 insertions(+), 2 deletions(-)
>
> diff --git a/src/obex.c b/src/obex.c
> index 49d9c18..978894e 100644
> --- a/src/obex.c
> +++ b/src/obex.c
> @@ -1377,8 +1377,7 @@ int obex_session_start(GIOChannel *io, uint16_t tx_mtu, uint16_t rx_mtu,
>
>        os = g_new0(struct obex_session, 1);
>
> -       os->service = obex_service_driver_find(server->drivers, NULL,
> -                                                       0, NULL, 0);
> +       os->service = server->drivers->data;
>        os->server = server;
>        os->rx_mtu = rx_mtu != 0 ? rx_mtu : DEFAULT_RX_MTU;
>        os->tx_mtu = tx_mtu != 0 ? tx_mtu : DEFAULT_TX_MTU;
> --
> 1.7.1
>
> --

The idea here is to initialized with OPP driver which has no target
thus the NULL, so picking up the first driver in the list may not
enough. Btw, if passing a NULL was a bug OPP driver would never have
worked, so I wonder how you managed to get no driver as a response to
NULL target?



-- 
Luiz Augusto von Dentz
