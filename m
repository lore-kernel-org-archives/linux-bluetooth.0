Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0412413D613
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Aug 2024 03:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722484629; cv=none; b=CEoUrunXKQ5GX3QGDvEU1/x30vmHUXLPp4hjsvszstyG6sR6S8bgrq78vOitaY00LUk+cybg3XwBBGHaS349YmB4JVk/1aAg33nIXVcDmiVrPS1btkNSw9MZsx+CpBhSj+wdom4rrYx3xzEf7lJCTEW+AEesHmLcY/n2lpWHy4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722484629; c=relaxed/simple;
	bh=9z+DUe19MXcVwhPiCcg1jBIb6j+CrevqhI1KdsX/zG0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jikykF/aIYsT7nx3Ise7tArKvZnG11SdqL09DTWjA338EPezpfU5tBjRCeMzadkx532/NUj1dKVLV2y0sfDLY83IhopjMUri/3IwssBkUc4qfOG6tnaLgwIP8Ctjza4J90SFOEdQgeiF0HZWy3y9x3PaKuO26w1o+uEMlUvwoYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=MGrGm2pF; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="MGrGm2pF"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-70d18d4b94cso4788716b3a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Jul 2024 20:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1722484625; x=1723089425; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=E3c0jDeg9jATLBjz8MH1N0Oj6qwqnRYEeVc2HEf4DB4=;
        b=MGrGm2pFRyQjizS4KN/++6GMaqvkhvmwFREh86hWbwtUsKAcOI0ypVIpeJqwAVxPek
         mvBNIPEiuiUSEaxVAVWT9QLwgVG3Zm4hamN2O3/kHtS0g0rvERyzEUCKGr99aqqktBNK
         04DzQxxcE0UDwKOwQ3j3KsmqzC407zcvwhDSg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722484625; x=1723089425;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=E3c0jDeg9jATLBjz8MH1N0Oj6qwqnRYEeVc2HEf4DB4=;
        b=QPbTyru4kELombUKNKpRagGNtAxhJb0D5xDV3tDX0B3gTE6ZgiGqPrGxkgg2qOiC1E
         rt0NInvAZuxzMkGXTC3DIZKKw14s3iqfcH8B5ZrrwnWOTHrxsvwFqcaijgN3qbfrR5QC
         zoItHSlthFWAlXyVpbVMhlKTZ2C0hZ272Rwuv6I5wVXFax/RzpvxiyA6iyHH9D3foyhu
         uw5DOE8h/AiH3SQQRTGgtRq910tlACIyIJk3LJyRLIcl7iQsdmi4euGbxkFSnELaY3LS
         5DA2oEAranGQRQY+B0+xDWV2jgkjxcZ0L/cLDydobDVhrfEJnlZL+POnJn7q515lgj27
         E8Fg==
X-Forwarded-Encrypted: i=1; AJvYcCUMF8lfgaYJCzJYqV8A4JZ61V27dNWVwNNXn9SXwxCiASHFOTt9PeGsbCRa3iQswmfGYgZ/VI6sKb96V7Npz+cfYTTfkGXT+l61IAvx3TnW
X-Gm-Message-State: AOJu0YzSD7D8XQZ3R1W1oMyiCtaw7D+jvM0F0lOxXUqq0RHMExFAYUjO
	urjDA/TNqYSMiE0u9837EvVIZhJhCQZ5ckZ6XJjK9j1S9WPt6QffZCnVxmVnkppSNl9J7xN3GzN
	2SsPv
X-Google-Smtp-Source: AGHT+IEFdP76UW/IZ+sC2v4ImHKOP3FcwGDmZrqokrJHVTrqdDNiXNJhqK0SPMMBLeC7lZGGATEBbA==
X-Received: by 2002:a05:6a20:9f86:b0:1c1:61a9:de4a with SMTP id adf61e73a8af0-1c68cf22b8amr1895142637.24.1722484625007;
        Wed, 31 Jul 2024 20:57:05 -0700 (PDT)
Received: from [172.16.102.95] (c-98-45-34-39.hsd1.ca.comcast.net. [98.45.34.39])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc430fa2sm2150004a91.13.2024.07.31.20.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 20:57:04 -0700 (PDT)
Message-ID: <721b286c-7143-40c7-84cf-c77986009895@penguintechs.org>
Date: Wed, 31 Jul 2024 20:57:02 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Bluetooth: hci_qca: fix post merge window regressions
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20240731-hci_qca_fixes-v1-0-59dad830b243@linaro.org>
 <CABBYNZ+dvLGos9oLi6euFkmiU9OReJ5F3qsA6WrhW29yeZ-jWQ@mail.gmail.com>
Content-Language: en-US
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <CABBYNZ+dvLGos9oLi6euFkmiU9OReJ5F3qsA6WrhW29yeZ-jWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Luiz and Bartosz,

On 7/31/24 9:32 AM, Luiz Augusto von Dentz wrote:
> Hi Wren,
> 
> On Wed, Jul 31, 2024 at 11:21 AM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
>>
>> Here are the fixes for regressions reported by Wren and Dmitry. I could
>> reproduce the crash on db820c and so I was able to test it but patch 2/3
>> could use a Tested-by from Wren on QCA6390.
> 
> Can you give this set a try and report back?

I'll give it a shot tonight or tomorrow and report back.

Bartosz, thanks for looking into this.

>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>> ---
>> Bartosz Golaszewski (3):
>>        Bluetooth: hci_qca: don't call pwrseq_power_off() twice for QCA6390
>>        Bluetooth: hci_qca: fix QCA6390 support on non-DT platforms
>>        Bluetooth: hci_qca: fix a NULL-pointer derefence at shutdown
>>
>>   drivers/bluetooth/hci_qca.c | 19 +++++++++----------
>>   1 file changed, 9 insertions(+), 10 deletions(-)
>> ---
>> base-commit: cd19ac2f903276b820f5d0d89de0c896c27036ed
>> change-id: 20240731-hci_qca_fixes-8e7a8ed3ad83
>>
>> Best regards,
>> --
>> Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>
> 
> 

-- 
You're more amazing than you think!

