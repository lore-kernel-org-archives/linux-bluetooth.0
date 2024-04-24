Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5679C1428FA
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 04:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713933009; cv=none; b=Apg2RiUnkcRw7k1cDu6KB3caPCSRtEMlWFzDnVGo5vwabQ9McXenUcJOnuUliM4sZPzSqjDxsugzJwHFhkqvaXITiabIqqgtbGla4BSj0/qWkS37SFh80zrEf2Jguf79CKAwF9SQstfYhD0HvBLFMsvHUocWeJ1M91q06qmlZAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713933009; c=relaxed/simple;
	bh=ZNoNas49XTGU/GGPh3qbUdUAyM+kgFEb0iaYJHdmUCQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PnLsjwSnleU9kS+03hbGijqywcy9pUfYvkf6bQu0LMsqP/qHtoeTJelQQgYXkpdzeyuBFLeH5Nn0NzOY/Ps2/64FlQaSLRbqf0Fco6pv99pt7RPr+WAcSTZSw3uwGivHgfa0FQqH07QOjVYUpcg6eo/Yo3YqfB9RhabDiS4wpz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Wbu1ONcB; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wbu1ONcB"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a55b93f5540so349161766b.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Apr 2024 21:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713933006; x=1714537806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=VkZG+dfRKVCvk6n/gOBR17YOs/782cF+tijroUdXw/U=;
        b=Wbu1ONcBPES22y/pJ2xav6GGc0vKpS254dmHGt4icpgjfCLZZrlFsAG5XYmDVN3N8P
         WEyJjvhKtQrxLMdCOcLn11EZORmmRWGBT12cLb5ZeU2/iPjVHlRLHsSbtiXfkLea09WS
         nPKZoOPo33YNsicZbO0JuUdFLKHciCJ6Srnt3bCSDIiXJAy9A02OztcreutzLbIe51D1
         uuOANTna7Vwhix4vnNt7c1xxa91ZHnSuJdhPUh4dyyGBdbw3cGEbj8rTU8iPMqGCkSHM
         p9aGmDAPAmGU/+Us1Ry1d1wG4jv80Bg1O7e8GLhM9w21U9Oc96yBh8pc5rqvqyvo1Xf5
         yjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713933006; x=1714537806;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VkZG+dfRKVCvk6n/gOBR17YOs/782cF+tijroUdXw/U=;
        b=BTZfrlRMJy3LSGx1vXxfCl5O3JI65z+9HPpk7RwNzy+Y7sMkoH0oXWF3181w9Wm+ho
         ITug6rRXgLEjXts2qBrtRnMvQjGOre4Rq9TRZQBz5baWRbbFhxPF4ODZFZh6kanMS66L
         A1xX+46dNQ8Gs7sDOOz+MC2cYCYVymz+OtkS91afG4wsyXa9LbvJAHC6BxSQ8qZZBCW1
         qMPcr6AAWQpQ6ucRORjnH2ZiOHxccdBKMHp24l4TE2F5XEOwAAd5OAGPzjlKw39pHP/b
         QrSKYP1ie5xLpJhTDXtijShVOzR2tEXaC7a2UDQoy0kfOmO2HS6FaKmpu4isDOqas1rs
         fDcg==
X-Gm-Message-State: AOJu0YzX6Kx/NN28lnnBl8Mc6Hde39cyvQDNKRDSJD9493z0n8O1ccDX
	pR2EbxdTTNcn0Eq8WKN7Vvw3jDVX7IC96YLgjx1br86nXOGLsrv+RMojahCpJ5o=
X-Google-Smtp-Source: AGHT+IEwVNedzwnUbi0N5TtWMyRSRUNs3PYDOooZf9/7Blt0KfVYo1XtSUTOnOT+/wT9LnmIKwcD0w==
X-Received: by 2002:a17:907:9711:b0:a58:9748:6d6e with SMTP id jg17-20020a170907971100b00a5897486d6emr101730ejc.6.1713933005622;
        Tue, 23 Apr 2024 21:30:05 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id r25-20020a170906351900b00a55b5c365dfsm3337258eja.199.2024.04.23.21.30.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 21:30:05 -0700 (PDT)
Message-ID: <a8a7e3df-44c6-4fa6-a576-da384c02e9ac@linaro.org>
Date: Wed, 24 Apr 2024 06:30:03 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] Bluetooth: qca: Fix BT enable failure for QCA6390
To: Zijun Hu <quic_zijuhu@quicinc.com>, luiz.dentz@gmail.com,
 luiz.von.dentz@intel.com, marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, bartosz.golaszewski@linaro.org,
 wt@penguintechs.org, regressions@lists.linux.dev, kernel@quicinc.com,
 gregkh@linuxfoundation.org, stable@vge.kernel.org
References: <1713932807-19619-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713932807-19619-2-git-send-email-quic_zijuhu@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <1713932807-19619-2-git-send-email-quic_zijuhu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/04/2024 06:26, Zijun Hu wrote:
> Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
> with gpiod_get_optional()") will cause below serious regression issue:
> 
> BT can't be enabled any more after below steps:
> cold boot -> enable BT -> disable BT -> BT enable failure
> if property enable-gpios is not configured within DT|ACPI for QCA6390.
> 
> The commit wrongly changes flag @power_ctrl_enabled set logic for this
> case as shown by its below code applet and causes this serious issue.
> qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>                                                GPIOD_OUT_LOW);
> - if (IS_ERR_OR_NULL(qcadev->bt_en)) {
> + if (IS_ERR(qcadev->bt_en)) {
>   	dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
> 	power_ctrl_enabled = false;
>   }
> 
> Fixed by reverting the mentioned commit for QCA6390.
> 
> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
> Cc: stable@vge.kernel.org
> Reported-by: Wren Turkal <wt@penguintechs.org>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218726
> Link: https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f
> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
> Tested-by: Wren Turkal <wt@penguintechs.org>
> ---
> Changes:
> V6 -> V7: Add stable tag

Stop sending multiple pathchsets per day. I already asked you to first
finish discussion and then send new version. You again start sending
something while previous discussion is going.

Best regards,
Krzysztof

