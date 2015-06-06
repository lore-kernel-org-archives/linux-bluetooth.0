Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2098\))
Subject: Re: [PATCH] bluetooth: hci_bcsp: Clean up code Fix
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20150604070848.GA8533@ubuntu>
Date: Sat, 6 Jun 2015 06:49:19 +0200
Cc: "Gustavo F. Padovan" <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <A1AA5BA0-D94C-46CF-BA06-3CF378C8B3D0@holtmann.org>
References: <20150604070848.GA8533@ubuntu>
To: "Mutharaju, Prasanna (P.)" <mkarthi3@visteon.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Prasanna,

> Fix for spaces prohibited around that '->' reported by checkpatch
> and space prohibited between function name and open parenthesis '('
> 
> Signed-off-by: Prasanna Karthik <mkarthi3@visteon.com>
> ---
> drivers/bluetooth/hci_bcsp.c |   28 ++++++++++++++--------------
> 1 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_bcsp.c b/drivers/bluetooth/hci_bcsp.c
> index dc8e3d4..94e0046 100644
> --- a/drivers/bluetooth/hci_bcsp.c
> +++ b/drivers/bluetooth/hci_bcsp.c
> @@ -285,7 +285,7 @@ static struct sk_buff *bcsp_dequeue(struct hci_uart *hu)
> 	struct bcsp_struct *bcsp = hu->priv;
> 	unsigned long flags;
> 	struct sk_buff *skb;
> -	
> +
> 	/* First of all, check for unreliable messages in the queue,
> 	   since they have priority */
> 
> @@ -436,7 +436,7 @@ static inline void bcsp_unslip_one_byte(struct bcsp_struct *bcsp, unsigned char
> 			break;
> 		default:
> 			memcpy(skb_put(bcsp->rx_skb, 1), &byte, 1);
> -			if ((bcsp->rx_skb-> data[0] & 0x40) != 0 && 
> +			if ((bcsp->rx_skb->data[0] & 0x40) != 0 &&
> 					bcsp->rx_state != BCSP_W4_CRC)

if you do this, then also adjust the indentation to follow the network subsystem style. This driver has most likely plenty of them. --strict for checkpatch in case you wonder.

Regards

Marcel

