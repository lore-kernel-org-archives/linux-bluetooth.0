Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADAD15CD7C
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 22:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713996600; cv=none; b=J2iuFqkn2sVTOlszFAlIsUWYAS9p+D1+ERpEt3UYpDQYYLGPvb0hdZbPAD5lkp54HdhLqoGl4r3Vn+kQmdeaPei2OUhoHdI+0EPJtnYcCGSqy2OWiSNxQBq7T4NIDv975oD1/GJAxWSsjymn4rCZCAl7JLSCi2zKA+42f6Ti838=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713996600; c=relaxed/simple;
	bh=Z+LSPiitJ4S+OIF6sYqersJWnLa0MGFekPKWhQgZaXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tqwvAhN92aEqo4wxRkvO8KuEubbEASiu7GZ2k1fKS+p3tiI3oUTC9qdKihi/Pn1ulTtHgBpXiZYXMK+/v8FLKxUAKuPzgQcn+clmcelg6W3d4N+0/2rjQBWPMmW8NuLR58Oj6Y2rVFlWocCObyMrc4d+BENZU9NP307Ia0dUimQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=bpWQbUM/; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="bpWQbUM/"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1e455b630acso2396455ad.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 15:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1713996597; x=1714601397; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3Q+R04e89x8DmATWRxK3KA/duXsCdtrQ9p6q/LToE94=;
        b=bpWQbUM/pkspqUt5xc7bD93CYOOhuVgc+5I93P/fCmEZHkeNCIwq9iZ8TD5D70pj0j
         Dq1fH3O2OyAjAPNZcJsLXmzMGHbZr/gwHUep/0NaBMIhdnw8gMkwDEj+BHBKqHU/XrXo
         hLZmDyQpKvDZjxdSpq4z6f342qHOJhhZ3x17E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713996597; x=1714601397;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Q+R04e89x8DmATWRxK3KA/duXsCdtrQ9p6q/LToE94=;
        b=M5PvtXgL3EWPBlkXuYiVZn8NQE3tkKV8vs88Hzj2aEx/wk8WvVoZudWfDfejwwugme
         Haq9xgIcJU9Rp8nQYY+n0KZMmdegqomdygwgDCxez9bvp2D7KiRnnEfmtufUKQPKYnVZ
         4NlueGd2hXwvYv3STFgt3Z431EJx8cYY6H4uxYxoQGRRQ45aQVRhleW5DAf/1a5DRD/u
         dffyglTZJ9AfTkQjYgtG8mRfjdF841ZsSnGpt0ENP3V8JxSqkzbv2XBUqcKMrnzs1QY6
         DlvBu6ZC6XgI6gew4DyEEUCRz26a1IatArZVeGzlDxSko4MjM0UHi2jlrij/bhvUV6zm
         CiEg==
X-Forwarded-Encrypted: i=1; AJvYcCUpOVKoWhODqeeTWDOE2jizQR6HNc9qffdDMNO8bAYdoZbZ9mv4hXHjCbXSglFkIPHUhV4/yVm91AeTA2zNCdZmNz1ZSMx/mhrv5PQIScYN
X-Gm-Message-State: AOJu0YzVqUu8sv98k3PnU65gI+dcUImNbfLH9Gw0zqEYgL2JPWaf2TQL
	WM/03o8q5BkZAQuFCjWqQ/SU6lRKnCjlZrYlUClg223cJospwLXEQ0NGAweNJw==
X-Google-Smtp-Source: AGHT+IER+N7HlfUCJTNSkoZIJesGbmJ8vnU3SkoCF0xpzSIoJdmy+q5LOQkj17tXPQJf91AvR9lVQQ==
X-Received: by 2002:a17:90b:1e0b:b0:2ac:5ac2:8c28 with SMTP id pg11-20020a17090b1e0b00b002ac5ac28c28mr3623775pjb.31.1713996597338;
        Wed, 24 Apr 2024 15:09:57 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id ev16-20020a17090aead000b002ae2579ffeesm5418632pjb.19.2024.04.24.15.09.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 15:09:56 -0700 (PDT)
Message-ID: <aca9dc3c-a916-48d1-8a00-459d4e7d584a@penguintechs.org>
Date: Wed, 24 Apr 2024 15:09:54 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: qca: set power_ctrl_enabled on NULL returned
 by gpiod_get_optional()
