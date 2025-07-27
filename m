Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355CE219EB;
	Sun, 27 Jul 2025 08:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753605001; cv=none; b=dmPRF/fdk20evEowzOFb2SAx8w7hdrLeTJa4mrtMu0byL2PgrxNM6QszEp6ADqJpm9LikxZwpY1vk9468D8J2j+z+c8IA0Sw+RprIh18Wr8cBELo1A/s1/7LS7i2GbRFnjY13XNkwWpVPrc115lucjBN89geB8glXMidtlYVo94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753605001; c=relaxed/simple;
	bh=xr0tpliZDQIN+IiWtRnec3+fNqVNhbApJRTIlHblPuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Xs/4+CTLOX7Cg8VySwxtMSf/kwdtsraLMF2pM1oFAjGmbp2Qtj1+72rZUCtaDOqtzG3uJk2+K5G9uujMa+BEWGpvn+vi0TMJPF4pY4qvZBC+FsfhSq5rXu6Mu6Wm7+EbCJZCC2A3OMfY9OY4sRtq4PWtiqg4CDaClgy7PJoGReQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.202] (p5b13a0f7.dip0.t-ipconnect.de [91.19.160.247])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0D7A861E64849;
	Sun, 27 Jul 2025 10:29:45 +0200 (CEST)
Message-ID: <1a02a250-f56b-47bf-9816-2ef1c1e68862@molgen.mpg.de>
Date: Sun, 27 Jul 2025 10:29:44 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: bcm203x: Fix use-after-free and memory leak in
 device lifecycle
To: Salah Triki <salah.triki@gmail.com>
References: <aIR0ekNXjuLs6IWa@pc>
Content-Language: en-US
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <aIR0ekNXjuLs6IWa@pc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Salah,


Thank you for your patch.


Am 26.07.25 um 08:23 schrieb Salah Triki:
> The driver stores a reference to the `usb_device` structure (`udev`)
> in its private data (`data->udev`), which can persist beyond the
> immediate context of the `bcm203x_probe()` function.
> 
> Without proper reference count management, this can lead to two issues:
> 
> 1. A `use-after-free` scenario if `udev` is accessed after its main
>     reference count drops to zero (e.g., if the device is disconnected
>     and the `data` structure is still active).
> 2. A `memory leak` if `udev`'s reference count is not properly
>     decremented during driver disconnect, preventing the `usb_device`
>     object from being freed.
> 
> To correctly manage the `udev` lifetime, explicitly increment its
> reference count with `usb_get_dev(udev)` when storing it in the
> driver's private data. Correspondingly, decrement the reference count
> with `usb_put_dev(data->udev)` in the `bcm203x_disconnect()` callback.
> 
> This ensures `udev` remains valid while referenced by the driver's
> private data and is properly released when no longer needed.
> 

Please add a Fixes: tag.

> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
>   drivers/bluetooth/bcm203x.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/bcm203x.c b/drivers/bluetooth/bcm203x.c
> index c738ad0408cb..c91eaba33905 100644
> --- a/drivers/bluetooth/bcm203x.c
> +++ b/drivers/bluetooth/bcm203x.c
> @@ -165,7 +165,7 @@ static int bcm203x_probe(struct usb_interface *intf, const struct usb_device_id
>   	if (!data)
>   		return -ENOMEM;
>   
> -	data->udev  = udev;
> +	data->udev  = usb_get_dev(udev);
>   	data->state = BCM203X_LOAD_MINIDRV;
>   
>   	data->urb = usb_alloc_urb(0, GFP_KERNEL);
> @@ -243,6 +243,8 @@ static void bcm203x_disconnect(struct usb_interface *intf)
>   
>   	usb_set_intfdata(intf, NULL);
>   
> +	usb_put_dev(data->udev);
> +
>   	usb_free_urb(data->urb);
>   	kfree(data->fw_data);
>   	kfree(data->buffer);

The diff looks good to me, though other Bluetooth drivers seem to use 
`interface_to_usbdev(intf)`.


Kind regards,

Paul
