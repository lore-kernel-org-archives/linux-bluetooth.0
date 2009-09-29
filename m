Return-Path: <cyrus@holtmann.org>
Subject: Re: [PATCH] Bluetooth: Enable auto sleep mode for btmrvl driver
From: Marcel Holtmann <marcel@holtmann.org>
To: Bing Zhao <bzhao@marvell.com>
Cc: linux-bluetooth@vger.kernel.org,
	Amitkumar Karwar <akarwar@marvell.com>
In-Reply-To: <1254192601-2553-1-git-send-email-bzhao@marvell.com>
References: <1254192601-2553-1-git-send-email-bzhao@marvell.com>
Content-Type: text/plain
Date: Mon, 28 Sep 2009 21:14:35 -0700
Message-Id: <1254197675.2659.70.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bing,

> From: Amitkumar Karwar <akarwar@marvell.com>
> 
> The auto sleep mode for btmrvl driver is not enabled by default.
> This patch enables auto sleep mode when card is probed.
> 
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> Signed-off-by: Bing Zhao <bzhao@marvell.com>
> ---
>  drivers/bluetooth/btmrvl_drv.h  |    1 +
>  drivers/bluetooth/btmrvl_main.c |   56 +++++++++++++++++++++++---------------
>  drivers/bluetooth/btmrvl_sdio.c |    2 +
>  3 files changed, 37 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/bluetooth/btmrvl_drv.h b/drivers/bluetooth/btmrvl_drv.h
> index 411c7a7..523d197 100644
> --- a/drivers/bluetooth/btmrvl_drv.h
> +++ b/drivers/bluetooth/btmrvl_drv.h
> @@ -131,6 +131,7 @@ void btmrvl_check_evtpkt(struct btmrvl_private *priv, struct sk_buff *skb);
>  int btmrvl_process_event(struct btmrvl_private *priv, struct sk_buff *skb);
>  
>  int btmrvl_send_module_cfg_cmd(struct btmrvl_private *priv, int subcmd);
> +int btmrvl_enable_ps(struct btmrvl_private *priv);
>  int btmrvl_prepare_command(struct btmrvl_private *priv);
>  
>  #ifdef CONFIG_DEBUG_FS
> diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
> index e605563..43b5b68 100644
> --- a/drivers/bluetooth/btmrvl_main.c
> +++ b/drivers/bluetooth/btmrvl_main.c
> @@ -189,6 +189,39 @@ int btmrvl_send_module_cfg_cmd(struct btmrvl_private *priv, int subcmd)
>  }
>  EXPORT_SYMBOL_GPL(btmrvl_send_module_cfg_cmd);
>  
> +int btmrvl_enable_ps(struct btmrvl_private *priv)
> +{
> +	struct sk_buff *skb;
> +	struct btmrvl_cmd *cmd;
> +	int ret = 0;
> +
> +	skb = bt_skb_alloc(sizeof(*cmd), GFP_ATOMIC);
> +	if (skb == NULL) {
> +		BT_ERR("No free skb");
> +		return -ENOMEM;
> +	}
> +
> +	cmd = (struct btmrvl_cmd *) skb_put(skb, sizeof(*cmd));
> +	cmd->ocf_ogf = cpu_to_le16(hci_opcode_pack(OGF,
> +					BT_CMD_AUTO_SLEEP_MODE));
> +	cmd->length = 1;
> +
> +	if (priv->btmrvl_dev.psmode)
> +		cmd->data[0] = BT_PS_ENABLE;
> +	else
> +		cmd->data[0] = BT_PS_DISABLE;
> +
> +	bt_cb(skb)->pkt_type = MRVL_VENDOR_PKT;
> +
> +	skb->dev = (void *) priv->btmrvl_dev.hcidev;
> +	skb_queue_head(&priv->adapter->tx_queue, skb);
> +
> +	BT_DBG("Queue PSMODE Command:%d", cmd->data[0]);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(btmrvl_enable_ps);

can we please stop this non-sense with int ret = 0. That variable is not
used anywhere. And if you wouldn't init it, the compiler would loudly
complain about it already.

Regards

Marcel


