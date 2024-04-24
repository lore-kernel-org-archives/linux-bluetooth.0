Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556D915F3F1
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 15:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713971122; cv=none; b=Ow0HnjDPsEja4Qsh0lAJ/lD9ZRyf0Wl4/kD8BJR1HxogJssmOKjC9mUYVKBRScKRwe0gynjUIiXiPF4WbOEPyxtyxqroexlXhhIKQZ/5xwIXi4E0nMgrPiyY9Uj7Z2FvDdMusBnJFBH3Wu0h5IF3aZuCUHeBfpPwxooF35EhDEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713971122; c=relaxed/simple;
	bh=M2PXvP1fic5DS1K9axVojGNHcogjxY4cLWb7IesW5Co=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sQo2jp6SOLKOx043GMUPNR3uaCLwLXALQlnv2WDaedkokXr8DMnIauPFTgIMK4O7UsVPbQlmuMHZCU3/TKRniRbqzNaysXnF9l9qXdBcOdvoXKpy/BgXLdQG13Mak1V3HYVOCFhnNHaycVFeOxGqIns9W18LMyOOd49mHzrN21s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K464Wd1I; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K464Wd1I"
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5709cb80b03so7923338a12.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 08:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713971118; x=1714575918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=HRYQTL86S7iszempQr9kHRXwK3r/THL9d8asewXe2Ag=;
        b=K464Wd1IYxiRe9IESIbXo+hHRlasJmM8vrb0xTDYvV0JTBvI1Pks7/5EhpJgaqrhwo
         dqkYdIOfxNM75A5NL1brjTNkRrfwT7uZFNuwfGMztgbWBJ9qNzNVf0zXZwuT6kDmy+oD
         Hdg7HybbFiRMBosWKZUTz2KaZZenHSxgJ6XPmfd9sy7M/S/zCwQkC/CNGdRc1amXTSFl
         TtpI9qKbCSOGvCMB4leGZoKbjXnrij+vL5kUIXw3w8bsZs+TkysWBiLgALDafEUi1zOq
         ZSKOMfqlC9dPB6wUp3xztnsnr70Pd6ulbMIleQAvodJ5xW+B1tdiaa4drGOxQcdRjZJP
         QptQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713971118; x=1714575918;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HRYQTL86S7iszempQr9kHRXwK3r/THL9d8asewXe2Ag=;
        b=Pd/FYBqOVu4rTzIfigE2fSi4VCe7NEKxWMcvCyYyY9H0JyX4XQWILJ85luVnFX6JV+
         XF03+nm7f+UqJsTLSdAYcU3CzUNKbkmdOfPl0ka2Gb3doL+jjFZkD1qXQaWCMxuiERHD
         GYnvT9jSpcTCO8WsWAM0Eq9BAZ2iwC+foOkd31P0b9yKyDvthGlhoGk7TTkC5/kH6OQC
         F+NLHLzcjXRro3cN73EUeua8DU7MlR41aFVgJ2S+/8VTQDP+qbMyZZnwdeERxY0j8vdS
         AVmEWsOELIPcIe6gAdCbQtLeZw4T9JfdyTGvW+fuk+kliHpeuEAnhAu3kRpKMsGw/fjt
         OuQw==
X-Forwarded-Encrypted: i=1; AJvYcCX1EZ0vVfWpYZtM9zVdtuslQWgEV/ghltjVzxo1lFtvcwjHu0LAZ7iNnXY7qd8ua71a+i+cV+QTnCxVNqWKe/Bx4LUpJ91Ht9KLCN+mebCZ
X-Gm-Message-State: AOJu0Yz5vXVCnPuRiJHUuy9UzCjzh5IMYRxAwG0Hwz6/hwrJ4E4IX0Xy
	oet8aHZug8DSUUtmNcUzVb1lJsZJnqDSJoOIAYi1p2HKDHKnkFM13dxTIzTZ3Fs=
X-Google-Smtp-Source: AGHT+IGhlPI9ixaNAj3YWrHfevJrcuyDAp0PUrGGXjHAftgG4dFjZ+EujBPjLO7aZH6PYUbcOjGZ4g==
X-Received: by 2002:a50:d718:0:b0:571:c0e6:233c with SMTP id t24-20020a50d718000000b00571c0e6233cmr1636157edi.37.1713971118620;
        Wed, 24 Apr 2024 08:05:18 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id n13-20020a50cc4d000000b005721d18a843sm2264659edi.65.2024.04.24.08.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 08:05:17 -0700 (PDT)
Message-ID: <74997967-7f7f-4fb2-8449-c7d795520858@linaro.org>
Date: Wed, 24 Apr 2024 17:05:16 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: qca: set power_ctrl_enabled on NULL
 returned by gpiod_get_optional()
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann
 <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Wren Turkal <wt@penguintechs.org>, Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240424122932.79120-1-brgl@bgdev.pl>
 <0f8ba1b5-490e-4961-80e2-7942f66730ec@linaro.org>
 <CACMJSeuBCkNyaD60qGVpAq91DqD_OA=tCVEY0t+JNK2vcWBc+Q@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CACMJSeuBCkNyaD60qGVpAq91DqD_OA=tCVEY0t+JNK2vcWBc+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/04/2024 16:52, Bartosz Golaszewski wrote:
> On Wed, 24 Apr 2024 at 16:46, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 24/04/2024 14:29, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>
>>
>>>               qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
>>>               if (IS_ERR(qcadev->susclk)) {
>>> @@ -2355,10 +2360,13 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>>>               qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>>>                                              GPIOD_OUT_LOW);
>>>               if (IS_ERR(qcadev->bt_en)) {
>>> -                     dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
>>> -                     power_ctrl_enabled = false;
>>> +                     dev_err(&serdev->dev, "failed to acquire enable gpio\n");
>>> +                     return PTR_ERR(qcadev->bt_en);
>>>               }
>>>
>>> +             if (!qcadev->bt_en)
>>> +                     power_ctrl_enabled = false;
>>
>> This looks duplicated - you already have such check earlier.
>>
> 
> It's under a different switch case!

Damn diff. Yeah, looks ok.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

