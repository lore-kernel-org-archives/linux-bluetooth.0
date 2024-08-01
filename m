Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D1D16EBE9
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Aug 2024 08:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722501407; cv=none; b=u87sgIfveH6INc6SV6dFs7S3MtpaoqeuEPXGjMFWbGfQMEFqBOhatdcnxFNNxwMiceRCgGoVbM2SZKHhsl+fIDYgqJg6Wyl7zSkAvuZpKvCR5QornqCEN+/Mq0E7X9KrN8d39GOWl+HVUR4r0hnmIunEd/YIlVTglBTJvUsgBVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722501407; c=relaxed/simple;
	bh=LpZ5tG3kREpMyW09CPowBUUFW2LF9heP8zVIHNTPT0U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dpR13RYS8nk9/vD58pagpI2FNdq6/vOK6Qs+gnQEF17k8wA+yJpIzBi8vAl72doknN3+cyXTPkMGU3Jvr0BDXW3lvTQBRTMKSVthervRVUt82300IR0EPjuqtAcoBVWek9Mq/8vjREYS7CKmtTs6wJ0exJVlRbikjmcrWbqG964=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=ZBv9RjLH; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="ZBv9RjLH"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7163489149eso4761609a12.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Aug 2024 01:36:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1722501404; x=1723106204; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D7fR3SRJTUQ7dOEucym1tYG7av9HF1DUTSLWQxf97uc=;
        b=ZBv9RjLH/c/Uiv7wdDza2w3yRmeBxdbkJlCrUsdFLosfuHl5oN3Crm+YlDYvuekbWk
         hZ4GX1hYkHjjW7JWpEDQPLkLING8C9Z18cvDPQMWptYXyVa62Kgj2oE6QTF8vbiakKZb
         qEvAEMP8jd7SevZQAsNXNQ3ShzBSB9ik/ggHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722501404; x=1723106204;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D7fR3SRJTUQ7dOEucym1tYG7av9HF1DUTSLWQxf97uc=;
        b=hYbFPkExWROe6y933am+7IJOHh7zRnj8tgQxxcdNGBQww+bsp5fgHb/HUuUjTGLhDc
         rDM6AxWD+9fC3XWGYwtTgZ+rTAfT5smWBcXZWYi8jAG0iLc+8A/4+O/ybPgoXjC9IDgx
         QsouWn6t3DbnlPV/ObhN6n1bCu+EioiJqpmw+Y2EPW08SjQS4XCWMldF3WcCn5zmF4H/
         9u2UWg2aMzSjp5DfzQjcQdnN/Mxk3e/51DCvGtH+I+ddL9CO8gznJgdb4gaJsZEMknEF
         HA5EQE8k3HrXW18mHcEjcPFnHTOZtYu8F3AEZ1IKo9TL53dO03jiBCvDPWDWi8zLMqGh
         fICQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyrnp8d5hthpdGAqncHdqHDyWuOXTnOxNrAmO1rtqvz32FW7uel0QfPQ8hLz8OosB2tt7THMKuWtScDTwHVpf00UFNoHKGcwwYYw3BGcf3
X-Gm-Message-State: AOJu0YyURD8BnChryX5Cu8PiG/LW7MklWe94tg9dyyNTomYqi85cfa4Z
	VNwUSQh1/DYPjF33lbChkeZZ1KmD8itppVNWu9KrimPN1FJ8+pUpoAvFFFSdlg==
X-Google-Smtp-Source: AGHT+IEmBBbA+h+BtbyLI+nfU7/Vthm2k0GsrIb6HVOWPY8dFHB0yn3+9n5DWcTWA83WOm2EZ8o0Ag==
X-Received: by 2002:a17:90b:1b48:b0:2ca:8b71:21f4 with SMTP id 98e67ed59e1d1-2cfe78c3c59mr2232887a91.18.1722501404408;
        Thu, 01 Aug 2024 01:36:44 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cfdc4067ecsm2721775a91.4.2024.08.01.01.36.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Aug 2024 01:36:43 -0700 (PDT)
Message-ID: <549619fa-958d-4e9a-a53e-d8d73686ae63@penguintechs.org>
Date: Thu, 1 Aug 2024 01:36:42 -0700
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
Content-Language: en-US
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <CACMJSetaLXr8a9ffpSN3GpH6YOcHn-o2seL4fj9q6iFbfEUxDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 8/1/24 1:09 AM, Bartosz Golaszewski wrote:
> On Thu, 1 Aug 2024 at 09:59, Wren Turkal <wt@penguintechs.org> wrote:
>>>
>>> Indeed. I don't know why I assumed it must be an ARM laptop. I will
>>> come up with a fix shortly.
>>
>> I have a question, does this fact have anything to do with the problem
>> with failing to initialize the QCA6390 BT hardware on my laptop after a
>> warm reboot? As I didn't understand the connection to DT in that other
>> issue, does this fact change anything about how to approach that issue?
>> I only ask because that issue still very much exists.
>>
> 
> Can you remind me if you had bisected it to a specific offending commit?

I don't think I was able to fully bisect that one. I was more focused on 
the fact that the BT hardware didn't work at all even after a cold boot 
in that previous issue.

Zijun suggested a fix in 
https://lore.kernel.org/linux-bluetooth/1715866294-1549-1-git-send-email-quic_zijuhu@quicinc.com/.

That fix was landed (mainline commit 
88e72239ead9814b886db54fc4ee39ef3c2b8f26) and reverted for regression 
(revert part of merge 033771c085c2ed73cb29dd25e1ec8c4b2991cad9).

I do not know how to move that one forward. I was hoping that this 
pwrseq work and the fact that this laptop doesn't use DT might be new 
facts that make it easier to move forward.

wt
-- 
You're more amazing than you think!

