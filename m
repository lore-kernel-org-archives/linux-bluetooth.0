Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F5034251D
	for <linux-bluetooth@vger.kernel.org>; Tue, 11 Nov 2025 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762874432; cv=none; b=rmR+HLuaLvszotZuwBv2FathndqaGuMKVlVUgYPdZrIF6qdUZ0p6l3LWnHxe+88qhCmCakEFDJhyYVdjagMoGfIBQkVc6ZAp+yE28cXJTldMUNdcQ0RWnt7i8A/QFA+dB/IvGuhuJfAODCfrNFr9esnYJb43NYGmpdK/1UPoscc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762874432; c=relaxed/simple;
	bh=4PewdndPEIfnySWdVktM9Y2ob9TPBpZ9mM8pYOuUtOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BgqxKXRLKnv5W4yIv7fYClRS1QhXOcTlAv3ivyLiKvoaptgj9XQDGcaiydH/UKGhJjsrBTj8AR809CYmNFYd20xlB/tJs2CAZy1JKTMVfYzIyl+XfXYjakv1XDv7ZNw9C4MZy31dYO2wtf38ML97IXiJs4BDiUqtbcwJMhsm9Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.42] (g42.guest.molgen.mpg.de [141.14.220.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id CAE2D61CC3FEF;
	Tue, 11 Nov 2025 16:20:15 +0100 (CET)
Message-ID: <78ccae43-731d-4cee-868d-50d3c5842ea8@molgen.mpg.de>
Date: Tue, 11 Nov 2025 16:20:14 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drivers/bluetooth: btbcm: Use kmalloc_array() to prevent
 overflow
To: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org
References: <20251111142041.229145-1-ayaanmirzabaig85@gmail.com>
Content-Language: de-DE
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20251111142041.229145-1-ayaanmirzabaig85@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Ayaan,


Thank you for your patch.


Am 11.11.25 um 15:20 schrieb Ayaan Mirza Baig:
> Replace the open-coded multiplication in kmalloc() with a call
> to kmalloc_array() to prevent potential integer overflows.

Excuse my ignorance, how would that overflow happen? How is the 
generated code different?

> This is a mechanical change, replacing BCM_FW_NAME_LEN with
> the type-safe sizeof(*fw_name) as the element size

I’d add a dot/period at the end of the sentence.

> Signed-off-by: Ayaan Mirza Baig <ayaanmirzabaig85@gmail.com>
> ---
>   drivers/bluetooth/btbcm.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
> index 3a3a56ddbb06..d33cc70eec66 100644
> --- a/drivers/bluetooth/btbcm.c
> +++ b/drivers/bluetooth/btbcm.c
> @@ -642,7 +642,9 @@ int btbcm_initialize(struct hci_dev *hdev, bool *fw_load_done, bool use_autobaud
>   		snprintf(postfix, sizeof(postfix), "-%4.4x-%4.4x", vid, pid);
>   	}
>   
> -	fw_name = kmalloc(BCM_FW_NAME_COUNT_MAX * BCM_FW_NAME_LEN, GFP_KERNEL);
> +	fw_name = kmalloc_array(BCM_FW_NAME_COUNT_MAX,
> +		sizeof(*fw_name),
> +		GFP_KERNEL);
>   	if (!fw_name)
>   		return -ENOMEM;
>   


Kind regards,

Paul
