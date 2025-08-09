Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DF3A2AE90
	for <linux-bluetooth@vger.kernel.org>; Sat,  9 Aug 2025 05:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754718037; cv=none; b=cx9qsWUvDJvj6I4r6YKA3JFEQIlR6KiSSYVmC8GR+vTWkpRh7DGnpIaBJowZJKihNqRvKUSFRvDusLnCpvDoM5SgqQxskmvWfyI6rCbXzz2SIPEpA2kUDUddYZ0vGBiHdF/rFN48Jgfukmp5kf3kkZK1/7dQDotHnTFLnlm2aIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754718037; c=relaxed/simple;
	bh=j6TlCEzTdktQnXTPe2LM4tj1eVT9ame0nmyGkTWpmwY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=d+L5iYYUAc/ruRydpGh6VVcCqsiPD0zxstEo1cp3YU+w/wZseffXWCZ6Bmh+wVZJy/0jRgc1b+/rJtymrW9BDIfRmJ5CuwRwCnvXL6BMmxD0PabRaCukXsvjd0F2VYThaMfA7DMnOoENATZVsJsBtCHflEBglZDtO3AWTTT5FkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af7a9.dynamic.kabel-deutschland.de [95.90.247.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id E0F4061E647B7;
	Sat, 09 Aug 2025 07:40:27 +0200 (CEST)
Message-ID: <59fe2e9e-c150-44e4-9140-3fc09eaddaa0@molgen.mpg.de>
Date: Sat, 9 Aug 2025 07:40:24 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] lib/uuid: Do not use mixed-case letters in UUIDs
To: Arkadiusz Bokowy <arkadiusz.bokowy@gmail.com>
References: <20250808170630.202336-1-arkadiusz.bokowy@gmail.com>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250808170630.202336-1-arkadiusz.bokowy@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Arkadiusz,


Thank you for your patch.

Am 08.08.25 um 19:06 schrieb Arkadiusz Bokowy:

Maybe mention, that you settled on lower case, or make the summary more 
specific: lib/uuid: Make mixed-case letter UUIDs lowercase.

Also, your Signed-off-by: line is missing.

> ---
>   lib/uuid.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/uuid.h b/lib/uuid.h
> index 479986f06..67cb1b92b 100644
> --- a/lib/uuid.h
> +++ b/lib/uuid.h
> @@ -50,7 +50,7 @@ extern "C" {
>   #define BATTERY_UUID		"0000180f-0000-1000-8000-00805f9b34fb"
>   #define SCAN_PARAMETERS_UUID	"00001813-0000-1000-8000-00805f9b34fb"
>   
> -#define SAP_UUID		"0000112D-0000-1000-8000-00805f9b34fb"
> +#define SAP_UUID		"0000112d-0000-1000-8000-00805f9b34fb"
>   
>   #define HEART_RATE_UUID			"0000180d-0000-1000-8000-00805f9b34fb"
>   #define HEART_RATE_MEASUREMENT_UUID	"00002a37-0000-1000-8000-00805f9b34fb"
> @@ -164,7 +164,7 @@ extern "C" {
>   #define BAA_SERVICE_UUID	"00001851-0000-1000-8000-00805f9b34fb"
>   
>   #define ASHA_SERVICE					0xFDF0
> -#define ASHA_PROFILE_UUID	"0000FDF0-0000-1000-8000-00805f9b34fb"
> +#define ASHA_PROFILE_UUID	"0000fdf0-0000-1000-8000-00805f9b34fb"
>   
>   #define PAC_CONTEXT					0x2bcd
>   #define PAC_SUPPORTED_CONTEXT				0x2bce

With the formalities fixed:

Reviewed-by: Paul Menzel


Kind regards,

Paul
