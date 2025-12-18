Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFBF3314CE
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Dec 2025 12:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766061692; cv=none; b=f50gg3s834iFnZiqPDIhX3ZMgopSfqGYO5qtmcIUsQDhpkPRViXlNupRPBJRDrFGPPBAT/u5Vuuf9FlavvLneLMAD/jH6HrWI3LUn8ZkmcmxXgZ3jC3ef8ccZPrLch7092JmHR+xmCkRIug0C+WyC8KCHMoFWY4GqlEmIaTx3Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766061692; c=relaxed/simple;
	bh=jUxt4k7UKtHa3evezAF29IB9mGnsTeBDvQzMsZMgg0M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=oUZuOW5Gk1dps+2T0fo+Tpy0MfUXMFhIoGzAC3mG1ZowXWwjkc++wDZJP5S+ZIVK9l/9XIH7evQ4szYoTzEpE/W5mCj3IEsV4yCypOh8W0QK9pJ+OYxQiV67A9nfic4lLbJStOKzLLFzleT32Xh/LMu6I1hUekRuUAFxTPJrkjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1A65961CC3FF9;
	Thu, 18 Dec 2025 13:41:11 +0100 (CET)
Message-ID: <9831beac-8f6c-414b-b160-5755fdb6e87f@molgen.mpg.de>
Date: Thu, 18 Dec 2025 13:41:07 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: mgmt: Fix TLV parameter code type conversion
To: =?UTF-8?Q?Stefan_S=C3=B8rensen?= <ssorensen@roku.com>
References: <20251218120826.533081-1-ssorensen@roku.com>
Content-Language: en-US
Cc: marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com,
 linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251218120826.533081-1-ssorensen@roku.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Stefan,


Am 18.12.25 um 13:08 schrieb Stefan Sørensen:
> Use the correct le16 conversion for the TLV type field when adding a
> TLV using a u32 data field.

Why is the correct conversion?

> Fixes: afa20d8099ddf ("Bluetooth: mgmt: Add idle_timeout to configurable system parameters")
> Signed-off-by: Stefan Sørensen <ssorensen@roku.com>
> ---
>   net/bluetooth/mgmt_config.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/bluetooth/mgmt_config.c b/net/bluetooth/mgmt_config.c
> index 4ec6c008cb7e6..fdcc752c6f13f 100644
> --- a/net/bluetooth/mgmt_config.c
> +++ b/net/bluetooth/mgmt_config.c
> @@ -37,7 +37,7 @@
>   
>   #define TLV_SET_U32(_param_code_, _param_name_) \
>   	{ \
> -		{ cpu_to_le32(_param_code_), sizeof(__u32) }, \
> +		{ cpu_to_le16(_param_code_), sizeof(__u32) }, \
>   		cpu_to_le32(hdev->_param_name_) \
>   	}
>   


Kind regards,

Paul
