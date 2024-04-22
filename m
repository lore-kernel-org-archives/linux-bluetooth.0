Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63735028A
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 07:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713771853; cv=none; b=BiJLrTKwELkJdcuRF2zXRnz9Tyzm6uCJ1nItKo6mRyxQTQG21CxfXmIuTZ8MnBLlWbso2HQkQPnu7wqGJqGUnRd5O8GjiyQI/7lVqSWPfFNYOI03guE+J9MoCsdrFVC6lGQ2LXJYICT03SaXbNqG8HQIWybsB2NW3sOYv/a5HoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713771853; c=relaxed/simple;
	bh=85iXZOLwJY0gzNWfR+mqKyzMgYOnR8MUW6tV4suFjUk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=lqDEKxVA1Li1pGg3IBY4poiUgHRRuHMaEY8i50gDAFK4eVXSeUqesg8B2N5Q9Ce7erF+RMKJtYiU2kXK1km4THEYxkOIfLLtSzysFfIH+7XHyNQrpVutnPK3hOp3375JqJ29anr0XCW7ZSIXJHRblvLpfzQYnIK740ct5ltWT/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=aBubqWnO; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aBubqWnO"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-41a5958d7c2so3928935e9.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 00:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713771850; x=1714376650; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Tf+HlNZtb/snewbptC+4tUIMMu4+ce0rJkIE8GTpKhQ=;
        b=aBubqWnOGFCtdDUlz2JikQmT5ooGRhSTgw1N9MltwR2kGoybzX28np51BgCVY5uZBQ
         yRI5cn4sc3xkxuzq2kQl3RL47G+/kPlgtqOSSBv5Zn7rbk6W5ktat0jWazG84b7gg0wc
         Q3UNXqty06JSMbDXXQULTkIsXXwPGh4nfiSiQNqV371aoFwfc6XhfTEyF7J63yGkLscZ
         jS3RPRiWLnkb6E3qxBFhTH/owoSnosMd01IUxx6YSUGxwV0JLbZNuqqgn7sbKdS7dU+3
         XtykduCUGtzIlVN8B/thIac69PRuv2LF/V5C6EhV4RjHc4vBRGo2gnwEkxSdXu3zoS9M
         mI2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713771850; x=1714376650;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tf+HlNZtb/snewbptC+4tUIMMu4+ce0rJkIE8GTpKhQ=;
        b=ajvGiY4um1ONag0DDIm/ayJ1+6yPh7OnYIb3uETBUpxGfrkiU8UvtY8NSXvkVo67FI
         i9yTi4vyTPW/JvJPz54OyXjZFtIwbM6yLEYDrLnhb0T398W20EkcgSlMW0m5xe1KBYk6
         eVBc6mrP5yL7zKBRK9PL+wckti2TH1MlAIkh0MPBBVkfNdDsw00WeUJD25SgQqFVBsOK
         mGU3rzf8MhGA31/e69w5r3mJVTjQRprHVlxdLrTSBHIw4za8dVug1PFUVa6+47SHp+vS
         5grjKdokf/TLbxgHxMRZgTjQxwnhjXXtMNOubtPmJ1OF9KJabeoUW+dx9oSMnY0K3A3g
         OBQw==
X-Gm-Message-State: AOJu0YxmOtYnSkEIYOXypY2OAMQYTxwNOhFhIQvLxAgjotS1Zd0F/DcW
	s6GE4sFlcC71uA3vA8k4WSKAYDUXwe6HVXP1/tojKKtLegdmkFXjfWfmrYhqJaA=
X-Google-Smtp-Source: AGHT+IFvMWNrI9VlMGqJP/tD7fFS8jKkN2J/CfDUOqQSMXRP31bgP9ZHU0bjM48pEUxki8NrCA0J6g==
X-Received: by 2002:a05:600c:444b:b0:418:fd36:b0a7 with SMTP id v11-20020a05600c444b00b00418fd36b0a7mr6477776wmn.20.1713771850179;
        Mon, 22 Apr 2024 00:44:10 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c4f4500b0041a0f3d996bsm5902089wmq.47.2024.04.22.00.44.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 00:44:09 -0700 (PDT)
Message-ID: <8e2b0731-fc0e-446e-af83-478e6e86a7ad@linaro.org>
Date: Mon, 22 Apr 2024 09:44:08 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] Fix two regression issues for QCA controllers
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Zijun Hu <quic_zijuhu@quicinc.com>, luiz.dentz@gmail.com,
 luiz.von.dentz@intel.com, marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, bartosz.golaszewski@linaro.org,
 wt@penguintechs.org
References: <1713449192-25926-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713564212-21725-1-git-send-email-quic_zijuhu@quicinc.com>
 <3ab33f9c-206a-4c77-816a-471769591b6c@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <3ab33f9c-206a-4c77-816a-471769591b6c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/04/2024 13:01, Krzysztof Kozlowski wrote:
> On 20/04/2024 00:03, Zijun Hu wrote:
>> This patch series are to fix below 2 regression issues for QCA controllers
>> 1) BT can't be enabled once BT was ever enabled for QCA_QCA6390
>> 2) BT can't be enabled after disable then warm reboot for QCA_QCA6390
>>
>> the links for these issues are shown below:
>> https://bugzilla.kernel.org/show_bug.cgi?id=218726
>> https://lore.kernel.org/linux-bluetooth/ea20
> 
> 
> Provide changelog, either in cover letter or in individual patches under
> ---.
> 
> Do not attach (thread) your patchsets to some other threads (unrelated
> or older versions). This buries them deep in the mailbox and might
> interfere with applying entire sets.
> 

How did you implement these two feedbacks?

v4 and v5 are still bad.

Best regards,
Krzysztof

