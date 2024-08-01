Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4EE14884C
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Aug 2024 18:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722537429; cv=none; b=i3J+IJAyAxkuMP6uQBPTZqsMbjYVBEFgl/uzPKUlawrKkIOIOD9VG+an2IeSGR5B5dewaTS1K6rxe34S+GHxADoTTnYx5GUpvA3c8mMt++5MUL6BRlDAVZMX+iMQQHHym4UqLdtci7P/pKRN4h6xoA65Fp8sb68tq+8Y5/VbovI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722537429; c=relaxed/simple;
	bh=fKW9DaWY0zfX5F0Go+KUurfxAOxnAPc5yyRYmXqpclk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r5NfOUlNV4kZsO3NVhHSQYl+L7tft/Wph94Vmi5PgqR/1S3jx9sxffiqiWRpB8QhvfifvNmZrqFDST49PIl4whkrHmPlWuGTAnoWF7jgZKF7DE2ijbw02HQtLoQ1KSTtdU7WSyWIjR0+83+olSGm09pYOdOlnURmVRNsUbIgK5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=Pb4suVIh; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="Pb4suVIh"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7106cf5771bso415647b3a.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Aug 2024 11:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1722537427; x=1723142227; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HQt/O/nOSU+HohCWoFHe9z9ITmYwUizomWaVAjVqbOc=;
        b=Pb4suVIh1kMV/w4rCm9auxE5GMWqn5qsRlPzUIK04LsGbpfbuFk9pLEwmG41/PCUy8
         ibW2zTQYCovvmXqKSa0dMCR1zIripN58kyS4ojZ/3WBlMjXc2Yu0WPBQ4ncSDQ67rJbq
         /pLgxDcCFPsXYyXgcSjB8z/Nw1car8sHtLQXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722537427; x=1723142227;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HQt/O/nOSU+HohCWoFHe9z9ITmYwUizomWaVAjVqbOc=;
        b=XWeENqCr3PvZyLYs5S3vPIELhDEGaUmcWO3yAkEVEwg79+X2yXCWOTfmfX0u91vOl5
         GGnCAbv+StDaYuLY0Ti8lfXZKNBXJMzvnFXGNRMZz+p1s6azj28aE1SnSA2KKO8ONY04
         uIyu8PgIHu63OYM4vOLne1CKVOMZJ6NJRXAMx1lE8bMQYHGNzxvkT2XBw7vlg86bWRgB
         qM8GDd/YHPI033qFiAqQDyXaUVcoY8t8K/QhzIYEYZN7EQZYCAnABI9hWPYKFZJBa4/N
         bgyNrrVQrt3JdO2r1N7TWZLDiDh2Ckqdf7xfBm60EepTEHqenrqbtRWzJgNMh+g87O9t
         izFg==
X-Forwarded-Encrypted: i=1; AJvYcCWGEqOfnytkosB15buEyZNkRHdO0FOtlZVhHc/XMKwi1y2prZuYniScvCh5bHaF6paN65kM2TdGsuRBv6ZdxHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYEbNJrTivEoQWulTULw2vLswbN5Cw2lpAjkmzP0zp/n9gI3q3
	GlW3AaXqOK4zUmFnVrMjFZdL60wIZkVu2fifVKQ2kNyvZhdmvMZGg7DUpYoJvQ==
X-Google-Smtp-Source: AGHT+IHpB+6bAzZ0qf21vk4ywaudxK3zNNo/eLOGE2th17OoF30R+wNxWOsbE8REJXtwoiaJR6D2zA==
X-Received: by 2002:a05:6a00:21d1:b0:70d:2ca0:896a with SMTP id d2e1a72fcca58-7106cfe212fmr1248856b3a.18.1722537426591;
        Thu, 01 Aug 2024 11:37:06 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ed2d04bsm133691b3a.201.2024.08.01.11.37.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 11:37:05 -0700 (PDT)
