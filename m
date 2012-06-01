Return-Path: <cyrus@holtmann.org>
Date: Fri, 1 Jun 2012 10:06:42 +0300
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Andre Guedes <andre.guedes@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: Trivial refactoring in __l2cap_chan_add
Message-ID: <20120601070641.GB3009@aemeltch-MOBL1>
References: <1338508794-12534-1-git-send-email-andre.guedes@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1338508794-12534-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andre,

On Thu, May 31, 2012 at 08:59:54PM -0300, Andre Guedes wrote:
> All cases in switch statement set chan->omtu to L2CAP_DEFAULT_MTU.
> This patch moves the assignments to outside the switch statement.
> 
> Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
> ---
>  net/bluetooth/l2cap_core.c |    5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index f9bffe3..0ba8875 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -449,13 +449,11 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
>  	case L2CAP_CHAN_CONN_ORIENTED:
>  		if (conn->hcon->type == LE_LINK) {
>  			/* LE connection */
> -			chan->omtu = L2CAP_DEFAULT_MTU;
>  			chan->scid = L2CAP_CID_LE_DATA;
>  			chan->dcid = L2CAP_CID_LE_DATA;
>  		} else {
>  			/* Alloc CID for connection-oriented socket */
>  			chan->scid = l2cap_alloc_cid(conn);
> -			chan->omtu = L2CAP_DEFAULT_MTU;
>  		}
>  		break;
>  
> @@ -463,7 +461,6 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
>  		/* Connectionless socket */
>  		chan->scid = L2CAP_CID_CONN_LESS;
>  		chan->dcid = L2CAP_CID_CONN_LESS;
> -		chan->omtu = L2CAP_DEFAULT_MTU;
>  		break;
>  
>  	case L2CAP_CHAN_CONN_FIX_A2MP:

what about omtu for fixed channel?

Best regards 
Andrei Emeltchenko 

