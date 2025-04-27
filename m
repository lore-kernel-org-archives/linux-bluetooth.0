Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7A11B4223;
	Sun, 27 Apr 2025 19:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745780489; cv=none; b=Lwv0g986t/Lm2LrCufai5z33GjzpY3apfGqU0KJ6JmM2ITQps9vH1zRo3XB2rCZmcsj6CpkyfgR6PUpHogqYX/0cvI1lFH8b28xVNDfgWVgG7fE+zvrYlPPhrvOTuC+swjc2Ql2T2wmECRcsSuuTJmRMrGM2I/UCASmNQjEqwT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745780489; c=relaxed/simple;
	bh=UDRvEcvidJ5FWlMauEHuj7LUUOKzdZvPl1c91Ca/DaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=LrxS6GBhBIBqPcSLl40IF27bCVpCUdd0ACpI4QRUuldvufINMlXIRD5YQye9u5gG9qKpL4M+bfc5n/oD78xhRn/sTXUcabXjw7DV8bRhXrsjscLXLWqI6evMQhfH7KQPPq9x4s2bhuAHMD+Gfq6ffTTgZdEjHEtxVpcBp8N+Q5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.224] (ip5f5aecdf.dynamic.kabel-deutschland.de [95.90.236.223])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 0916361E64782;
	Sun, 27 Apr 2025 21:01:15 +0200 (CEST)
Message-ID: <0d52b631-547e-4398-93ba-8e3b3dbd84ca@molgen.mpg.de>
Date: Sun, 27 Apr 2025 21:01:13 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers: bluetooth: bpa10x: use usb_{get,put}_dev in
 bpa10x_{probe,disconnect}
To: Salah Triki <salah.triki@gmail.com>
References: <aA5Z_gOXAwrWDI7E@pc>
Content-Language: en-US
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <aA5Z_gOXAwrWDI7E@pc>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Salah,


Thank you for your patch.

Am 27.04.25 um 18:23 schrieb Salah Triki:
> Use usb_{get,put}_dev() to update the ref count of udev.

Could you please add why that is better?

> Signed-off-by: Salah Triki <salah.triki@gmail.com>
> ---
>   drivers/bluetooth/bpa10x.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
> index 1fa58c059cbf..0b9931311a59 100644
> --- a/drivers/bluetooth/bpa10x.c
> +++ b/drivers/bluetooth/bpa10x.c
> @@ -375,7 +375,7 @@ static int bpa10x_probe(struct usb_interface *intf,
>   	if (!data)
>   		return -ENOMEM;
>   
> -	data->udev = interface_to_usbdev(intf);
> +	data->udev = usb_get_dev(interface_to_usbdev(intf));
>   
>   	init_usb_anchor(&data->tx_anchor);
>   	init_usb_anchor(&data->rx_anchor);
> @@ -422,6 +422,8 @@ static void bpa10x_disconnect(struct usb_interface *intf)
>   
>   	usb_set_intfdata(intf, NULL);
>   
> +	usb_put_dev(data->udev);
> +
>   	hci_unregister_dev(data->hdev);
>   
>   	hci_free_dev(data->hdev);


Kind regards,

Paul
