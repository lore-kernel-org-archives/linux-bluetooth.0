Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 981353E48C
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 19:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715370579; cv=none; b=ricjswO/BQauCEigzkfr/LbKUfPOe0gJrqICsD/BNczFLoOuCpuKQ+OlU9ZdvGw5FiJxgaCWe0uL8izNz4OSR8KJXmdVya9/VLReIZpO67TbM3XAJrPKQng5e4hRy13mlbvkwcDXkaNEf1POwub14kIkPhhtHCd71xNNKgILlxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715370579; c=relaxed/simple;
	bh=JCFFmbNlsOn6FVvGztjgo6+wDYo3/QMxgC04ADQpeJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IJwpix+nKXuV3mowUIqquG6cOLXJPiKbMw39MvNCgpK3pJXyOwlaWAkeOw7iA1a+juZsa0I1bMaxOCfpFHFca6euoEQkr8jHwCtk/eZZtUhQfzSZOkZdRhzvL1/tAWTqn9GfZXIL6ZKGFXsm3ECP6oeVR/cyflNNOuew4E9fvpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=YZgESg6e; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="YZgESg6e"
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-5ac61cf3fffso1054968eaf.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 12:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1715370576; x=1715975376; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yxWyXszhHGNezoVa9cm6qt9auwsbCofn2LFU7/T+05M=;
        b=YZgESg6eBrMAaoeIa+C1eu2czx+4a0b2iF2AllDctx5CvMew/giAm1H+eyQ2Im9nzl
         etaqrtAMU1wL1K5fPwQyhu+FswUv5dgpdbkb48AIfVOP8x4q/96e9C/37ji7vj/mVLdL
         3k7deKhuwRwVByM2p3tLqVAJ58EawYjIrJ3cs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715370576; x=1715975376;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yxWyXszhHGNezoVa9cm6qt9auwsbCofn2LFU7/T+05M=;
        b=D8Bod3dM9hxvLdGWkRB1Rz1JN8zMZKyiGWC0WpI9hFSBGQyUYpg94rV8cE8SbMDhk+
         /wTrbwlUSjADvhZ3cRG8ukjwz6RHjwwlpe7a5Z8u1Y465xpYzPNZMgpwyY1AqOvTt3/9
         xg5/NpqImLS5VHs2U6tQwBkxFHhp+rKBeNW3cAiGc2brayySVYHBJ/g2eTvT/vUYlfxw
         3UDTrj3lwWa+CgQkA+SbzmCr1Lp43lhd52XCmbIlxqFc4plvumgdvpVNyHqmwk0UKJHt
         wcyKFgZAi/ONlT6zL64OHp3HE8qAmP0id/qPl0FRDUC0BkyJiiHcP7lINxstretZUUrO
         +gyA==
X-Gm-Message-State: AOJu0YxG2x1RQBEMS1MeKmAS1juXU4vsx/lSDl0NujakKntZzGB9AAvZ
	oJSmLS0I1sQCcxR+CSGNltro1VqU7mW+zGA2/eMupZq5kX55geHJmLaU981Tlw==
X-Google-Smtp-Source: AGHT+IEX+36Sj6GYkUunsowtfhH38q+3cvxoAjNx4PliHhEkHO5WeF7xTXdWc4kLq9JBMqeDbGP8yg==
X-Received: by 2002:a05:6358:93a3:b0:192:9d35:b025 with SMTP id e5c5f4694b2df-193bb63f056mr351397055d.16.1715370576521;
        Fri, 10 May 2024 12:49:36 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-6340c4d4a1csm3462978a12.40.2024.05.10.12.49.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 May 2024 12:49:36 -0700 (PDT)
Message-ID: <d9232cf5-b0ca-47f2-841d-45f5880368c8@penguintechs.org>
Date: Fri, 10 May 2024 12:49:34 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] Bluetooth: qca: Fix BT enable failure again for
 QCA6390 after warm reboot
Content-Language: en-US
To: Krzysztof Kozlowski <krzk@kernel.org>, Zijun Hu
 <quic_zijuhu@quicinc.com>, luiz.dentz@gmail.com, luiz.von.dentz@intel.com,
 marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org, regressions@lists.linux.dev,
 stable@vger.kernel.org
References: <1714658761-15326-1-git-send-email-quic_zijuhu@quicinc.com>
 <5e5e869c-da12-4818-837e-55709f0c4db9@kernel.org>
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <5e5e869c-da12-4818-837e-55709f0c4db9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 5/3/24 3:16 AM, Krzysztof Kozlowski wrote:
> On 02/05/2024 16:06, Zijun Hu wrote:
>> Commit 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed
>> serdev") will cause below regression issue:
>>
>> BT can't be enabled after below steps:
>> cold boot -> enable BT -> disable BT -> warm reboot -> BT enable failure
>> if property enable-gpios is not configured within DT|ACPI for QCA6390.
>>
>> The commit is to fix a use-after-free issue within qca_serdev_shutdown()
>> during reboot, but also introduces this regression issue regarding above
>> steps since the VSC is not sent to reset controller during warm reboot.
>>
>> Fixed by sending the VSC to reset controller within qca_serdev_shutdown()
>> once BT was ever enabled, and the use-after-free issue is also be fixed
>> by this change since serdev is still opened when send to serdev.
>>
>> Fixes: 272970be3dab ("Bluetooth: hci_qca: Fix driver shutdown on closed serdev")
>> Cc: stable@vger.kernel.org
>> Reported-by: Wren Turkal <wt@penguintechs.org>
>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218726
>> Signed-off-by: Zijun Hu <quic_zijuhu@quicinc.com>
>> Tested-by: Wren Turkal <wt@penguintechs.org>
>> ---
>>   drivers/bluetooth/hci_qca.c | 5 ++---
> 
> I don't think this is v1. Version your patches properly and provide
> changelog.
> 
> I asked already *two times*:
> 1. On which kernel did you test it?
> 2. On which hardware did you test it?

I thought I had already chimed in with this information. I am using a 
Dell XPS 13 9310. It's the only hardware I have access to. I can say 
that the fix seems to work as advertised in that it fixes the warm boot 
issue I have been experiencing.

As a user, I vastly prefer a one time cold boot rather than having to do 
it every time. As such, I can do the test. However, I do not think that 
the patch not working in that case should block landing logic that 
empirically improved my experience with the hardware and minimizes the 
corner case to a much smaller corner (that of warm booting from an OS 
that improperly puts the device in a bad state to a Linux kernel with 
this UX improvement).

wt
-- 
You're more amazing than you think!
