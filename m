Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF51D3FE4
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jul 2024 20:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722369930; cv=none; b=rmyLk2Po8mWv5Y92lsLN1aW8UEYVIchWEdZ02XUi+W/IgJp154o/k84hAqi088fI0LIfXSpVEMAdFBdGnp0VZ7ngaEuNwi1Ne3sDFVjtEUPrg2MbAX8rt1/ftWNkfAAnIhhbQlNWscspBC2xj1xENcHpoaWmyUYwAHvg//p8mEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722369930; c=relaxed/simple;
	bh=I+0eoWhg6O2fy8YKhXnqmutKsxVcSmL6fwgkMyeODyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jAk11kaa9hnhVkdRSkEgXAAxr3OYo08cPh+uILP2Q7QGOgb5TkeV/2th0CZFxhxtj02ywQQ2KtRBFRIVilXOHi9qDxgbPJz2GgqO2xogJ5lVx3ENzl7UsBP9I+FwuKkOlaVKz4MVGuvjfIDehGFwGlpOReztalLh+vGOmt+snkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=eZ6mbQXb; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="eZ6mbQXb"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-70cec4aa1e4so3402347b3a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jul 2024 13:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1722369928; x=1722974728; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ADBVFRLaHaAhYnFIHVd074ej3LECI6MjrZiftTr7xuI=;
        b=eZ6mbQXbqYRFJ+vE9Ti6+cMLECEaSNYVOHoI5nchVlL1lX1nCd70Xg+DmQMBubUteu
         pRGpeWJitthiMfgCJC1DvIgqxIoaUmTbElHiouGYuetq9uq35ZLmV6ByoW/XOEAo/hVD
         sgYxFrrhB/zK60Hrcacxp02atZCJn7ba1BTHc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722369928; x=1722974728;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ADBVFRLaHaAhYnFIHVd074ej3LECI6MjrZiftTr7xuI=;
        b=faMHT+O+FLAPnJlKV9BxA7eEjuJqbXB+pzZo83W1+C5vgXJ8ctmG7974W52IuLhz2J
         y/dx6UjpTFgz18SPXvoJ7qG23MF+vj97sr1McENgY0KdNY5uAeXrjqmhRCDyTfsUvp+d
         u5Bf9eSrCtWnagzUVot/yAVDk62nCq4s7UjwLMahUAsRIxiwG116DPJsVTPp+s0N89gp
         Qch6v/1EVmY9kXTG9RpUF4ghk7JN3OXrO3mUI+b58+66zSj/QKg6nlt8OFonKkaVgVgS
         +H/DW3U8fC39DyHn7iq0DjEQdD6chVwTtyiITTnQa7NzeYIAj3dBFr4RYP3503HLSTYp
         lMPw==
X-Forwarded-Encrypted: i=1; AJvYcCVxeHqQQl1DJN/64sC5R9pNsd+c2HqVQO4QXV+6jIBqgJDzGC7dFFjceeycKqhZscraPbcAT83ywS17p3NUslgetRysMgFyBe2w+69npBsF
X-Gm-Message-State: AOJu0Yxf0f6jlfPJi5Q7JipCg2rclv1s/6qvFQ+RYMwOBheXO5jGt3/W
	VfrdcioxORS0iFLaPZ7tMn/GdZ/bb+sjEYZoPDCU08cgcjmwy+FMGx2hasBXFVWQtF/WplmsRn+
	qCw==
X-Google-Smtp-Source: AGHT+IFLB7bwTbMp+LNL1V+DCLoIczrQONBil80OrPrv2q9y9+aPqQYEzkX7lIxdWwO1nJEHcog6eA==
X-Received: by 2002:a05:6a20:7fa8:b0:1c0:e54b:5651 with SMTP id adf61e73a8af0-1c4a12e0e9dmr16714727637.24.1722369927722;
        Tue, 30 Jul 2024 13:05:27 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7d15e98sm106401195ad.99.2024.07.30.13.05.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 13:05:27 -0700 (PDT)
