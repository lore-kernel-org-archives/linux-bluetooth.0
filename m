Return-Path: <cyrus@holtmann.org>
From: Bing Zhao <bzhao@marvell.com>
To: Marcel Holtmann <marcel@holtmann.org>,
        "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
CC: Gustavo Padovan <gustavo@padovan.org>,
        Johan Hedberg
	<johan.hedberg@gmail.com>,
        Scott James Remnant <keybuk@chromium.org>,
        Avinash
 Patil <patila@marvell.com>,
        Amitkumar Karwar <akarwar@marvell.com>
Date: Tue, 1 Jul 2014 14:16:32 -0700
Subject: RE: [PATCH] Bluetooth: btmrvl: indicate pscan scheduling instant in
 a debug event
Message-ID: <477F20668A386D41ADCC57781B1F70430FE5F376F7@SC-VEXCH1.marvell.com>
References: <1396302104-11582-1-git-send-email-bzhao@marvell.com>
In-Reply-To: <1396302104-11582-1-git-send-email-bzhao@marvell.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

Could you please review this patch when you get the chance?

Thanks,
Bing

> A vendor specific command is sent to firmware during
> initialization to enable this feature. This command is for
> SD8897 only.
>=20
> Signed-off-by: Bing Zhao <bzhao@marvell.com>
> ---
>  drivers/bluetooth/btmrvl_drv.h  |  1 +
>  drivers/bluetooth/btmrvl_main.c | 19 +++++++++++++++++++
>  drivers/bluetooth/btmrvl_sdio.c |  5 +++++
>  drivers/bluetooth/btmrvl_sdio.h |  2 ++
>  4 files changed, 27 insertions(+)
>=20
> diff --git a/drivers/bluetooth/btmrvl_drv.h b/drivers/bluetooth/btmrvl_dr=
v.h
> index 199ff49..16d136f 100644
> --- a/drivers/bluetooth/btmrvl_drv.h
> +++ b/drivers/bluetooth/btmrvl_drv.h
> @@ -89,6 +89,7 @@ struct btmrvl_private {
>  #define MRVL_VENDOR_PKT			0xFE
>=20
>  /* Vendor specific Bluetooth commands */
> +#define BT_CMD_PSCAN_WIN_REPORT_ENABLE	0xFC03
>  #define BT_CMD_AUTO_SLEEP_MODE		0xFC23
>  #define BT_CMD_HOST_SLEEP_CONFIG	0xFC59
>  #define BT_CMD_HOST_SLEEP_ENABLE	0xFC5A
> diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_m=
ain.c
> index 5c0b944..4f05e39 100644
> --- a/drivers/bluetooth/btmrvl_main.c
> +++ b/drivers/bluetooth/btmrvl_main.c
> @@ -214,6 +214,23 @@ int btmrvl_send_module_cfg_cmd(struct btmrvl_private=
 *priv, int subcmd)
>  }
>  EXPORT_SYMBOL_GPL(btmrvl_send_module_cfg_cmd);
>=20
> +int btmrvl_pscan_window_reporting(struct btmrvl_private *priv, u8 subcmd=
)
> +{
> +	struct btmrvl_sdio_card *card =3D priv->btmrvl_dev.card;
> +	int ret;
> +
> +	if (!card->support_pscan_win_report)
> +		return 0;
> +
> +	ret =3D btmrvl_send_sync_cmd(priv, BT_CMD_PSCAN_WIN_REPORT_ENABLE,
> +				   &subcmd, 1);
> +	if (ret)
> +		BT_ERR("PSCAN_WIN_REPORT_ENABLE command failed: %#x", ret);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(btmrvl_pscan_window_reporting);
> +
>  int btmrvl_send_hscfg_cmd(struct btmrvl_private *priv)
>  {
>  	int ret;
> @@ -489,6 +506,8 @@ static int btmrvl_setup(struct hci_dev *hdev)
>=20
>  	btmrvl_cal_data_dt(priv);
>=20
> +	btmrvl_pscan_window_reporting(priv, 0x01);
> +
>  	priv->btmrvl_dev.psmode =3D 1;
>  	btmrvl_enable_ps(priv);
>=20
> diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_s=
dio.c
> index 9dedca5..efff064 100644
> --- a/drivers/bluetooth/btmrvl_sdio.c
> +++ b/drivers/bluetooth/btmrvl_sdio.c
> @@ -108,6 +108,7 @@ static const struct btmrvl_sdio_device btmrvl_sdio_sd=
8688 =3D {
>  	.helper		=3D "mrvl/sd8688_helper.bin",
>  	.firmware	=3D "mrvl/sd8688.bin",
>  	.reg		=3D &btmrvl_reg_8688,
> +	.support_pscan_win_report =3D false,
>  	.sd_blksz_fw_dl	=3D 64,
>  };
>=20
> @@ -115,6 +116,7 @@ static const struct btmrvl_sdio_device btmrvl_sdio_sd=
8787 =3D {
>  	.helper		=3D NULL,
>  	.firmware	=3D "mrvl/sd8787_uapsta.bin",
>  	.reg		=3D &btmrvl_reg_87xx,
> +	.support_pscan_win_report =3D false,
>  	.sd_blksz_fw_dl	=3D 256,
>  };
>=20
> @@ -122,6 +124,7 @@ static const struct btmrvl_sdio_device btmrvl_sdio_sd=
8797 =3D {
>  	.helper		=3D NULL,
>  	.firmware	=3D "mrvl/sd8797_uapsta.bin",
>  	.reg		=3D &btmrvl_reg_87xx,
> +	.support_pscan_win_report =3D false,
>  	.sd_blksz_fw_dl	=3D 256,
>  };
>=20
> @@ -129,6 +132,7 @@ static const struct btmrvl_sdio_device btmrvl_sdio_sd=
8897 =3D {
>  	.helper		=3D NULL,
>  	.firmware	=3D "mrvl/sd8897_uapsta.bin",
>  	.reg		=3D &btmrvl_reg_88xx,
> +	.support_pscan_win_report =3D true,
>  	.sd_blksz_fw_dl	=3D 256,
>  };
>=20
> @@ -1067,6 +1071,7 @@ static int btmrvl_sdio_probe(struct sdio_func *func=
,
>  		card->firmware =3D data->firmware;
>  		card->reg =3D data->reg;
>  		card->sd_blksz_fw_dl =3D data->sd_blksz_fw_dl;
> +		card->support_pscan_win_report =3D data->support_pscan_win_report;
>  	}
>=20
>  	if (btmrvl_sdio_register_dev(card) < 0) {
> diff --git a/drivers/bluetooth/btmrvl_sdio.h b/drivers/bluetooth/btmrvl_s=
dio.h
> index d4dd3b0..453559f 100644
> --- a/drivers/bluetooth/btmrvl_sdio.h
> +++ b/drivers/bluetooth/btmrvl_sdio.h
> @@ -89,6 +89,7 @@ struct btmrvl_sdio_card {
>  	const char *helper;
>  	const char *firmware;
>  	const struct btmrvl_sdio_card_reg *reg;
> +	bool support_pscan_win_report;
>  	u16 sd_blksz_fw_dl;
>  	u8 rx_unit;
>  	struct btmrvl_private *priv;
> @@ -98,6 +99,7 @@ struct btmrvl_sdio_device {
>  	const char *helper;
>  	const char *firmware;
>  	const struct btmrvl_sdio_card_reg *reg;
> +	const bool support_pscan_win_report;
>  	u16 sd_blksz_fw_dl;
>  };
>=20
> --
> 1.8.0
