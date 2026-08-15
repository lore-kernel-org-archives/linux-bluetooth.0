Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B46B2773D8;
	Sat, 15 Aug 2026 07:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786779523; cv=none; b=JkX1YhluRwIBp1YUbQ+UMtKmL4FnZK4QeUKbzQhM429AHqscO1pqVRcqAz6Zb0MPNvEpNyuRLGLG4tCVC/JajUOKLhx4/Rv1ifU1eLSkOviVlWSHexQWXBkJjVHgdmKG4NYePt1n1u2RMypPGcLqEBiN5+cLzmmL0ab/GrNYM3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786779523; c=relaxed/simple;
	bh=jeffx8otDeA/kGnXMXI02NDydYsQkLq2NJzRoQdIcA8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b4mig+qiFyNBELsWAVGvVAO+5hlWxF2SspfXuhTPmHQrrxGO+WurXYK4C+nn+nVuu4aSfaRsoCQkc72GIh3fw+jd1OK2v8ZMNWJNjOXPqe7g2kVpzzjMQ+IloO7MiSS1FGs7DFqMO6kg1z4P8ReosQFvyEwbxZg9P7IvlcrzYc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.220] (p57bd97ad.dip0.t-ipconnect.de [87.189.151.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 54C6A4C2C37D4D;
	Sat, 15 Aug 2026 09:38:29 +0200 (CEST)
Message-ID: <7b6368b0-f5ab-45a0-a0a3-6384a78c6687@molgen.mpg.de>
Date: Sat, 15 Aug 2026 09:38:28 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btusb: treat 0bda:0002 as a generic HCI device
To: Andrew Bille <andrewbille@gmail.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Daniel Drake <drake@endlessm.com>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260815033346.15882-1-andrewbille@gmail.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260815033346.15882-1-andrewbille@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Andrew,


Thank you for your patch.

Am 15.08.26 um 05:33 schrieb Andrew Bille:
> The 0bda:0002 Bluetooth controller reports itself as "CSR BS8510"
> and exposes a standard Bluetooth USB interface.

Where did you find this controller?

> It currently matches the vendor-wide Realtek quirk and is therefore
> initialized through btrtl. The controller does not respond to the
> Realtek-specific register access and initialization fails with:
> 
>      Bluetooth: hci0: RTL: RTL: Read reg16 failed (-110)
> 
> No Bluetooth controller is then available to userspace.
> 
> Add an exact match for 0bda:0002 before the generic Realtek entry so
> that the device is handled as a generic USB HCI controller.

Does the device need any firmware?

> With this change the controller registers successfully. Scanning,
> pairing and A2DP audio have been tested successfully.

Please include relevant output of `/sys/kernel/debug/usb/devices`.

> Fixes: a2698a9bf9b0 ("Bluetooth: btusb: Add Realtek 8723A/8723B/8761A/8821A support")
> Cc: stable@vger.kernel.org
> Assisted-by: ChatGPT:GPT-5.6-Sol
> Signed-off-by: Andrew Bille <andrewbille@gmail.com>
> ---
>   drivers/bluetooth/btusb.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 184e95c1625e..fb9fdf90a3b9 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -615,6 +615,9 @@ static const struct usb_device_id quirks_table[] = {
>   	{ USB_DEVICE(0x0489, 0xe130), .driver_info = BTUSB_REALTEK |
>   						     BTUSB_WIDEBAND_SPEECH },
>   
> +	/* CSR BS8510 device using a Realtek USB vendor ID */
> +	{ USB_DEVICE(0x0bda, 0x0002) },
> +

Could some sort of message be logged, as we don’t know if there actual 
Realtek devices out there, that would regress? (More info in the commit 
message regarding regression potential would be useful.)

>   	/* Realtek Bluetooth devices */
>   	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01),
>   	  .driver_info = BTUSB_REALTEK },

With my comments addressed:

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
