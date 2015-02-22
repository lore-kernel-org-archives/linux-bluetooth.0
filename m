Return-Path: <cyrus@holtmann.org>
From: "Kim, Ben Young Tae" <ytkim@qca.qualcomm.com>
To: Marcel Holtmann <marcel@holtmann.org>, "linux-bluetooth@vger.kernel.org"
	<linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] Bluetooth: btusb: Add setup callback for chip init
 on USB
Date: Sun, 22 Feb 2015 23:55:32 +0000
Message-ID: <FD59A293-78F5-422A-9992-31A460F5CDA1@qca.qualcomm.com>
References: <ed9be4d986c749d7a0b35a335184a932@nalasexr02e.na.qualcomm.com>
In-Reply-To: <ed9be4d986c749d7a0b35a335184a932@nalasexr02e.na.qualcomm.com>
Content-Type: text/plain; charset="Windows-1252"
MIME-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On Feb 15, 2015, at 3:06 PM, Kim, Ben Young Tae <ytkim@qca.qualcomm.com> wr=
ote:

> Some of chipset does not allow to send a patch or config files through
> HCI VS channel at early stage as well as they don't support to send
> USB patch files to other channel except USB bulk path.
>=20
> New callback added is for initialization of BT controller through USB
>=20
> Signed-off-by: Ben Young Tae Kim <ytkim@qca.qualcomm.com>
> ---
> drivers/bluetooth/btusb.c | 11 +++++++++++
> 1 file changed, 11 insertions(+)
>=20
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 3ca2e1b..73e1066 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -337,6 +337,8 @@ struct btusb_data {
>=20
> 	int (*recv_event)(struct hci_dev *hdev, struct sk_buff *skb);
> 	int (*recv_bulk)(struct btusb_data *data, void *buffer, int count);
> +
> +	int (*setup_on_usb)(struct hci_dev *hdev);
> };
>=20
> static inline void btusb_free_frags(struct btusb_data *data)
> @@ -878,6 +880,15 @@ static int btusb_open(struct hci_dev *hdev)
>=20
> 	BT_DBG("%s", hdev->name);
>=20
> +	/* Patching USB firmware files prior to starting any URBs of HCI path
> +	 * It is more safe to use USB bulk channel for downloading USB patch
> +	 */
> +	if (data->setup_on_usb) {
> +		err =3D data->setup_on_usb(hdev);
> +		if (err <0)
> +			return err;
> +	}
> +
> 	err =3D usb_autopm_get_interface(data->intf);
> 	if (err < 0)
> 		return err;
> --=20
> 1.8.1.5
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth=
" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

PING=85

Thanks
=97 Ben Kim=
