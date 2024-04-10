Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D8B4C94
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2024 22:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712788837; cv=none; b=bQRIEDkGwVeNCwxLR/bi6iznCm76jRwM1q4JT+gz1/nuo7eV1lhI/rfundDWplzX1qHpQTY4lB8bbmd9mbFntNirP6dVj7eBdnG1RyA/JIfzDDD/z7skCgdEFvjff/v//WBkissZ7i1AVaYGtgMdb441m7kDnecBlnETDY1EjMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712788837; c=relaxed/simple;
	bh=Dk/k8coIJuxws2Ts0tamfDKSyZTA0mAmU752Cbww7t4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=rY1xrR9mcb2gvbe6asXXBm33QK7wkSKMwIiV26d0rMTBbmqDB3sGcJYTCPwQ4UleVxXq7gdGvKi6aDHgTFHx0pDPFL+UXMFsaRv4fW/eavZElH30/lnlnqhvX8UOIGviqJHfkDnFuQ5kHOzhopD89ZFHXzc/T+2MES/LIVKzjLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=EviDFuD/; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="EviDFuD/"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ed01c63657so4921711b3a.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2024 15:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1712788834; x=1713393634; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=soEZM/3jVaj/ItjpFqCPn2azxLmCK0C35uqBfBYWbaU=;
        b=EviDFuD/5TBKV0wG1QUe/6yMJNzVVer4xHCe4+cwqFEXiM3UymLlMy0/uKqumqMlo2
         QcF7ecjo53iDLRQUNj9qZhYw8q+0EwgRcjlTujGolS7T3B7rJvaaesgvltoN6UOP4GXP
         vPH6rLn4d81mqHbSZdWMTOhxHFola3kivnvco=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712788834; x=1713393634;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=soEZM/3jVaj/ItjpFqCPn2azxLmCK0C35uqBfBYWbaU=;
        b=UBOpdIMYh39bipqaHT68uJO0DQZO7fi01r+9piAsYuMdmhMpg4dLw2DpvEXYCyIMC/
         zc1cShQ9amAYi4vEyw4JKir4kc//B2qY//FqA6BYrLZ2mzDW5Tp57hTT4hlU3ws57xof
         eRf1pGaFm8UTGv/0q7tHcSJDsLlqnkgG4PuAjifSqLJdqEJW7+dJH3y10d2FaNZjFeTw
         0JlMo7Lf/8Pa832b02Z9DZu/w33kT3hruHvflXu82VYnoifKE+NAzzLL4wxfCrOkknCa
         /FsKhdMAIWLiMFnWI6gz7Xn0q+u2SJ6aV2suoxElsrWsLBmMZTtF1YVVumDvw+usvFaY
         W9ug==
X-Forwarded-Encrypted: i=1; AJvYcCUSLfWTuhxW1CqBXS1Dh9ZVqjEmZqsZuH1xeP85DRC8G7Ciz43nVadI+ahSDLShc7g5bZZP3WIXALDvuVPPiyxvxN801aIy4xBV2YDTcf/s
X-Gm-Message-State: AOJu0Yw8FYc636b7OL1QLt7EmJ+qFCbj6xce+IcM4Jf6UtuDb+SK/MKs
	EqCktUM7pYYI2nQBrgQ+Gj7p+FUPsYEuI/qBloolFPFgiTh95zgdoRjw20gFPDjfFosyLd6MCYo
	Ekg==
X-Google-Smtp-Source: AGHT+IF7/I+UW2aRd7T6Ky1OR8EPkbbZg4FHEpxyZnPDrN6EZpxIopUpklml4CBddN9rW7g+uAfZLA==
X-Received: by 2002:a05:6a00:803:b0:6eb:40:6bff with SMTP id m3-20020a056a00080300b006eb00406bffmr4730839pfk.14.1712788833990;
        Wed, 10 Apr 2024 15:40:33 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id bw36-20020a056a0204a400b005dc507e8d13sm40322pgb.91.2024.04.10.15.40.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 15:40:33 -0700 (PDT)
Message-ID: <8162d6c7-d968-465e-bb8f-3c939eb8d783@penguintechs.org>
Date: Wed, 10 Apr 2024 15:40:31 -0700
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
 <02400664-2d23-42d3-b49b-0c59f606d298@penguintechs.org>
Content-Language: en-US
In-Reply-To: <02400664-2d23-42d3-b49b-0c59f606d298@penguintechs.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/10/24 3:00 PM, Wren Turkal wrote:
> +Johan since he's a former BT drivers maintainer.
> 
> On 4/9/24 1:11 PM, Wren Turkal wrote:
>> On 4/9/24 1:03 PM, Luiz Augusto von Dentz wrote:
>>> 5.19 seems a little too old, imo, or has it been broken for that long,
>>> did you at least tried with bluetooth-next? Try contacting the people
>>> who actually wrote the driver.
>>
>> Sorry, I didn't answer your question. Yes, I do think it's been broken 
>> for longer than that, but I wanted to confirm.
> 
> Okay, so I tried 6.9-rc3 and every main release 5.19-6.8.
> 
> I have found the following:
> 
> * older kernels (6.3 and before) seem to be far less likely to kill on a 
> cycling the bluetooth service.
> * 6.8/6.9-rcs consistently destroy bluetooth when stopping and 
> restarting the service
> * If I destroy the bluetooth service with a BT service restart in 
> 6.9-rc3 and warm reboot into any release back to 5.19, bluetooth does 
> not work
> * cold boot works in all cases assuming I give the laptop about 5s 
> between power off/on

I just did another experiment on 6.9-rc3. I blacklisted relevant 
bluetooth modules and then warm booted without the blacklist. I did this 
for both the "bluetooth" and "btqca" modules. In both cases, I cold 
booted with and appropriate "module_blacklist" kernel arg. After the 
boot, I verified the module was not loaded. I then warm booted without 
the blacklist, and the bluetooth works, so bluetooth only seems to fail 
when the linux module code for closing the device is run before a warm boot.

> So, I suspsect that the process of closing out the hardware may be 
> leaving it in a state that the reset cannot handle (and probably never 
> could handle).
> 
> I also found that qualcomm has docs here: 
> https://www.qualcomm.com/products/technology/wi-fi/fastconnect/fastconnect-6800#Documentation
> 
> However, I am not a member of a Qualcomm verified company (mentioned in 
> the doc links). Luiz, Marcel, or Johan, do you have any contacts that 
> might be able to help me in getting info about the technical docs for 
> this hardware? I would love to see if I can find any issues in how the 
> hardware is being reset.
> 
> As an independent dev, I don't even know what it takes to get that kind 
> of access. I would welcome any help here. Hey Qualcomm, are you hiring? :P
> 
> wt

-- 
You're more amazing than you think!
