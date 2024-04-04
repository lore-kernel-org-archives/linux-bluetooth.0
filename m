Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6790D224DE
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 15:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712245947; cv=none; b=CfNkpPBj8gRJWKAVhdO+wdOenUp/R5fg58U12Rf72/39LyS/CNhF4fbrmsGpDaKDYbi5jQrOL86ADWNsPUF3+2ZsBIdIfZjv6ZDJfteXYXFKaOl5vLp4mppE7yJnO6DunttGnBNyYaSDZF2dakhtUxnpbhWN725L7WS4kc1RdTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712245947; c=relaxed/simple;
	bh=7x5KEa7CpZWISbyrkqpdO1t3M4Ne/wFNTbZ5iZlru84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RJ+5cMqDk5AhG+uHXFLvpHu5ayF8l4UpE82/paR77DTSeyKAbEuXhOEEEzv+S3FAkbnG9QShWmGzF7XGwsAbddM5Fv1eLrU0bL6Jbl2Wwm3Ec69Z3jP2231OWA8AFjGFvfVCWeDx3rfuwnV8JdOyDwY+8SY0yXlP7XgbW3ZQXyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5/nvNnX; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5/nvNnX"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-6e46dcd8feaso580179b3a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Apr 2024 08:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712245945; x=1712850745; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ju0RF6fCDt1S6BXVvNREcbGXDh3w5GKGLzMzqkDRpHE=;
        b=A5/nvNnXSWJ+ZAl62TLrs4ZrhXdyeQtksmLtSCejO+x81elpFwvqGeQ/eki4A0P/s5
         AXREXgjHC3876dPpvX52sNw0yTHC2W0PwGpJdFxemLf1gGVHAaToOsf/8zKH0M8SL2q9
         ezEHuiXafFtHCb0kUROERxNj1xYdmcsavxf/CSVeTlgWzZKwP0MLgCqnzMWKXl1kpl7y
         AXYdZ2sFXM6eXzZ/X/5PCUzCXOZtE1lCn564n1oLeQLgmK9uJvUfCyfI558JToGcdv25
         O1QwLbe6V3IagkNRYhONVBAaSuD6NfH4wFxdWJ7T2KDUpbDzOtRYxC2XkZhl2aqgV8xB
         hAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712245945; x=1712850745;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ju0RF6fCDt1S6BXVvNREcbGXDh3w5GKGLzMzqkDRpHE=;
        b=GJ78C5MbUI9mYRCkI9JExVU3JyEe/8Oiky8EwrdLC/1QGJ2b7XCyRHN1YQfolGfQN3
         IxJCbYd2IZIKgtSrWfET+6hYSmu7zMwvdniMzcj8S23a5meBmOwGwxzYOfsvkTW1W5P/
         6RlnwJqja7QbcfBXbZS+BZC2ouSsWdEu5/egjttGBwDjCISL5wfvWZPaCgX9tDmu9NJj
         JRvDlrjHoBD1FwnsxzDQsMLcZEP5XKEzTxRd7sGXgz2uP3Zi3ugUDptHN2ikIDbxBRW/
         +BwMW0rTD7tmfmsxZ2CUo0Xi1ksn09RniYU/tZkkBBkYv2dOQpEqxE+CzVMb5Lc4N49p
         8hKA==
X-Gm-Message-State: AOJu0Yza7iDs9yZN/OKWORtC+vv5hbDa6JO2DWXfWVTs7Tgv6Y4ozwql
	EBqF9JAW8ma6pR++VM/QeHR5ZLQZ4i2GpdPJMmjfbsIFgfEihQsVZimpfSMWRtkV8nMl
X-Google-Smtp-Source: AGHT+IF1HqI096YKqtxOrEpDStlb9IqAkoalbEydjyHVyQS75n4PwxxVVPDncW7WykaHPDCznb1FnQ==
X-Received: by 2002:a05:6a00:1816:b0:6e7:b3c4:43a4 with SMTP id y22-20020a056a00181600b006e7b3c443a4mr3125626pfa.25.1712245944807;
        Thu, 04 Apr 2024 08:52:24 -0700 (PDT)
Received: from ?IPV6:2600:3c0a:e002:7f00::1001? ([2600:3c0a:e002:7f00::1001])
        by smtp.gmail.com with ESMTPSA id z185-20020a6265c2000000b006ea80883ce3sm14278516pfb.133.2024.04.04.08.52.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 08:52:24 -0700 (PDT)
Message-ID: <0f681858-fe53-4964-82f9-5f3c3ee903e3@gmail.com>
Date: Thu, 4 Apr 2024 08:52:22 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH BlueZ 1/1] Refactor btd_device_is_connected
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <20240403205252.71978-1-dimitris.on.linux@gmail.com>
 <20240404024521.120349-1-dimitris.on.linux@gmail.com>
 <20240404024521.120349-2-dimitris.on.linux@gmail.com>
 <CABBYNZJjSp74CoJU2RYCft_nQi85EWnk9JOvyxMH8YmAtON+8w@mail.gmail.com>
Content-Language: en-US
From: Dimitris <dimitris.on.linux@gmail.com>
In-Reply-To: <CABBYNZJjSp74CoJU2RYCft_nQi85EWnk9JOvyxMH8YmAtON+8w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/4/24 07:59, Luiz Augusto von Dentz wrote:

>> diff --git a/src/adapter.c b/src/adapter.c
>> index 4bcc464de..0b7aab4b5 100644
>> --- a/src/adapter.c
>> +++ b/src/adapter.c
>> @@ -7486,7 +7486,7 @@ static void adapter_remove_connection(struct btd_adapter *adapter,
>>                  device_cancel_authentication(device, TRUE);
>>
>>          /* If another bearer is still connected */
>> -       if (btd_device_is_connected(device))
>> +       if (btd_device_state_is_connected(device))
> 
> Perhaps btd_device_bearer_is_connected would be a better name.

Thanks, I'll rename.

> I guess the problem is that some service is indicating it is still
> connected though?

Newbie question for sure, but: As this is happening in the code path for 
"disabling bluetooth", shouldn't services already be disconnected here?

D.
