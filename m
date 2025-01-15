Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFE62442E0;
	Wed, 15 Jan 2025 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736948845; cv=none; b=j5rA0sq+QiZc3Ipc9g/mmZMD2A3gtzRMhmw48aayHjxxGICslFeyNlyhC5xT1Z1I/RIPMbjZDbGL7cRv1j17dHjhXdDRj1Zu6eV1W/bTgyf+BQaVh/BbIWJ193T+0cEYRfdZjrhAW2fUWBCgsI3m7zqrYp+eni7jdGldjlQeejc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736948845; c=relaxed/simple;
	bh=eoJjMXQuNSdT0sKvzdz5AoeKOULbBgVot49/V/9uyFA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ET3unZnDdIjNaCRux03I5WpP/MGk74YkGLSnW0sT3xoQDuY+s7Iqc3IEVMJQtEI9sDV/eV4audMWNcKr/ZfmhEtesCk0zu8TRSAblHrrVS0FWpU2uWi8k5uC7D59QcX7klUPgZWEJVDBoStw1/h+G3De4MOYNt1jLbYzjqFkvxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.45] (g45.guest.molgen.mpg.de [141.14.220.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 19DAA61E647A3;
	Wed, 15 Jan 2025 14:47:05 +0100 (CET)
Message-ID: <65518362-55ca-47d0-99ea-9bee3a8aef05@molgen.mpg.de>
Date: Wed, 15 Jan 2025 14:47:04 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btusb: Add 14 USB device IDs for Qualcomm
 WCN785x
To: Zijun Hu <quic_zijuhu@quicinc.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Zijun Hu
 <zijun_hu@icloud.com>, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250115-qc_wos_btusb-v1-1-811664ce5d64@quicinc.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250115-qc_wos_btusb-v1-1-811664ce5d64@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Zijun,


Thank you for your patch.


Am 15.01.25 um 14:33 schrieb Zijun Hu:
> Add 14 USB device IDs for Qualcomm WCN785x, and these IDs are extracted
> from driver inf file within various types of WoS(Windows on Snapdragon)

Please add a space before the (.

> laptop.

If possible, it’d be great if you listed the various laptop types in the 
commit message.

> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> ---
>   drivers/bluetooth/btusb.c | 28 ++++++++++++++++++++++++++++
>   1 file changed, 28 insertions(+)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 9aa018d4f6f5..633a0d11474d 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -375,10 +375,38 @@ static const struct usb_device_id quirks_table[] = {
>   						     BTUSB_WIDEBAND_SPEECH },
>   	{ USB_DEVICE(0x0489, 0xe0f3), .driver_info = BTUSB_QCA_WCN6855 |
>   						     BTUSB_WIDEBAND_SPEECH },
> +	{ USB_DEVICE(0x0489, 0xe100), .driver_info = BTUSB_QCA_WCN6855 |
> +						     BTUSB_WIDEBAND_SPEECH },
> +	{ USB_DEVICE(0x0489, 0xe103), .driver_info = BTUSB_QCA_WCN6855 |
> +						     BTUSB_WIDEBAND_SPEECH },
> +	{ USB_DEVICE(0x0489, 0xe10a), .driver_info = BTUSB_QCA_WCN6855 |
> +						     BTUSB_WIDEBAND_SPEECH },
> +	{ USB_DEVICE(0x0489, 0xe10d), .driver_info = BTUSB_QCA_WCN6855 |
> +						     BTUSB_WIDEBAND_SPEECH },
> +	{ USB_DEVICE(0x0489, 0xe11b), .driver_info = BTUSB_QCA_WCN6855 |
> +						     BTUSB_WIDEBAND_SPEECH },
> +	{ USB_DEVICE(0x0489, 0xe11c), .driver_info = BTUSB_QCA_WCN6855 |
> +						     BTUSB_WIDEBAND_SPEECH },
> +	{ USB_DEVICE(0x0489, 0xe11f), .driver_info = BTUSB_QCA_WCN6855 |
> +						     BTUSB_WIDEBAND_SPEECH },
> +	{ USB_DEVICE(0x0489, 0xe141), .driver_info = BTUSB_QCA_WCN6855 |
> +						     BTUSB_WIDEBAND_SPEECH },
> +	{ USB_DEVICE(0x0489, 0xe14a), .driver_info = BTUSB_QCA_WCN6855 |
> +						     BTUSB_WIDEBAND_SPEECH },
> +	{ USB_DEVICE(0x0489, 0xe14b), .driver_info = BTUSB_QCA_WCN6855 |
> +						     BTUSB_WIDEBAND_SPEECH },
> +	{ USB_DEVICE(0x0489, 0xe14d), .driver_info = BTUSB_QCA_WCN6855 |
> +						     BTUSB_WIDEBAND_SPEECH },
>   	{ USB_DEVICE(0x13d3, 0x3623), .driver_info = BTUSB_QCA_WCN6855 |
>   						     BTUSB_WIDEBAND_SPEECH },
> +	{ USB_DEVICE(0x13d3, 0x3624), .driver_info = BTUSB_QCA_WCN6855 |
> +						     BTUSB_WIDEBAND_SPEECH },
>   	{ USB_DEVICE(0x2c7c, 0x0130), .driver_info = BTUSB_QCA_WCN6855 |
>   						     BTUSB_WIDEBAND_SPEECH },
> +	{ USB_DEVICE(0x2c7c, 0x0131), .driver_info = BTUSB_QCA_WCN6855 |
> +						     BTUSB_WIDEBAND_SPEECH },
> +	{ USB_DEVICE(0x2c7c, 0x0132), .driver_info = BTUSB_QCA_WCN6855 |
> +						     BTUSB_WIDEBAND_SPEECH },
>   
>   	/* Broadcom BCM2035 */
>   	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = BTUSB_BCM92035 },


Kind regards,

Paul
