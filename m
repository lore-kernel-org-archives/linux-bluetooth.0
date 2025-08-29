Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D6A211A14
	for <linux-bluetooth@vger.kernel.org>; Fri, 29 Aug 2025 14:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756478853; cv=none; b=a59kLVp6/i3Jjtx+j9va/YMZKokTmvIRnhyXnjN1jnY36EgLRix4vzUUywZb5c/WUAOMPbXeEiKMSBFvFvH2Q8pSvF5H1R+EoZRO7/ysNdotf1j7NM4EdkjZOMowshUg35ig8tO7xCLYCtCDQFLbl3wt4IhCBdqEKTJldS/Z9jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756478853; c=relaxed/simple;
	bh=QvuAdKEq+Ji73Aaw79iuwsynzhU6JxlY1p+zenB7qNE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UfflIjJNGMtSKyr60zuRAXXboTbae6xZN/IZdMCfABtbAJpcGztN3xK3tJUKq4d2mAhwpkyE4eoT12JF3mCmD00K7cha3NFYeHzEEHSrkXE5clqRLMuVzVTWIhegzs7pR7n3+P2QdXbrFeosiHt3R6cqJiB2uHqERXTwmyLQzvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PCNRlm9h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PCNRlm9h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756478851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l57kCAwofXgSoxlRtWMOU/+1veE98KFisOutq6Bmz1k=;
	b=PCNRlm9hX2wCn9eD52JH4NrPED+39BXzY5kAzb+OoJPjd0y/IuR3Oo136tlo9lgFX1iGmX
	seThscAF/TpWXhQadI7wNWNVmizC7JNQ4hbxl/V7nLS7MMEIjgzzHo8eO5SAKNdmhP/0fx
	jsqOl1K3hIJyk/pjFFbdhwjM7ePog2o=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-WP0cd_HANPa7IPARdkcx9w-1; Fri, 29 Aug 2025 10:47:27 -0400
X-MC-Unique: WP0cd_HANPa7IPARdkcx9w-1
X-Mimecast-MFC-AGG-ID: WP0cd_HANPa7IPARdkcx9w_1756478846
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-afeeb44fe3fso157163066b.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Aug 2025 07:47:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756478846; x=1757083646;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l57kCAwofXgSoxlRtWMOU/+1veE98KFisOutq6Bmz1k=;
        b=WCAc6hXD0xultgfjvw2G35XzZ/8RNve9m3NDvXZ0uz5mEXP7UzgBpYbLTRg7RW8n1k
         gS3ae9G292b7hIfxHU8VcNIunqLfRXCYeNP4WGDLAYs6fKW2WxbRiJtEvGvuTKgLY6BQ
         rWEqVN8u1ZJKe30fGpEMc6kZl/RmAsEp+hKru1qBENSWZYgIKyWcrhviPD/d88+ZqVEe
         vKtLenTwPhYMeLzDUNuZskv9l0uV/+FnQvE9wKM0kdEWUkpI3XohuWinldl6be5/Sv+H
         Pv2UzwCLXrpyM8z4uhglQ11H6+WJqo/45Ak4UxMpW9lmuHnKkqBoJmba+tUdwBAczQG0
         q2HQ==
X-Forwarded-Encrypted: i=1; AJvYcCXGPxowgS7nNRXFnYFx4s2WUjKfZIXVCCxVGwy1dMOwHLdwZW3zJZ3hdYk2vQM7HvuxzhcAE+XUmiKvKZow/gM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDwZrl8Qnon+3vSERxPzH7fJQAT+EV27RyTF3To4HF/qtqgAhI
	lgbDcvrpTj0JWIpIo8x8dQ/LGPJeTy+5569N8+NJycwE7mo4FRFnWliH0e3CkEsT2PFl2kAVA+n
	ierCugjpGWGvuJm1j4raRMt9Dhyarik02YVY5Md4wXNkeAi+/GBVzzAFMwYQjvQBBgbJWRQ==
