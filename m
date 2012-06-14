Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
CC: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 14 Jun 2012 11:11:29 -0700
Subject: RE: [RFC] Bluetooth: btmrvl: Do not send vendor events to bluetooth
 stack
Message-ID: <477F20668A386D41ADCC57781B1F7043083A8A6E5F@SC-VEXCH1.marvell.com>
References: <1339583744-2849-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1339583744-2849-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Content-Type: text/plain; charset=US-ASCII
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

> From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
> 
> Vendor-specific events shall be processed in driver and not sent
> to bluetooth stack where they screw up HCI command countings.

I tested this patch and it actually fixed the "hci0 command tx timeout" issue for me.

> 
> Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Tested-by: Bing Zhao <bzhao@marvell.com>

Thanks,
Bing

> ---
>  drivers/bluetooth/btmrvl_drv.h  |    2 +-
>  drivers/bluetooth/btmrvl_main.c |   14 ++++++++++++--
>  drivers/bluetooth/btmrvl_sdio.c |    8 +++++---
>  3 files changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/bluetooth/btmrvl_drv.h b/drivers/bluetooth/btmrvl_drv.h
> index 94f2d65..27068d1 100644
> --- a/drivers/bluetooth/btmrvl_drv.h
> +++ b/drivers/bluetooth/btmrvl_drv.h
> @@ -136,7 +136,7 @@ int btmrvl_remove_card(struct btmrvl_private *priv);
> 
>  void btmrvl_interrupt(struct btmrvl_private *priv);
> 
> -void btmrvl_check_evtpkt(struct btmrvl_private *priv, struct sk_buff *skb);
> +bool btmrvl_check_evtpkt(struct btmrvl_private *priv, struct sk_buff *skb);
>  int btmrvl_process_event(struct btmrvl_private *priv, struct sk_buff *skb);
> 
>  int btmrvl_send_module_cfg_cmd(struct btmrvl_private *priv, int subcmd);
> diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
> index 681ca9d..dc304de 100644
> --- a/drivers/bluetooth/btmrvl_main.c
> +++ b/drivers/bluetooth/btmrvl_main.c
> @@ -44,23 +44,33 @@ void btmrvl_interrupt(struct btmrvl_private *priv)
>  }
>  EXPORT_SYMBOL_GPL(btmrvl_interrupt);
> 
> -void btmrvl_check_evtpkt(struct btmrvl_private *priv, struct sk_buff *skb)
> +bool btmrvl_check_evtpkt(struct btmrvl_private *priv, struct sk_buff *skb)
>  {
>  	struct hci_event_hdr *hdr = (void *) skb->data;
>  	struct hci_ev_cmd_complete *ec;
> -	u16 opcode, ocf;
> +	u16 opcode, ocf, ogf;
> 
>  	if (hdr->evt == HCI_EV_CMD_COMPLETE) {
>  		ec = (void *) (skb->data + HCI_EVENT_HDR_SIZE);
>  		opcode = __le16_to_cpu(ec->opcode);
>  		ocf = hci_opcode_ocf(opcode);
> +		ogf = hci_opcode_ogf(opcode);
> +
>  		if (ocf == BT_CMD_MODULE_CFG_REQ &&
>  					priv->btmrvl_dev.sendcmdflag) {
>  			priv->btmrvl_dev.sendcmdflag = false;
>  			priv->adapter->cmd_complete = true;
>  			wake_up_interruptible(&priv->adapter->cmd_wait_q);
>  		}
> +
> +		if (ogf == OGF) {
> +			BT_DBG("vendor event skipped: ogf 0x%4.4x", ogf);
> +			kfree_skb(skb);
> +			return false;
> +		}
>  	}
> +
> +	return true;
>  }
>  EXPORT_SYMBOL_GPL(btmrvl_check_evtpkt);
> 
> diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
> index 3b9a8a3..8255a5e 100644
> --- a/drivers/bluetooth/btmrvl_sdio.c
> +++ b/drivers/bluetooth/btmrvl_sdio.c
> @@ -565,10 +565,12 @@ static int btmrvl_sdio_card_to_host(struct btmrvl_private *priv)
>  		skb_put(skb, buf_len);
>  		skb_pull(skb, SDIO_HEADER_LEN);
> 
> -		if (type == HCI_EVENT_PKT)
> -			btmrvl_check_evtpkt(priv, skb);
> +		if (type == HCI_EVENT_PKT) {
> +			if (btmrvl_check_evtpkt(priv, skb))
> +				hci_recv_frame(skb);
> +		} else
> +			hci_recv_frame(skb);
> 
> -		hci_recv_frame(skb);
>  		hdev->stat.byte_rx += buf_len;
>  		break;
> 
> --
> 1.7.9.5

