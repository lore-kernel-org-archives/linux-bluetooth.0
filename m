Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A14016C869
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 15:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713972723; cv=none; b=dv8R10WE9TsZ74kd7CBSeIXcqyvbMmVLarMb4EiH+amc1sB/XsudYItaE769sqDZKgXexA79sPOtyhkGbgq5a4UtzLThiioZ3vzGswQ7AaGqCOsI5Z/0i6nUqMK/j6I0WyMitNRo/NhTb0Q0S18g7ffDYuialqD55Jzq87fLmNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713972723; c=relaxed/simple;
	bh=JRPyW97KW7IS/Nem/7ojIkA+DreihF5J6fcAyHruBEE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GOf46XN/OiKgBvJTIQ83qMgFR42mL1B35qviZhCsdE81F5xuWdX2m02+BfH/EzCCiKw+W2jmc5cG4rGSJXh5nmzu8T1P5v9KkE4/zcGLCP6bn3cxFRwIT+1hH1YacFLJ8K4sQWc72buV9daGbYZXZJ4vvJgglZsSGeQpvX7HGzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rPklk4O/; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rPklk4O/"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a5873c52f10so1725166b.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 08:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713972720; x=1714577520; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C+dWfPI8IFobREfQX5crMpKB9ycgdxhFRCM8gK/Bltg=;
        b=rPklk4O/+7EpL7p6Rj3QV+EmFbDFCvl8k0ZjSB4biqSAkPBJJwXnWseFR0QL177UaB
         2tT+Z6RGwGMMqoLRolFgC9eGTSLods1ZHrAyV+vD9U4MiIFDRIKGs7jkUPNja07Qn8v0
         wN7M0yNBEZn9xMOpGu49No3LZHcuO/J6ZLSImdypQ1zr4vHa7OTpbEplVm0+MAhT3CGm
         SBoAOyaYVbEphVB/WfGVDPdPGzQpKrNHTGj6LJx3Ocv6XV1WfRaF6jW87ig+dtUi0WhQ
         iU98hnTctpOb124FgXP6AAYTVp+9t6AJusXH1cHBxBC67sblWCMGA8SEXSPYuqw7Jp0o
         WGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713972720; x=1714577520;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C+dWfPI8IFobREfQX5crMpKB9ycgdxhFRCM8gK/Bltg=;
        b=ctOpI+HaUo+xdMzcTy1iLpqJHjMpzBkdqzwp5Eb0AsI7EdgxCF3BWlbtMoClRXeciS
         UhIYYZX5VSYeVUZPfLcEiXtsT9x1yY+njfJORJGMD1QEZSK1p6WKTEQjKFR7O6Aas6sw
         RNVlOKE75FSPEASAiAOqOOBznbsjeq1XX2onVS0UMvacftoPnpUT3TCKW+Ba6amSRmRD
         /faRV6L1oUQShgbyKfVvVu+90MRvk2gl7BFmHaW0PrXcqWy858kb7GUEAOgL8HSHLCaL
         x4eYLttmYO6XRORDnOQnn7YiEyrf6C4aZ3ywSZRrIfQ9OYWBTQakuE4b0l6SIVdFsCcI
         zNcA==
X-Forwarded-Encrypted: i=1; AJvYcCVT//U9aa7Py0oVjrTeKur/RgWJUSDawTpLkPLkyFN8uHbSAt8cUdCGWXTaaY/Em5G7gLpcha4M+GVU8cHzS158XUHNoKiagRPHW7P2dFjj
X-Gm-Message-State: AOJu0Yw5yHgjR4jzSXX9DjxbWDm/Y199ObEy5cMqR8BnmaIg1QQPNqCH
	dvf834+xYLvh3Gq5KsvuRd9fEvO/YNaGBTgTz2LuqBu4rV+FQkofdUqxXnaLxxY=
X-Google-Smtp-Source: AGHT+IF/N580yjGmcwtQe4iXcAd1fok4yxd+7XptzOrdKEgMM24yg2c9fz3fw9/NwaS6+kiF3QLSpw==
X-Received: by 2002:a17:906:3291:b0:a46:3ce4:5acb with SMTP id 17-20020a170906329100b00a463ce45acbmr1810267ejw.75.1713972720404;
        Wed, 24 Apr 2024 08:32:00 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id l9-20020a17090615c900b00a555be38aaasm8445564ejd.164.2024.04.24.08.31.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 08:31:59 -0700 (PDT)
Message-ID: <cfc263aa-110e-4b63-b54b-976d07724369@linaro.org>
Date: Wed, 24 Apr 2024 17:31:58 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: qca: set power_ctrl_enabled on NULL
 returned by gpiod_get_optional()
To: quic_zijuhu <quic_zijuhu@quicinc.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann
 <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Wren Turkal <wt@penguintechs.org>
References: <20240424122932.79120-1-brgl@bgdev.pl>
 <0f8ba1b5-490e-4961-80e2-7942f66730ec@linaro.org>
 <CACMJSeuBCkNyaD60qGVpAq91DqD_OA=tCVEY0t+JNK2vcWBc+Q@mail.gmail.com>
 <d82c2e39-d2b8-4de0-a11a-6ab2420f8f95@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <d82c2e39-d2b8-4de0-a11a-6ab2420f8f95@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/04/2024 17:24, quic_zijuhu wrote:
> On 4/24/2024 10:52 PM, Bartosz Golaszewski wrote:
>> On Wed, 24 Apr 2024 at 16:46, Krzysztof Kozlowski
>> <krzysztof.kozlowski@linaro.org> wrote:
>>>
>>> On 24/04/2024 14:29, Bartosz Golaszewski wrote:
>>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>>
>>>
>>>>               qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
>>>>               if (IS_ERR(qcadev->susclk)) {
>>>> @@ -2355,10 +2360,13 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>>>>               qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>>>>                                              GPIOD_OUT_LOW);
>>>>               if (IS_ERR(qcadev->bt_en)) {
>>>> -                     dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
>>>> -                     power_ctrl_enabled = false;
>>>> +                     dev_err(&serdev->dev, "failed to acquire enable gpio\n");
>>>> +                     return PTR_ERR(qcadev->bt_en);
> please think about for QCA2066. if it is returned from here.  BT will

Which is correct. QCA2066 requires GPIO. Look at the bindings.

> not working at all.  if you don't return here. i will be working fine
> for every BT functionality.
> NAK again by me.

Yeah, my bad, I taught you that sentence and you keep repeating it.

Best regards,
Krzysztof