X-Gm-Gg: ASbGncvbdwyRuQOhdsUO9FDgcN507Yb5YT5Rdj6IDHH6cWOVHZeKNKIQ6RvNOi6ZtaS
	mTHJybF+ekjX5j0gQshZe8AHmEBnd6pg6CGitt5pLeArBOhdCMxtLQwAGGd6WtSXEEMbW3i9Eyj
	NTHtOK5HfPSIxCnW6FrVOdep/3Mit7McMUKsD83WXRGUdKelyAK0EiLXKePhBrfr6F9/ili7SKf
	EWhduQLwGQvS24m5ZTMUJo5aLZyQ2GVxsXvFa4KB2Rzl9K7f8cWCBkcG61XEiNFhZKOPCGGYWGg
	W9jXg10ujZsrgKKREfCaKYBi1xZNSc8G1PBgNK8jnx58OjTYpNmkg/wsa0b9DQELo52uIS1IdXE
	D7HiXsK+bhx05XhdD3p8UOZ1vZ3IwHUKAr2i/1vo7K6/GSMSrhiyL53N+BGYtDYqbDado+yL68k
	oRlndyu7dSJ4C9Mmw=
X-Received: by 2002:a17:906:4fca:b0:aff:10a7:7589 with SMTP id a640c23a62f3a-aff10a77b06mr160220966b.64.1756478846365;
        Fri, 29 Aug 2025 07:47:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF+FB1sN2Rss19C9N2+/y4vCWEpfRSC0ObzgI5vwDX0YV77Ax9vfYOtXoYE4jeM83tk0LPjdQ==
X-Received: by 2002:a17:906:4fca:b0:aff:10a7:7589 with SMTP id a640c23a62f3a-aff10a77b06mr160218066b.64.1756478845913;
        Fri, 29 Aug 2025 07:47:25 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-afefcc2d50dsm210942366b.93.2025.08.29.07.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Aug 2025 07:47:25 -0700 (PDT)
Message-ID: <ebb489b9-11f9-4d3a-a64d-7809c22c5a96@redhat.com>
Date: Fri, 29 Aug 2025 16:47:24 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bluetooth-next PATCH] Bluetooth: hci_bcm: Configure sleep mode
 on RPM suspend/resume
To: Marek Vasut <marex@denx.de>, linux-bluetooth@vger.kernel.org
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>, kernel@dh-electronics.com
References: <20240629172235.29901-1-marex@denx.de>
From: Hans de Goede <hdegoede@redhat.com>
Content-Language: en-US, nl
In-Reply-To: <20240629172235.29901-1-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Marek,

On 29-Jun-24 7:22 PM, Marek Vasut wrote:
> The Infineon CYW43439 Bluetooth device enters suspend mode right after
> receiving the Set_Sleepmode_Param sleep_mode=1 HCI command, even if the
> BT_DEV_WAKE input is HIGH, i.e. device ought to be awake. This triggers
> a timeout of any follow up HCI command, in case of regular boot, that is
> HCI_OP_RESET command issued from hci_init1_sync() .
> 
> Rework the code such that during probe, the device is configured to not
> enter sleep mode by issuing Set_Sleepmode_Param sleep_mode=0 instead of
> sleep_mode=1 in bcm_setup(). Upon RPM suspend, issue Set_Sleepmode_Param
> with sleep_mode=1 to allow the device to enter the sleep mode when the
> BT_DEV_WAKE signal is deasserted, which is deasserted soon after in the
> RPM suspend callback. Upon RPM resume, assert BT_DEV_WAKE to resume the
> chip from sleep mode and then issue Set_Sleepmode_Param sleep_mode=0 to
> yet again prevent the device from entering sleep mode until the next RPM
> suspend.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

Thank you for your patch. The patch looks good to me and I've been
running this in my personal tree / test-kernels which includes
various devices with BCM BT serdevs without issues:

