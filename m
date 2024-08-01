Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2411EB4A6
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Aug 2024 07:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722499163; cv=none; b=gJf/uaG092hn+YACMTri00/IsQV+D6l23asIz49Ai51RvbBOhTxZi499vA3rCP+T63lByMiSaFPhIMtJ2ryHdV4KD/tdyPCugqbWdcYvWOR36IYJedKjYw7kDpOlZiq/+oCZpcrXWgMgROiXlVUp+kcdH+7nRf7Rxho2OgP+huo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722499163; c=relaxed/simple;
	bh=TdGc8HYman/AsKmvU2SzEFOJP3JzH2NV9z5CHhgu7fU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DF5zHY7aNoISw+vD/5ZBVJImKHS6yi6EvGbAYgP5TG5it0BjhgDGbb/Oj5DDulX/JvwOKlVzbbn+Hi3j1AuLHtIuGYzP2ztBr3jSGtTgzttIBRlfwix5O4KPuA50auUi6n5m3+ZqfaxKhKiyN6C/SlUZMyRutbsQjeG0YAUdvXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=FWqAz+/e; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="FWqAz+/e"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7a92098ec97so4522896a12.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Aug 2024 00:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1722499161; x=1723103961; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jxEMkiW5AF7hanjXSFu4zgg/RDegXqyfXH+v23bN8d8=;
        b=FWqAz+/er0Hzf0viBuyPCAG8HYiVNhUAH+SAULIIPJS8g+jo6tat1w8unuH2TMsCB1
         1wz4wnkyrfxW38HdU0IrYTb6o9ZTZNmrcLkoiJ8Ta2g8FFxJJilt6YgjwmlpOSjEwebe
         OPkGedLkjGf9JBrU0le0bPXFUTUdseMDKyZa4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722499161; x=1723103961;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jxEMkiW5AF7hanjXSFu4zgg/RDegXqyfXH+v23bN8d8=;
        b=MX0CRvRD7T+FzCDlPz0TMMMpojUJIxRVfXk8mPpkcZ0j0/F3EIyp++YxwYHqAps+cI
         Sf+ufpVlyKn5DnsS12e0o6rABOvKMgdj3HE/Lsh7InqVsgViE6hmOG5DlIbbwaBpj8O/
         TBpZqm2XKfyxc5HDdQ8D7KScQnoRZnLbaKqUgjuXvA2G/n0K8991gyICYY+7Dqk9YpLu
         WELvYWQWICHAntAxBTHf+vg//R0reZ0hdBUMKLklVzpHv8IzbXimIKdR272usAMZbAeq
         xuUsHKW/8agFo6gyvvqvhg+DkdCEWbBrRQL98QYIytBdwP7mRTS7ziBqG3EYzIvy3DpY
         MOWg==
X-Forwarded-Encrypted: i=1; AJvYcCU1VrGvmjREDGhL3VVA7tM7ODYcXG4sJKnu3KrpGe8q4SNpdH+kDuCDg2RxN35fmslqt62CbedFRD3r+rGgRD4y+kYfPaE/IM0KX9RjrEEn
X-Gm-Message-State: AOJu0Yy+zK3NXFnPRfUVvJ4Xkzs3PPUmEJkAxyG7paDfcnBvpg/aRwm1
	5FtsByuk28v9u5vRHHs1WwESrphb0sitFKN8O7mTuaSWul9Pglo+vkT/6WZEiA==
X-Google-Smtp-Source: AGHT+IEOCORlO9v8f2Cef2WdUTK+a0Et3fsMg1FKbsHm226CDreMtIirqXY/8gQD3JPdzykqndfjew==
X-Received: by 2002:a05:6a21:9990:b0:1c0:f0c1:5d45 with SMTP id adf61e73a8af0-1c68d125490mr2297955637.44.1722499160638;
        Thu, 01 Aug 2024 00:59:20 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc405f4asm2623873a91.11.2024.08.01.00.59.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 00:59:20 -0700 (PDT)
Message-ID: <3dc56ebc-d378-4ba0-aed8-03c93e0aea20@penguintechs.org>
Date: Thu, 1 Aug 2024 00:59:18 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QCA6390 broken in current kernel
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
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
Content-Language: en-US
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <CACMJSesML_Q-Z79XyAZd0sJuE=AbGQ-TWozPWTRmdF3sMh7VHg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Bart,

On 7/31/24 2:05 AM, Bartosz Golaszewski wrote:
> On Wed, 31 Jul 2024 at 10:55, Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
>>
>> On Wed, 31 Jul 2024 at 11:51, Bartosz Golaszewski
>> <bartosz.golaszewski@linaro.org> wrote:
>>>
>>> On Tue, 30 Jul 2024 at 22:05, Wren Turkal <wt@penguintechs.org> wrote:
>>>>>
>>>>> Hi Wren,
>>>>>
>>>>> Thanks for the report. I was made aware of this yesterday. I had some
>>>>> more regressions on my plate but with those now fixed, I will take
>>>>> care of the Bluetooth breakage tomorrow morning.
>>>>>
>>>>> Bartosz
>>>>>
>>>>>> I will next try Zijun's suggested patch.
>>>>>>
>>>>>> wt
>>>>>> --
>>>>>> You're more amazing than you think!
>>>>>>
>>>>
>>>> Thanks! If there is anything I can do to help, like test a patch, please
>>>> feel free to include me. I'd really like to help you, if I can.
>>>>
>>>> wt
>>>> --
>>>> You're more amazing than you think!
>>>>
>>>
>>> The issue Dmitry reported to me happens with qca6174 not qca6390 which
>>> makes me think it's a different issue after all.
>>>
>>> The laptop you're using is not supported by upstream device-tree, is it?
>>>
>>> Is the device tree publicly available?
>>>
>>> I'm thinking that - since we switched qca6390 to using the power
>>> sequencer exclusively in the driver (we could do it as there were no
>>> DT bindings in place that would say otherwise so no ABI contract) -
>>> out-of-tree DT sources could potentially stop working. You may need to
>>> update it to reflect the true internal architecture of the qca6390.
>>
>> Please allow me to point out that QCA6390 supports binding via ACPI
>> tables? And it might be used on x86 laptops with no device tree.
>>
>> Dell XPS13 9310 is an Intel-based laptop.
>>
>> --
>> With best wishes
>> Dmitry
> 
> Indeed. I don't know why I assumed it must be an ARM laptop. I will
> come up with a fix shortly.

I have a question, does this fact have anything to do with the problem 
with failing to intialize the QCA6390 BT hardware on my laptop after a 
warm reboot? As I didn't understand the connection to DT in that other 
issue, does this fact change anything about how to approach that issue? 
I only ask because that issue still very much exists.

wt
-- 
You're more amazing than you think!

