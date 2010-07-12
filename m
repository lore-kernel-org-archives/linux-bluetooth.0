Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH v5 1/3] Implements hci_reassembly to reassemble Rx
 packets
From: Marcel Holtmann <marcel@holtmann.org>
To: Suraj Sumangala <suraj@atheros.com>
Cc: linux-bluetooth@vger.kernel.org, Jothikumar.Mothilal@Atheros.com
In-Reply-To: <1278936744-6003-1-git-send-email-suraj@atheros.com>
References: <1278936744-6003-1-git-send-email-suraj@atheros.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 12 Jul 2010 11:45:12 -0300
Message-ID: <1278945912.10421.194.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Suraj,

> Implements feature to reassemble HCI frames received from an input stream.
> 
> Signed-off-by: Suraj Sumangala <suraj@atheros.com>
> ---
>  net/bluetooth/hci_core.c |  106 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 files changed, 106 insertions(+), 0 deletions(-)
> 
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index aeb2982..e1ede0b 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -1033,6 +1033,112 @@ int hci_recv_frame(struct sk_buff *skb)
>  }
>  EXPORT_SYMBOL(hci_recv_frame);
>  
> +static int hci_reassembly(struct hci_dev *hdev, int type, void *data,
> +			  int count, struct sk_buff **skb_ptr, gfp_t how)
> +{

so while reviewing this patch, I seems to make more sense to just give
an index to the reassembly SKB instead of trying to hand it as an extra
output parameter.

So reassembly[0] can be used for streams and [1..3] for packet specific
types then. That needs a small patch first to extend the array to 4
entries, but that should be just fine.

This meaning we do index = 0 for stream reassembly and index = type - 1
for packet type based reassembly.

Especially since this method is fully internal to bluetooth.ko I would
actually prefer this.

And "gfp_t gfp_mask" please.

> +	int len = 0;
> +	int header_len = 0;

We generally called this hlen.

> +	int remain = count;
> +	struct sk_buff *skb = *skb_ptr;
> +	struct { struct bt_skb_cb cb_info; int expect; } *scb;

Why do we need this double scb. We could just extend our current
bt_skb_cb. Just put "u16 expect" after incoming.

Regards

Marcel


