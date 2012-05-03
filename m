Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: Marcel Holtmann <marcel@holtmann.org>, Gustavo Padovan
	<gustavo@padovan.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Johan
 Hedberg <johan.hedberg@gmail.com>, Amitkumar Karwar <akarwar@marvell.com>
Date: Wed, 2 May 2012 17:29:28 -0700
Subject: RE: [PATCH 2/2 v2] Bluetooth: btmrvl: add support for SDIO
 suspend/resume callbacks
Message-ID: <477F20668A386D41ADCC57781B1F7043083A4AD379@SC-VEXCH1.marvell.com>
References: <1335379434-12564-1-git-send-email-bzhao@marvell.com>
In-Reply-To: <1335379434-12564-1-git-send-email-bzhao@marvell.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel, Gustavo,

> From: Amitkumar Karwar <akarwar@marvell.com>
>=20
> Host sleep is activated using already configured host sleep
> parameters in suspend handler and it is cancelled in resume
> handler.
>=20
> Signed-off-by: Amitkumar Karwar <akarwar@marvell.com>
> Signed-off-by: Bing Zhao <bzhao@marvell.com>
> ---
> v2: remove '\n' at end of BT_DBG, BT_ERR. (Marcel Holtmann)

Could you please review this v2 patch?

Thanks,
Bing

