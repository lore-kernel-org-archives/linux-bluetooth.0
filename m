Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9FB84D1F
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 04:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713931812; cv=none; b=OK30PptPgF7E4MfpKf1KiOazaV8OhcOdtrhqwHwBsVQ2vXjAOVuZcrs1srR6sTHSY3uL57RQa1Y6tUHRgvf0PKUAgvEWfZlVvS72HbxOiD5UHtTmt8MpJfygDwMgPcTNl0N0Z7QUNW5vRiwa5yH6ePwy3ZiXrXpf2x0yTd92VAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713931812; c=relaxed/simple;
	bh=5CTEDUKhuty+xSK64fcrORKB66CUbX0rNW3/tOCKzD4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ngc4YgMuCj5CCBVaSJOsvGOw+H3bcUKT22lAEtS21VWxSkBJLceYTpcIZwyN0XpuqTpqJzwKC7lW0Tfu/6sijhGxOuPnhn6fmES6IkQzfRx/e3PSpyFBppDWuGYgvlm9Yq1R06F3TSiUKzvYFaYu2ZmAxgomw2Ta5DI9/F1Rrco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jvJPDrsP; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jvJPDrsP"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a56d7d457a1so301255066b.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 23 Apr 2024 21:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713931809; x=1714536609; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6xml2FXGnImdmU4NErN3WJ5kJgBbG/s+B+H+8dqXT0=;
        b=jvJPDrsPurMeH/gwr0XW+xEhsZTUAQcUVJ+aKC0hx0DxEzt1CAySdZcSmF4Gf86uUu
         k2vOyCNblx1eerMAR+mMD6DEKkarBpq3+evU4NY3D9vJF5BycRLY6oiXfPUCOgHRBgAd
         BMpKUIg8R8th5a/YKxVsU8vSPNUV79kRJQIpxAChXnO4OT++aUiGFKx75HB36vDAxdsq
         tKIEWxa7PyqT/iGTjzN9OjlzjO45ARhkif8kfuy+qkyrWIm30HoyXDPlm5D3qs/DRtIb
         ryhrhXTqRefzht1jWB01uy6TqR7AgyHtcncTOW9JAtI2PbfOn/0jjGpMc0o/VSnhwAmg
         hnKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713931809; x=1714536609;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y6xml2FXGnImdmU4NErN3WJ5kJgBbG/s+B+H+8dqXT0=;
        b=HWv/uZ38i/ii9i9vrI/uBVGWOrmgHsvXcCf7WLdQYVGej+rrnlyOabpxcDGdBJVROM
         Coff6pIe+EPh3cKDq3RpjwT9uiCErXyRdPFdiIRad+kGFEyPAtNU0dZGx3zoePE88Zpl
         jahBqDyfZL8C2JiP7Mze2BsuzVqcZG+J0PNHdZ5XIlxs8Xb9VpznaHoh7ty1CfwpJahP
         HC8sQAf/zf9gyMsdkcqC1JMZ9MGV1/iuFzalYXihBYhmguSN5nHldvDxeKpzUA9beEF9
         Z+VAjmzS+E/RyimJc3cNvPCrpokz6XajnFB91CKWs9G3+lG6M20l2dQKnYpqNPOC2oTc
         dLyg==
X-Gm-Message-State: AOJu0YxDTpJuYjIk1VEa86TY9sviUQC0T/l7Uomcfaks8jifd1z4fo9O
	oU7TwczgaQsSTege7+yXO2DQTYwModR3NzsuwCN4UTInQX8y4NWAvqkkuucY7b0=
X-Google-Smtp-Source: AGHT+IHIbm0ox4SKQrmwa5lVXhvHgqk22MI89qqUIMiTYU7LzGOjQnHu20s2dRuK1sIhJS8uLpBmgQ==
X-Received: by 2002:a17:906:4a10:b0:a58:9707:6857 with SMTP id w16-20020a1709064a1000b00a5897076857mr43702eju.12.1713931809560;
        Tue, 23 Apr 2024 21:10:09 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id bu6-20020a170906a14600b00a57c75871d8sm2367499ejb.106.2024.04.23.21.10.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 21:10:09 -0700 (PDT)
Message-ID: <dfe18768-f6da-4c60-880d-deeae3c3b04d@linaro.org>
Date: Wed, 24 Apr 2024 06:10:07 +0200
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
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <e8cd122d-e342-45c2-b078-a4ca2d8dcfff@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/04/2024 06:07, quic_zijuhu wrote:
> On 4/24/2024 12:06 PM, Krzysztof Kozlowski wrote:
>> On 24/04/2024 02:46, Zijun Hu wrote:
>>> Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
>>> with gpiod_get_optional()") will cause below serious regression issue:
>>>
>>> BT can't be enabled any more after below steps:
>>> cold boot -> enable BT -> disable BT -> BT enable failure
>>> if property enable-gpios is not configured within DT|ACPI for QCA6390.
>>>
>>> The commit wrongly changes flag @power_ctrl_enabled set logic for this
>>> case as shown by its below code applet and causes this serious issue.
>>> qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>>>                                                GPIOD_OUT_LOW);
>>> - if (IS_ERR_OR_NULL(qcadev->bt_en)) {
>>> + if (IS_ERR(qcadev->bt_en)) {
>>>   	dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
>>> 	power_ctrl_enabled = false;
>>>   }
>>>
>>> Fixed by reverting the mentioned commit for QCA6390.
>>>
>>> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
>>> Reported-by: Wren Turkal <wt@penguintechs.org>
>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218726
>>> Link: https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f
>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>> Tested-by: Wren Turkal <wt@penguintechs.org>
>>
>> No, Bartosz' patch should go.
>>
> what is Bartosz' patch.

Srsly? You were Cc'ed on it. How many upstream patches on upstream
mailing lists do you receive that you lost track of them?

Best regards,
Krzysztof