Reviewed-by: Hans de Goede <hansg@kernel.org>
Tested-by: Hans de Goede <hansg@kernel.org>

Regards,

Hans



> ---
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: kernel@dh-electronics.com
> Cc: linux-bluetooth@vger.kernel.org
> ---
>  drivers/bluetooth/hci_bcm.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
> index 89d4c2224546f..fde5e0136c392 100644
> --- a/drivers/bluetooth/hci_bcm.c
> +++ b/drivers/bluetooth/hci_bcm.c
> @@ -389,13 +389,19 @@ static const struct bcm_set_sleep_mode default_sleep_params = {
>  	.pulsed_host_wake = 1,
>  };
>  
> -static int bcm_setup_sleep(struct hci_uart *hu)
> +static int bcm_setup_sleep(struct hci_uart *hu, bool sync, int mode)
>  {
>  	struct bcm_data *bcm = hu->priv;
>  	struct sk_buff *skb;
>  	struct bcm_set_sleep_mode sleep_params = default_sleep_params;
>  
>  	sleep_params.host_wake_active = !bcm->dev->irq_active_low;
> +	sleep_params.sleep_mode = mode;
> +
> +	if (!sync) {
> +		return __hci_cmd_send(hu->hdev, 0xfc27, sizeof(sleep_params),
> +				      &sleep_params);
> +	}
>  
>  	skb = __hci_cmd_sync(hu->hdev, 0xfc27, sizeof(sleep_params),
>  			     &sleep_params, HCI_INIT_TIMEOUT);
> @@ -412,7 +418,7 @@ static int bcm_setup_sleep(struct hci_uart *hu)
>  }
>  #else
>  static inline int bcm_request_irq(struct bcm_data *bcm) { return 0; }
> -static inline int bcm_setup_sleep(struct hci_uart *hu) { return 0; }
> +static inline int bcm_setup_sleep(struct hci_uart *hu, bool sync, int mode) { return 0; }
>  #endif
>  
>  static int bcm_set_diag(struct hci_dev *hdev, bool enable)
> @@ -647,7 +653,7 @@ static int bcm_setup(struct hci_uart *hu)
>  		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hu->hdev->quirks);
>  
>  	if (!bcm_request_irq(bcm))
> -		err = bcm_setup_sleep(hu);
> +		err = bcm_setup_sleep(hu, true, 0);
>  
>  	return err;
>  }
> @@ -767,6 +773,16 @@ static int bcm_suspend_device(struct device *dev)
>  	bt_dev_dbg(bdev, "");
>  
>  	if (!bdev->is_suspended && bdev->hu) {
> +		err = bcm_setup_sleep(bdev->hu, false, 1);
> +		/*
> +		 * If the sleep mode cannot be enabled, the BT device
> +		 * may consume more power, but this should not prevent
> +		 * RPM suspend from completion. Warn about this, but
> +		 * attempt to suspend anyway.
> +		 */
> +		if (err)
> +			dev_err(dev, "Failed to enable sleep mode\n");
> +
>  		hci_uart_set_flow_control(bdev->hu, true);
>  
>  		/* Once this returns, driver suspends BT via GPIO */
> @@ -810,6 +826,16 @@ static int bcm_resume_device(struct device *dev)
>  		bdev->is_suspended = false;
>  
>  		hci_uart_set_flow_control(bdev->hu, false);
> +
> +		err = bcm_setup_sleep(bdev->hu, false, 0);
> +		/*
> +		 * If the sleep mode cannot be disabled, the BT device
> +		 * may fail to respond to commands at times, or may be
> +		 * completely unresponsive. Warn user about this, but
> +		 * attempt to resume anyway in best effort manner.
> +		 */
> +		if (err)
> +			dev_err(dev, "Failed to disable sleep mode\n");
>  	}
>  
>  	return 0;

