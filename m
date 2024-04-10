Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A022B1836E7
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2024 22:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712786427; cv=none; b=n+gw1cK/rwwbAaPywKn/Eh3UIrZsoHdlMloUC/e4+T5xBJF98Vccl2u0earzcOGN0pnwItXZzQjTrx6l4CeScnW9LYsl9u1HvOkg8AdP0aiaLfDvzF5PPkPbJxeAP5laO3zAqig46G68qL/8ZmNDtO5kGHbSoB8uNwJfEnExNBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712786427; c=relaxed/simple;
	bh=Zx3CCcxHs3OpXONxdTcKg4mWTKcPJHXGOtZ4a6Iow1Y=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=toPmorgBDaMQd4Do0HrjUPycblZtbj340yGnespJW7HLnPPNXeW11a/KX4C7tzE1Jav8J/r6TkrjhFSQfZya1rgICGZOkYwz62/xvzVY5hu9k1LVl3aPw/OH2L9LITXzkgoJ2/2mfQhhOVW7oZzuoMxSygTYOxy3FA2v0Y89zic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=b93ti7JF; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="b93ti7JF"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ecfeefe94cso213246b3a.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2024 15:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1712786425; x=1713391225; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xBagYfSF2VpuPkFqS5FJ8XAb1CielWua0CPGtB5IEPE=;
        b=b93ti7JFPfoefx2zPRcblCBaXHWUdLSiFE4f5mgb9lqDFGQIlrcM/NkhJN6yAVAOQO
         CbCvIQo7joIy7ZrWBUMg6vICPGRqqMKKC5SfBxzb104IAqCrxGyg96es2nOppZqYThtJ
         i7eV/wtzzCHscXMDEBBQzJ9ApSezazWCX9coQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712786425; x=1713391225;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xBagYfSF2VpuPkFqS5FJ8XAb1CielWua0CPGtB5IEPE=;
        b=KFlwsWni3aPQzDPdIP99Z2vRQ9oxxXMjyTkeO0Gns/aprd4RNH0hJ2K8ZoLCN6kd+0
         6rB/SJweQbooP0xCrAlPx/dfEYzabVmx7xSd8DoGHzfEaFma6LOYTIuphqi9s6GQAvo6
         xdwGWvZauR8b9b29HMLgX1Xu9IztLiZl1TiecqJizk5CDQYWkn0MebFvNmtzs6n87raw
         2cJmNJfUcHV4VgILWJD4zUtDLogLrAtq8tIrHFg9AkqJtSr3xR3OqFRP2qIBJxipy7bV
         D1KqQidiB/xZerx24GYfa5gWA3jnXq9Mp1kGDyI84t2IEAoli5ucUu4cfPJEwluZ7q4o
         Nq/w==
X-Forwarded-Encrypted: i=1; AJvYcCU7xeZFXL54h0TcDYO1U9I6mC9K4jjTRCXDqlKHZ2NrEmO0Moxz24tMi+KPoXBzHrIbRJQBukj/OtKgpMV4Yg19fn1rb97QPtL0DDXXKNvk
X-Gm-Message-State: AOJu0YzlG/rg4WYqJgSjrMIYvkkJnF13tvy350kzi5cy4VxH3jX0cL1R
	AUJU8Cw0qz3S25Gzniza6xOSx/465Llcn9foW5IKi4wY49UxFr7fDga2AYHWrw==
X-Google-Smtp-Source: AGHT+IE7tJUtmyDmEfT88K4d36972vBAPniKC9dO38yf4Vy4usYUldMNxrpkF6RJSBtYWrcfp9uU+A==
X-Received: by 2002:a05:6a00:9394:b0:6ed:21d5:fbdb with SMTP id ka20-20020a056a00939400b006ed21d5fbdbmr1115316pfb.8.1712786424445;
        Wed, 10 Apr 2024 15:00:24 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id n3-20020aa78a43000000b006ed0d0307aasm131148pfa.70.2024.04.10.15.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 15:00:23 -0700 (PDT)
Message-ID: <02400664-2d23-42d3-b49b-0c59f606d298@penguintechs.org>
Date: Wed, 10 Apr 2024 15:00:22 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QCA6390 bluetooth doesn't work after warm boot or
 disable/reenable
From: Wren Turkal <wt@penguintechs.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>,
 Johan Hedberg <johan.hedberg@gmail.com>
Cc: ath11k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
 Kalle Valo <kvalo@kernel.org>
References: <a03dace1-ca0f-41d6-8e2c-636e3b053a3a@penguintechs.org>
 <31bb6e18-ecee-49b3-87d7-50ab53e07447@penguintechs.org>
 <1b3d3937-6679-491e-a5c6-818ae8ac639a@penguintechs.org>
 <b592d037-41ed-42e8-8c3c-286eb1a68ceb@penguintechs.org>
 <68a31d6a-8eb8-4d78-819b-fb67367cc41d@penguintechs.org>
 <CABBYNZJQUy37fxWuCXV1OgM+DNnOr7V0h_rkgcSdw-5hF7iauQ@mail.gmail.com>
 <fca46585-c1ed-4a60-91b5-6da39a5bbdec@penguintechs.org>
Content-Language: en-US
In-Reply-To: <fca46585-c1ed-4a60-91b5-6da39a5bbdec@penguintechs.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

+Johan since he's a former BT drivers maintainer.

On 4/9/24 1:11 PM, Wren Turkal wrote:
> On 4/9/24 1:03 PM, Luiz Augusto von Dentz wrote:
>> 5.19 seems a little too old, imo, or has it been broken for that long,
>> did you at least tried with bluetooth-next? Try contacting the people
>> who actually wrote the driver.
> 
> Sorry, I didn't answer your question. Yes, I do think it's been broken 
> for longer than that, but I wanted to confirm.

Okay, so I tried 6.9-rc3 and every main release 5.19-6.8.

I have found the following:

* older kernels (6.3 and before) seem to be far less likely to kill on a 
cycling the bluetooth service.
* 6.8/6.9-rcs consistently destroy bluetooth when stopping and 
restarting the service
* If I destroy the bluetooth service with a BT service restart in 
6.9-rc3 and warm reboot into any release back to 5.19, bluetooth does 
not work
* cold boot works in all cases assuming I give the laptop about 5s 
between power off/on

So, I suspsect that the process of closing out the hardware may be 
leaving it in a state that the reset cannot handle (and probably never 
could handle).

I also found that qualcomm has docs here: 
https://www.qualcomm.com/products/technology/wi-fi/fastconnect/fastconnect-6800#Documentation

However, I am not a member of a Qualcomm verified company (mentioned in 
the doc links). Luiz, Marcel, or Johan, do you have any contacts that 
might be able to help me in getting info about the technical docs for 
this hardware? I would love to see if I can find any issues in how the 
hardware is being reset.

As an independent dev, I don't even know what it takes to get that kind 
of access. I would welcome any help here. Hey Qualcomm, are you hiring? :P

wt
-- 
You're more amazing than you think!
