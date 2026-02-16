Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 855E317A2F6;
	Mon, 16 Feb 2026 12:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771246526; cv=none; b=helvbjwBL1+PiDmuohbiV2fOhCwhbUOP8d8sqcQDfwU01EmXG+QMLvrrUUj11AY9nDZSSAj0d8xcJlQsmUPtjGJpWkxON2PS1RNoVXdkNOamwBviuB/gvSGboq+6zvUO3gT6RhSjEqaW8m1s90j3kBOFCbmszu3YvIEJMeODt3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771246526; c=relaxed/simple;
	bh=wMud/zXsW57h/pzFLrQyWiLWanq9uGVhLdnmh94RKyY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BakWjVKeH78hsEj4xcuXLqJyeUjeypF5l2HhI/FjkVTP6F4o+QkiQZK3X1Pl9xkXRsDZhy27/ga8qHTnmPhQ3JwesxM4pJlamf0IRyAdkcnQPUZ+pKBnGaAk5KgbQrzuW4z/l2fKPboZJq81zh/lHW68fo0FsVdcAmc6KAApFEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AC4bpm3t; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AC4bpm3t"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1771246523;
	bh=wMud/zXsW57h/pzFLrQyWiLWanq9uGVhLdnmh94RKyY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=AC4bpm3thsMtP87lemc3eM14HXqf4MEjhDK6TVvGXfJRYVT+6OrpM7w9MakmNjNRR
	 orgwToWFJjxiMGL5YX/VN5TkTG0D/ZkAm+GUN3JquiQw+dyziBO0zO9t606R+Fpg4k
	 UFKGzpCJlGbccREX9PNc6P241OZxCm6MGIxsly3rljmv7R1Mjb8UVrLcYMT4n+Fjm+
	 UJeF+a+lFsAGvawT8e/K6pSjkWiAe6P1g9gy9hMm/NZcVWaQ9mDiDumTMmBcBunRpS
	 zOP4cuXv8OVBvBL/o0BSG3Xk2uR+A2Mg3lnk8lu2XkW4od6CoLszW9EVbHhD7+Msug
	 xgORXVDmAviYg==
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits))
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 9082D17E12A9;
	Mon, 16 Feb 2026 13:55:23 +0100 (CET)
Message-ID: <60ff7530-b9a4-47a7-b5bc-3c81a57a4fc0@collabora.com>
Date: Mon, 16 Feb 2026 13:55:23 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btusb: Add support for MediaTek MT7902
To: OnlineLearningTutorials <kush.kulshrestha5@gmail.com>,
 luiz.dentz@gmail.com, marcel@holtmann.org
Cc: kush.kulshrestha.5@gmail.com, matthias.bgg@gmail.com,
 linux-bluetooth@vger.kernel.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260214082738.139047-1-kush.kulshrestha.5@gmail.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20260214082738.139047-1-kush.kulshrestha.5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 14/02/26 09:27, OnlineLearningTutorials ha scritto:
> This patch adds USB IDs for the AzureWave/MediaTek MT7902 Bluetooth
> module.
> The device IDs included are:
> - 13d3:3579
> - 13d3:3580
> - 13d3:3594
> - 13d3:3596
> 
> Signed-off-by: OnlineLearningTutorials <kush.kulshrestha.5@gmail.com>

Please use your real name when you send patches, and also use the get_maintainer.pl
script.

Actually, just read: https://docs.kernel.org/process/submitting-patches.html

Regards,
Angelo

> ---
>   drivers/bluetooth/btmtk.c |  1 +
>   drivers/bluetooth/btusb.c | 10 ++++++++++
>   2 files changed, 11 insertions(+)
> 
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index a8c520dc09e1..b793947dd920 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -1323,6 +1323,7 @@ int btmtk_usb_setup(struct hci_dev *hdev)
>   	case 0x7668:
>   		fwname = FIRMWARE_MT7668;
>   		break;
> +	case 0x7902:
>   	case 0x7922:
>   	case 0x7925:
>   	case 0x7961:
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index fcec8e589e81..13a2aa13b9f4 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -629,6 +629,16 @@ static const struct usb_device_id quirks_table[] = {
>   	/* Additional MediaTek MT7668 Bluetooth devices */
>   	{ USB_DEVICE(0x043e, 0x3109), .driver_info = BTUSB_MEDIATEK |
>   						     BTUSB_WIDEBAND_SPEECH },
> +
> +	/* Additional MediaTek MT7902 Bluetooth devices */
> +	{ USB_DEVICE(0x13d3, 0x3579), .driver_info = BTUSB_MEDIATEK |
> +						     BTUSB_WIDEBAND_SPEECH },
> +	{ USB_DEVICE(0x13d3, 0x3580), .driver_info = BTUSB_MEDIATEK |
> +						     BTUSB_WIDEBAND_SPEECH },
> +	{ USB_DEVICE(0x13d3, 0x3594), .driver_info = BTUSB_MEDIATEK |
> +						     BTUSB_WIDEBAND_SPEECH },
> +	{ USB_DEVICE(0x13d3, 0x3596), .driver_info = BTUSB_MEDIATEK |
> +						     BTUSB_WIDEBAND_SPEECH },
>   
>   	/* Additional MediaTek MT7920 Bluetooth devices */
>   	{ USB_DEVICE(0x0489, 0xe134), .driver_info = BTUSB_MEDIATEK |


