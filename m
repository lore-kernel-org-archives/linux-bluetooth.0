Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1DFD15E89
	for <linux-bluetooth@vger.kernel.org>; Mon, 22 Apr 2024 05:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713763622; cv=none; b=gppPn5uJhZljuAnsPNHX/ZvUUazuxWVc+nXO9QRrz4QNAvy+WzzKEdVWyIBqJIYCgdVPKRQQFcJ1AWY7R/B9cOomPXV7kdroteuHqqYAVHA3fNZ6+p85fDdkHzilT85HqyoiS5ozZcslE6XCvZySaWhUpqsnm0KqbldsOnKOXzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713763622; c=relaxed/simple;
	bh=lZnyeggYopLWPuvcWIWAfIXqI9bCeS44SROhBn8jZFk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U2VBOMaNFo1vY+9A1kFoKMvXnxsW1xFYLdCKj93S43F8boD+XvdwT6jp+4oaa1k4ytNpaIw+OunjscqdcU0G0S0F2M6gVlhJDwPZLCj7AwAZH4HW0JQsxmIjMCCmtJoCJjLzFGYgAWp3crYnyJebHyw133G0MSoUpUzK7zLIwLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=d2e+xwuR; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="d2e+xwuR"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1e4bf0b3e06so38578365ad.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 21 Apr 2024 22:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1713763620; x=1714368420; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xQLUT/GHsCBhS89oXeP+WG09waBn/dieGNuKLrpbS4c=;
        b=d2e+xwuRq4fdobPsONyRUmC1GaSajQV9K+6rkpWKChpIDz26YbUM9CRr2tl0XRBeaY
         Junhgg5uRFpYUdcMUPzNq3n3FHLZlipWGKmFZBJ244RRDLQJN+UhXfFjG8AX1Aa9bYMn
         wbxsjrfMro/mKPqS1zV4BOH8WBs7Lz3iktmTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713763620; x=1714368420;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xQLUT/GHsCBhS89oXeP+WG09waBn/dieGNuKLrpbS4c=;
        b=ST265YjZZHsPuFvXAIzCyjbmM6OpP2fcKeohDQu80B/pBbOGreLcBv0tKNz0Tgt2aF
         DH72XtlHh7+YTt254ba/e5Xzd5KoXLX32gO9wymBkX5Aih8pdoCSNUH82/MOcKcfcPPW
         63yW/V65iXcZk0A2RQX12DznGhCuvpkHBEWuSR5TnHV3nblbYj2LAva1DHUPdJkgvKv2
         9bntjgVwZbtYTanvp4e7g0YvDaJzxh9hpl2+RWQE7ozlWA3N8qqoYUx9BrPp0rFbviQD
         Yv33tsPLrQu9vCxgTrEHzB9GXg301vqohkstj+mfn/umsTi5FWVJXXdAw6EHAwETUnJW
         MrEA==
X-Forwarded-Encrypted: i=1; AJvYcCWJs1nTDXRw5VYcRtOwpi2rBk2QBrq/LUD9eok/6X8IeTbc2MmJeoj/1BOFT3Z31OmFWoVJPWawfA787s/ZTRmC7iIexMqYFbdI9O0J1HGn
X-Gm-Message-State: AOJu0YzZ15XloBtzq82nkwUPEcHs/o3Cc/trQamm93AkD3JEQBiHwLUV
	MpU4oJNAQctzWN0eNHJJ73Qv6MpVt1VQGQO8lIuuIg0t/6MPA0ciRyCiKBoGyA==
X-Google-Smtp-Source: AGHT+IFfjdBueyyjnDtyN9RwDxmqfwx7WbnAl6Q48A4i/cnZcCo3TVcc4E+VHak1t+/3CCiEx9nuzw==
X-Received: by 2002:a17:903:228e:b0:1e3:ca5a:2d9a with SMTP id b14-20020a170903228e00b001e3ca5a2d9amr12214081plh.53.1713763620164;
        Sun, 21 Apr 2024 22:27:00 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id b14-20020a170902650e00b001e5e6877494sm7329503plk.238.2024.04.21.22.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 22:26:59 -0700 (PDT)
Message-ID: <8a625e4e-8283-41bf-9f2f-70bcc47784ab@penguintechs.org>
Date: Sun, 21 Apr 2024 22:26:58 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] Revert "Bluetooth: hci_qca: don't use
 IS_ERR_OR_NULL() with gpiod_get_optional()"
To: quic_zijuhu <quic_zijuhu@quicinc.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org,
 linux-bluetooth@vger.kernel.org, krzysztof.kozlowski@linaro.org
References: <1713449192-25926-1-git-send-email-quic_zijuhu@quicinc.com>
 <1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com>
 <CACMJSevfE3wLhaz1z6A977JL5gOH62NThYWzybVqmHyR7pru=w@mail.gmail.com>
 <1ab7e6fd-68f2-4952-b5d5-bc244b8b7eb3@quicinc.com>
 <CACMJSeuTkC=Sho29HLada3eTPoasZguObhC1FwmgtJ0dqj=Ykw@mail.gmail.com>
 <5c9a57ba-d516-4d3e-85e5-bba299ee97a6@penguintechs.org>
 <cd6539e1-3d6c-4174-96cd-838fdaa9288c@quicinc.com>
Content-Language: en-US
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <cd6539e1-3d6c-4174-96cd-838fdaa9288c@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/21/24 2:40 AM, quic_zijuhu wrote:
> On 4/21/2024 3:14 PM, Wren Turkal wrote:
>> On 4/18/24 3:42 PM, Bartosz Golaszewski wrote:
>>>> 1) do you meet the case that EPROBE_DEFER is returned ?
>>>>
>>> It doesn't matter. It's about correct usage of a programming interface.
>>
>> In case you are not aware, this apparent correct usage of the
>> programming interface breaks real hardware. As a kernel user with this
>> problem, I am just wondering if we expect a fix to land before v6.9 lands.
>>
>> If we can't find the a fix that has "correct usage of the programming
>> interface" before 6.9 closes out, would we be able to revert this change
>> considering that it causes a real userspace regression in that the BT on
>> some laptops simply don't work now? I guess I am asking if this
>> theoretical correction more important than breaking actual currently
>> supported hardware?
>>
>> Real users like me are hurt by this. In my case, I am using a laptop
>> that was shipped in 2020 with Linux by Dell that included working BT
>> support. I now have broken BT hardware that is barely usable at all.
>>
>> And as a kernel user, I thought the kernel had a no regression policy.
>> Granted, I don't know the specific details of how it works. Does that
>> policy include support of widely deployed hardware?
>>
>> Just so you know, I am just trying to understand what to expect.
>>
>> Also, I want to offer help. Is there anything I can do to help y'all
>> reach a resolution?
>>
>> Thanks,
>> wt
> per QCA6390. we have correct usage of a programming interface.
> 
> as my reply at below link, we don't need to take care bout
> Bartosz's question since it is not relevant with this issue.
> 
> https://lore.kernel.org/all/01677a26-ea91-47cc-bdc4-283cf313d8e4@quicinc.com/

Ack. Thx for the pointer.

I will admit, I am finding it a bit difficult to follow the discussion. 
As such, I have no opinion on who's right. I just want to help reach a 
conclusion that includes my hardware working.

wt
-- 
You're more amazing than you think!
