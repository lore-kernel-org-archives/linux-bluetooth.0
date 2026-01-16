Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48DDCEACD
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 13:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768570536; cv=none; b=OULf5FZUYwNDy1LxOQXwKeT5iKiHvuJdq5kWPaLm6v1VFCtldooncXHGrfA7dW2QMfmzQ/IhFid9n730jzi+SWErGlvGta3W8xy3kojMEqvAbsK63t7QKWiCVCde1fiBFfo6WgUDyQv+LbjBjGV3dOEBwBIKPDnIGfDAuzyOg6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768570536; c=relaxed/simple;
	bh=h57velXgtpfh2AXfTInN7occB/4qm2dhBjFuGUNTdlQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=LyT4BFP8N0Hgj0VTFDCVDkWlNH7oBHA3oeDyz5827dUHmtm1Kbom03QxcdNCfekDfHtm+6/qtMp/gq61TxRMyNiDQqK0EzwT9WM7TCYIm3aIQgY23+SPiRfKyDknD9+v7IG2iN5StcYZmCm3Ha0lX7Smdvy5UPNjGLp0meX4NX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 653084C442FC58;
	Fri, 16 Jan 2026 14:35:29 +0100 (CET)
Message-ID: <ba5e0921-b15a-4476-9c45-895a135816a8@molgen.mpg.de>
Date: Fri, 16 Jan 2026 14:35:28 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] Bluetooth: btnxpuart: Remove unneeded CONFIG_PM ifdef
To: Bastien Nocera <hadess@hadess.net>
References: <20260116125803.598552-1-hadess@hadess.net>
 <20260116125803.598552-3-hadess@hadess.net>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260116125803.598552-3-hadess@hadess.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Bastien,


Thank you for your patch.

Am 16.01.26 um 13:50 schrieb Bastien Nocera:
> The functions are already disabled through the use of pm_ptr() when
> CONFIG_PM is disabled, and won't be included in the final code if not
> needed.
> 
> This increases build coverage and allows to drop an #ifdef.
> 
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> ---
>   drivers/bluetooth/btnxpuart.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/bluetooth/btnxpuart.c b/drivers/bluetooth/btnxpuart.c
> index 3b1e9224e965..13daa174aaaa 100644
> --- a/drivers/bluetooth/btnxpuart.c
> +++ b/drivers/bluetooth/btnxpuart.c
> @@ -1947,7 +1947,6 @@ static void nxp_serdev_remove(struct serdev_device *serdev)
>   	hci_free_dev(hdev);
>   }
>   
> -#ifdef CONFIG_PM_SLEEP
>   static int nxp_serdev_suspend(struct device *dev)
>   {
>   	struct btnxpuart_dev *nxpdev = dev_get_drvdata(dev);
> @@ -1975,7 +1974,6 @@ static int nxp_serdev_resume(struct device *dev)
>   	ps_control(psdata->hdev, PS_STATE_AWAKE);
>   	return 0;
>   }
> -#endif
>   
>   #ifdef CONFIG_DEV_COREDUMP
>   static void nxp_serdev_coredump(struct device *dev)

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
