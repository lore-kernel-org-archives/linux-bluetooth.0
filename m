Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 162B2158DC0
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 09:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713952088; cv=none; b=Od/41p8BO7SftowwbtJI5LX+PQRdGH918gZ0IXYbuWEtGpZ/CY3mJA3m3v50nRI0pqZkUiIgV0Lv3crZnJ1euc/0hZ0EYkxSMiI7/y4V5VcitJn7bMnoRub2T8WV2V9CiYcgiHCcu6k5bVxmPL/y/VgUYwAr7PmvlIPfRvEwv0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713952088; c=relaxed/simple;
	bh=xFZVwNSUbyYVxOCP0imNdccoHJMfl4t38ZoiVS7hHUI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SX8fZaayR00i0U6mpEW9HhooIOI2AbY6arPXmNdPSXcYXEM4fsezBX9iSwDEuHKInujO4i2P/t4eCMnWE3wsiMzLvZd7bhmKg/Gja3ua7YKCyta3RzTcJkWqKKR3HMdjdyetgEsFvGMlFszhMw0OSTJc3UYNtrW4FOpqUmTTznI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D3kUaUPS; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D3kUaUPS"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a55b78510bbso360154366b.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 02:48:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713952085; x=1714556885; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dBMhN6tSTtjNRSH1RVubQtWgZkTS86F6MB7x5+O8QBM=;
        b=D3kUaUPS1x7KZ/rFWMdeIQ6g0jGhi5rqNkMBSQ1XBM9sD8tjOL+td8KkX7Qrm1ekrc
         15Up5/g94FtMLqL6E6O0tnbewo8739hUMLLPB+NZOn2dwVaAsd5pdocz6qCH0yXxYRXy
         BFgOflaQe5Wzv3bdGN/hrgRFIWrzB3gTiHQoNQKoG8u/IS5cHCfjxE0k98qJ6JQFgFqA
         RNCq4BlIL6fnUEK50gnSZ/cNK2CgSXVLTEfpdSP7rP3V3fJSi5LmhMreuKPJLIFYMQAd
         m5AEjP3UNQDU+7ZRXDfiywfjLO3UxFy1uGjdU6s26BnCeHTRO5igQ7k5dxIOHdDUf++J
         qFPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713952085; x=1714556885;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dBMhN6tSTtjNRSH1RVubQtWgZkTS86F6MB7x5+O8QBM=;
        b=lh+jfAVmbUV4QxSRE7jXjZHCqJaxM7+EXUCpmDE6CiGEauCrc40pSFmXbD/wmuB4/h
         M69rkQ/JlllLJ+26Q+KhMDQ1+v55bBnOFAV3jKA693uR+nrV/QiVakW4wDE6V6vpf2R8
         MPr+I2815FQSf3pV6mS5wapqP93uPYU7+H4l6G0szMMocxXZ6ZAbcXYxRXFCH6p5rV0k
         FlDQGoZBC9qC765jOiNcRRYVUZMKhjLDeskCDNeXzehPz5+lSwsHwnGs6cvSnrO+BjEO
         nOeEqR0YIfC750iqq7ttdPicOH1qvLRt+gs45vHl4oi/0Pz8rZRFOp818SJ9ztPzJzW0
         11DA==
X-Gm-Message-State: AOJu0Yy6c/E+/UiP52KGJ4mLKpJqx5tDQ3za+jrQs8LglBcJitgzZXaV
	vVl6RRoHpxRNx9mrVicd8HeYz3R2IYFEpwV8lUBJMJQbZPsC0kLURVDpymPFV/g=
X-Google-Smtp-Source: AGHT+IGMegTBrEoK3B5XDbr+9+PF7FrMuGc66Z1Oq6WOqpIPvAmRmcQ7aAK4zK9xDf0IJ2thtqnFbg==
X-Received: by 2002:a17:906:a447:b0:a52:62a2:d727 with SMTP id cb7-20020a170906a44700b00a5262a2d727mr1177365ejb.52.1713952085192;
        Wed, 24 Apr 2024 02:48:05 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id gf16-20020a170906e21000b00a526fe5ac61sm8082895ejb.209.2024.04.24.02.48.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 02:48:04 -0700 (PDT)
Message-ID: <9e8e8607-dc12-4371-af4e-16786b13a13e@linaro.org>
Date: Wed, 24 Apr 2024 11:48:03 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] Bluetooth: qca: Fix BT enable failure for QCA6390
To: quic_zijuhu <quic_zijuhu@quicinc.com>, Wren Turkal <wt@penguintechs.org>,
 luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, bartosz.golaszewski@linaro.org,
 regressions@lists.linux.dev, kernel@quicinc.com, gregkh@linuxfoundation.org,
 stable@vge.kernel.org
