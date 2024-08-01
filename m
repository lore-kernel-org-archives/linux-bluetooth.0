Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A547B13D889
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Aug 2024 18:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722537588; cv=none; b=tQI0DPbDxnuZQ1GzkVfM41f8Vh3QiLQr2KZghVI5TE324n0wsSL4EottzxdaCkMmYDoG83WqXtpHXpawlxkIG+SMRe3Ud9BhAnI13YNcUI7fVsChN7VA+Q0Dcx6PSn3pa3JV7m5ZBuEDa2+Pdh1r9xVXSocZt3U4D0bLnH1USjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722537588; c=relaxed/simple;
	bh=k7AcBaHw0GU1YgIxBcXC2Y27R74SQAVtJYJQJVK9Vys=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=re62VEqVdp9iPdD+uoY5BZvjbibZlKQmpoNwBpCJSAnrnXJwdd25r/aq6agrc930aprudExLVxQ6gq/tsPCTa+Tx9ND6NuCXTdOeELaDJAdZ7SLg36DqkWHBQ1Hb3e2Z8MPU6esnBQ+AdyDQxNMsXt0+DADse3z69gwYZM8n368=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=FXrxRsnG; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="FXrxRsnG"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7104f939aa7so1886763b3a.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Aug 2024 11:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1722537586; x=1723142386; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QwGP3+nPxoUKxCObY6692Ymm80JqpiaOG/oRr0uVPkA=;
        b=FXrxRsnG8hdISR3mLgh8Apali0x4QEK4758ShoX1VN43onxn/7n+0oC39qk1BmHhZ/
         wMFeAzYpl7E1oOcZBenitDKHmVXxwsHRe0NvmooYkBp+t8WG3XGOp4uye26aq78Ojeob
         yO+riEdQJw5GfZK195CPVhcDwyvNXHFbhHslM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722537586; x=1723142386;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QwGP3+nPxoUKxCObY6692Ymm80JqpiaOG/oRr0uVPkA=;
        b=tQJ+HlXPJq5eg/X++ri4ciEeaNZP+8eK7liQQK+PxFt0Mf4QvhkVQKRYyKj7DlWdMK
         c2nkQHMiRetxpj3AxrA+TjOQZjCAUIaZfTWWtcHmwen/kD+0S8iC1IBS0cLYKU1OD5hJ
         Wpc9gsEOJFEwBdVVC90wz/7CoE+CtzI3d0+X5Be54DNWm9vRT3IiyJj9aIW7JVkRrdap
         PWXTUI9QrofmoCBwMOApPe5FDeKyYufcSXrmT0i76OU0uW/G5iOlwpVY53qLgsb4hR2H
         Bz97upepjgWQvtkcZRgLMqA7Y7J5JHcoUpH27AmrDgY+AnPZVIWoeCqNj2DY4ONnEINe
         O3ng==
X-Forwarded-Encrypted: i=1; AJvYcCVBtY3DMxFFyiCoZnu5bJPREhKkVMRKWSOugyWaJGvr2J/RU7xHoriJ3Y26ih/TAt4L/01Rt0b6aWe0wB1OE6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YySUwvnw5B+VusxZwVfvInZo0ciW68XYGYLIzyWVe/7BT6q1kxO
	0MESYbWEtfF0oPtGJoc9KO8Q8mwqGwBk+yFLZhleouvUwjJQJkB+B/O2rZdBgQ==
X-Google-Smtp-Source: AGHT+IE6d/M6PayBlLngV6xWtvwREUAlcnbZI+XXyl6xEmXXUTu/3mZQ0FEBuW8Sbj2ZDrq+dKK0Rg==
X-Received: by 2002:a05:6a20:a11f:b0:1c4:944c:41e2 with SMTP id adf61e73a8af0-1c699683bdbmr1664792637.51.1722537585234;
        Thu, 01 Aug 2024 11:39:45 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ece0895sm138274b3a.125.2024.08.01.11.39.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 11:39:44 -0700 (PDT)
Message-ID: <67696520-1465-4e61-9449-cb5b4e15b9d3@penguintechs.org>
Date: Thu, 1 Aug 2024 11:39:43 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QCA6390 broken in current kernel
From: Wren Turkal <wt@penguintechs.org>
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
 <8be14241-28b7-4409-aa79-40c4103c613b@penguintechs.org>
Content-Language: en-US
In-Reply-To: <8be14241-28b7-4409-aa79-40c4103c613b@penguintechs.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Bart,

On 8/1/24 11:37 AM, Wren Turkal wrote:
> Bart,
> 
> On 8/1/24 1:40 AM, Bartosz Golaszewski wrote:
>> On Thu, 1 Aug 2024 at 10:36, Wren Turkal <wt@penguintechs.org> wrote:
>>>
>>> On 8/1/24 1:09 AM, Bartosz Golaszewski wrote:
>>>> On Thu, 1 Aug 2024 at 09:59, Wren Turkal <wt@penguintechs.org> wrote:
>>>>>>
>>>>>> Indeed. I don't know why I assumed it must be an ARM laptop. I will
>>>>>> come up with a fix shortly.
>>>>>
>>>>> I have a question, does this fact have anything to do with the problem
>>>>> with failing to initialize the QCA6390 BT hardware on my laptop 
>>>>> after a
>>>>> warm reboot? As I didn't understand the connection to DT in that other
>>>>> issue, does this fact change anything about how to approach that 
>>>>> issue?
>>>>> I only ask because that issue still very much exists.
>>>>>
>>>>
>>>> Can you remind me if you had bisected it to a specific offending 
>>>> commit?
>>>
>>> I don't think I was able to fully bisect that one. I was more focused on
>>> the fact that the BT hardware didn't work at all even after a cold boot
>>> in that previous issue.
>>>
>>> Zijun suggested a fix in
>>> https://lore.kernel.org/linux-bluetooth/1715866294-1549-1-git-send- 
>>> email-quic_zijuhu@quicinc.com/.
>>>
>>> That fix was landed (mainline commit
>>> 88e72239ead9814b886db54fc4ee39ef3c2b8f26) and reverted for regression
>>> (revert part of merge 033771c085c2ed73cb29dd25e1ec8c4b2991cad9).
>>>
>>> I do not know how to move that one forward. I was hoping that this
>>> pwrseq work and the fact that this laptop doesn't use DT might be new
>>> facts that make it easier to move forward.
>>>
>>
>> With the fixes from this series the driver should theoretically go
>> back to the behavior pre-pwrseq on your hardware. Is there a specific
>> kernel version where it still works?
> 
> I know it used to work a long time ago (like when I first got this 
> laptop years ago). Having said that I do not have specifics on which 
> kernel versions that actually worked. I do think that Zijun is right 
> about the reset command being sent to the hardware in the wrong case 
> causing the problem. His patch did seem to work reliably for me. I am 
> not sure what the regression was with Zijun's patch. I see references to 
> use-after-free, so I am assuming that there was some bug in the logic in 
> a case that doesn't affect my use case.

I forgot to say this. Yes, the behavior with your patch series is as it 
was before the pwrseq changes. At this point, the regression should be 
considered closed when the bluetooth changed are merged into Linus' tree.

wt
-- 
You're more amazing than you think!

