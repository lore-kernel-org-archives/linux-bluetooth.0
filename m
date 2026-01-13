Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0F333BBC6
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Jan 2026 09:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768296930; cv=none; b=XrvFNL9e/7Id2/uLA/urFGVcDI6pg6AT3Co3FZHhPoVECmhjB+uzlTqZWwcWe+EFoHTN1p3JZlTx9Ol0a5t+rglF0niYvq40RD06IzSRUcS0EqWQC9UAZwUq4QX9N8Rc0wRq69dFwn424gH5nFJpbAPXPpcgNIuAswg8WsmPa60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768296930; c=relaxed/simple;
	bh=RUd0W6w7YK62kfnbM/N/z2tcovo5+fIQBjy57JyT/MU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=VjpYOP+u67+eNjNqCOPC0Ecn7BUvuUT9c0Dnl2/BJZG+YVDWvU+G0AVRbmYRpZXv5FFwr+AxmFAla3cemB23TNZkxgCEDd8EbQcJEAaz7Hmwgi81VFI6kIFxjIhxtYEQxbfFCqgkibqg1YzYOvNFy57/9nnzqWZxAre/nZ2WAZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.13.172] (g427.RadioFreeInternet.molgen.mpg.de [141.14.13.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 9CBC52387DCEB;
	Tue, 13 Jan 2026 10:35:19 +0100 (CET)
Message-ID: <f9b85a17-d5af-48b3-940c-585ebaa4aadb@molgen.mpg.de>
Date: Tue, 13 Jan 2026 10:35:19 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: btusb: Use pm_ptr instead of #ifdef
 CONFIG_PM
To: Bastien Nocera <hadess@hadess.net>
References: <20260113090128.244709-1-hadess@hadess.net>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260113090128.244709-1-hadess@hadess.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Bastien,


Thank you for your patch.

Am 13.01.26 um 10:01 schrieb Bastien Nocera:
> This increases build coverage and allows to drop an #ifdef.
> 
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> ---
> Changes since v1:
> - Fixed build
> 
>   drivers/bluetooth/btusb.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index ded09e94d296..67ee2b869852 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -4462,7 +4462,6 @@ static void btusb_disconnect(struct usb_interface *intf)
>   	kfree(data);
>   }
>   
> -#ifdef CONFIG_PM
>   static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
>   {
>   	struct btusb_data *data = usb_get_intfdata(intf);
> @@ -4616,7 +4615,6 @@ static int btusb_resume(struct usb_interface *intf)
>   
>   	return err;
>   }
> -#endif
>   
>   #ifdef CONFIG_DEV_COREDUMP
>   static void btusb_coredump(struct device *dev)
> @@ -4633,10 +4631,8 @@ static struct usb_driver btusb_driver = {
>   	.name		= "btusb",
>   	.probe		= btusb_probe,
>   	.disconnect	= btusb_disconnect,
> -#ifdef CONFIG_PM
> -	.suspend	= btusb_suspend,
> -	.resume		= btusb_resume,
> -#endif
> +	.suspend	= pm_ptr(btusb_suspend),
> +	.resume		= pm_ptr(btusb_resume),
>   	.id_table	= btusb_table,
>   	.supports_autosuspend = 1,
>   	.disable_hub_initiated_lpm = 1,

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
