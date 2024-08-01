Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F3F3157E62
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Aug 2024 07:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722497009; cv=none; b=ahRPBqWDXJ9Ft+5aMF8DKXV2bDuWZun9OTCyOl3+muSGtsLVjF8Gh6Qko7he0W4KYfYClQCXh4R0u/ifZaPLsGnUPdF7+5QGAiPmZBax7uQnO2hZWonNpoB3+C6sPG3g4Jr9IpJ1jGrJNjTZSXFQBhv8XU+bZbhgzztbkYZmIxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722497009; c=relaxed/simple;
	bh=sSnpR8T3HWqyH57d43tYCrY0GtNGtGqXjWZkkziwtLs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=XJXm9GlBX7LSblpxy1X/0XlIbpC3MOqeV66W0/qGLx4IPknpAlgBeL95vj+DGeeo/sASBR2lPfxJfNWyzqyzCaymBbJpvrmsOqrhz1X1pjjUro7CzWgTIXcz58RiGWZWptukQC5Pv8+hbQ+VswwdLo1hs1J96K47XE82QmZzHsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=WmYiG4Mj; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="WmYiG4Mj"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc52394c92so58478615ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Aug 2024 00:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1722497006; x=1723101806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PCt7QnhrAiB4sQ6YhOwxu8pXKKSA9/F5K2ANy9A8n5A=;
        b=WmYiG4MjmiGb3fNjSsnF86gHy+K6UslMm0NMRSYYie+khNH7Qmo6pKxuMv+Uyx1vRE
         PIv8N+On9ckd+dwf5l68Mlx6t3g4/aiTHzjgWGVD6V3F69cLdX3WJZgXTAP0m1/H05R9
         93lCoT+BKUJNs0hsj33mXG6uLktgC4PKMIN0g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722497006; x=1723101806;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PCt7QnhrAiB4sQ6YhOwxu8pXKKSA9/F5K2ANy9A8n5A=;
        b=XB+S+MbeSzlnnCBOVOtdEam+kBOR6PfH5Qf1iDXeBvRCylR4JXPY4OwT+8RvDLFQfM
         kAOhmW6aj4qR6YroSkzviXZu4CuCaHj0fsZ8eoOACx8REjYI3rcgxhpV8txafHbngbWW
         MhlwlKjoxDcDGJWJBZBXlACIS6LsARu1YLoKxbgjCFBzyCIe35Tk0LdfOOCJgmkKYvrY
         j+ROhqSRdEUJz2AewbKr7ai/LrwMXf/LqARVIaWww6Oalw+zUDiat9qPk1iDRec9E+Zq
         +GRrk1I5dUoHVmUj+SVhfqHckY/z2td2aNoylPmZ6QhXJFC+rnd5Yt0LJsdo5Swm0lI7
         yRqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUzFX8w5Vz3/kHTvfEyeFwiSCazzYTA8rUQgE7K/lS+4UyssACVsw3P3WgVUYteQKqtS+uJpjuVz7h/dRGa/VzLgRUMa8kGa4f1XtRoQmO/
X-Gm-Message-State: AOJu0YxtIFmIcEwHtJ5KR0H4RDcjezAxYw2MaPT1LgOSFquIHx61eU0U
	v7B3PNHDUCT37zfSGylzNF1mt6O+RbsOQcY0EYEt5aSxUmoPGggqxjfuHXJprw==
X-Google-Smtp-Source: AGHT+IHKzoCBN8aBLvqtz8kuT+Tx3VpZBBXRM5kC27Z+diKMoF9U00abCS9BlvN1CJ7l7N6CnEFa7A==
X-Received: by 2002:a17:902:654f:b0:1f7:2293:1886 with SMTP id d9443c01a7336-1ff4ce56c00mr16784555ad.12.1722497006327;
        Thu, 01 Aug 2024 00:23:26 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7f1b6c3sm131715595ad.192.2024.08.01.00.23.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 00:23:25 -0700 (PDT)
Message-ID: <5a293fa0-944c-4049-896e-fa0a945c82c6@penguintechs.org>
Date: Thu, 1 Aug 2024 00:23:23 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Bluetooth: hci_qca: fix post merge window regressions
From: Wren Turkal <wt@penguintechs.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240731-hci_qca_fixes-v1-0-59dad830b243@linaro.org>
 <CABBYNZ+dvLGos9oLi6euFkmiU9OReJ5F3qsA6WrhW29yeZ-jWQ@mail.gmail.com>
 <721b286c-7143-40c7-84cf-c77986009895@penguintechs.org>
Content-Language: en-US
In-Reply-To: <721b286c-7143-40c7-84cf-c77986009895@penguintechs.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Bartosz,

On 7/31/24 8:57 PM, Wren Turkal wrote:
> Luiz and Bartosz,
> 
> On 7/31/24 9:32 AM, Luiz Augusto von Dentz wrote:
>> Hi Wren,
>>
>> On Wed, Jul 31, 2024 at 11:21 AM Bartosz Golaszewski <brgl@bgdev.pl> 
>> wrote:
>>>
>>> Here are the fixes for regressions reported by Wren and Dmitry. I could
>>> reproduce the crash on db820c and so I was able to test it but patch 2/3
>>> could use a Tested-by from Wren on QCA6390.
>>
>> Can you give this set a try and report back?
> 
> I'll give it a shot tonight or tomorrow and report back.
> 
> Bartosz, thanks for looking into this.
> 
>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>> ---
>>> Bartosz Golaszewski (3):
>>>        Bluetooth: hci_qca: don't call pwrseq_power_off() twice for 
>>> QCA6390
>>>        Bluetooth: hci_qca: fix QCA6390 support on non-DT platforms
>>>        Bluetooth: hci_qca: fix a NULL-pointer derefence at shutdown
>>>
>>>   drivers/bluetooth/hci_qca.c | 19 +++++++++----------
>>>   1 file changed, 9 insertions(+), 10 deletions(-)
>>> ---
>>> base-commit: cd19ac2f903276b820f5d0d89de0c896c27036ed
>>> change-id: 20240731-hci_qca_fixes-8e7a8ed3ad83
>>>
>>> Best regards,
>>> -- 
>>> Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>
>>
>>
> 

+Tested-by: Wren Turkal <wt@penguintechs.org>

It works. Thanks for chasing this down.

wt
-- 
You're more amazing than you think!

