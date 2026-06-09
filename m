Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B6F3AB26C
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Jun 2026 16:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781022342; cv=none; b=Bh+fZp0M+HqFVFD3cjOVjTsZhe2K9WjCQTGPXFakS+0sN2i3sswAFS1TrXG5U1aO6S8JeDaOB44T9igVB5N/91kP66vDOC9vcESNxiZmowmnHtcDjS1SKvdrtPfxdZGBVKFJ5ENggI2YCyVfCpDtRtSEeGNyoENC0STJ7YOAeC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781022342; c=relaxed/simple;
	bh=2056/iH79J4phdV8ILdEDrs/XERYdOmsAyzfVSq3rvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p0X6+W9HBTvT/A4a6skw73t5o4H9MHCB/r+ClIGVWRRqAWahH3CaaVIPuuQ45t5akd7nbNKd/UuFeCFUKKQo/0A44PozVX0IPMLFwBBlmsQ/oUqIAYy1l6I/LiIANcbbmhZ6i1NRwiEEAwVlg5PQKBHColB11ECD8ID23rZJKtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com; spf=pass smtp.mailfrom=streamunlimited.com; dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b=BaGTHkco; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=streamunlimited.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=streamunlimited.com header.i=@streamunlimited.com header.b="BaGTHkco"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490b9318997so42228975e9.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Jun 2026 09:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=streamunlimited.com; s=google; t=1781022339; x=1781627139; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KWiIkYN1GIpafBcxhdphohwu2d7SHbJo4BJqg0Pr9Oo=;
        b=BaGTHkcoZ0FQHL2BQYiNYf3crNX1ytAyShIKlIOBkcoM13EisHhSYLkGtpwwZ4EX9r
         ByotlOyifD077opvj+6/Y/mA09pHCGy4T+j9LFzlx4CwpIqFNnUlRbWFUGOVtx4QP+xX
         0kVCTjDDadvO2RJLUq6Taj4h5/ezP2xLbx1Ps=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781022339; x=1781627139;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KWiIkYN1GIpafBcxhdphohwu2d7SHbJo4BJqg0Pr9Oo=;
        b=H2DG79rhEdyX1fHNbuqzw02h+ilHFxmzHTEnedtOU11ZdtuGFrPLBhmFSHAq+TKT1r
         hInozRqFli1J1OTNLp5QzV/3AOrYg+/5rkd0O0Nxi8DxF4klDQxP5XbeuAlFrliG/1An
         KDTqzikwuE+oNG7KsRRmObU5daIIWE0bp/ltozK1HiYEjKQWU2iVj5lCItBHYIQU1K4O
         vQU+QWxAVqSzOTc2Uu8JNQ1fgMl0O77PZ+Hdc9pn1HBqJgZ9rfUzMMy1lHW+uWiszMvx
         q2oBCsVXClPBTvqKIhcfxFymNiR2nxfSsB3omq9ZXDfLVpz4eoJWRHOzP84rDvshFONJ
         kj5A==
X-Gm-Message-State: AOJu0YxrY4UcPHn2iMsoDUXuHoYDS/EA+pX2gr+IRD10RWFZ4gv2JMDd
	10EFx78koDmG7aJxpI4n+0OTrQn6qkgdn41iJqpdbBd+qGsCg0MFyf64yiEELHuQYFddIx+TzOj
	t3GJV
X-Gm-Gg: Acq92OEz3B3cU0OlHV0Mtla0Cx8BL2YyL1UcNtgCgqmrzr/gviF95f1TzFRoWRDHiv6
	rQqJ5Vl+UYbviuO1SatINN5Vh5tyCszs0XUmUqG69uZMTcl/fVvPyueudGGXVECQHN/bHI+UZ3W
	xtodzBK1OonggUpKOKcxuMSSRNmqpyjqRRHvUAwu7y/s80PeJurNMF8yVMqzdYe0rKPLt7FfGeI
	rqgm0LObUCFufnqqcMggBwoTkiAU8QccP590zuJAlf20MxSgS2LWEGM/rk2hFCn/dHboINYyvS0
	jcRodEhdLafdUl1zHtnzNGs3P0ixo9YfhIZvyJCi36mdzjTYyDR3ZCxrQSCbFLgjgATU6ho8TbL
	I60vXGw5FEwxuuMLUjTv3sLNJbyv72LUCwsPPy9qh2vsSy+zufrBmhzOSxHRx4EYQql5xAtZzGS
	X9A0AdY4RIR0rP0+J5zjfeA3dRyshR3QzhHFihtkx4V07mKi8oIj3NzA==
