Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: Re: [PATCH BlueZ] Fix obex protocol for powerpc
To: linux-bluetooth@vger.kernel.org
References: <1469711532-7588-1-git-send-email-fabien.proriolpatch@kazoe.org>
 <1469711532-7588-2-git-send-email-fabien.proriolpatch@kazoe.org>
Cc: Fabien Proriol <fabien.proriol@jdsu.com>
From: Fabien PRORIOL <fabien.proriolpatch@kazoe.org>
Message-ID: <a007102f-ef72-aa54-357b-2ab911729ffa@kazoe.org>
Date: Thu, 28 Jul 2016 16:00:43 +0200
MIME-Version: 1.0
In-Reply-To: <1469711532-7588-2-git-send-email-fabien.proriolpatch@kazoe.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

opps, sorry, I sent this new patch a lot too quickly...

uint16_t is unsigned, and can't accept -1...
I need to rework on it

Fabien Proriol


On 28/07/2016 15:12, fabien.proriolpatch@kazoe.org wrote:
> From: Fabien Proriol <fabien.proriol@jdsu.com>
>
> omtu and imtu is define as uint16_t in l2cap_get function (use with va_arg).
> ---
>  obexd/client/bluetooth.c  | 4 ++--
>  obexd/plugins/bluetooth.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/obexd/client/bluetooth.c b/obexd/client/bluetooth.c
> index be007de..3cc1f90 100644
> --- a/obexd/client/bluetooth.c
> +++ b/obexd/client/bluetooth.c
> @@ -443,8 +443,8 @@ static int bluetooth_getpacketopt(GIOChannel *io, int *tx_mtu, int *rx_mtu)
>  {
>  	int sk = g_io_channel_unix_get_fd(io);
>  	int type;
> -	int omtu = -1;
> -	int imtu = -1;
> +	uint16_t omtu = -1;
> +	uint16_t imtu = -1;
>  	socklen_t len = sizeof(int);
>  
>  	DBG("");
> diff --git a/obexd/plugins/bluetooth.c b/obexd/plugins/bluetooth.c
> index d8b872a..3ee5432 100644
> --- a/obexd/plugins/bluetooth.c
> +++ b/obexd/plugins/bluetooth.c
> @@ -75,8 +75,8 @@ static void connect_event(GIOChannel *io, GError *err, void *user_data)
>  	struct bluetooth_profile *profile = user_data;
>  	struct obex_server *server = profile->server;
>  	int type;
> -	int omtu = BT_TX_MTU;
> -	int imtu = BT_RX_MTU;
> +	uint16_t omtu = BT_TX_MTU;
> +	uint16_t imtu = BT_RX_MTU;
>  	gboolean stream = TRUE;
>  	socklen_t len = sizeof(int);
>  
