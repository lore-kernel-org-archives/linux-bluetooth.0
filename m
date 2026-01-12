Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E301A2BE7BE
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Jan 2026 11:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768216748; cv=none; b=nm2gPlHI4IkU4mUEZjAI39h9MVxRg8lGZzssq05h3lz+gqifjVHBWZOgliyLHRjtaC6rNEsAk07BZ9ZTIkkTd3JM/O8Q9nbfnm0n/h43ZuilyP58hBx3umMRz8Lj3ML/ptCRJiup1E4AQFq5W5OZ+vG7+PJwcLnLzOASe7sUY88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768216748; c=relaxed/simple;
	bh=xyqRWG8B52HFgGAnPubGHgfaf1fal8XfX6GddRL0fUM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=WX1uLFmTzoUmzZDKx5Ue1RjQUN2r5Vz5qSVBwboTYda9tYxX0AHpx0mtx3uKy9Ij/ZmvSbKkjw9nIPxA4JTGRWMLgpzCpUgpmYr6NvGHjYwVE2mCelFzhxSSN8eqOhkVVDEg9vmvZSSTeyvGXAOh6pOzaaOga1EsTdF/shKvp9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.2.217] (p5b13a106.dip0.t-ipconnect.de [91.19.161.6])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id A55C52394AFE6;
	Mon, 12 Jan 2026 12:18:58 +0100 (CET)
Message-ID: <3d3b1c23-8d35-45a2-a7e5-16610251b955@molgen.mpg.de>
Date: Mon, 12 Jan 2026 12:18:57 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: btusb: Use pm_ptr instead of #ifdef CONFIG_PM
To: Bastien Nocera <hadess@hadess.net>
References: <20260112105127.3664608-1-hadess@hadess.net>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20260112105127.3664608-1-hadess@hadess.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Bastian,


Thank you for your patch.

Am 12.01.26 um 11:51 schrieb Bastien Nocera:
> This increases build coverage and allows to drop an #ifdef.
> 
> Signed-off-by: Bastien Nocera <hadess@hadess.net>
> ---
>   drivers/bluetooth/btusb.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 8ed3883ab8ee..539e93227b5c 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -4627,10 +4627,8 @@ static struct usb_driver btusb_driver = {
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
