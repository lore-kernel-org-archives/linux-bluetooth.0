Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Subject: Re: [PATCH] Bluetooth: Fix ERTM L2CAP resend packet
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1407841466-24720-1-git-send-email-lukasz.rymanowski@tieto.com>
Date: Wed, 13 Aug 2014 10:23:23 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <D9DCCFA5-D511-4211-B4B1-11CE8587A635@holtmann.org>
References: <1407841466-24720-1-git-send-email-lukasz.rymanowski@tieto.com>
To: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Lukasz,

> I-Frame which is going to be resend already has FCS field added and set
> (if it was required). Adding additional FCS field calculated from data +
> old FCS in resend function is incorrect.
> 
> This patch fix that.
> 
> Cached on PTS testing.

"Issue has been found during PTS testing."

No caching ;)

> 
> Signed-off-by: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
> ---
> net/bluetooth/l2cap_core.c | 7 ++++---
> 1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
> index 0cd7ed9..7b0d744 100644
> --- a/net/bluetooth/l2cap_core.c
> +++ b/net/bluetooth/l2cap_core.c
> @@ -1968,10 +1968,11 @@ static void l2cap_ertm_resend(struct l2cap_chan *chan)
> 					   tx_skb->data + L2CAP_HDR_SIZE);
> 		}
> 
> +		/* Update FCS */
> 		if (chan->fcs == L2CAP_FCS_CRC16) {
> -			u16 fcs = crc16(0, (u8 *) tx_skb->data, tx_skb->len);
> -			put_unaligned_le16(fcs, skb_put(tx_skb,
> -							L2CAP_FCS_SIZE));
> +			u16 fcs = crc16(0, (u8 *)tx_skb->data, tx_skb->len -
> +					L2CAP_FCS_SIZE);

+                       u16 fcs = crc16(0, (u8 *) tx_skb->data,
+                                       tx_skb->len - L2CAP_FCS_SIZE);

> +			put_unaligned_le16(fcs, tx_skb->tail - L2CAP_FCS_SIZE);
> 		}

  CC      net/bluetooth/l2cap_core.o
net/bluetooth/l2cap_core.c: In function ‘l2cap_ertm_resend’:
net/bluetooth/l2cap_core.c:1975:4: warning: passing argument 2 of ‘put_unaligned_le16’ makes pointer from integer without a cast [enabled by default]
    put_unaligned_le16(fcs, tx_skb->tail - L2CAP_FCS_SIZE);
    ^
In file included from ./arch/x86/include/asm/unaligned.h:8:0,
                 from include/net/bluetooth/l2cap.h:30,
                 from net/bluetooth/l2cap_core.c:38:
include/linux/unaligned/access_ok.h:37:91: note: expected ‘void *’ but argument is of type ‘sk_buff_data_t’  static inline void put_unaligned_le16(u16 val, void *p)
                                                                                           ^

Regards

Marcel

