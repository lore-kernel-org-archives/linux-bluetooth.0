Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: Amitkumar Karwar <akarwar@marvell.com>,
	"linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Mon, 12 Oct 2009 12:58:16 -0700
Subject: RE: [PATCH v2] Bluetooth: Enable auto sleep mode for btmrvl driver
Message-ID: <477F20668A386D41ADCC57781B1F704306DDE0965B@SC-VEXCH1.marvell.com>
References: <1254334710-1811-1-git-send-email-bzhao@marvell.com>
In-Reply-To: <1254334710-1811-1-git-send-email-bzhao@marvell.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>


Hi Marcel,

> -----Original Message-----
> From: Bing Zhao [mailto:bzhao@marvell.com]
> Sent: Wednesday, September 30, 2009 11:19 AM
> To: linux-bluetooth@vger.kernel.org
> Cc: Bing Zhao; Amitkumar Karwar
> Subject: [PATCH v2] Bluetooth: Enable auto sleep mode for btmrvl driver
>=20
> From: Amitkumar Karwar <akarwar@marvell.com>
>=20
> The auto sleep mode for btmrvl driver is not enabled by default.
> This patch enables auto sleep mode when card is probed.
>=20
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> Signed-off-by: Bing Zhao <bzhao@marvell.com>

Does this patch look okay to you? Please let me know if any change is neede=
d.

Thanks,

Bing


> ---
>  drivers/bluetooth/btmrvl_drv.h  |    1 +
>  drivers/bluetooth/btmrvl_main.c |   55 +++++++++++++++++++++++----------=
-----
>  drivers/bluetooth/btmrvl_sdio.c |    2 +
>  3 files changed, 36 insertions(+), 22 deletions(-)
>=20
> diff --git a/drivers/bluetooth/btmrvl_drv.h b/drivers/bluetooth/btmrvl_dr=
v.h
> index 411c7a7..523d197 100644
> --- a/drivers/bluetooth/btmrvl_drv.h
> +++ b/drivers/bluetooth/btmrvl_drv.h
> @@ -131,6 +131,7 @@ void btmrvl_check_evtpkt(struct btmrvl_private *priv,=
 struct sk_buff *skb);
>  int btmrvl_process_event(struct btmrvl_private *priv, struct sk_buff *sk=
b);
>=20
>  int btmrvl_send_module_cfg_cmd(struct btmrvl_private *priv, int subcmd);
> +int btmrvl_enable_ps(struct btmrvl_private *priv);
>  int btmrvl_prepare_command(struct btmrvl_private *priv);
>=20
>  #ifdef CONFIG_DEBUG_FS
> diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_m=
ain.c
> index e605563..f97771c 100644
> --- a/drivers/bluetooth/btmrvl_main.c
> +++ b/drivers/bluetooth/btmrvl_main.c
> @@ -189,6 +189,38 @@ int btmrvl_send_module_cfg_cmd(struct btmrvl_private=
 *priv, int subcmd)
>  }
>  EXPORT_SYMBOL_GPL(btmrvl_send_module_cfg_cmd);
>=20
> +int btmrvl_enable_ps(struct btmrvl_private *priv)
> +{
> +	struct sk_buff *skb;
> +	struct btmrvl_cmd *cmd;
> +
> +	skb =3D bt_skb_alloc(sizeof(*cmd), GFP_ATOMIC);
> +	if (skb =3D=3D NULL) {
> +		BT_ERR("No free skb");
> +		return -ENOMEM;
> +	}
> +
> +	cmd =3D (struct btmrvl_cmd *) skb_put(skb, sizeof(*cmd));
> +	cmd->ocf_ogf =3D cpu_to_le16(hci_opcode_pack(OGF,
> +					BT_CMD_AUTO_SLEEP_MODE));
> +	cmd->length =3D 1;
> +
> +	if (priv->btmrvl_dev.psmode)
> +		cmd->data[0] =3D BT_PS_ENABLE;
> +	else
> +		cmd->data[0] =3D BT_PS_DISABLE;
> +
> +	bt_cb(skb)->pkt_type =3D MRVL_VENDOR_PKT;
> +
> +	skb->dev =3D (void *) priv->btmrvl_dev.hcidev;
> +	skb_queue_head(&priv->adapter->tx_queue, skb);
> +
> +	BT_DBG("Queue PSMODE Command:%d", cmd->data[0]);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(btmrvl_enable_ps);
> +
>  static int btmrvl_enable_hs(struct btmrvl_private *priv)
>  {
>  	struct sk_buff *skb;
> @@ -258,28 +290,7 @@ int btmrvl_prepare_command(struct btmrvl_private *pr=
iv)
>=20
>  	if (priv->btmrvl_dev.pscmd) {
>  		priv->btmrvl_dev.pscmd =3D 0;
> -
> -		skb =3D bt_skb_alloc(sizeof(*cmd), GFP_ATOMIC);
> -		if (skb =3D=3D NULL) {
> -			BT_ERR("No free skb");
> -			return -ENOMEM;
> -		}
> -
> -		cmd =3D (struct btmrvl_cmd *) skb_put(skb, sizeof(*cmd));
> -		cmd->ocf_ogf =3D cpu_to_le16(hci_opcode_pack(OGF, BT_CMD_AUTO_SLEEP_MO=
DE));
> -		cmd->length =3D 1;
> -
> -		if (priv->btmrvl_dev.psmode)
> -			cmd->data[0] =3D BT_PS_ENABLE;
> -		else
> -			cmd->data[0] =3D BT_PS_DISABLE;
> -
> -		bt_cb(skb)->pkt_type =3D MRVL_VENDOR_PKT;
> -
> -		skb->dev =3D (void *) priv->btmrvl_dev.hcidev;
> -		skb_queue_head(&priv->adapter->tx_queue, skb);
> -
> -		BT_DBG("Queue PSMODE Command:%d", cmd->data[0]);
> +		btmrvl_enable_ps(priv);
>  	}
>=20
>  	if (priv->btmrvl_dev.hscmd) {
> diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_s=
dio.c
> index 5b33b85..d6aaf51 100644
> --- a/drivers/bluetooth/btmrvl_sdio.c
> +++ b/drivers/bluetooth/btmrvl_sdio.c
> @@ -930,6 +930,8 @@ static int btmrvl_sdio_probe(struct sdio_func *func,
>  	priv->hw_wakeup_firmware =3D btmrvl_sdio_wakeup_fw;
>=20
>  	btmrvl_send_module_cfg_cmd(priv, MODULE_BRINGUP_REQ);
> +	priv->btmrvl_dev.psmode =3D 1;
> +	btmrvl_enable_ps(priv);
>=20
>  	return 0;
>=20
> --
> 1.5.4.3
