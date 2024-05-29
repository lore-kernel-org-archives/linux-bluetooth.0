Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B0518133A
	for <linux-bluetooth@vger.kernel.org>; Wed, 29 May 2024 15:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716997209; cv=pass; b=I3zwpN5gFejl9PsZNAld0Mek4bO7DTzQkJvMsd1arJVc6Kr/2SA0G2RQxOUEzlkIMqgzWg/pmFtzOxRCOA81MRCj44K7pmZu9aPAagvKQSUB9ekRU0aye41dvzRztLTQ3FfOqVnIEadKwor41F1Ft7jGQngt3Xp1k8F4r48/AoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716997209; c=relaxed/simple;
	bh=oWYSeKyqlr3jQwBKCu1SY6pEH5LaxAtFV4ljhRgyCvQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IdsND2UdhIw+F130RtRqo6KCm+whNOqRGIGS6ZjBjnXqQ0apeloUJP/OEyDPsycLe0PGZtSiVKreOrMFKmOns1HtTIFvAcKZTGcMrHPg887HGQZ3mxEf7KFp28uPSP1mf2N4pXs6asVbzfx1RjTD5grXVzzELN3aX36Ezo5VrKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=uTsYBxrt; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="uTsYBxrt"
Received: from monolith.lan (91-152-121-138.elisa-laajakaista.fi [91.152.121.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4VqD8q00kjz49Q4h;
	Wed, 29 May 2024 18:39:53 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1716997196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cmVLK6ArdPQuJgrHtOAx19jBSeIkqKEMt982bJdct6Y=;
	b=uTsYBxrt0YN751bVW2yowVyYEONJwyxf6/KyKi7V7W8iPGpEyOxfwsF3apaCr/fo68eQJo
	WjSgQX6lmqMzGNni2EVPrRuB5lXSIhhHuh2lu5YnWwswPpppeMgOM9+SKPslwmeBcEu2q1
	cULecdfzukAyCSSreAzd0+tWApN9nX3Dc73HtuwAzWXFoXhOG1ahoR6Tv877BbLwAJzYnn
	j7bZg2Zq3j2Fv+kiCdzckkED26TjTHJMjmyRp+qu86xiPxT0oeQQZ+TZTTX1COjX89XGid
	ZaZl/p3rqPJYzy7gfNFqFv7z8czVQJh4nu/ss2ehG4LGZcXl4K2OVQj6KG7FLg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1716997196; a=rsa-sha256;
	cv=none;
	b=sRrEueCUaqCVel9yHscX+VJqM9EArR7P1nuJINXyHPXnqm4r42/znhEX1dm/GQfqS4sYFi
	TW7k1jjnIkvj5DvLYH2nsMnyIo+gC1F4ypvcvBu0Sdg7v86naIGDveVhkWZTT557eDrC1w
	wJQ5xgONzLZOz+YHYVOp3rmhZDe8MYUcu1fnXZKkleWCn2SFlY3jiwwYao6T7J28/ek+RS
	Do6C0yRWjrpyEk3gxE/J0kVrclQb8S5su5Ht2Nlu7TVDwp1cWWYZ4SxM7Chiew0W1heKyU
	xT/uWQ5EtnTjLR/zqMUo4sq4to0LJBcvaWkK7W1CJuFODzOwoJmH34pq2lcorA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1716997196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cmVLK6ArdPQuJgrHtOAx19jBSeIkqKEMt982bJdct6Y=;
	b=r7XZjYtU1MxL/hQcF1bJfTHWZDhw2GfaJ7UffVwvlpMGDoLjFuoF1U8G3OOJAAgRs6GiE1
	aSQ3pK4MBO80SlASmrBcy0kdP2AwmRHV7yZbS8aGvYKH5zS2vdmicQ9MVWcDG1xTjmz7on
	ruDfyB5cGFiVs9VtnBeKxfEc856goY5DxtKvvMH2wEksIW08cxD98gjjOScFLJ1aUV4Vx2
	BLV8m1P/YvrYcWP8XDxvmzhf5VgR1qplUcUY8X/gZXmdqvB4rRJZ+Setpzlko42N/cLj/O
	kC/+6OtykxdnMWRRIYRDieYZzFlIj3qb8P9t1pjWmtqNvHq+xY4erCscEO1NPw==
Message-ID: <26bd44ae500d2c314d396811541795c941eb2459.camel@iki.fi>
Subject: Re: [PATCH v2 3/3] Bluetooth: btusb: mediatek: add MediaTek ISO
 data transmission function
From: Pauli Virtanen <pav@iki.fi>
To: Chris Lu <chris.lu@mediatek.com>
Cc: Sean Wang <sean.wang@mediatek.com>, Deren Wu <deren.Wu@mediatek.com>, 
 Aaron Hou <aaron.hou@mediatek.com>, Steve Lee <steve.lee@mediatek.com>,
 linux-bluetooth <linux-bluetooth@vger.kernel.org>, linux-mediatek
 <linux-mediatek@lists.infradead.org>
Date: Wed, 29 May 2024 18:39:52 +0300
In-Reply-To: <20240529062946.5655-4-chris.lu@mediatek.com>
References: <20240529062946.5655-1-chris.lu@mediatek.com>
	 <20240529062946.5655-4-chris.lu@mediatek.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1 (3.52.1-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ke, 2024-05-29 kello 14:29 +0800, Chris Lu kirjoitti:
> This patch implement function for ISO data send and receive in btusb
> driver for MediaTek Controller.
>=20
> MediaTek define a specific interrupt endpoint for ISO data
> transmission because the characteristics of interrupt are
> similar to the application of ISO data which can ensure bandwidth,
> has enough data length and support error check.
>=20
> Driver setup ISO interface in btusb_mtk_setup after download patch and
> submit interrtupt urb to handle ISO data send and receive.
>=20
> Signed-off-by: Chris Lu <chris.lu@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/bluetooth/btmtk.c |  35 +++++
>  drivers/bluetooth/btmtk.h |  23 +++
>  drivers/bluetooth/btusb.c | 295 +++++++++++++++++++++++++++++++++++++-
>  3 files changed, 352 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index a27c251bf56e..f0aecd319911 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
[clip]
> @@ -2122,7 +2358,10 @@ static int btusb_send_frame(struct hci_dev *hdev, =
struct sk_buff *skb)
>  		return submit_tx_urb(hdev, urb);
> =20
>  	case HCI_ISODATA_PKT:
> -		urb =3D alloc_bulk_urb(hdev, skb);
> +		if (btmtk_test_flag(hdev, BTMTK_ISOPKT_OVER_INTR))

The btmtk flag macros require hci_get_priv(hdev) contains struct
btmediatek_data.

Here this is code for generic hdev, so probably misbehaves with non-
mediatek hdev.

> +			urb =3D alloc_mtk_intr_urb(hdev, skb);
> +		else
> +			urb =3D alloc_bulk_urb(hdev, skb);
>  		if (IS_ERR(urb))
>  			return PTR_ERR(urb);
> =20
> @@ -2650,6 +2889,8 @@ static int btusb_recv_event_realtek(struct hci_dev =
*hdev, struct sk_buff *skb)
>  #define MTK_BT_RESET_REG_CONNV3	0x70028610
>  #define MTK_BT_READ_DEV_ID	0x70010200
> =20
> +/* MediaTek ISO interface number */
> +#define MTK_ISO_IFNUM		2
> =20
>  static void btusb_mtk_wmt_recv(struct urb *urb)
>  {
> @@ -3126,6 +3367,28 @@ static int btusb_mtk_reset(struct hci_dev *hdev, v=
oid *rst_data)
>  	return err;
>  }
> =20
> +static int btusb_mtk_claim_iso_intf(struct btusb_data *data, struct usb_=
interface *intf)
> +{
> +	int err;
> +
> +	err =3D usb_driver_claim_interface(&btusb_driver, intf, data);
> +	if (err < 0)
> +		return err;
> +
> +	__set_mtk_intr_interface(data->hdev, MTK_ISO_IFNUM);
> +
> +	err =3D btusb_mtk_submit_intr_urb(data->hdev, GFP_KERNEL);
> +	if (err < 0) {
> +		usb_kill_anchored_urbs(&data->isopkt_anchor);
> +		bt_dev_err(data->hdev, "ISO intf not support (%d)", err);
> +		return err;
> +	}
> +
> +	btmtk_set_flag(data->hdev, BTMTK_ISOPKT_OVER_INTR);
> +
> +	return 0;
> +}
> +
>  static int btusb_mtk_setup(struct hci_dev *hdev)
>  {
>  	struct btusb_data *data =3D hci_get_drvdata(hdev);
> @@ -3210,6 +3473,12 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
>  		/* It's Device EndPoint Reset Option Register */
>  		btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, MTK_EP_RST_IN_OUT_OPT);
> =20
> +		/* Claim USB interface and EndPoint for ISO data */
> +		mediatek->isopkt_info.isopkt_intf =3D usb_ifnum_to_if(data->udev, MTK_=
ISO_IFNUM);
> +		err =3D btusb_mtk_claim_iso_intf(data, mediatek->isopkt_info.isopkt_in=
tf);
> +		if (err < 0)
> +			mediatek->isopkt_info.isopkt_intf =3D NULL;
> +
>  		/* Enable Bluetooth protocol */
>  		param =3D 1;
>  		wmt_params.op =3D BTMTK_WMT_FUNC_CTRL;
> @@ -3226,6 +3495,13 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
> =20
>  		hci_set_msft_opcode(hdev, 0xFD30);
>  		hci_set_aosp_capable(hdev);
> +
> +		/* Setup ISO interface after protocol enabled */
> +		if (btmtk_test_flag(hdev, BTMTK_ISOPKT_OVER_INTR)) {
> +			btmtk_isointf_setup(hdev);
> +			set_bit(BTUSB_ISOPKT_RUNNING, &data->flags);
> +		}
> +
>  		goto done;
>  	default:
>  		bt_dev_err(hdev, "Unsupported hardware variant (%08x)",
> @@ -4347,6 +4623,7 @@ static int btusb_probe(struct usb_interface *intf,
>  	init_usb_anchor(&data->isoc_anchor);
>  	init_usb_anchor(&data->diag_anchor);
>  	init_usb_anchor(&data->ctrl_anchor);
> +	init_usb_anchor(&data->isopkt_anchor);
>  	spin_lock_init(&data->rxlock);
> =20
>  	priv_size =3D 0;
> @@ -4663,6 +4940,17 @@ static void btusb_disconnect(struct usb_interface =
*intf)
>  	if (data->diag)
>  		usb_set_intfdata(data->diag, NULL);
> =20
> +	if (btmtk_test_flag(hdev, BTMTK_ISOPKT_OVER_INTR)) {

Same here, possibly also elsewhere.

> +		struct btmediatek_data *btmtk_data =3D hci_get_priv(hdev);
> +
> +		if (btmtk_data->isopkt_info.isopkt_intf) {
> +			usb_set_intfdata(btmtk_data->isopkt_info.isopkt_intf, NULL);
> +			usb_driver_release_interface(&btusb_driver,
> +						     btmtk_data->isopkt_info.isopkt_intf);
> +		}
> +		btmtk_clear_flag(hdev, BTMTK_ISOPKT_OVER_INTR);
> +	}
> +
>  	hci_unregister_dev(hdev);
> =20
>  	if (intf =3D=3D data->intf) {
> @@ -4818,6 +5106,11 @@ static int btusb_resume(struct usb_interface *intf=
)
>  			btusb_submit_isoc_urb(hdev, GFP_NOIO);
>  	}
> =20
> +	if (test_bit(BTUSB_ISOPKT_RUNNING, &data->flags)) {
> +		if (btusb_mtk_submit_intr_urb(hdev, GFP_NOIO) < 0)
> +			clear_bit(BTUSB_ISOPKT_RUNNING, &data->flags);
> +	}
> +
>  	spin_lock_irq(&data->txlock);
>  	play_deferred(data);
>  	clear_bit(BTUSB_SUSPENDING, &data->flags);

--=20
Pauli Virtanen
