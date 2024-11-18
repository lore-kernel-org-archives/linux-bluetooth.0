Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192601BDABE;
	Mon, 18 Nov 2024 17:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731949860; cv=pass; b=K2efLcRluKd4Lvw62rHqkL6ULvP73GKJB4mcqr06AWtw/C/72ITwNwc+CcEU0glf10NZ3l+dxktAWNQg8cx+oO/gONJUpMB78Jlcttrmazsg0kU+KlYJBG4w4blOr+mMDWbrX1DyKsOaz3NJcoQ1s86pNfvPQhZxQm7o9Xi1CSI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731949860; c=relaxed/simple;
	bh=tmyhyZKLTK+yZ2+rkODmL/renDuj81rbKfbe0CwvGGk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Kv3IiGQKiP5GhbyvCnN17skwYSTn6gBTZk1GYKtozL5yl2uw8A6hwQoBSJ4e8pRFBAMkK59MctVfExRRiIC563Bm33//TZM7JKJCy/tQjoC+v6wueH/sHx7j+4Oa2dxAhiaDnTNvHRIvLuTo8ItDGRcANXWgSADdxZIrZ2WS/MQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=Hk+tkMXt; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="Hk+tkMXt"
Received: from [192.168.1.195] (unknown [IPv6:2a0c:f040:0:2790::a03d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4XsYn874cXz49Q5g;
	Mon, 18 Nov 2024 19:01:32 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1731949295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eScYoJiu9NDn1iFtxMkj9I6LsM48n1pF2OmIeqFgQRo=;
	b=Hk+tkMXtQgKbRlSLcCADdT8OBc4t7Er/i0BfEkoxUcAmmqc4F9UC6LxgdfEqbV12knVn6R
	E/q0nGLn6icrlFW3T7w0Zk7e5FJrK9W70cIcQsdYQ2QPw3uvUMdPJBraZer+EqkzhYZTmz
	OKNpkZ8mDCCUD5sZKpsvztDRVLbtUzVJwjcd642whNWIUbnPBwzgc+T7Yfwms/S980UCX7
	Xy0RsNaY09YWkkt4DHjWNXTxK0X/suuhMk32TwGvGoGh33cEDOIqTWm4Vjurr9EAA7YY5E
	fwAJPErkZLXC/hiq0gDTZwqp05uZeLk4m1kZCPYAGpA46tDMg46SGz4ZaQd/7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1731949295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=eScYoJiu9NDn1iFtxMkj9I6LsM48n1pF2OmIeqFgQRo=;
	b=sPcLjbSGM3w8eHazCCL+AtxEvYgNCZVYl+kP6qXRQK1NoOD9lfNpkE8uFcbOw+aADEA1jO
	UJ/uwWCcBkD8F0g1h/wR+8vNzbZvPqHznTb4uPC/7Uupm8f4HCp/K9XE2ANtwoZEVlVmLx
	1rj7YkaG+FgMRM0DgJP0FxABrYMh7jEP+0mzi4uZqufRHU9TnpGZ7N2/jGyzyUhUILPY7F
	tYzyUMvz/J/dYSoMC6OM5cAdU4WFm/au/4MHn6poq/bKgpFmw37cT/9p9X6icsSKwoMTLs
	DyFFfZOnF3tRsTnuC8+PKEBetzRgC7HDMynby9VNmQljNCvsl26RVyix0ZizNg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1731949295; a=rsa-sha256;
	cv=none;
	b=YKk1ygnArIXRcCy/q2fUtK9hDVOF+uo7h93AdSVo3UVadXgoXqP57EqutPMwVjRsdZn7EF
	gFfLgaYsU5ZzUFDMrZkQDWSkxwC5Sursd9CxeKe0it+zpS8ylMV8wSZNJvWbQrnGmTM64S
	zxGAImqu5FbdKyD64np95pFPhT1q9n8G0zypBJsxgUhjBhWMT8+WbBICjY++I6z7dC5+tn
	teA1M3rdoGntGBo0hGm6tX5I8lbG2yzqEG/YIHt6g05nHv9WR2cDSFFiLXi/pp73STS6DZ
	w00dBERPFHln1byHYKngGgWVa51VrPKnf1JIzZaPPGq03qZog0GkivzdtWC/1w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
Message-ID: <94a5b1010aa4a896249e416f5ad61916eee7ebf5.camel@iki.fi>
Subject: Re: [PATCH v2] bluetooth: add quirk using packet size 60
From: Pauli Virtanen <pav@iki.fi>
To: Hilda Wu <hildawu@realtek.com>, marcel@holtmann.org
Cc: luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, max.chou@realtek.com, alex_lu@realsil.com.cn,
 	kidman@realtek.com
Date: Mon, 18 Nov 2024 19:01:29 +0200
In-Reply-To: <20241118085757.3678244-1-hildawu@realtek.com>
References: <20241118085757.3678244-1-hildawu@realtek.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.1 (3.54.1-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

ma, 2024-11-18 kello 16:57 +0800, Hilda Wu kirjoitti:
> The RTL8852BE-VT supports USB alternate setting 6.
> However, its descriptor does not report this capability to the host.
> Therefore, a quirk is needed to bypass the RTL8852BE-VT's descriptor
> and allow it to use USB ALT 6 directly.
>=20
> The btmon log below shows the case that WBS with the USB alternate
> setting 6.
>=20
> > ACL Data RX: Handle 2 flags 0x02 dlen 18       #5338 [hci0] 91.977373
>       Channel: 70 len 14 [PSM 3 mode Basic (0x00)] {chan 3}
>       RFCOMM: Unnumbered Info with Header Check (UIH) (0xef)
>          Address: 0x09 cr 0 dlci 0x02
>          Control: 0xff poll/final 1
>          Length: 9
>          FCS: 0x5c
>          Credits: 4
>         41 54 2b 42 43 53 3d 32 0d 5c                    AT+BCS=3D2.\    =
>
> < ACL Data TX: Handle 2 flags 0x00 dlen 15       #5339 [hci0] 91.978294
>       Channel: 64 len 11 [PSM 3 mode Basic (0x00)] {chan 3}
>       RFCOMM: Unnumbered Info with Header Check (UIH) (0xef)
>          Address: 0x0b cr 1 dlci 0x02
>          Control: 0xff poll/final 1
>          Length: 6
>          FCS: 0x86
>          Credits: 1
>         0d 0a 4f 4b 0d 0a 86                             ..OK...       >
> < HCI Command: Enhanced.. (0x01|0x003d) plen 59  #5340 [hci0] 91.978326
>         Handle: 2
>         Transmit bandwidth: 8000
>         Receive bandwidth: 8000
>         Max latency: 13
>         Packet type: 0x0380
>           3-EV3 may not be used
>           2-EV5 may not be used
>           3-EV5 may not be used
>         Retransmission effort: Optimize for link quality (0x02)
> > HCI Event: Command Status (0x0f) plen 4        #5341 [hci0] 91.981723
>       Enhanced Setup Synchronous Connection (0x01|0x003d) ncmd 2
>         Status: Success (0x00)
> > HCI Event: Number of Complete.. (0x13) plen 5  #5342 [hci0] 91.982705
>         Num handles: 1
>         Handle: 2
>         Count: 1
> > HCI Event: Synchronous Conne.. (0x2c) plen 17  #5343 [hci0] 92.015758
>         Status: Success (0x00)
>         Handle: 3
>         Address: 78:A7:EB:4C:53:4D (OUI 78-A7-EB)
>         Link type: eSCO (0x02)
>         Transmission interval: 0x0c
>         Retransmission window: 0x04
>         RX packet length: 60
>         TX packet length: 60
>         Air mode: Transparent (0x03)
> @ MGMT Open: bt_main_th.. (privileged) version 1.22  {0x0003} 92.016366
> @ MGMT Command: Unknown (0x0101) plen 11             {0x0003} 92.016374
>         00 00 78 a7 eb 4c 53 4d 00 01 02                 ..x..LSM...   >
> @ MGMT Close: bt_main_thread                         {0x0003} 92.016409
> < ACL Data TX: Handle 2 flags 0x00 dlen 22       #5344 [hci0] 92.017651
>       Channel: 64 len 18 [PSM 3 mode Basic (0x00)] {chan 3}
>       RFCOMM: Unnumbered Info with Header Check (UIH) (0xef)
>          Address: 0x0b cr 1 dlci 0x02
>          Control: 0xef poll/final 0
>          Length: 14
>          FCS: 0x9a
>         0d 0a 2b 43 49 45 56 3a 20 32 2c 32 0d 0a 9a     ..+CIEV: 2,2..>
> ...
> > SCO Data RX: Handle 3 flags 0x00 dlen 60       #5349 [hci0] 92.037778
> < SCO Data TX: Handle 3 flags 0x00 dlen 60       #5350 [hci0] 92.038218
> > HCI Event: Max Slots Change (0x1b) plen 3      #5351 [hci0] 92.040758
>         Handle: 2
>         Max slots: 1
> > HCI Event: Number of Complete.. (0x13) plen 5  #5352 [hci0] 92.041760
>         Num handles: 1
>         Handle: 2
>         Count: 1
> > HCI Event: Number of Complete.. (0x13) plen 5  #5353 [hci0] 92.044784
>         Num handles: 1
>         Handle: 2
>         Count: 1
> > SCO Data RX: Handle 3 flags 0x00 dlen 60       #5354 [hci0] 92.047706
> < SCO Data TX: Handle 3 flags 0x00 dlen 60       #5355 [hci0] 92.048226
> > SCO Data RX: Handle 3 flags 0x00 dlen 60       #5356 [hci0] 92.057706
> < SCO Data TX: Handle 3 flags 0x00 dlen 60       #5357 [hci0] 92.058179
> ...
> > SCO Data RX: Handle 3 flags 0x00 dlen 60       #5362 [hci0] 92.067775
> > SCO Data RX: Handle 3 flags 0x00 dlen 60       #5363 [hci0] 92.067780
> < SCO Data TX: Handle 3 flags 0x00 dlen 60       #5364 [hci0] 92.068288
> < SCO Data TX: Handle 3 flags 0x00 dlen 60       #5365 [hci0] 92.068322
> > SCO Data RX: Handle 3 flags 0x00 dlen 60       #5366 [hci0] 92.077733
> < SCO Data TX: Handle 3 flags 0x00 dlen 60       #5367 [hci0] 92.078263
>=20
> Signed-off-by: Alex Lu <alex_lu@realsil.com.cn>
> Signed-off-by: Hilda Wu <hildawu@realtek.com>
>=20
> ---
> Change:
> v2: Use btusb_find_altsetting replace duplicating logic, add tested log.
> ---
> ---
>  drivers/bluetooth/btrtl.c |  3 ++
>  drivers/bluetooth/btrtl.h |  1 +
>  drivers/bluetooth/btusb.c | 82 +++++++++++++++++++++++++++++----------
>  3 files changed, 66 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index 83025f457ca0..7efd733f9e84 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -1312,6 +1312,9 @@ void btrtl_set_quirks(struct hci_dev *hdev, struct =
btrtl_device_info *btrtl_dev)
>  		    btrtl_dev->project_id =3D=3D CHIP_ID_8852C)
>  			set_bit(HCI_QUIRK_USE_MSFT_EXT_ADDRESS_FILTER, &hdev->quirks);
> =20
> +		if (btrtl_dev->project_id =3D=3D CHIP_ID_8852BT)
> +			btrealtek_set_flag(hdev, REALTEK_ALT6_FORCE);
> +
>  		hci_set_aosp_capable(hdev);
>  		break;
>  	default:
> diff --git a/drivers/bluetooth/btrtl.h b/drivers/bluetooth/btrtl.h
> index a2d9d34f9fb0..ffec2fca88ec 100644
> --- a/drivers/bluetooth/btrtl.h
> +++ b/drivers/bluetooth/btrtl.h
> @@ -105,6 +105,7 @@ struct rtl_vendor_cmd {
> =20
>  enum {
>  	REALTEK_ALT6_CONTINUOUS_TX_CHIP,
> +	REALTEK_ALT6_FORCE,
> =20
>  	__REALTEK_NUM_FLAGS,
>  };
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 279fe6c115fa..0a2107baf18a 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -814,6 +814,7 @@ struct qca_dump_info {
>  #define BTUSB_USE_ALT3_FOR_WBS	15
>  #define BTUSB_ALT6_CONTINUOUS_TX	16
>  #define BTUSB_HW_SSR_ACTIVE	17
> +#define BTUSB_ISOC_ALT_CHANGED	18
> =20
>  struct btusb_data {
>  	struct hci_dev       *hdev;
> @@ -866,6 +867,7 @@ struct btusb_data {
>  	unsigned int air_mode;
>  	bool usb_alt6_packet_flow;
>  	int isoc_altsetting;
> +	u16 isoc_mps;
>  	int suspend_count;
> =20
>  	int (*recv_event)(struct hci_dev *hdev, struct sk_buff *skb);
> @@ -2140,16 +2142,58 @@ static void btusb_notify(struct hci_dev *hdev, un=
signed int evt)
>  	}
>  }
> =20
> +static struct usb_host_interface *btusb_find_altsetting(struct btusb_dat=
a *data,
> +							int alt)
> +{
> +	struct usb_interface *intf =3D data->isoc;
> +	int i;
> +
> +	BT_DBG("Looking for Alt no :%d", alt);
> +
> +	if (!intf)
> +		return NULL;
> +
> +	for (i =3D 0; i < intf->num_altsetting; i++) {
> +		if (intf->altsetting[i].desc.bAlternateSetting =3D=3D alt)
> +			return &intf->altsetting[i];
> +	}
> +
> +	return NULL;
> +}
> +
>  static inline int __set_isoc_interface(struct hci_dev *hdev, int altsett=
ing)
>  {
>  	struct btusb_data *data =3D hci_get_drvdata(hdev);
>  	struct usb_interface *intf =3D data->isoc;
>  	struct usb_endpoint_descriptor *ep_desc;
> +	struct usb_host_interface *alt;
>  	int i, err;
> =20
>  	if (!data->isoc)
>  		return -ENODEV;
> =20
> +	/* For some Realtek chips, they actually have the altsetting 6, but its
> +	 * altsetting descriptor is not exposed. We can activate altsetting 6 b=
y
> +	 * replacing the altsetting 5.
> +	 */
> +	if (altsetting =3D=3D 6 && !btusb_find_altsetting(data, 6) &&
> +	    btrealtek_test_flag(hdev, REALTEK_ALT6_FORCE)) {

The btrealtek_*_flag() access priv data without checking that the
driver is RTL, probably return garbage/crash for other drivers.

AFAIK they can be used only when it is guaranteed the driver is RTL,
which is not the case here.

> +		alt =3D btusb_find_altsetting(data, 5);
> +		if (alt) {
> +			data->isoc_mps =3D 49;
> +			for (i =3D 0; i < alt->desc.bNumEndpoints; i++) {
> +				ep_desc =3D &alt->endpoint[i].desc;
> +				if (!usb_endpoint_xfer_isoc(ep_desc))
> +					continue;
> +				data->isoc_mps =3D
> +					le16_to_cpu(ep_desc->wMaxPacketSize);
> +				ep_desc->wMaxPacketSize =3D cpu_to_le16(63);
> +			}
> +			alt->desc.bAlternateSetting =3D 6;
> +			set_bit(BTUSB_ISOC_ALT_CHANGED, &data->flags);
> +		}
> +	}
> +
>  	err =3D usb_set_interface(data->udev, data->isoc_ifnum, altsetting);
>  	if (err < 0) {
>  		bt_dev_err(hdev, "setting interface failed (%d)", -err);
> @@ -2161,6 +2205,22 @@ static inline int __set_isoc_interface(struct hci_=
dev *hdev, int altsetting)
>  	data->isoc_tx_ep =3D NULL;
>  	data->isoc_rx_ep =3D NULL;
> =20
> +	/* Recover alt 5 desc if alt 0 is set. */
> +	if (!altsetting && test_bit(BTUSB_ISOC_ALT_CHANGED, &data->flags)) {
> +		alt =3D btusb_find_altsetting(data, 6);
> +		if (alt) {
> +			for (i =3D 0; i < alt->desc.bNumEndpoints; i++) {
> +				ep_desc =3D &alt->endpoint[i].desc;
> +				if (!usb_endpoint_xfer_isoc(ep_desc))
> +					continue;
> +				ep_desc->wMaxPacketSize =3D
> +					cpu_to_le16(data->isoc_mps);
> +			}
> +			alt->desc.bAlternateSetting =3D 5;
> +			clear_bit(BTUSB_ISOC_ALT_CHANGED, &data->flags);
> +		}
> +	}
> +
>  	for (i =3D 0; i < intf->cur_altsetting->desc.bNumEndpoints; i++) {
>  		ep_desc =3D &intf->cur_altsetting->endpoint[i].desc;
> =20
> @@ -2223,25 +2283,6 @@ static int btusb_switch_alt_setting(struct hci_dev=
 *hdev, int new_alts)
>  	return 0;
>  }
> =20
> -static struct usb_host_interface *btusb_find_altsetting(struct btusb_dat=
a *data,
> -							int alt)
> -{
> -	struct usb_interface *intf =3D data->isoc;
> -	int i;
> -
> -	BT_DBG("Looking for Alt no :%d", alt);
> -
> -	if (!intf)
> -		return NULL;
> -
> -	for (i =3D 0; i < intf->num_altsetting; i++) {
> -		if (intf->altsetting[i].desc.bAlternateSetting =3D=3D alt)
> -			return &intf->altsetting[i];
> -	}
> -
> -	return NULL;
> -}
> -
>  static void btusb_work(struct work_struct *work)
>  {
>  	struct btusb_data *data =3D container_of(work, struct btusb_data, work)=
;
> @@ -2279,7 +2320,8 @@ static void btusb_work(struct work_struct *work)
>  			 * MTU >=3D 3 (packets) * 25 (size) - 3 (headers) =3D 72
>  			 * see also Core spec 5, vol 4, B 2.1.1 & Table 2.1.
>  			 */
> -			if (btusb_find_altsetting(data, 6))
> +			if (btusb_find_altsetting(data, 6) ||
> +			    btrealtek_test_flag(hdev, REALTEK_ALT6_FORCE))

Same issue here.

>  				new_alts =3D 6;
>  			else if (btusb_find_altsetting(data, 3) &&
>  				 hdev->sco_mtu >=3D 72 &&

--=20
Pauli Virtanen
