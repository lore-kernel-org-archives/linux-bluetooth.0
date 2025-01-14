Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C69C45C14
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2025 14:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736863778; cv=none; b=caRVfyHrNhoTDMKeY7+h2LH6G1faIJzYs4sbS+JjVQKRY9+1Fp989pGI3UGOrBI3v4CViJgC3HRbRyF11MCpgpoqlYfitmNkS3RsLhUUTVrXvRja6Ave3BctFY8mGp71xM+gQeA43ClBL892oZwap0tNxBEi7tHVZQqU1iG5jWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736863778; c=relaxed/simple;
	bh=Rw0YwheHGkjgBmtJ3XrHVYkwWRiQHC6U1g7GiN7Nu8Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F/Rk/7y6O8XF01DMWuieD6aT3bJLMiHgybFpt//th7lkVCtrskewogYb66NWtkz4T1BAWv3VFNEcuRhQUhdE9Ch0kBQhTLHSdZEBJDDZQ5Mou2NUIOtFGw24W2Ezuby6VhlPllhF72wHNONVf/BypIjtN3A1Cq8vp5mzV2wj3hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=remarkable.no; spf=pass smtp.mailfrom=remarkable.no; dkim=pass (2048-bit key) header.d=remarkable.no header.i=@remarkable.no header.b=cgZ3Xh1y; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=remarkable.no
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=remarkable.no
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=remarkable.no header.i=@remarkable.no header.b="cgZ3Xh1y"
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5401fb9fa03so4324830e87.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 Jan 2025 06:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=remarkable.no; s=google; t=1736863774; x=1737468574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=91GZIzgjXBcFI31iM5fj3Hf8Rb+AoJ8tIZRBGy0zkpw=;
        b=cgZ3Xh1yd4WUFzHL4mi7PFoIxQv79JiX1BcXqx6H4FA8VWs9gEYx+G16/4HQx31A28
         LNyN7SaR1mn63ksfnmHfDnsIv7g7zwaYqXjfuSJAtjjg12UMEN8jdwHh3l9s3m4iRNhc
         4VFcu4+RaF9DGbfrZJsFm4K2njY/5rxDxVLFtfLhD1T/COAkhplwVb092a0bmF6q879C
         3V9V6lm7ah2TLrC47NNOCFlEltc1UvA3AGFo+0PvvL3gfdW6sopAJOH2wN3zEd6T/XW5
         bnN+5RUIEn5OhsCMQgkGEyJMwfPjG6904l6/UPlaiMw4nWRnYTIjtBJAJWn3HItV0RE1
         XLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736863774; x=1737468574;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=91GZIzgjXBcFI31iM5fj3Hf8Rb+AoJ8tIZRBGy0zkpw=;
        b=hGozIK3JH9HAwwTtQMPKXyp6RtcxcdImZ/NZejmVzqOXDDsKaxUWwnaKb3qAndheKg
         955h3TdhAVBQmcWstxwFovbgF0oDK3PhyhJr2bRXU0jg2iDgudKBYxLtD4zXZnlRtZtr
         jC+muVAAgjMsMU1E+DWLlAD9wkx0oA9KUrSpRUJiw43nCkUpTJyl3apjsIB3tJuE76vs
         Zkk7TTNw86DsTph4bi5b43HKF37YTrzQnIVT0hDdwJ2J3sUW4/2nfaFDDnRDbWcwFvl+
         3oKSAkss6Hsi4fO+FU0h6XlkyPPhguUGEcNe1meSpen51vgmpVxNonVljew3SH3vSbvW
         CcQg==
X-Gm-Message-State: AOJu0Yyjid+tlYZhbosT7sZKG5WqiXjaw7u/06qYGgWV0ppzzYq22ItJ
	qgwwkKVm47mhom4GapFFB7QGxSS/8Ikdgf8uhMdM06xi14UqwX5pGpxHjYvOMw==
