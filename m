Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B122713541F
	for <linux-bluetooth@vger.kernel.org>; Wed,  3 Jul 2024 07:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719990817; cv=none; b=j09YGKv611Q91icv6Um8Lbl5Tud0zyWgXv5vQttbl0EMPS5jxUaAOWsjwAv98Iiu81Aqx/gsCyvks2Xjc/9AA0RC+aXcwsD6EJ/qRSx54ZDBZJrCUiXhTPwemHmV89lfoej7pHk0341xu04TIIrOubx+84iLSZK73AQI0dJsOJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719990817; c=relaxed/simple;
	bh=/J0biAHPe/w1uFAw63EIt4jEnK/4HDQ5D/Jx7ZryiWI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J+oLZwocEdTgU37DaECFxSMXa/jNofJdgQpuVdHOQrPfGO/RmJItf38PSJOaEAkvOr5eJE2moEVDHEwDI3/AogPmttQVKwQbEFw5Ylw46WIyH19PJUBttfDC3oLOIGGYsIZx2akbiw8Klb2kQLwhxc8k7sMtg8F/9q8ra+u4FKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af14b.dynamic.kabel-deutschland.de [95.90.241.75])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id D318B61E5FE0A;
	Wed,  3 Jul 2024 09:13:21 +0200 (CEST)
Message-ID: <be20b37e-065a-4fb5-ae12-4f3ad87ba485@molgen.mpg.de>
Date: Wed, 3 Jul 2024 09:13:21 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Added BREDR not supported bit in AD Flag when
 discoverable is off
To: Prathibha Madugonde <quic_prathm@quicinc.com>
Cc: luiz.dentz@gmail.com, linux-bluetooth@vger.kernel.org,
 quic_mohamull@quicinc.com, quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
References: <20240703070220.15246-1-quic_prathm@quicinc.com>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240703070220.15246-1-quic_prathm@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Prathibha,


Thank you for your patch.

Am 03.07.24 um 09:02 schrieb quic_prathm@quicinc.com:
> From: Prathibha Madugonde <quic_prathm@quicinc.com>

I’d use imperative mood in the commit message summary/title:

s/Added/Add/

> Fix for GAP/DISC/NONM/BV-02-C
> As per GAP.TS.p44 test spec
> IUT does not contain General Discoverable mode and Limited Discoverable
> mode in the AD Type Flag. IUT shall send AD Type Flag to PASS the test
> case, thus added BR/EDR not supported bit in the AD Type Flag when

s/added/add/

> discoverable is off.

Please document your test setup.

> Signed-off-by: Prathibha Madugonde <quic_prathm@quicinc.com>

Please following the rules in `HACKING` [1].

> ---
>   src/advertising.c | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/src/advertising.c b/src/advertising.c
> index 5d373e088..cfb239585 100644
> --- a/src/advertising.c
> +++ b/src/advertising.c
> @@ -734,8 +734,7 @@ static bool set_flags(struct btd_adv_client *client, uint8_t flags)
>   	/* Set BR/EDR Not Supported if adapter is not discoverable but the
>   	 * instance is.
>   	 */
> -	if ((flags & (BT_AD_FLAG_GENERAL | BT_AD_FLAG_LIMITED)) &&
> -			!btd_adapter_get_discoverable(client->manager->adapter))
> +	if (!btd_adapter_get_discoverable(client->manager->adapter))
>   		flags |= BT_AD_FLAG_NO_BREDR;
>   
>   	if (!bt_ad_add_flags(client->data, &flags, 1))
> @@ -1499,6 +1498,17 @@ static DBusMessage *parse_advertisement(struct btd_adv_client *client)
>   		goto fail;
>   	}
>   
> +	/* GAP.TS.p44 Test Spec GAP/DISC/NONM/BV-02-C
> +	 * page 158:
> +	 * IUT does not contain
> +	 * ‘LE General Discoverable Mode’ flag or the
> +	 * ‘LE Limited Discoverable Mode’ flag in the Flags AD Type
> +	 * But AD Flag Type should be there for the test case to
> +	 * PASS. Thus BR/EDR Not Supported BIT shall be included
> +	 * in the AD Type flag.

You could re-flow for longer lines.

> +	 */
> +	set_flags(client, bt_ad_get_flags(client->data));
> +
>   	err = refresh_advertisement(client, add_adv_callback);
>   
>   	if (!err)


Kind regards,

Paul


[1]: 
https://github.com/bluez/bluez/blob/be0b08770e9214592e89589b2dc069426c0d9b91/HACKING#L98