Message-ID: <8be14241-28b7-4409-aa79-40c4103c613b@penguintechs.org>
Date: Thu, 1 Aug 2024 11:37:03 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QCA6390 broken in current kernel
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Zijun Hu <quic_zijuhu@quicinc.com>, linux-bluetooth@vger.kernel.org
References: <27e6a6c5-fb63-4219-be0b-eefa2c116e06@penguintechs.org>
 <CABBYNZ+vVFUm1Tb+BvViYMJd6XQczTYPgyO++GGbCcWrkaC4Kg@mail.gmail.com>
 <30319168-9456-49dd-be27-480b2a068fe3@penguintechs.org>
 <1a519b2f-f5cf-40b3-8223-162dc04f8ca8@penguintechs.org>
 <21645f07-da90-4441-8dbb-d999298165e9@penguintechs.org>
 <b1061ec0-5f8f-44af-8955-2d6fa11f94b3@penguintechs.org>
 <CACMJSet3H3B1rz2eZyxUr_ySUOdhTkAognfKpFZ=Kzto8UsxMQ@mail.gmail.com>
 <534cff38-7bbf-4e9d-90c5-c4a4ba331a8e@penguintechs.org>
 <CACMJSett7WOHWnfNGwtWL0sQQ3K9rqr08W9KDF5U=rJbpBZfzA@mail.gmail.com>
 <CAA8EJprdmXfJYx2xk5fcV4UgWqeBPekrgv1iv7F7FugaBH6=KA@mail.gmail.com>
 <CACMJSesML_Q-Z79XyAZd0sJuE=AbGQ-TWozPWTRmdF3sMh7VHg@mail.gmail.com>
 <3dc56ebc-d378-4ba0-aed8-03c93e0aea20@penguintechs.org>
 <CACMJSetaLXr8a9ffpSN3GpH6YOcHn-o2seL4fj9q6iFbfEUxDg@mail.gmail.com>
 <549619fa-958d-4e9a-a53e-d8d73686ae63@penguintechs.org>
 <CACMJSetWLnDH=U8tXVPMz=jVEFy0731SRjozqE_WbtufTUEgMw@mail.gmail.com>
Content-Language: en-US
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <CACMJSetWLnDH=U8tXVPMz=jVEFy0731SRjozqE_WbtufTUEgMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Bart,

On 8/1/24 1:40 AM, Bartosz Golaszewski wrote:
> On Thu, 1 Aug 2024 at 10:36, Wren Turkal <wt@penguintechs.org> wrote:
>>
>> On 8/1/24 1:09 AM, Bartosz Golaszewski wrote:
>>> On Thu, 1 Aug 2024 at 09:59, Wren Turkal <wt@penguintechs.org> wrote:
>>>>>
>>>>> Indeed. I don't know why I assumed it must be an ARM laptop. I will
>>>>> come up with a fix shortly.
>>>>
>>>> I have a question, does this fact have anything to do with the problem
>>>> with failing to initialize the QCA6390 BT hardware on my laptop after a
>>>> warm reboot? As I didn't understand the connection to DT in that other
>>>> issue, does this fact change anything about how to approach that issue?
>>>> I only ask because that issue still very much exists.
>>>>
>>>
>>> Can you remind me if you had bisected it to a specific offending commit?
>>
>> I don't think I was able to fully bisect that one. I was more focused on
>> the fact that the BT hardware didn't work at all even after a cold boot
>> in that previous issue.
>>
>> Zijun suggested a fix in
>> https://lore.kernel.org/linux-bluetooth/1715866294-1549-1-git-send-email-quic_zijuhu@quicinc.com/.
>>
>> That fix was landed (mainline commit
>> 88e72239ead9814b886db54fc4ee39ef3c2b8f26) and reverted for regression
>> (revert part of merge 033771c085c2ed73cb29dd25e1ec8c4b2991cad9).
>>
>> I do not know how to move that one forward. I was hoping that this
>> pwrseq work and the fact that this laptop doesn't use DT might be new
>> facts that make it easier to move forward.
>>
> 
> With the fixes from this series the driver should theoretically go
> back to the behavior pre-pwrseq on your hardware. Is there a specific
> kernel version where it still works?

I know it used to work a long time ago (like when I first got this 
laptop years ago). Having said that I do not have specifics on which 
kernel versions that actually worked. I do think that Zijun is right 
about the reset command being sent to the hardware in the wrong case 
causing the problem. His patch did seem to work reliably for me. I am 
not sure what the regression was with Zijun's patch. I see references to 
use-after-free, so I am assuming that there was some bug in the logic in 
a case that doesn't affect my use case.

wt
-- 
You're more amazing than you think!

