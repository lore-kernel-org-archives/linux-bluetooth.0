Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BAC11CBA
	for <linux-bluetooth@vger.kernel.org>; Fri, 16 Jan 2026 13:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768570603; cv=none; b=tlmU9c5rvI2j4wukyyQx5zcApqR9tY7SNdEjLU98YtZK4ZU3oIkXMNKHHzZosLgCAB1GeJM9+hGEK/ZQYdzR+WBjOXD2AP3937hm3RAoqHL8RAOL2kPP+kjHLMtocf0Qkbw1R6uw56AEehQQ91mrRqEFQjOd+sChHeLA9DOIN/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768570603; c=relaxed/simple;
	bh=VNPpU3kP+9mGZU6XHw0S2/hmxMa4poFxiUJBKNCyfCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=Z21lFHZZ0oMlkxRCDsQfX0yM/i8xnUs/vvQr7TJj/HhY3/8o6qPGw35okckfUKvpEpd1GxMfXlf1OHlGAJYtnUHAxY5bMjUVbJQDsdKWb9QM2P+MIu48PNw19gaOG+NTskMOVyGRE6gU3AQRHjtIodIb1aEGJQsfyahHunFB94w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8E5AC4C442FC6E;
	Fri, 16 Jan 2026 14:36:37 +0100 (CET)
Message-ID: <04d31b37-05c0-4080-b175-56b601e6bb46@molgen.mpg.de>
Date: Fri, 16 Jan 2026 14:36:37 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] Bluetooth: btintel: Remove unneeded CONFIG_PM*
 #ifdef's
To: Bastien Nocera <hadess@hadess.net>
References: <20260116125803.598552-1-hadess@hadess.net>
 <20260116125803.598552-4-hadess@hadess.net>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260116125803.598552-4-hadess@hadess.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Bastien,


Thank you for your patch.

Am 16.01.26 um 13:50 schrieb Bastien Nocera:
> The functions are already disabled if CONFIG_PM or CONFIG_PM_SLEEP are
> disabled through the use of SET_SYSTEM_SLEEP_PM_OPS() and
> SET_RUNTIME_PM_OPS().
> 
> This increases build coverage and allows to drop a few #ifdef's.
> 
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> ---
>   drivers/bluetooth/hci_intel.c | 6 ------
>   1 file changed, 6 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_intel.c b/drivers/bluetooth/hci_intel.c
> index 20baf2895dec..52dca7520fa0 100644
> --- a/drivers/bluetooth/hci_intel.c
> +++ b/drivers/bluetooth/hci_intel.c
> @@ -126,7 +126,6 @@ static int intel_wait_booting(struct hci_uart *hu)
>   	return err;
>   }
>   
> -#ifdef CONFIG_PM
>   static int intel_wait_lpm_transaction(struct hci_uart *hu)
>   {
>   	struct intel_data *intel = hu->priv;
> @@ -237,7 +236,6 @@ static int intel_lpm_resume(struct hci_uart *hu)
>   
>   	return 0;
>   }
> -#endif /* CONFIG_PM */
>   
>   static int intel_lpm_host_wake(struct hci_uart *hu)
>   {
> @@ -1066,7 +1064,6 @@ static const struct acpi_device_id intel_acpi_match[] = {
>   MODULE_DEVICE_TABLE(acpi, intel_acpi_match);
>   #endif
>   
> -#ifdef CONFIG_PM
>   static int intel_suspend_device(struct device *dev)
>   {
>   	struct intel_device *idev = dev_get_drvdata(dev);
> @@ -1090,9 +1087,7 @@ static int intel_resume_device(struct device *dev)
>   
>   	return 0;
>   }
> -#endif
>   
> -#ifdef CONFIG_PM_SLEEP
>   static int intel_suspend(struct device *dev)
>   {
>   	struct intel_device *idev = dev_get_drvdata(dev);
> @@ -1112,7 +1107,6 @@ static int intel_resume(struct device *dev)
>   
>   	return intel_resume_device(dev);
>   }
> -#endif
>   
>   static const struct dev_pm_ops intel_pm_ops = {
>   	SET_SYSTEM_SLEEP_PM_OPS(intel_suspend, intel_resume)

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
