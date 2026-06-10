Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4024C18A6CF
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 07:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781077617; cv=none; b=rQhAhYL5Ewmg8yrpMR9PbipztvDa0C1XbfHUWa1DNbDMPJBin7h4/GUjc5WNeoRTERl0CeTFACYrvD0eZrYfwgwCsOzdnPaxB3jFzQA/IbWyGp6VALJeQwRPkS6vhWF42YpXQJRV8ASz2rmW5oL8kBjxOIMqOXAbI3tc+lDfQm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781077617; c=relaxed/simple;
	bh=T0FIN2EqOzqqlC43q7OsvsDW9/TMY1XCRUp2igBOtJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=kCv9Tsxd5CyPgqSjBCheEcr27amTh9zbH5GOwp2IXa09bcc14odJepJbfGdX5uhAi819gxnrWbs8OPWeulOVmiMOsOJESQExwAxH3vyr4GT2IRoGvfuiEQwL06EFAd4ju3mLheHaHHPozlG2vqEwuMNbaPXXAVqzi+Rh9EezyyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=guRLV5jW; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="guRLV5jW"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490b3637b90so55146685e9.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Jun 2026 00:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1781077612; x=1781682412; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q/aAvw7nci7toYn/GLce4/25EVkOszr9YyLPEwSlOGo=;
        b=guRLV5jWCDAFUVzlSa2WiAdiI9ZJW3wH1e3ow7ycahuecsw3UCW3jtSAvh2W+SKON+
         2dLlomqfW7HJlSiruQo6T1yXv/5RwZkjtZE0OCWvbXTrldd3txzpWxsEGSkfsoB5iDm0
         1t8UUv5H9oLKdSTsHbkBainVCImZDT52VPyBI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781077612; x=1781682412;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q/aAvw7nci7toYn/GLce4/25EVkOszr9YyLPEwSlOGo=;
        b=D/iycK+wZshAXHbZhz4vbZ1Xq7JwHXXzlIHZVNnBkJunmi5FgmXo+WzKAxW2P0PgmW
         qNQnqcEBkTbayy3d5Ky8hNxVlfIGqQ7uOPsSGzuXM75UK2CknsPGCXjJSxKGX20Kf+Yv
         GDQiX5wDoIUlJ0KoUsqIokt9OPXYx802OBH4hTAu2L0SWfm74tno575D+EKDarz119gQ
         aUg+Cf0ECnlCwFeKKznDCsRRklnPtDM4L184/DnefjyKNCre6wtbGiHS94Fp4XASLNS8
         zexsiNyfmfR7UBzvMtOf1svL+zD6tjj0f+xGM152hv2AT/XU59NYxFwpS6J2xMwjOoWl
         g3og==
X-Forwarded-Encrypted: i=1; AFNElJ9vMiVS5Ww4xyFSH3yZhXcETrMcz+o4AtO6dhKImDVFQ5L+2j75VSQpbacVGbnJYW7Dfh95eWcuKBzgC7jIU0I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdhHCKMQLrhwXMzRtX/vXfzFt0RixmyFEnj61hvrj77aXVCiog
	ldvbjMOJp+e9YRo/ZY+A2k4aIFylTAznTlo4WuLnjcyNamE7oSu5leRJuOaHMnqzGijG6YTlGuI
	ynq5i
X-Gm-Gg: Acq92OHTpf0+VbV51pMI2VUawae98oAVr/LZhX+SS3CAOc5vSqFzdnO0qxyT7PyD0bW
	N9M6Z66YL9F1RAHO8/JpLayObFMHyp5IwvJcUszTXVNxkb7NjP+AQYZuxRvab2LD39rpcxGACua
	V2Uj6ajUSWsA8Wj3eWnvtBQIhY3/jy6qUtbzEClYUJFcZyHcXqs6qdF9JqeKyJIay0W2Ouktzfg
	19uw+4KiVoToK0R4lRa51IyAMry/YJ+cOv3YPsCHhwFR+ul865HeXzDgCA0ukF5SlG/yPqFNghk
	yh/5Hr0KzAo5L7+LzmQ9LyMygGIIg3pHRB1cRkQC1is1gflF+e6M6N/rEhWRRH7W1u5onxk3+Nm
	oxi9n01S+is6/bvfIB+wyY9W/TGF79u53sgijZB3EvwHV8KgT+x736dUooSgK+01SSgpUWE3OpC
	vpKY3FWUOIQx20wXSshFGljQu1daF+5nbv/MNfSq/sKl1QWqygOSsZoA==
