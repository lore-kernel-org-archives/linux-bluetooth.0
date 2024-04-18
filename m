Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3042A4A20
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 22:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713479839; cv=none; b=Ubmuc1vGEPW/HwdISkaLcBDHLl9lavQF0L6Ii7087xglO0wO/uWNC9FgZTo4wDuwUnyJ5s5gTQ99XxxuwvaeLdg3EGhN8sPPOci8N8Dda3sIx8XqbN/J7ztkg5vno8bSiVgYg2qXypP7Uvc0DulSJfrDUniInUcks/3XGMJRjb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713479839; c=relaxed/simple;
	bh=Xbgd/exa8qf/QYBD1lldu+SDodYLutGvqNZOu5u0qXA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fngqcE/dceAVDi/So7JARR92ogYyN+sB4YxzaAZdHJpEBIobV0XaGokey/rmZPqlIBa3HZbaRFSzOOjaS+MvLWq+9iCz3Kgpb31T7pprqxvcP6ztyRkSvZIkFgTESJk3ta0MSIqMRChborEU0k7RkN2TJ/IRY5ydNWhBYxPtMJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AbOSW98o; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AbOSW98o"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1e8b03fa5e5so5363665ad.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 15:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713479837; x=1714084637; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7okPBaveo1ZiS5BzkmL1UYE8cQkDLuGYdlHLujOhpzc=;
        b=AbOSW98ooy6lgQSSeIfoNo8VA0uI8vD2eJ9FbxlNNfOBrCywByOOdKVbDquByivNX7
         dvgE3PSpy5/Qyy3s/b9bURoR0Q34/1G0MTbxcoDnbeExj5NPHMoEnVGBQExmKtzp5NYw
         EvO/KOAT3huI2h9JtvkYiX7h8SkDrlhivn9iEPWf9UG00ImEBRqb9Fh7ppgw42D38Sga
         u4UMSIS0QBKdlJFo9BQKR4yOSn8afqUA/jSNEo9TRTcetq/fwKD8vmldVoM/1H+Z7+lF
         3Xlw5KBJCMGnZqELdtpviSad6DA4O3q0FEhrYLKdde7Tr284Hzj4TYN0FCCH26mf7rhm
         LjPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713479837; x=1714084637;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7okPBaveo1ZiS5BzkmL1UYE8cQkDLuGYdlHLujOhpzc=;
        b=Xqnz84Pk5DcAqEE5oH8JWJ7uDMrxyxHT4JI6xR1DSQHwF9hbHYBkzHeGIe8UkQtnQN
         CAE9mtaAfH7u7pyAzGkLT39698ldbuEkQK5nWzS51UU+vb26iZqssjFetuUp/s3GYXxt
         w1JPeRvpjJSy5pCUNiWseN2Vr4p4gR9skLpbWca+9llxAUIazCTh2y0QpOWarlKWbiN9
         P6CmE9yGlT4CYoOisVoaLL4xLAm8800vGooaQLiHjM5GMps+00A30kTt4nPc2jZpLRYj
         Z6PyzUV+daajj6jjJpz7ZLGJXufMYqptTIu7oQ+Cf73w3I6orZUDYQ3mdtD4G5x4l/EH
         oFkg==
X-Gm-Message-State: AOJu0YzZQI4eW7S4P6gTGL2bNPjqRZF3Pn2GMjOynEuh5A5oxB9MjVtX
	CNPeJf7SCC0HPGv8iMwtl/Wet7P0SJd5EFKvFu09FSgbOVQ1wPD08oRRC9pbfrE=
X-Google-Smtp-Source: AGHT+IEiB4L5WIP8juAMIO7vkO3C/kFAsfUGeSVEe5tGwZ17K8DStY9/63sx1PuWRmMA2k5Iljh1Zg==
X-Received: by 2002:a17:902:d491:b0:1e3:1542:91e2 with SMTP id c17-20020a170902d49100b001e3154291e2mr551277plg.46.1713479837383;
        Thu, 18 Apr 2024 15:37:17 -0700 (PDT)
Received: from [10.36.51.174] ([24.75.208.147])
        by smtp.gmail.com with ESMTPSA id o24-20020a170902779800b001e5119c0f9asm2042123pll.66.2024.04.18.15.37.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 15:37:16 -0700 (PDT)
Message-ID: <52394d97-04c3-4f77-aaae-f1e152cd5632@linaro.org>
Date: Fri, 19 Apr 2024 00:37:15 +0200
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] Revert "Bluetooth: hci_qca: don't use
 IS_ERR_OR_NULL() with gpiod_get_optional()"
To: quic_zijuhu <quic_zijuhu@quicinc.com>, luiz.dentz@gmail.com,
 luiz.von.dentz@intel.com, marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, wt@penguintechs.org,
 bartosz.golaszewski@linaro.org
References: <1713449192-25926-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com>
 <83a1c837-e403-4da2-83c6-ee3dedbc1fe0@linaro.org>
 <7c5b85ca-e897-4798-97e7-955478c57d12@quicinc.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <7c5b85ca-e897-4798-97e7-955478c57d12@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/04/2024 23:16, quic_zijuhu wrote:
> On 4/19/2024 12:52 AM, Krzysztof Kozlowski wrote:
>> On 18/04/2024 16:06, Zijun Hu wrote:
>>> This reverts commit 56d074d26c5828773b00b2185dd7e1d08273b8e8.
>>>
>>> Commit 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL()
>>> with gpiod_get_optional()") will cause serious regression issue for
>>> several QCA controllers such as QCA_WCN6750,QCA_WCN6855,QCA_ROME,
>>
>> The pin is required on 6750, 6855 and maybe others. You cannot not have
>> the GPIO.
>>
>> This is no correct fix. You provide wrong DTS and, instead fixing it,
>> try to revert kernel code.
>>
>> No, fix your DTS first.
>>
> no. your point is not right.
> 
> 1) do you have any evidence that the hci_qca driver must use reset GPIO?

I think we talk here about enable-gpios, right? Then the evidence are
bindings.

> 2) why does original design do error return when get GPIO error if GPIO is mandatory?

If GPIO is mandatory, then it is expected to return error. What is the
problem here?


> 3) i meet many customer cases that BT are working fine without hci_qca operating the GPIO,
> there is why HCI_QUIRK_NON_PERSISTENT_SETUP are introduced.

Bindings tell different story and nothing in the commit msg explained
this. You did not correct bindings either.


> 4) does the reverted change solve the issue your mentioned ?

??? I did not mention any issue. I am saying that your rationale is
either not complete or not correct.

Specifically, the enable-gpios ARE currently required, so whatever you
claim here is not correct till they are required. Make them optional and
then your arguments could have sense.

Best regards,
Krzysztof

