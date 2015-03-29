Return-Path: <cyrus@holtmann.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2070.6\))
Subject: Re: [PATCH] Bluetooth: Refactor HCI request & L2CAP bt_skb_cb members to use union
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1427652407-30345-1-git-send-email-johan.hedberg@gmail.com>
Date: Sun, 29 Mar 2015 12:34:46 -0700
Cc: linux-bluetooth@vger.kernel.org
Message-Id: <F53E6EA2-26B3-4214-9B5C-F13E00F611FC@holtmann.org>
References: <1427652407-30345-1-git-send-email-johan.hedberg@gmail.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Johan,

> The HCI request and L2CAP related members of the bt_skb_cb struct will
> never be in use at the same time. Since space available for the skb cb
> is limited this patch splits the members to the existing l2cap_ctrl and
> a new req_ctrl struct, both behind the same union.
> 
> This paves the way to extend the req_ctrl with another callback option
> without hitting the limits of the skb cb size.
> 
> Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
> ---
> include/net/bluetooth/bluetooth.h | 20 ++++++++++------
> net/bluetooth/hci_core.c          | 12 +++++-----
> net/bluetooth/hci_event.c         |  4 ++--
> net/bluetooth/hci_request.c       |  6 ++---
> net/bluetooth/hci_sock.c          |  2 +-
> net/bluetooth/l2cap_core.c        | 48 +++++++++++++++++++--------------------
> net/bluetooth/l2cap_sock.c        |  6 ++---
> net/bluetooth/smp.c               |  2 +-
> 8 files changed, 53 insertions(+), 47 deletions(-)
> 
> diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
> index 33a5e00025aa..8b2840d8e974 100644
> --- a/include/net/bluetooth/bluetooth.h
> +++ b/include/net/bluetooth/bluetooth.h
> @@ -269,25 +269,31 @@ struct l2cap_ctrl {
> 	__u16	reqseq;
> 	__u16	txseq;
> 	__u8	retries;
> +	__le16  psm;
> +	struct l2cap_chan *chan;
> +	bdaddr_t bdaddr;
> };

it might make sense to have bdaddr_t before the data pointer. At least bdaddr_t is fixed size on each architecture would be most likely easier to pack and align.

> struct hci_dev;
> 
> typedef void (*hci_req_complete_t)(struct hci_dev *hdev, u8 status, u16 opcode);
> 
> +struct req_ctrl {
> +	__u8 start:1;

Since this is of no benefit here, I wonder if we should just start using bool here.

> +	u8 event;
> +	hci_req_complete_t complete;
> +};
> +
> struct bt_skb_cb {
> 	__u8 pkt_type;
> 	__u8 force_active;
> 	__u16 opcode;
> 	__u16 expect;
> 	__u8 incoming:1;
> -	__u8 req_start:1;
> -	u8 req_event;
> -	hci_req_complete_t req_complete;
> -	struct l2cap_chan *chan;
> -	struct l2cap_ctrl control;
> -	bdaddr_t bdaddr;
> -	__le16 psm;
> +	union {
> +		struct l2cap_ctrl l2cap;
> +		struct req_ctrl req;
> +	};
> };

I would have done this in multiple patches. Fist group the L2CAP specific ones into l2cap_ctrl. I mean add psm, bdaddr and chan into l2cap_ctrl struct. And then rename control to l2cap. That would confine the changes into the L2CAP layer things.

Then second, create the req_ctrl and use a req_ctrl req entry in the struct.

And thirdly move l2cap and req into a union. Actually third might not work out and breaks compilation in 64-bit if incoming and req_start are no longer close to each other so that bits are really moved into a single char.

The rest seems fine.

Regards

Marcel

