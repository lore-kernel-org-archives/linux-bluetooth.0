Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82AB155386
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jul 2024 18:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722019939; cv=none; b=GAFAiLY4sNRu33/hZ9PUO/Q6S7ftzg+MJEmV6s2CbYGbgeKtUN2MXOHfBVWEi9nMEsn7x3+JMsYWqS9egqAXCgKj1XO512lKBoteuvcpqMwp9VmFO4YhRlzyrlQPgMHGBLE3gU12x8RGgK7c+OQk4jBxUM3Itij/PR9wSQKCcp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722019939; c=relaxed/simple;
	bh=lDCYy0iwb8e146vK4FXtOlCuC26DpAKb7NVmVzdjl0w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=KZ7FgIvZlwzokCpdqThmvIN9Jeq3hULJHmufg98r5YOqjUzop6eF6tHMVXYKzxzXjuccZ88/5ANrvGQfketG6JBoCzgmSaUOpAT9OrQ5HU/FPJJe2givX+ATHVNum/D74MqVG6ku/FVQv84jbXyFejecgJtZ/xfuU6S3V4HTonA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=ZYmcozgL; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="ZYmcozgL"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fd640a6454so10023215ad.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jul 2024 11:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1722019936; x=1722624736; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JFzDfizDvhfPemSFveDwT5/JRbF8KXcgsh052FyrAMQ=;
        b=ZYmcozgLeQcC+ljgQPb9M1w6nwv/1ZHk8m5mpwYrI1XOch1647w+IRhsb42tQxULUU
         +svh9IWeNS+AW9B5Sq42RoNyCgyCiH13AkdC6/LKncktehevcMgQBcE72mqpRLDm7iiD
         t8paqrW6TSZlJAi60ShEOJuDNNWODbDPW+6E0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722019936; x=1722624736;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JFzDfizDvhfPemSFveDwT5/JRbF8KXcgsh052FyrAMQ=;
        b=qWm0YL7xVqNt3enCice0c3MVx5qo1xjOqUNkUpUKTe6CZ3pMHwAkoVUwkVVjNMqM10
         v89EfhiF0Zj2lFaJg+v0bIO8KZr/YaFkrF5X7Cm4oGaH1t0SIF536R7ARl38v5wUwOcX
         CmmMwGo23clWe53aA3DSV8R7trgrs7Wr03O+ppxE2yNQdQaKTF1BDRo7ndnIo4DVEpuT
         Oko3fQdSGF1D6h/s5OeR+9oRjiqk2ktVmOiVjsP/Fw5krPWrwRXbGa7MLqUhwMM6Ksxs
         ZdDJOSUJRibtgCIWLZaQhOH5lX0pCX5G1/rRC/PAhliOovWOzz9legqOpvQSt9oh7L5V
         PxTA==
X-Gm-Message-State: AOJu0YziAzGeV27vo77vJauEEA3GbBLe99p9VdJejBMfw3aZ8LwnEYtH
	DA//N3Ae7GYK1PMYZGmWt/pFgVh/SkLzWEZ5HriHIWk9OPe2AqWHPHg0IgnO2YOPy+O3qp0ASiJ
	Drw==
X-Google-Smtp-Source: AGHT+IFWqnLMmkdcEeyDdioQ9syvu9qycACd3pdjErs/oKNgWT3KigoXNVBpIT2Lei6/dp+SxTIAMw==
X-Received: by 2002:a17:903:41ca:b0:1fd:9c2d:2f1b with SMTP id d9443c01a7336-1ff04910c43mr7767065ad.52.1722019935811;
        Fri, 26 Jul 2024 11:52:15 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c8d201sm36292975ad.30.2024.07.26.11.52.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 11:52:15 -0700 (PDT)
Message-ID: <1a519b2f-f5cf-40b3-8223-162dc04f8ca8@penguintechs.org>
Date: Fri, 26 Jul 2024 11:52:13 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QCA6390 broken in current kernel
From: Wren Turkal <wt@penguintechs.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
References: <27e6a6c5-fb63-4219-be0b-eefa2c116e06@penguintechs.org>
 <CABBYNZ+vVFUm1Tb+BvViYMJd6XQczTYPgyO++GGbCcWrkaC4Kg@mail.gmail.com>
 <30319168-9456-49dd-be27-480b2a068fe3@penguintechs.org>
Content-Language: en-US
In-Reply-To: <30319168-9456-49dd-be27-480b2a068fe3@penguintechs.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/25/24 1:47 PM, Wren Turkal wrote:
> On 7/25/24 1:35 PM, Luiz Augusto von Dentz wrote:
>> Hi Wren,
>>
>> On Thu, Jul 25, 2024 at 2:35 PM Wren Turkal <wt@penguintechs.org> wrote:
>>>
>>> Hello BT folks,
>>>
>>> Just so y'all know, the QCA6390 bluetooth hardware appears to be broken
>>> at least since commit 720261cfc732.
>>>
>>> The KDE and Gnome bluetooth control panels appear to think there is no
>>> bluetooth hardware. Rolling back to 6.10 appear to function.
>>>
>>> I have a Dell XPS13 9310.
>>>
>>> I will attempt to capture some kernel logs in a bit.
>>
>> git show 720261cfc732
>> fatal: ambiguous argument '720261cfc732': unknown revision or path not
>> in the working tree.
> 
> I gave you the sha for the built fedora rawhide kernel package, not a 
> mainline sha. Sorry about that. I thought it was a mainline sha. I am 
> trying to bisect the problem. Hopefully, I can get a mainline git sha 
> for you soon.
> 
> If it helps, the build date of the kernel is 2024-07-19.
> 
> Sorry about the confusion. Hope this helps track down the problem.

I have managed to get the following commit id range for the issue:
80ab5445da6235..e2f710f97f35

I am still working on the bisect to further narrow.

wt
-- 
You're more amazing than you think!

