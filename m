Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDDB40D579
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 07:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781078257; cv=none; b=GmVuLKYkn2wOW1FuCTMZUKfattwpM2/sddkU9KORQ/tKquEB3qIoO0yl2u76Y3fpnXN81DEOwHm39/INrA0yGLBtQnXYK2+N+Bu3bMFPaVbfodfm/7wXd32dVz2IMMvusuI6WgKwAleIvmAxxzPdZB+sMvdmy1j99rCTXMsujEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781078257; c=relaxed/simple;
	bh=rGuzvrf8gdJXMb0PFWucTyRWAus9ud2K1GdT5L5CCSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CfXwTCWMZWb76kI9fGMteI/Mxeu84cUe2MGqPtZy6Ytv007BP7qaunlRlDnLROpYSeraX+HPl07rywjK1WM7hJEskWPzEIvKOBUr18CWdev5TrAnDIZcOPfcuRxAFrUJHBB68FT+V561B7grCGL0ihwOuax8ee3zsi8sLt9r2eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=qcK4Trj7; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="qcK4Trj7"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490aaeabdb4so41490945e9.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 00:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1781078254; x=1781683054; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=a+WZKUkOv9ib6EI2/ew1/IGUAL8x/KpMYqsqnngx5L4=;
        b=qcK4Trj7hySkfDJ9esmvyXggRCJ8RyeHDKGUsytBk3oHGhVn7rMVLt3QvCqEUGFryD
         NnDf+L7nuRdC0W9JtVKkYlNb3e/iRbPFzsVU9vh4WEOJQMPzpFKRkWNH5wj3bTs8aqHm
         Mk4NHlhy8u0VjQ0Je0OthW9Y8psDlOSIGgZUk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781078254; x=1781683054;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a+WZKUkOv9ib6EI2/ew1/IGUAL8x/KpMYqsqnngx5L4=;
        b=B0MGbk3aaZKF0Fh8wfCRMizlNx8VafbrOkJ3rTaKyRsPkysbUUAw5Ukjnduc9yROQL
         vouKVe4uIuTyuugcMEmhfSK6rFTUkW1GNfe3lWtGinULp+P9EgP6L5QOHlvRMU4pCJAe
         fzHvgTqXl319alj1/szpkXS4fZXWiAahok1yvoQaK9mtKsCf0wuebF4V0AGq2XFaaGkj
         hiky6lRO9zvzdO6rvei5B3iXm0weGfan3T0vJpTiHnr8lZG9FwFWk24yI533zHKcsmpE
         dlu+AqarM7K0VgGvZoDFmhnJxwz6k8GNku27JiaUGKtoIuuLtNubIhOKMnEWqToFUP4X
         To2g==
X-Forwarded-Encrypted: i=1; AFNElJ+qZLKKCEmO/Kxu+xN/Rq8c6r1f7yFri/TFLrcZiNJKbTmoduintpk6My+UdiQ2l6irE0w1qRu2mdlkhvIWGFM=@vger.kernel.org
X-Gm-Message-State: AOJu0YygJ2sbUWF4pLGBXvUvoJ0j47BH17UBvmim2ZGQmDWspS1aVvDE
	wuSNVPLoUTMBvjMZe8NUgiUVBpcsByvqzXhGsvsesWXmbTUrqQkq37xj7v/g5Vwi2LdSg090vAg
	aq4hD
X-Gm-Gg: Acq92OGUNzmIp9JNuoZ1wBN+vwoLmcoas+c5wxzVmLqGgXqrexfYIXZzhDYA0olBLGc
	Pqxzr0GRhPzyducoZKPmaKjPKb+C5Wr/lZAqyNjkJUmaAmEvNFU/7M5zNFOfRWG348tBHuI49O+
	OTG97xIJhmzeBB0rNsKBv1gLEqY8hAixkJTzmzk2OvyHcaeqR2k+LnEqr4TSLBCfODdCs1TjeF4
	8iBMzCKjUc9cfFf8GftYRaXhExyeEazUqRU7rJASlwBwNTTNJAetevaIbWnekVEAWrYoIxdl/OL
	DiIX4kQsUP0WugT0h+FdihyI3biCuw292/gP5bjaLcip//Zc38Yw1NpzzBsSsEICRTF9xCN/3r2
	MSeoWA3t+3wULENIcnGQZ05e5/ZxLpjbpuxJrLA+4gK0NVaQs+nAloHQ/6Kl8TPJQO10qSV3XjR
	Ou64KCCNrM1l4PdPRYLuDv+WNuh7mwYZNhCnTszBqGPS3lCsv6S0sh1g==
X-Received: by 2002:a05:600c:3486:b0:490:b2a6:8c2a with SMTP id 5b1f17b1804b1-490c258f419mr343048515e9.5.1781078253852;
        Wed, 10 Jun 2026 00:57:33 -0700 (PDT)
Received: from [10.122.244.41] ([84.245.120.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490dc47d4e0sm46358885e9.0.2026.06.10.00.57.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 00:57:33 -0700 (PDT)
Message-ID: <ac997f34-8c43-4935-bc78-90fa5eef714b@streamunlimited.com>
Date: Wed, 10 Jun 2026 09:57:32 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ] shared/bap: Transition ASE to QoS Configured on CIS
 loss
To: Pauli Virtanen <pav@iki.fi>, linux-bluetooth@vger.kernel.org
References: <20260609211120.3887737-1-simon.mikuda@streamunlimited.com>
 <e89af328197d3fb429c08b7a3107d7fd8e05ac00.camel@iki.fi>
Content-Language: en-US
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
In-Reply-To: <e89af328197d3fb429c08b7a3107d7fd8e05ac00.camel@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

this check is for ep (struct bt_bap_endpoint) that is used only for 
unicast. broadcasts use different state in struct bt_bap_stream, so it 
should be OK

On 6/10/26 00:15, Pauli Virtanen wrote:
> ti, 2026-06-09 kello 23:11 +0200, Simon Mikuda kirjoitti:
>> stream_io_disconnected() only handled the Releasing state, leaving
>> Enabling, Streaming and Disabling ASEs stuck when the CIS was lost
>> unexpectedly. The ASE shall autonomously move to QoS Configured on loss
>> of the CIS and notify the peer; add that transition.
>>
>> Fixes PTS test BAP/USR/SCC/BV-167-C
>> ---
>>   src/shared/bap.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/src/shared/bap.c b/src/shared/bap.c
>> index deb85b264..350ed53d9 100644
>> --- a/src/shared/bap.c
>> +++ b/src/shared/bap.c
>> @@ -6779,6 +6779,14 @@ static bool stream_io_disconnected(struct io *io, void *user_data)
>>   	if (stream->ep->state == BT_ASCS_ASE_STATE_RELEASING)
>>   		stream_set_state(stream, BT_BAP_STREAM_STATE_CONFIG);
>>   
>> +	/* On loss of the CIS the ASE shall autonomously transition to QoS
>> +	 * Configured and notify the peer.
>> +	 */
>> +	if (stream->ep->state == BT_ASCS_ASE_STATE_STREAMING ||
>> +			stream->ep->state == BT_ASCS_ASE_STATE_ENABLING ||
>> +			stream->ep->state == BT_ASCS_ASE_STATE_DISABLING)
>> +		stream_set_state(stream, BT_BAP_STREAM_STATE_QOS);
>> +
>>   	bt_bap_stream_set_io(stream, -1);
>>   	return false;
>>   }
> iirc it may be also broadcast source here, does it do the right thing?
>