X-Gm-Gg: ASbGnctoosj++fkhrAvEKrKS/VUMMJH5rOS+Z0FOuEErCgJEzPmaEsmSYLLCPikpOf7
	Zt/ASfxB10dRQ226X9b3Up7uyAHSrVDixcOJWIe3tFIfP9oEQdGWImoErxsAuGCfGuKhDkH8wFb
	T9XEFu+49t6YcsTw/B8zx3g0fZ1ut1vGlTTKHbnTHyK8mDPFDwQZ06NDzJojAgi0DcUgz6p+skx
	dreS2dhT4W6NU5seqCWvxaqvCdwsL8LI/BW5+gJEJTTiWePbXq67kTeTzbIcHiHZQMZtGqYRmAc
	R5XNC6jOMBGFtAItLdp1LZ2sXH6H2Jw=
X-Google-Smtp-Source: AGHT+IFoRDuCSh+PCWGYFtIoF6NIctlAFX3rohBL5ZQstpfFeSZSElly5OSQJQFTSaC7IKBKDWvYhg==
X-Received: by 2002:a19:6a0f:0:b0:542:8a7c:509f with SMTP id 2adb3069b0e04-5428a7c5293mr5001343e87.2.1736863774384;
        Tue, 14 Jan 2025 06:09:34 -0800 (PST)
Received: from ?IPV6:2001:4643:2b9c:0:742e:f778:f9f1:b089? ([2001:4643:2b9c:0:742e:f778:f9f1:b089])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5428be4999bsm1687773e87.14.2025.01.14.06.09.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jan 2025 06:09:33 -0800 (PST)
Message-ID: <30b09e71-6790-4ab2-8945-e011996ee85f@remarkable.no>
Date: Tue, 14 Jan 2025 15:09:32 +0100
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] Bluetooth: btnxpuart: Add support for set BD
 address
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>,
 "marcel@holtmann.org" <marcel@holtmann.org>,
 "luiz.dentz@gmail.com" <luiz.dentz@gmail.com>,
 "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
 <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Amitkumar Karwar <amitkumar.karwar@nxp.com>, Sherry Sun
 <sherry.sun@nxp.com>, Luke Wang <ziniu.wang_1@nxp.com>,
 "kristian.krohn@remarkable.no" <kristian.krohn@remarkable.no>,
 Manjeet Gupta <manjeet.gupta@nxp.com>
References: <20250114133548.2362038-1-neeraj.sanjaykale@nxp.com>
 <20250114133548.2362038-2-neeraj.sanjaykale@nxp.com>
 <43beb3f3-071d-4f58-b356-6dc6b9de947a@remarkable.no>
 <PA4PR04MB9687E566EEC90DEF5FB44A2CE7182@PA4PR04MB9687.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Johan Korsnes <johan.korsnes@remarkable.no>
In-Reply-To: <PA4PR04MB9687E566EEC90DEF5FB44A2CE7182@PA4PR04MB9687.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/14/25 3:07 PM, Neeraj Sanjay Kale wrote:
> 
> Hi Johan,
> 
>>
>> On 1/14/25 2:35 PM, Neeraj Sanjay Kale wrote:
>>> This adds support for setting BD address during hci registration. NXP
>>> FW does not allow vendor commands unless it receives a reset command
>>> after FW download and initialization done.
>>> As a workaround, the .set_bdaddr callback function will first send the
>>> HCI reset command, followed by the actual vendor command to set BD
>>> address.
>>>
>>
>> Hi Neeraj,
>>
>> If NXP firmware does not allow vendor commands prior to this reset, would it
>> not be better to perform this reset during probe/init?
>>
> HCI reset is already part of kernel init sequence hci_init0_sync().
> However, .set_bdaddr() is called immediately after FW download is complete, but before this init sequence.
> 
> Also, if local-bd-address property is not defined in the DTB, sending HCI reset command in probe does not add any value.
> 
> With current implementation, if local-bd-address is defined, driver sends HCI reset, followed by set BD address vendor command, and kernel continues with the HCI init sequence.
>

Thanks for clarifying, that makes sense :-)

Kind regards,
Johan

> Thanks,
> Neeraj

