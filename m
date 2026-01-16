Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E46313C9C4
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768570434; cv=none; b=PpGHZ8BwYZzGHFOEZir8UJyF4waudwd8g7f6czMr0rtZfWL07PJVLA7ymEnjDlOoqB6aQKGRuip59IVpU5rKxdRGMoOgWQv5kRW0Dd4FG4W/HCqzqrfzcuD5h+dwmurQcekUJfzn+xxiU0jdqohvsupCu049YiE9gBQh4yNaaYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768570434; c=relaxed/simple;
	bh=HKfZAu36zFTLoNGU//bO14dU+hoLm4QXvYTAbGPImtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Cl4vzJIA3qkG76W1mOnN8Jb5eESFYh1ZduoJntxIRcoZ510wfdUYbHV5qX7wqGh2GbGD52cc+kuWgZU6d6NA5o5FMDCWUwVj/TURfKoVdlX0MMDLB8/UAIB6UXNVZMuK9lqzCTnsLFmTn7+HmB3UnH13LdHVQXgl3Qkoa3pGW6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id C883E4C442FC58;
	Fri, 16 Jan 2026 14:33:46 +0100 (CET)
Message-ID: <ebecbe2f-d770-477c-ab61-7513dc95b7a6@molgen.mpg.de>
Date: Fri, 16 Jan 2026 14:33:46 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] Bluetooth: btmtksdio: Simplify dev_pm_ops usage
To: Bastien Nocera <hadess@hadess.net>
References: <20260116125803.598552-1-hadess@hadess.net>
 <20260116125803.598552-2-hadess@hadess.net>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260116125803.598552-2-hadess@hadess.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Bastien,


Thank you for your patch.

Am 16.01.26 um 13:50 schrieb Bastien Nocera:
> This increases build coverage and allows to drop a few #ifdef's.

Should you resend, you could elaborate on the difference between 
SYSTEM_SLEEP_PM_OPS and SET_SYSTEM_SLEEP_PM_OPS.

> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> ---
>   drivers/bluetooth/btmtksdio.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
> index fba3ab6d30a5..ec17521d5b9f 100644
> --- a/drivers/bluetooth/btmtksdio.c
> +++ b/drivers/bluetooth/btmtksdio.c
> @@ -1472,7 +1472,6 @@ static void btmtksdio_remove(struct sdio_func *func)
>   	hci_free_dev(hdev);
>   }
>   
> -#ifdef CONFIG_PM
>   static int btmtksdio_runtime_suspend(struct device *dev)
>   {
>   	struct sdio_func *func = dev_to_sdio_func(dev);
> @@ -1538,22 +1537,17 @@ static int btmtksdio_system_resume(struct device *dev)
>   }
>   
>   static const struct dev_pm_ops btmtksdio_pm_ops = {
> -	SYSTEM_SLEEP_PM_OPS(btmtksdio_system_suspend, btmtksdio_system_resume)
> -	RUNTIME_PM_OPS(btmtksdio_runtime_suspend, btmtksdio_runtime_resume, NULL)
> +	SET_SYSTEM_SLEEP_PM_OPS(btmtksdio_system_suspend, btmtksdio_system_resume)
> +	SET_RUNTIME_PM_OPS(btmtksdio_runtime_suspend, btmtksdio_runtime_resume, NULL)
>   };
>   
> -#define BTMTKSDIO_PM_OPS (&btmtksdio_pm_ops)
> -#else	/* CONFIG_PM */
> -#define BTMTKSDIO_PM_OPS NULL
> -#endif	/* CONFIG_PM */
> -
>   static struct sdio_driver btmtksdio_driver = {
>   	.name		= "btmtksdio",
>   	.probe		= btmtksdio_probe,
>   	.remove		= btmtksdio_remove,
>   	.id_table	= btmtksdio_table,
>   	.drv = {
> -		.pm = BTMTKSDIO_PM_OPS,
> +		.pm = &btmtksdio_pm_ops,
>   	}
>   };

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul

