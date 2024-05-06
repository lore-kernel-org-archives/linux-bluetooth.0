Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C03C613C69F
	for <linux-bluetooth@vger.kernel.org>; Mon,  6 May 2024 19:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715023299; cv=none; b=eB32Wlx2hZQfBYKk20gIpBNnEs/wiBObpeOOM2tZ7+cG/J61FCsFfUe288QFtta0EwacjYnHdD5byebrfi7IS0OmnIEPveg0hLMGrm6kWdN2LNMDyOW+diNSmJjXnbppU9qIU0vuAXD6u1zmlhE05sp9LtZs555QUOp/60BsQ+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715023299; c=relaxed/simple;
	bh=X3YwlbKHtlbgh5paaDoTp02wt/z8uJUHDrihFNIYwRk=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=TMHnOKFXn+QTH3meu58xaXKYqJx+/5JnUuIeRclcpzG9PdA+kzvMbn3Bsdy5t+vrFMoZHHYpp8a5s+EnRGNItU1a3bzCsjl+ON4A+ru+T44MgJZaolXhc0+BeAXxWb861H2I/+V++J/IIW3933IQCY22z9TTowmXTk4rqp08YeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=EdTXT5gp; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="EdTXT5gp"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1ecd3867556so15968415ad.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 06 May 2024 12:21:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1715023295; x=1715628095; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7WvaSssL8hW+happfuz7Ifo7zzuW3z2wrCHUtE0u0Mg=;
        b=EdTXT5gpAnzuY13UQGZI3pNeQ2jR2ddV8FAFAgWsP8N49WTi4gEHLfM22Oih8gz00z
         1olS4BsGlt7qXUrlz8lyxil6kdX0+NimloyARipDH5pAgt8ItY/2KH+tUlrRrsoxloJ1
         3nUlP7aK97P/zeRc+Db1z/ygN8XVvMjDQWJMA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715023295; x=1715628095;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=7WvaSssL8hW+happfuz7Ifo7zzuW3z2wrCHUtE0u0Mg=;
        b=dbA8qiBLBmDN/Y8gIO1UinAQQY+8f4RMjymG+JoOSHJGoAtxGRuMPL/JEMMz8ARUSg
         3EY8Eph52QtwAI8LozUq42VTbYiQ8FrPkiUODYBH5Rpjaz/3e8KdYw/brVygr4O1H8xS
         N9qZ8bhT4VWqAWKYgDffVthTVLV+m7zPceoKbMC53CyJhcr0VOWwzoG3tJcDJYNW8GdV
         498/B6Z5ejUhC7JXBA+Vuj+b8d1OX5tEPQiGxOX0ruXTWS3RLwBuPYtNiIDE03HuCyAC
         6cJ6rnoA3aA3V6cfBp0H8SfNgzOttabwuLfp4PES0PWj5GDM1R8inOp+hbvmoSW0SzMo
         f7rQ==
X-Gm-Message-State: AOJu0YyEMWthF4hcQa0VufyzlzlNZsKL3B3JQnkckmb/7i9i51Kv2Fwv
	wnoj5MqYLkX0YnqheN8vsFIQ1PW681XstAhAVvSb9fiXvxfdh55yUsbC82cUV/3XZgamSQse8e3
	shQ==
X-Google-Smtp-Source: AGHT+IHxLrSKB0zjbYT5M6RFFiD+nN0ZpTsG9KGIzmJjrtbpNTzaCW5M1t7au4K6butZNGMjVWNrxQ==
X-Received: by 2002:a17:903:298f:b0:1eb:5222:7c5f with SMTP id lm15-20020a170903298f00b001eb52227c5fmr14309294plb.10.1715023294423;
        Mon, 06 May 2024 12:21:34 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id x13-20020a170902ec8d00b001ecf6d3edb5sm8656820plg.241.2024.05.06.12.21.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 May 2024 12:21:33 -0700 (PDT)
Message-ID: <3475f0dd-6a0f-4319-9590-379eee33f504@penguintechs.org>
Date: Mon, 6 May 2024 12:21:32 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-bluetooth@vger.kernel.org,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Zijun Hu <quic_zijuhu@quicinc.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
From: Wren Turkal <wt@penguintechs.org>
Subject: path to landing patch to fix warm boot issue for qca6390
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Krzysztof,

I am reaching out to you as you had the most important objections to the 
change to fix qca6390 for the warm boot/module reload bug that I am 
experiencing.

For context, the problem is that the hci_uart module will send specific 
vendor specfic commands during shutdown of the hardware under most 
situations. These VSCs put the bluetooth device into a non-working state 
on my Dell XPS 13 9310 with qca6390 bluetooth hardware.

Zijun's proposed fix is to not send these commands when it's not 
appropriate for the hardware. The vendor commands should be avoided when 
the hardware does not have persistent configuration or when the device 
is in setup state (indicating that is has never been setup and should 
not be sent the VSCs on the shutdown path). This is what Zijun's patch 
implements.

In addition, Zijun's change removes the influence of both
the QCA_BT_OFF qca flag and and HCI_RUNNING hdev flag. Zijun asserts 
that those flags should not influence the sending of the VSCs in the 
shutdown path. If I understand KK's objections properly, this is where 
his objection is stemming from. KK, is this correct?

Zijun's proposed fix can be seen here: 
https://patchwork.kernel.org/project/bluetooth/patch/1713932807-19619-3-git-send-email-quic_zijuhu@quicinc.com/

I'm wondering if we can resolve this impasse by splitting the change 
into two changes, as follows:

1. Change that removes the influence of the QCA_BT_OFF and HCI_RUNNING 
flags in the shutdown path.
2. Add the quirk from Zijun's patch that fixes my hardward configuration.

I'm hoping that better clearer descriptions for #1 can help get that 
landed since the logic current appears to be at odds with how the 
hardware works.

Also, I am happy to split the patches into the two patches, or (maybe 
more ideally) just modify the commit message to better indicate the 
reason the change. I just need guidance from maintainers so that 
whatever work I do leads to something acceptable for y'all.

So, please help me get this done. I am just a user with broken hardware 
and a fondness for Linux. I would love to help do what's needed to get 
this fix landed.

Please help me get there,
Wren T
-- 
You're more amazing than you think!
