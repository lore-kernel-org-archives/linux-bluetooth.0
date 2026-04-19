Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6DF1175A6D;
	Sun, 19 Apr 2026 10:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776594941; cv=pass; b=grs7UF26y+xniMZB/4FTQgPVUx6n/7BVOeNBWDN2o5QoEG2hdAXz/76ukZGvif+0ERMhD1dzJ0lQci+pZiJ984cO4rSD4pcUd95IS/L9+tzia0fnm/Hw1jQGeQ4rfBtPg1Cn+gjqnGpe0QMQ3wyEuYmoS/x++/w6lUNe2i73xOU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776594941; c=relaxed/simple;
	bh=E5Kqxw79hRNLnsyX24XHLhji7PtwrNpKmOmPi7T1QHQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iYiDI2PWc669LyTVHb0YH8o9ZQUkexIRwqr6Fe8W+hQIs5VddiZBIFUgiqfGJpNZw+kgKhumJOy5Pp86DrTcW+L1DEpK7BdU1XiT7S13lfqCV+E2Xeg6wbM7a7aWQHZbA/cr2bwnbvYd8D6tVxzcOzMhT90wvydUak8KZULuQaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=lPrbT/U7; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="lPrbT/U7"
Received: from [10.71.62.38] (unknown [185.65.133.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav@iki.fi)
	by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4fz4l33BvNz49Q67;
	Sun, 19 Apr 2026 13:35:27 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1776594928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5rP+Fe1XpOkLplyhhdcTUuKfBipzvtBCI6bsu4cuWrY=;
	b=lPrbT/U7r0yE/yZe6uqeiyJ9uxXW4FzC0lY3WCpi/2gxvNAqdG0KUSmLDkvh/7MQlzvsRm
	jMiUwHobTOQYlcpiMxxLlCUDWAeELyLi4OQszKeEl2Ftx8Dps2xHZzkiDMk2emyedvFXmq
	X/mR2SRZLBLXxXvgBCoKA3hVQ5jhMaaSzY2ako9WIX82ZaLTcVq9p5RkzSg27VT2Q2Dxjz
	NALEYU5E46zXvxNeVrwUcd7hhuBm58lmjaNBhM4Oa1vJhCTAui/hCgLKEtInG7pp0+yHWB
	x4PlW6oZgnxyRAud7jSLeEGxpV6GW5hyHo1HXPrYKuc2tNTGOiwBKY+oSmAxaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=lahtoruutu; t=1776594928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=5rP+Fe1XpOkLplyhhdcTUuKfBipzvtBCI6bsu4cuWrY=;
	b=paCzmDSaXYDhbfc8lsXjxlRGvWGpWXySo19xHubWxPOiTrcz8QCon+Fy3nkhnKuUBw+ZHH
	Zz0jZDWABJezd5FO/E/ZOaH4YJ/vjS9cn3UjnnRc2CJHliH5o0pSvHaIjdQcbE9e/7kuGb
	G6UK2q62B9m1nDv8dSG2SqKxR9TFhwi1U1lq6iVvyManC6FMECMZLJoSsWJQVUXHlbKLCB
	ACgMa+r7RY3sVgEAnL+8VmtKjnBT9jz5p6zlDkJWQsn3cpU/X/AZHacWTHuIlVt3V4OXSH
	PEvClLpwKAs24eB3x6i+zvnuSUFk7XxyuOIvaq2fm2D3S2fteIVG+TIFdXH4JQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav@iki.fi smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=lahtoruutu; cv=none; t=1776594928;
	b=lM1+Uveu5oQZcudCaKZV3YPzbtkeZCVPplRE9wsfsyzTB3IS0qVdDr80vPI7HuG8NyutjP
	pDiU4Qc9TQKwXfeOsQz38r6PBTzgf/msJ7BymDNF3z65p/t1cmID0IH0JqyGBFadb0QqPD
	jAneC+1YunMGDgZdBpnJ+6ZDvr9KixPqklp0i8qyF2qyGA3mn5Shy8Hr7oMfgacrwZ4erz
	JSY6jnEtomUhYVhCrBUL5sD7CpajqNvcKah4qT4kC/C9mFU5YD+Y8OJTVWB1ttFZ2fveMU
	dvUZg0VfyO754IOIHBcX2TQ0xLccooEvucP86R4nNbib5k4v1c9hEfHo0SklCg==
Message-ID: <8961a9ba3e4a48eaa33060114366573439bbf73f.camel@iki.fi>
Subject: Re: [PATCH] Bluetooth: Add HCI_QUIRK_NO_SCAN_WHILE_CONNECTED for
 combo chips
From: Pauli Virtanen <pav@iki.fi>
To: StefanCondorache <condorachest@gmail.com>, 
	linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-kernel@vger.kernel.org
Date: Sun, 19 Apr 2026 13:35:13 +0300
In-Reply-To: <20260419072433.55976-1-condorachest@gmail.com>
References: <20260419072433.55976-1-condorachest@gmail.com>
Autocrypt: addr=pav@iki.fi; prefer-encrypt=mutual;
 keydata=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
 bzyGkKh2h8XdrYhtDjw9LmrprPQ==
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (3.60.0-1.fc44) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

su, 2026-04-19 kello 10:24 +0300, StefanCondorache kirjoitti:
> Realtek combo chips share a single antenna between Wi-Fi and Bluetooth.
> Background LE passive scanning while an active connection exists causes
> antenna multiplexing conflicts via Packet Traffic Arbitration (PTA),
> resulting in audio stuttering and Wi-Fi packet loss.
>=20
> Add HCI_QUIRK_NO_SCAN_WHILE_CONNECTED to suppress passive scanning in
> hci_update_passive_scan_sync() when active connections are present.
> Set this quirk for all Realtek devices in btrtl_set_quirks().

Some general questions on this, which are not immediately apparent from
the commit message:

How is it know which Realtek models have this bug?

Which ones were tested?

Is it better to set the quirk for all Realtek devices than do it per
USB id / chipset for each known bad device?

> Also add device ID 0x0bda:0xc829 to the btusb Realtek device table.

Patches adding USB device ids usually have USB info from
/sys/kernel/debug/usb/devices in the commit message, see other patches
add these. Probably should be separate patch?

> Signed-off-by: StefanCondorache <condorachest@gmail.com>
> ---
>  drivers/bluetooth/btrtl.c   |  6 ++++++
>  drivers/bluetooth/btusb.c   |  2 ++
>  include/net/bluetooth/hci.h | 11 +++++++++++
>  net/bluetooth/hci_sync.c    |  7 +++++++
>  4 files changed, 26 insertions(+)
>=20
> diff --git a/drivers/bluetooth/btrtl.c b/drivers/bluetooth/btrtl.c
> index 62f9d4df3a4f..00dfba656970 100644
> --- a/drivers/bluetooth/btrtl.c
> +++ b/drivers/bluetooth/btrtl.c
> @@ -1299,6 +1299,12 @@ EXPORT_SYMBOL_GPL(btrtl_download_firmware);
> =20
>  void btrtl_set_quirks(struct hci_dev *hdev, struct btrtl_device_info *bt=
rtl_dev)
>  {
> +	/* Realtek combo chips share the antenna between Wi-Fi and
> +	 * Bluetooth. Suppress passive scanning while connected to
> +	 * prevent coexistence issues.
> +	 */
> +	hci_set_quirk(hdev, HCI_QUIRK_NO_SCAN_WHILE_CONNECTED);

This sets the quirk for all Realtek chips.

Realtek chips are also in stuff like Bluetooth USB dongles that are not
combo wifi ones. Can they be identified?

> +
>  	/* Enable controller to do both LE scan and BR/EDR inquiry
>  	 * simultaneously.
>  	 */
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 5f57953393be..87972f5fc567 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -516,6 +516,8 @@ static const struct usb_device_id quirks_table[] =3D =
{
>  	/* Realtek 8822CU Bluetooth devices */
>  	{ USB_DEVICE(0x13d3, 0x3549), .driver_info =3D BTUSB_REALTEK |
>  						     BTUSB_WIDEBAND_SPEECH },
> +	{ USB_DEVICE(0x0bda, 0xc829), .driver_info =3D BTUSB_REALTEK |
> +							 BTUSB_WIDEBAND_SPEECH },
> =20
>  	/* Realtek 8851BE Bluetooth devices */
>  	{ USB_DEVICE(0x0bda, 0xb850), .driver_info =3D BTUSB_REALTEK },
> diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
> index 572b1c620c5d..8466dc52aeca 100644
> --- a/include/net/bluetooth/hci.h
> +++ b/include/net/bluetooth/hci.h
> @@ -378,6 +378,17 @@ enum {
>  	 */
>  	HCI_QUIRK_BROKEN_READ_PAGE_SCAN_TYPE,
> =20
> +	/* When this quirk is set, the controller suppresses passive LE
> +	 * background scanning while an active connection exists.
> +	 * This is required for combo chips with shared Wi-Fi/Bluetooth
> +	 * antennas to prevent coexistence issues causing audio drops
> +	 * and Wi-Fi packet loss.
> +	 *
> +	 * This quirk can be set before hci_register_dev is called or
> +	 * during the hdev->setup vendor callback.
> +	 */
> +	HCI_QUIRK_NO_SCAN_WHILE_CONNECTED,
> +
>  	__HCI_NUM_QUIRKS,
>  };
> =20
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index fd3aacdea512..5e30e725efa2 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -3194,6 +3194,13 @@ int hci_update_passive_scan_sync(struct hci_dev *h=
dev)
>  	if (hdev->discovery.state !=3D DISCOVERY_STOPPED)
>  		return 0;
> =20
> +	/* If the controller requires no scanning while connected,
> +	 * suppress passive scanning when an active connection exists.
> +	 */
> +	if (hci_test_quirk(hdev, HCI_QUIRK_NO_SCAN_WHILE_CONNECTED) &&
> +	    !list_empty(&hdev->conn_hash.list))
> +		return 0;
> +

Does this break initiating connections via hci_connect_le_scan() if
another connection is active?

Is it possible to make more than one LE connection simultaneously?

>  	/* Reset RSSI and UUID filters when starting background scanning
>  	 * since these filters are meant for service discovery only.
>  	 *

--=20
Pauli Virtanen
