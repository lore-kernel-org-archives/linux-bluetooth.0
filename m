Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CBED27D
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Apr 2024 07:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713683671; cv=none; b=s0RPouUqWlTUuWdX/KXQW2Q0Dv3IYNesdN1VgLagHepwj+BEWpHherZcNrMYOd/K5sCan9Ps6+VdOZhex/o8s37D31tL5Iy7tFsYKrQbqdqAPFAHPfLqyMHMW13WEZllmf/nMnefSy9LaSRZ7O/S5L7H13jE8kOuArw74SpTVGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713683671; c=relaxed/simple;
	bh=ZsTJO117JBiuYjMZVeWeNVL6Si7OROsVptobqrHLrgM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ErkhKH7Cq7uUSUtJzG90csR3psn+S86bZ+GdH23c6MB02HPxuxIVI4tONXSaf9qFWbBQNmyN+qylBOq8UmYbXQE4NlPOTP8TkRjec+8dn+p1H4Q8ZnGLVm384z/vc3HHYh4dDZJL1uC+5Sz3T3aVd7EEgvidIbT0zVIMiy+/E5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=L1g3/fW9; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="L1g3/fW9"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5dbcfa0eb5dso2615149a12.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Apr 2024 00:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1713683669; x=1714288469; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Hw2VrKOp6For+PtVTJXLyHtt17xjrQ+n0OQLGYPQX20=;
        b=L1g3/fW9x2u92NBnlt+xtxJLnVaYTaNFmi0zU9LI0akN2pb3ip+LZmEKTYQhLZ+ONU
         hYH33vNI3lWTOIWOsnR5WpW/8nGkBClFNqopJEoh2Q9gFRzY+lOOBqjeKt7EW8SqP8a4
         UNY7BJNEsLyfGM4to6XvRzXJ9FBoeewwpiRhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713683669; x=1714288469;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Hw2VrKOp6For+PtVTJXLyHtt17xjrQ+n0OQLGYPQX20=;
        b=LGM7xkK4Z/ypXeiuDCQNsaJLslSYsmhPJ7Z0tWdrF6gDyHMYmC697q3HUXO91B/wX/
         p2eDNbIsJKDGRhnkidYOGWk52IMRm5S31oNUijH8nhczH+XyAjKv1ISpAA+mLrqeXjFK
         R0TbjxJO2kv5HK67p/ixoubwDRCaPb1+1Jp4I1ctiuTgEu9b31cdT0kNG3XMqEgi4e9K
         KgLTgSKvfcTtamtz+NmFCvtf7695DgxAX8yDYoxZLVkRfpLwPIhTDjH4gulZxx59z3jw
         KSUds3fNf48gupcWbRYfbkdQPtPBpQ+64ArKvYDj4v6piLlubLDfk4Fk6V4bxxg75lor
         Tx/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWha4Lm+/R+RkuBblxkWGaajkQuC+VVMYFXOuwN/J87Otz9l7z9DCP3E9EfQSZTdhBNCO98Tx9e0jszZFyCZKTdJicV3FPFX7PzkgiDEyQg
X-Gm-Message-State: AOJu0YyrHIn6oQ3BFtDhWWQGAfkAzrLOW7Pe+nDlqgBNwpQtUhhqSYXU
	T6SthsBrI2TCUdXRppi53fXxI/jKT734uKOAojCowRM1qFwlma737JnhscYSxg==
X-Google-Smtp-Source: AGHT+IFcKK5W1F83u0+U7CZgPnIj/hrh1yZ+fOBm3us6qmk/sFRyhzz1plHAdDIOcVhGAwbNEbbGcA==
X-Received: by 2002:a17:902:ea82:b0:1e3:e295:3f47 with SMTP id x2-20020a170902ea8200b001e3e2953f47mr6186129plb.69.1713683668679;
        Sun, 21 Apr 2024 00:14:28 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id h3-20020a170902680300b001e107222eb5sm6018600plk.191.2024.04.21.00.14.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 00:14:27 -0700 (PDT)
Message-ID: <5c9a57ba-d516-4d3e-85e5-bba299ee97a6@penguintechs.org>
Date: Sun, 21 Apr 2024 00:14:25 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] Revert "Bluetooth: hci_qca: don't use
 IS_ERR_OR_NULL() with gpiod_get_optional()"
Content-Language: en-US
To: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 quic_zijuhu <quic_zijuhu@quicinc.com>
Cc: luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org, krzysztof.kozlowski@linaro.org
References: <1713449192-25926-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com>
 <CACMJSevfE3wLhaz1z6A977JL5gOH62NThYWzybVqmHyR7pru=w@mail.gmail.com>
 <1ab7e6fd-68f2-4952-b5d5-bc244b8b7eb3@quicinc.com>
 <CACMJSeuTkC=Sho29HLada3eTPoasZguObhC1FwmgtJ0dqj=Ykw@mail.gmail.com>
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <CACMJSeuTkC=Sho29HLada3eTPoasZguObhC1FwmgtJ0dqj=Ykw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/18/24 3:42 PM, Bartosz Golaszewski wrote:
>> 1) do you meet the case that EPROBE_DEFER is returned ?
>>
> It doesn't matter. It's about correct usage of a programming interface.

In case you are not aware, this apparent correct usage of the 
programming interface breaks real hardware. As a kernel user with this 
problem, I am just wondering if we expect a fix to land before v6.9 lands.

If we can't find the a fix that has "correct usage of the programming 
interface" before 6.9 closes out, would we be able to revert this change 
considering that it causes a real userspace regression in that the BT on 
some laptops simply don't work now? I guess I am asking if this 
theoretical correction more important than breaking actual currently 
supported hardware?

Real users like me are hurt by this. In my case, I am using a laptop 
that was shipped in 2020 with Linux by Dell that included working BT 
support. I now have broken BT hardware that is barely usable at all.

And as a kernel user, I thought the kernel had a no regression policy. 
Granted, I don't know the specific details of how it works. Does that 
policy include support of widely deployed hardware?

Just so you know, I am just trying to understand what to expect.

Also, I want to offer help. Is there anything I can do to help y'all 
reach a resolution?

Thanks,
wt
-- 
You're more amazing than you think!