Content-Language: en-US
To: quic_zijuhu <quic_zijuhu@quicinc.com>, Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240422130036.31856-1-brgl@bgdev.pl>
 <99242a7c-53bf-4227-9623-7bc092f564b3@penguintechs.org>
 <CAMRc=MepDwUbAKrWgm0CXKObqy8=igtug0QDgo-CgwxjZCAC2Q@mail.gmail.com>
 <b982b73d-0540-409c-a6e2-0e03ecb11715@penguintechs.org>
 <0381f39c-38ba-4a2b-915c-f14c5f911eb9@penguintechs.org>
 <CAMRc=MfnEct7ThQhCA3AoY7hxq8j1mmFLNNkK17+RSvJxs67XQ@mail.gmail.com>
 <2371f538-ec53-4037-b171-c62bf4e06eb1@penguintechs.org>
 <CACMJSeunUaj0cxLaN4MpFmX5vTOx_vnWjBN4Y2FavdQoQxFRkg@mail.gmail.com>
 <4c33304a-5dbc-450a-b874-e04ba9e93150@penguintechs.org>
 <CAMRc=MeDQFHX9r-sHNxqkfpi=LkHoRSL7i6dWokB-J+J03rBEg@mail.gmail.com>
 <93e15ecf-252f-4789-a23b-a28280f6aa84@quicinc.com>
 <e64b89b3-a8f5-44e7-ae7f-fc4298841f1c@penguintechs.org>
 <dbc3495e-5f12-4928-afa3-fb8886d276c2@quicinc.com>
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <dbc3495e-5f12-4928-afa3-fb8886d276c2@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 4/24/24 6:30 AM, quic_zijuhu wrote:
> On 4/24/2024 9:26 PM, Wren Turkal wrote:
>> On 4/24/24 6:12 AM, quic_zijuhu wrote:
>>> On 4/24/2024 8:27 PM, Bartosz Golaszewski wrote:
>>>> On Wed, Apr 24, 2024 at 2:24 PM Wren Turkal <wt@penguintechs.org> wrote:
>>>>>>>>
>>>>>>>> That's OK, we have the first part right. Let's now see if we can
>>>>>>>> reuse
>>>>>>>> patch 2/2 from Zijun.
>>>>>>>
>>>>>>> I'm compiling it right now. Be back soon.
>>>>>>>
>>>>>>
>>>>>> Well I doubt it's correct as it removed Krzysztof's fix which looks
>>>>>> right. If I were to guess I'd say we need some mix of both.
>>>>>
>>>>> Patch 2/2 remove K's fix? I thought only 1/2 did that.
>>>>>
>>>>> To be specific, I have applied your patch and Zijun's 2/2 only.
>>>>>
>>>>
>>>> No, patch 1/2 from Zijun reverted my changes. Patch 2/2 removes
>>>> Krzysztof's changes and replaces them with a different if else. This
>>>> patch is a better alternative to Zijun's patch 1/2. For 2/2, I'll let
>>>> Krzysztof handle it.
>>>>
>>> do you really realize what do you talk about?
>>> do you really listen what do @Wren says?
>>>
>>> he says that my patch 2/2 is right based on several verification results.
>>
>> she, not he
>>
>>> BTW, my 2/2 fix don't have anything about DTS usage.
>>
>> I think the problem with your 2/2 patch is that it removes the
>> conditional bailing if the device is shutdown or not open.
>>
>> Maybe this patch instead?
>>
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 2f7ae38d85eb..fcac44ae7898 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -2456,6 +2456,10 @@ static void qca_serdev_shutdown(struct device *dev)
>>                      !test_bit(HCI_RUNNING, &hdev->flags))
>>                          return;
>>
>> +               if (test_bit(HCI_QUIRK_NON_PERSISTENT_SETUP,
>> &hdev->quirks) ||
>> +                   hci_dev_test_flag(hdev, HCI_SETUP))
>> +                       return;
>> +
>>                  serdev_device_write_flush(serdev);
>>                  ret = serdev_device_write_buf(serdev, ibs_wake_cmd,
>>                                                sizeof(ibs_wake_cmd));
>>
>>> he maybe be a DTS expert but not BT from his present fix history for
>>> bluetooth system.
>>
>>
> Hi Wren,
> i think i don't need to care about why wrong condition cause wrong results.

I can't speak the intellectual purity of this patch. However, I can say 
that the patch works for my hardware. I am able to disable/enable on 
cold boot and on warm boot.

@Zijun, Functionally, it seems incorporate your new logic without 
reverting Krzysztof's. Are you saying this is incorrect logic?

wt
-- 
You're more amazing than you think!
