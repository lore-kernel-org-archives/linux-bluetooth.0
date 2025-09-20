Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41A328727A
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Sep 2025 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758359494; cv=none; b=oZfAULakIFg7BghQwpm6DnzKVIffFx5Ixkgz+irIzQzI6pN+YnXS1U2IKTfcGIUQmR74L4E/VJWDdoofY2ieHp83NslgIYXpTZXz1XNg3u0kj+LjyhVEeSA9RVMve/D3eHzwEfJ7ZIBB5Tv+iet/n9hggTKO8xUhsME1dNibOFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758359494; c=relaxed/simple;
	bh=9ktbEPQLs9J1XGEWnozgtsPPWxbLaMSRrz5wLXhn5mk=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:Cc:From:
	 In-Reply-To:Content-Type; b=aZoqiAy/uyF2h+1GDOnDl/0pru1BVFlOXL+sAie6VKctkuq4aFtcxZHQrp/b6nuAyqNGEmRw2Hisdn9Ahw6KmhbXU0zDy/wU6Jbo08VSLTG0LB4pvpha2csylAuPeyH45H/Fd/CtmvcSzDB52n2FPD1MTbRFCl0UrWvLAU0Qvj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.5] (ip5f5af13c.dynamic.kabel-deutschland.de [95.90.241.60])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 3932D6028F376;
	Sat, 20 Sep 2025 11:01:24 +0200 (CEST)
Message-ID: <d11fd07a-85a4-4531-9b39-f1356fb37627@molgen.mpg.de>
Date: Sat, 20 Sep 2025 11:01:22 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: hci_sync: Fix using random address for
 BIG/PA advertisements
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
References: <20250919163005.2278059-1-luiz.dentz@gmail.com>
Content-Language: en-US
Cc: linux-bluetooth@vger.kernel.org
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20250919163005.2278059-1-luiz.dentz@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Dear Luiz,


Thank you for your patch.

Am 19.09.25 um 18:30 schrieb Luiz Augusto von Dentz:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> 
> When creating an advertisement for BIG the address shall not be
> non-resolvable since in case of acting as BASS/Broadcast Assistant the
> address must be the same as the connection in order to use the PAST
> method and even when PAST/BASS are not in the picture a PA can still be

PA = Periodic Advertisement

> synchronized thus the same argument as to connectable advertisements
> still stand.

stand*s*

> Fixes: eca0ae4aea66 ("Bluetooth: Add initial implementation of BIS connections")

Just for the record, that entered Linux in 6.0-rc1.

> Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
> ---
>   net/bluetooth/hci_sync.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index 6a0f731615f2..7f4310dc804c 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -1325,7 +1325,7 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
>   {
>   	struct hci_cp_le_set_ext_adv_params cp;
>   	struct hci_rp_le_set_ext_adv_params rp;
> -	bool connectable;
> +	bool connectable, require_privacy;
>   	u32 flags;
>   	bdaddr_t random_addr;
>   	u8 own_addr_type;
> @@ -1363,10 +1363,12 @@ int hci_setup_ext_adv_instance_sync(struct hci_dev *hdev, u8 instance)
>   		return -EPERM;
>   
>   	/* Set require_privacy to true only when non-connectable
> -	 * advertising is used. In that case it is fine to use a
> -	 * non-resolvable private address.
> +	 * advertising is used and it is not periodic.
> +	 * In that case it is fine to use a non-resolvable private address.
>   	 */
> -	err = hci_get_random_address(hdev, !connectable,
> +	require_privacy = !connectable && !(adv && adv->periodic);
> +
> +	err = hci_get_random_address(hdev, require_privacy,
>   				     adv_use_rpa(hdev, flags), adv,
>   				     &own_addr_type, &random_addr);
>   	if (err < 0)

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