X-Received: by 2002:a05:600c:3f0e:b0:490:bb45:79ef with SMTP id 5b1f17b1804b1-490c2508a5emr375700635e9.0.1781022339012;
        Tue, 09 Jun 2026 09:25:39 -0700 (PDT)
Received: from [10.122.244.41] ([84.245.120.9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f360bd6sm68082628f8f.36.2026.06.09.09.25.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jun 2026 09:25:38 -0700 (PDT)
Message-ID: <11d03be6-8f9c-4b8c-8bd7-0b7d9c9d87b4@streamunlimited.com>
Date: Tue, 9 Jun 2026 18:25:37 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ] hog: Fix starting encryption on some BLE remotes
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20260608091140.3606008-1-simon.mikuda@streamunlimited.com>
 <CABBYNZLRz2iqR-eQNjXsJnyeZ8aONnjgaQDO6bRWVqfVy8SbbQ@mail.gmail.com>
Content-Language: en-US
From: Simon Mikuda <simon.mikuda@streamunlimited.com>
In-Reply-To: <CABBYNZLRz2iqR-eQNjXsJnyeZ8aONnjgaQDO6bRWVqfVy8SbbQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Luiz.
I don't think it forces encryption without bonding.
The diff is:
          if (!device_is_bonded(device, 
btd_device_get_bdaddr_type(device))) {
     ........
+        } else if (auto_sec) {
+  bt_gatt_client_set_security(btd_device_get_gatt_client(device),
+                                BT_ATT_SECURITY_MEDIUM);
          }

so it means device IS bonded and auto_sec is enabled


On 6/8/26 16:23, Luiz Augusto von Dentz wrote:
> Hi Simon,
>
> On Mon, Jun 8, 2026 at 5:20 AM Simon Mikuda
> <simon.mikuda@streamunlimited.com> wrote:
>> When BLE remote doesn't reply with Insufficient Authentication Error
>> encryption is not started.
>>
>> Good remote:
>> < ACL Data TX: Handle 64 flags 0x00 dlen 7
>>        ATT: Read Request (0x0a) len 2
>>          Handle: 0x0021 Type: HID Information (0x2a4a)
>>> ACL Data RX: Handle 64 flags 0x02 dlen 9
>>        ATT: Error Response (0x01) len 4
>>          Read Request (0x0a)
>>          Handle: 0x0000
>>          Error: Insufficient Authentication (0x05)
>> < HCI Command: LE Start Encryption (0x08|0x0019) plen 28
>>          Handle: 64 Address: xx:xx:xx:xx:xx:xx (OUI xx-xx-xx)
>>          Random number: ...
>>          Encrypted diversifier: ...
>>          Long term key: ...
>>
>> Bad remote:
>> < ACL Data TX: Handle 64 flags 0x00 dlen 7
>>        ATT: Read Request (0x0a) len 2
>>          Handle: 0x001e Type: HID Information (0x2a4a)
>>> ACL Data RX: Handle 64 flags 0x02 dlen 9
>>        ATT: Read Response (0x0b) len 4
>> ---
>>   profiles/input/hog.c | 3 +++
>>   1 file changed, 3 insertions(+)
>>
>> diff --git a/profiles/input/hog.c b/profiles/input/hog.c
>> index f50a0f217..845087c9d 100644
>> --- a/profiles/input/hog.c
>> +++ b/profiles/input/hog.c
>> @@ -189,6 +189,9 @@ static int hog_accept(struct btd_service *service)
>>                  if (!bt_gatt_client_set_security(client,
>>                                                  BT_ATT_SECURITY_MEDIUM))
>>                          return -ECONNREFUSED;
>> +       } else if (auto_sec) {
>> +               bt_gatt_client_set_security(btd_device_get_gatt_client(device),
>> +                               BT_ATT_SECURITY_MEDIUM);
> So this forces encryption even without bonding; why?
>
>>          }
>>
>>          /* TODO: Replace GAttrib with bt_gatt_client */
>> --
>> 2.43.0
>>
>>
>