>=20
>  drivers/bluetooth/btmrvl_drv.h  |    2 +
>  drivers/bluetooth/btmrvl_main.c |    3 +-
>  drivers/bluetooth/btmrvl_sdio.c |  100 +++++++++++++++++++++++++++++++++=
++++++
>  3 files changed, 104 insertions(+), 1 deletions(-)
>=20
> diff --git a/drivers/bluetooth/btmrvl_drv.h b/drivers/bluetooth/btmrvl_dr=
v.h
> index 2c79e76..94f2d65 100644
> --- a/drivers/bluetooth/btmrvl_drv.h
> +++ b/drivers/bluetooth/btmrvl_drv.h
> @@ -67,6 +67,7 @@ struct btmrvl_adapter {
>  	u8 wakeup_tries;
>  	wait_queue_head_t cmd_wait_q;
>  	u8 cmd_complete;
> +	bool is_suspended;
>  };
>=20
>  struct btmrvl_private {
> @@ -142,6 +143,7 @@ int btmrvl_send_module_cfg_cmd(struct btmrvl_private =
*priv, int subcmd);
>  int btmrvl_send_hscfg_cmd(struct btmrvl_private *priv);
>  int btmrvl_enable_ps(struct btmrvl_private *priv);
>  int btmrvl_prepare_command(struct btmrvl_private *priv);
> +int btmrvl_enable_hs(struct btmrvl_private *priv);
>=20
>  #ifdef CONFIG_DEBUG_FS
>  void btmrvl_debugfs_init(struct hci_dev *hdev);
> diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_m=
ain.c
> index a880537..681ca9d 100644
> --- a/drivers/bluetooth/btmrvl_main.c
> +++ b/drivers/bluetooth/btmrvl_main.c
> @@ -262,7 +262,7 @@ int btmrvl_enable_ps(struct btmrvl_private *priv)
>  }
>  EXPORT_SYMBOL_GPL(btmrvl_enable_ps);
>=20
> -static int btmrvl_enable_hs(struct btmrvl_private *priv)
> +int btmrvl_enable_hs(struct btmrvl_private *priv)
>  {
>  	struct sk_buff *skb;
>  	struct btmrvl_cmd *cmd;
> @@ -298,6 +298,7 @@ static int btmrvl_enable_hs(struct btmrvl_private *pr=
iv)
>=20
>  	return ret;
>  }
> +EXPORT_SYMBOL_GPL(btmrvl_enable_hs);
>=20
>  int btmrvl_prepare_command(struct btmrvl_private *priv)
>  {
> diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_s=
dio.c
> index d7d8f83..a853244 100644
> --- a/drivers/bluetooth/btmrvl_sdio.c
> +++ b/drivers/bluetooth/btmrvl_sdio.c
> @@ -1046,11 +1046,111 @@ static void btmrvl_sdio_remove(struct sdio_func =
*func)
>  	}
>  }
>=20
> +static int btmrvl_sdio_suspend(struct device *dev)
> +{
> +	struct sdio_func *func =3D dev_to_sdio_func(dev);
> +	struct btmrvl_sdio_card *card;
> +	struct btmrvl_private *priv;
> +	mmc_pm_flag_t pm_flags;
> +	struct hci_dev *hcidev;
> +
> +	if (func) {
> +		pm_flags =3D sdio_get_host_pm_caps(func);
> +		BT_DBG("%s: suspend: PM flags =3D 0x%x", sdio_func_id(func),
> +		       pm_flags);
> +		if (!(pm_flags & MMC_PM_KEEP_POWER)) {
> +			BT_ERR("%s: cannot remain alive while suspended",
> +			       sdio_func_id(func));
> +			return -ENOSYS;
> +		}
> +		card =3D sdio_get_drvdata(func);
> +		if (!card || !card->priv) {
> +			BT_ERR("card or priv structure is not valid");
> +			return 0;
> +		}
> +	} else {
> +		BT_ERR("sdio_func is not specified");
> +		return 0;
> +	}
> +
> +	priv =3D card->priv;
> +
> +	if (priv->adapter->hs_state !=3D HS_ACTIVATED) {
> +		if (btmrvl_enable_hs(priv)) {
> +			BT_ERR("HS not actived, suspend failed!");
> +			return -EBUSY;
> +		}
> +	}
> +	hcidev =3D priv->btmrvl_dev.hcidev;
> +	BT_DBG("%s: SDIO suspend", hcidev->name);
> +	hci_suspend_dev(hcidev);
> +	skb_queue_purge(&priv->adapter->tx_queue);
> +
> +	priv->adapter->is_suspended =3D true;
> +
> +	/* We will keep the power when hs enabled successfully */
> +	if (priv->adapter->hs_state =3D=3D HS_ACTIVATED) {
> +		BT_DBG("suspend with MMC_PM_KEEP_POWER");
> +		return sdio_set_host_pm_flags(func, MMC_PM_KEEP_POWER);
> +	} else {
> +		BT_DBG("suspend without MMC_PM_KEEP_POWER");
> +		return 0;
> +	}
> +}
> +
> +static int btmrvl_sdio_resume(struct device *dev)
> +{
> +	struct sdio_func *func =3D dev_to_sdio_func(dev);
> +	struct btmrvl_sdio_card *card;
> +	struct btmrvl_private *priv;
> +	mmc_pm_flag_t pm_flags;
> +	struct hci_dev *hcidev;
> +
> +	if (func) {
> +		pm_flags =3D sdio_get_host_pm_caps(func);
> +		BT_DBG("%s: resume: PM flags =3D 0x%x", sdio_func_id(func),
> +		       pm_flags);
> +		card =3D sdio_get_drvdata(func);
> +		if (!card || !card->priv) {
> +			BT_ERR("card or priv structure is not valid");
> +			return 0;
> +		}
> +	} else {
> +		BT_ERR("sdio_func is not specified");
> +		return 0;
> +	}
> +	priv =3D card->priv;
> +
> +	if (!priv->adapter->is_suspended) {
> +		BT_DBG("device already resumed");
> +		return 0;
> +	}
> +
> +	priv->adapter->is_suspended =3D false;
> +	hcidev =3D priv->btmrvl_dev.hcidev;
> +	BT_DBG("%s: SDIO resume", hcidev->name);
> +	hci_resume_dev(hcidev);
> +	priv->hw_wakeup_firmware(priv);
> +	priv->adapter->hs_state =3D HS_DEACTIVATED;
> +	BT_DBG("%s: HS DEACTIVATED in resume!", hcidev->name);
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops btmrvl_sdio_pm_ops =3D {
> +	.suspend	=3D btmrvl_sdio_suspend,
> +	.resume		=3D btmrvl_sdio_resume,
> +};
> +
>  static struct sdio_driver bt_mrvl_sdio =3D {
>  	.name		=3D "btmrvl_sdio",
>  	.id_table	=3D btmrvl_sdio_ids,
>  	.probe		=3D btmrvl_sdio_probe,
>  	.remove		=3D btmrvl_sdio_remove,
> +	.drv =3D {
> +		.owner =3D THIS_MODULE,
> +		.pm =3D &btmrvl_sdio_pm_ops,
> +	}
>  };
>=20
>  static int __init btmrvl_sdio_init_module(void)
> --
> 1.7.0.4