References: <1713932807-19619-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713932807-19619-2-git-send-email-quic_zijuhu@quicinc.com>
 <a8a7e3df-44c6-4fa6-a576-da384c02e9ac@linaro.org>
 <067db05d-56bc-4ca3-aef1-bc3bae47667c@quicinc.com>
 <c1fc9c28-25df-4d41-9ae6-c5d079ea805d@penguintechs.org>
 <0db77c30-5be2-41b5-adf0-fb4436b9107b@quicinc.com>
 <c9bf22a3-2549-4cf1-898e-8a9adcd2f0f6@penguintechs.org>
 <d77455b2-4fb9-4ffc-acf9-c24b5a0f4a45@quicinc.com>
 <b3d8e1de-3beb-46a2-817d-ee0fdd614b0a@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <b3d8e1de-3beb-46a2-817d-ee0fdd614b0a@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 24/04/2024 11:39, quic_zijuhu wrote:
> On 4/24/2024 2:01 PM, quic_zijuhu wrote:
>> On 4/24/2024 1:49 PM, Wren Turkal wrote:
>>> On 4/23/24 10:46 PM, quic_zijuhu wrote:
>>>> On 4/24/2024 1:37 PM, Wren Turkal wrote:
>>>>> On 4/23/24 10:02 PM, quic_zijuhu wrote:
>>>>>> On 4/24/2024 12:30 PM, Krzysztof Kozlowski wrote:
>>>>>>> On 24/04/2024 06:26, Zijun Hu wrote:
>>>>>>>> Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
>>>>>>>> with gpiod_get_optional()") will cause below serious regression
>>>>>>>> issue:
>>>>>>>>
>>>>>>>> BT can't be enabled any more after below steps:
>>>>>>>> cold boot -> enable BT -> disable BT -> BT enable failure
>>>>>>>> if property enable-gpios is not configured within DT|ACPI for
>>>>>>>> QCA6390.
>>>>>>>>
>>>>>>>> The commit wrongly changes flag @power_ctrl_enabled set logic for
>>>>>>>> this
>>>>>>>> case as shown by its below code applet and causes this serious issue.
>>>>>>>> qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>>>>>>>>                                                  GPIOD_OUT_LOW);
>>>>>>>> - if (IS_ERR_OR_NULL(qcadev->bt_en)) {
>>>>>>>> + if (IS_ERR(qcadev->bt_en)) {
>>>>>>>>         dev_warn(&serdev->dev, "failed to acquire enable gpio\n");
>>>>>>>>      power_ctrl_enabled = false;
>>>>>>>>     }
>>>>>>>>
>>>>>>>> Fixed by reverting the mentioned commit for QCA6390.
>>>>>>>>
>>>>>>>> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
>>>>>>>> with gpiod_get_optional()")
>>>>>>>> Cc: stable@vge.kernel.org
>>>>>>>> Reported-by: Wren Turkal <wt@penguintechs.org>
>>>>>>>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218726
>>>>>>>> Link:
>>>>>>>> https://lore.kernel.org/linux-bluetooth/ea20bb9b-6b60-47fc-ae42-5eed918ad7b4@quicinc.com/T/#m73d6a71d2f454bb03588c66f3ef7912274d37c6f
>>>>>>>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>>>>>>>> Tested-by: Wren Turkal <wt@penguintechs.org>
>>>>>>>> ---
>>>>>>>> Changes:
>>>>>>>> V6 -> V7: Add stable tag
>>>>>>>
>>>>>>> Stop sending multiple pathchsets per day. I already asked you to first
>>>>>>> finish discussion and then send new version. You again start sending
>>>>>>> something while previous discussion is going.
>>>>>>> you concern is wrong and i am sure it don't block me sending new patch
>>>>>> sets to solve other issue. so i send this v7.
>>>>>>
>>>>>> i have give reply for Bartosz' patch.
>>>>>>
>>>>>> i hop you as DTS expert to notice my concern about DTS in the reply.
>>>>>
>>>>> Are you saying here (1) that you identified a problem in the DTs that
>>>>> you hope Krzysztof notices or (2) that you want Krzysztof to notice how
>>>>> your description of way that DT declares the gpio as required affects
>>>>> your proposed change. As a native American English speaker, I am finding
>>>>> your text hard to follow.
>>>>>
>>>> 1) is my purpose. i have given my concern about DTS for Bartosz' patch
>>>> and hope DTS expert notice the concern.
>>>>
>>>> my change don't have any such concern about DTS usage. that is why i
>>>> changed my fix from original reverting the whole wrong commit to now
>>>> focusing on QCA6390.
>>>
>>> Let me try to parse this. If #1 is the correct interpretation, does that
>>> mean that the DTs are wrong and need to be changed? Do you expect K to
>>> do that since he's the "DTS expert"?
>>>
>> for your 1) question, NO
>> for your 2) question, need DTS expert notice or suggest how to handle
>> case that a DTS property is marked as required but not be configed by user.
>>
>>>>> I think you are saying #2.
>>>>>
>>>>> I just want to make sure I am following the discussion here.
>>>>>
>>>>> wt
>>>>
>>>
>>
> Hi Krzysztof, bartosz.
> 
> do you have any concern for this patch serials?

What? Amount of noise coming with this constant ping and dispersed
discussions is really annoying.

Best regards,
Krzysztof