X-Received: by 2002:a05:600c:6091:b0:490:601f:d766 with SMTP id 5b1f17b1804b1-490c259a103mr406648185e9.1.1781077612565;
        Wed, 10 Jun 2026 00:46:52 -0700 (PDT)
Received: from [10.122.244.41] ([84.245.120.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f368e9fsm66542725f8f.37.2026.06.10.00.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jun 2026 00:46:52 -0700 (PDT)
Message-ID: <fa0febe1-5866-4a3f-9f86-ae70e9d4b22d@streamunlimited.com>
Date: Wed, 10 Jun 2026 09:46:51 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ] shared/bap: Don't link ucast streams before CIS IDs
 are assigned
To: Pauli Virtanen <pav@iki.fi>, linux-bluetooth@vger.kernel.org
References: <20260609211111.3887657-1-simon.mikuda@streamunlimited.com>
 <0744a915b7ea628647a17fa9aad0aa4365f83989.camel@iki.fi>
Content-Language: en-US
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
In-Reply-To: <0744a915b7ea628647a17fa9aad0aa4365f83989.camel@iki.fi>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I looked into it and 0 is valid ID (probably not used, but still valid).

There is a ugly part in bluez though, when stream is allocated cig and 
cis in qos struct are 0 not 0xff:

stream = new0(struct bt_bap_stream, 1);   /* qos all-zero: cig/cis = 0 */

and also in tests there are some struct comparisons that also use 
cig/cis == 0. Some parts check for 0xff (BT_ISO_QOS_CIG_UNSET, 
BT_ISO_QOS_CIS_UNSET)

Maybe more clean fix would be to hook this up to state, so that when 
CIG/CIS is not at least configured it is rejected e.g.:

if (stream->ep->state < BT_ASCS_ASE_STATE_QOS || link->ep->state < 
BT_ASCS_ASE_STATE_QOS)
         return -EINVAL;

Also probably i should cleanup all structs (code and tests), so that cig 
and cis are initialized properly with 0xff. And then provide the fix?

On 6/10/26 00:03, Pauli Virtanen wrote:
> ti, 2026-06-09 kello 23:11 +0200, Simon Mikuda kirjoitti:
>> bap_ucast_io_link pairs streams whose CIG/CIS IDs match, but the IDs
>> are unset in Codec Configured state, so a Sink and Source bound for
>> different CISes get linked. The stray link later propagates a
>> disconnect to the wrong ASE and breaks Receiver Start Ready.
>>
>> Skip linking until QoS Configured assigns the IDs.
>>
>> Fixes PTS test BAP/USR/STR/BV-362-C
>> ---
>>   src/shared/bap.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/src/shared/bap.c b/src/shared/bap.c
>> index deb85b264..98537de60 100644
>> --- a/src/shared/bap.c
>> +++ b/src/shared/bap.c
>> @@ -2679,6 +2679,12 @@ static int bap_ucast_io_link(struct bt_bap_stream *stream,
>>   			stream->ep->dir == link->ep->dir)
>>   		return -EINVAL;
>>   
>> +	/* Don't link until QoS Configured assigns the CIS IDs; while unset
>> +	 * the check above would pair unrelated streams.
>> +	 */
>> +	if (!stream->qos.ucast.cis_id || !link->qos.ucast.cis_id)
>> +		return -EINVAL;
> Zero is valid CIS ID?
>
>> +
>>   	if (stream->client && !(stream->locked && link->locked))
>>   		return -EINVAL;
>>   