Message-ID: <534cff38-7bbf-4e9d-90c5-c4a4ba331a8e@penguintechs.org>
Date: Tue, 30 Jul 2024 13:05:25 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QCA6390 broken in current kernel
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Zijun Hu <quic_zijuhu@quicinc.com>, linux-bluetooth@vger.kernel.org
References: <27e6a6c5-fb63-4219-be0b-eefa2c116e06@penguintechs.org>
 <CABBYNZ+vVFUm1Tb+BvViYMJd6XQczTYPgyO++GGbCcWrkaC4Kg@mail.gmail.com>
 <30319168-9456-49dd-be27-480b2a068fe3@penguintechs.org>
 <1a519b2f-f5cf-40b3-8223-162dc04f8ca8@penguintechs.org>
 <21645f07-da90-4441-8dbb-d999298165e9@penguintechs.org>
 <b1061ec0-5f8f-44af-8955-2d6fa11f94b3@penguintechs.org>
 <CACMJSet3H3B1rz2eZyxUr_ySUOdhTkAognfKpFZ=Kzto8UsxMQ@mail.gmail.com>
Content-Language: en-US
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <CACMJSet3H3B1rz2eZyxUr_ySUOdhTkAognfKpFZ=Kzto8UsxMQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Bartosz,

On 7/30/24 12:59 PM, Bartosz Golaszewski wrote:
> On Tue, 30 Jul 2024 at 21:03, Wren Turkal <wt@penguintechs.org> wrote:
>>
>> Luiz,
>>
>> On 7/26/24 12:25 PM, Wren Turkal wrote:
>>> On 7/26/24 11:52 AM, Wren Turkal wrote:
>>>> On 7/25/24 1:47 PM, Wren Turkal wrote:
>>>>> On 7/25/24 1:35 PM, Luiz Augusto von Dentz wrote:
>>>>>> Hi Wren,
>>>>>>
>>>>>> On Thu, Jul 25, 2024 at 2:35 PM Wren Turkal <wt@penguintechs.org>
>>>>>> wrote:
>>>>>>>
>>>>>>> Hello BT folks,
>>>>>>>
>>>>>>> Just so y'all know, the QCA6390 bluetooth hardware appears to be
>>>>>>> broken
>>>>>>> at least since commit 720261cfc732.
>>>>>>>
>>>>>>> The KDE and Gnome bluetooth control panels appear to think there is no
>>>>>>> bluetooth hardware. Rolling back to 6.10 appear to function.
>>>>>>>
>>>>>>> I have a Dell XPS13 9310.
>>>>>>>
>>>>>>> I will attempt to capture some kernel logs in a bit.
>>>>>>
>>>>>> git show 720261cfc732
>>>>>> fatal: ambiguous argument '720261cfc732': unknown revision or path not
>>>>>> in the working tree.
>>>>>
>>>>> I gave you the sha for the built fedora rawhide kernel package, not a
>>>>> mainline sha. Sorry about that. I thought it was a mainline sha. I am
>>>>> trying to bisect the problem. Hopefully, I can get a mainline git sha
>>>>> for you soon.
>>>>>
>>>>> If it helps, the build date of the kernel is 2024-07-19.
>>>>>
>>>>> Sorry about the confusion. Hope this helps track down the problem.
>>>>
>>>> I have managed to get the following commit id range for the issue:
>>>> 80ab5445da6235..e2f710f97f35
>>>
>>> Narrowed to 80ab5445da6235..586f14a6a182
>>>
>>
>> The first broken commit is 9a15ce685706e73154.
>>
>> commit 9a15ce685706e73154f03341b35ff5943e46d039
>> Author: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>> Date:   Wed Jun 12 10:01:50 2024 +0200
>>
>>       Bluetooth: qca: use the power sequencer for QCA6390
>>
>>       Use the pwrseq subsystem's consumer API to run the power-up
>> sequence for
>>       the Bluetooth module of the QCA6390 package.
>>
>>       Tested-by: Amit Pundir <amit.pundir@linaro.org>
>>       Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on
>> SM8550-QRD, SM8650-QRD & SM8650-HDK
>>       Tested-by: Caleb Connolly <caleb.connolly@linaro.org> # OnePlus 8T
>>       Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>       Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>>    drivers/bluetooth/hci_qca.c | 74
>> +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------
>>    1 file changed, 59 insertions(+), 15 deletions(-)
>>
>>
>> Bartosz, I added you to the thread since this is your commit.
>>
>> Luiz and Bartosz, is there any other information I can provide to help
>> in getting to a fix?
>>
> 
> Hi Wren,
> 
> Thanks for the report. I was made aware of this yesterday. I had some
> more regressions on my plate but with those now fixed, I will take
> care of the Bluetooth breakage tomorrow morning.
> 
> Bartosz
> 
>> I will next try Zijun's suggested patch.
>>
>> wt
>> --
>> You're more amazing than you think!
>>

Thanks! If there is anything I can do to help, like test a patch, please 
feel free to include me. I'd really like to help you, if I can.

wt
-- 
You're more amazing than you think!

