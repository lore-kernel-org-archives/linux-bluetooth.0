Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289FA14C5B3
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 04:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713933116; cv=none; b=XQO7IF78jemz/wgFD7sHZtXIbfCft73f6F9Cmj2O14dijBh7HpptfnekcSeGmU8GQ1hqjBdWKdxG74Ix9WXKV2fZADojZt8ZxYY6wI1utY0m3F07Hfc0yRw5xPYfsbwZdUJ6yAHTDCh9wzkCk76J7qixirezX25hH/TTAls4TFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713933116; c=relaxed/simple;
	bh=ddehf1XkqNfYW8z5o2O15QQu2jQf4WAe2w/ty1Vd4Zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rZQdeRXeXbJ+3eZIrgoQCf6WNy6L0AsPTtlTnnXdS5qwCPa93lxUQcTivt0ZAG4C77HowELvpzof5/IbNP8OOk51Eh8dussJgowqsTNq/HpOrTZr5XSbJ/VfiCO3Mvuqx3VaopoXRdKabOhp/ptACPRiC2IJDFnZiCpmtjsuWLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ca1/vz79; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ca1/vz79"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-571be483ccaso7586946a12.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Apr 2024 21:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713933113; x=1714537913; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=ApHvdHtnNfZYj+tanKKAuhkY8ePx1z5sxaA9LujT9l0=;
        b=ca1/vz79HaGp9zGiyMS7hbsHFriin/Z7gR5N79ExaFPSCAdJQnMlhgKda8bAd+U1Zq
         jPEaj1og6zmse5kjFUb9/1LYCtwnLxZVeoH3bpuC7dhn1vapuBcuHS/PD/qkUHdDWnO3
         KK9YakqNWSnXqFf4DEzkExdOh5zs4g/py0hGxDXAzYkksty5L9I1qNMlwrJmLDBCyyyc
         192oEEjZuXMme27hljFLoiCyvOT31XOf4LAMiT0e1Kjuu5sE01kYNLD0S3lj9qEru1hN
         uir1v2k+zNMsxrrN5EE99+eieQOWxJ98HehiEi7UvVkkWReF1z+ZbEl3xjnJ74jaM4bY
         OzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713933113; x=1714537913;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ApHvdHtnNfZYj+tanKKAuhkY8ePx1z5sxaA9LujT9l0=;
        b=vENUKw4BdX942d/ROfvRNvErIVFVUqH//lLQr+Y1LO5nlbNh0s5rq7eCa8LqeMQeUu
         9UwLu7UhzcqJcxlByq5Kdp/I0oJ3kJpjDMufBA0wdgvrD4Nl1aU/u54FzrpB5/E8lFM2
         ZCYGTjrRYZavQLVwuqJ/3c9z2j1QH5NmONHmUsW/8f4DRhnfXr66JYwyQVDYDAeUCmRI
         JyZocO+TSoIP63nsBqqw2itAeHzHMA9yUPXZLHFVHDB5JebPptgegWb+v39RWn++gKj8
         UcrhcMNi7K4+MX6fSD1QIuQ58NIRdF4xs6X0GrygUh1Z58Rjg/E8aHH+YASAZOGAhsni
         1jFA==
X-Gm-Message-State: AOJu0YyqzMtSqUS9J4YIxmBXns1rx0GBG04Uz2a9XULPY67fbyEtL3XP
	MYx6mUcKI3bsLWWYjdM5B2v6BiBKkFBST6lm+D8TsCMHJGmAXHG8tWGxq3IuXNM=
X-Google-Smtp-Source: AGHT+IFwjjFT1aZwPqoGx6rl+70P8xvnZXlWHs7OaLaIEEgfUcg2SBK+548ZzA4TuS1WnLZDkkTQpQ==
X-Received: by 2002:a17:906:2543:b0:a55:8f25:14f with SMTP id j3-20020a170906254300b00a558f25014fmr682651ejb.40.1713933112900;
        Tue, 23 Apr 2024 21:31:52 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id og14-20020a1709071dce00b00a55ac4c4550sm3989846ejc.211.2024.04.23.21.31.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 21:31:52 -0700 (PDT)
Message-ID: <5e363318-c6e4-4874-8026-7940b434d583@linaro.org>
Date: Wed, 24 Apr 2024 06:31:50 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] Bluetooth: qca: Fix BT enable failure for QCA6390
To: quic_zijuhu <quic_zijuhu@quicinc.com>, luiz.dentz@gmail.com,
 luiz.von.dentz@intel.com, marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, bartosz.golaszewski@linaro.org,
 wt@penguintechs.org, regressions@lists.linux.dev, kernel@quicinc.com
References: <1713919602-5812-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713919602-5812-2-git-send-email-quic_zijuhu@quicinc.com>
 <349b27a5-d2d3-46f1-b002-44f81e0cedef@linaro.org>
 <e8cd122d-e342-45c2-b078-a4ca2d8dcfff@quicinc.com>
 <dfe18768-f6da-4c60-880d-deeae3c3b04d@linaro.org>
 <8ae32009-5f5e-49a1-88a1-e330f0614f60@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <8ae32009-5f5e-49a1-88a1-e330f0614f60@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/04/2024 06:18, quic_zijuhu wrote:
> On 4/24/2024 12:10 PM, Krzysztof Kozlowski wrote:
>> On 24/04/2024 06:07, quic_zijuhu wrote:
>>> On 4/24/2024 12:06 PM, Krzysztof Kozlowski wrote:
>>>> On 24/04/2024 02:46, Zijun Hu wrote:
>>>>> Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
>>>>> with gpiod_get_optional()") will cause below serious regression issue:
>>>>>
>>>>> BT can't be enabled any more after below steps:
>>>>> cold boot -> enable BT -> disable BT -> BT enable failure
>>>>> if property enable-gpios is not configured within DT|ACPI for QCA6390.
>>>>>
>>>>> The commit wrongly changes flag @power_ctrl_enabled set logic for this
>>>>> case as shown by its below code applet and causes this serious issue.
>>>>> qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>>>>>                                                GPIOD_OUT_LOW);
>>>>> - if (IS_ERR_OR_NULL(qcadev->bt_en)) {
>>>>> + if (IS_ERR(qcadev->bt_en)) {
>>>>>   	dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
>>>>> 	power_ctrl_enabled = false;
>>>>>   }
>>>>>
>>>>> Fixed by reverting the mentioned commit for QCA6390.
>>>>>
>>>>> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
>>>>> Reported-by: Wren Turkal <wt@penguintechs.org>
>>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218726
>>>>> Link: https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f
>>>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>>>> Tested-by: Wren Turkal <wt@penguintechs.org>
>>>>
>>>> No, Bartosz' patch should go.
>>>>
>>> what is Bartosz' patch.
>>
>> Srsly? You were Cc'ed on it. How many upstream patches on upstream
>> mailing lists do you receive that you lost track of them?
>>
> Bartosz' patch have basic serious mistook and logic error and have no
> any help for QCA6390, and it is not suitable regarding DTS usage.

Really? Why you did not respond with comments then? Considering how
imprecise and vague you are in describing real issues, I have doubts in
your judgment here as well.

Best regards,
Krzysztof

