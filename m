Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BC586F53D
	for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 08:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713430587; cv=none; b=bvFwvOQqt647x0oElbacXbgFyAm7HyI7pqSDJrYF0Dd8t1DWM8y+fnUXUo4HP6A7kzC+AvT1QpC3l0H/HcdWLoDAVLOtjkMhpUcH1k6Y3q7b95QO4zVcJ+DGidJxZ7UBqbsYPcOcPqcVgVJcroElRh88jKidAMdr1jdFzv5I+q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713430587; c=relaxed/simple;
	bh=ObfLX8mSN5Y0FI/CKLw3NNRSx9M8btYjc8dvhz2PJQc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=jOR/f05L+m/Cjtpn1a73Jf+NGEQP+ynGBNCstY0bUd5NmKM+uBlDEWsSIaxn/Zpsv9+w1souVJnBRjA+EjKUk/tmx9pZeTYnCybhGMzxsoPJhWlsiHZ3TzcRcZtCJOXJMPqpuMmEZoUa1h6UCj5hllqUaRFeJi40YF1jZjnpAxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=Nl/D8FQP; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="Nl/D8FQP"
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-23333dddd8aso465767fac.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 18 Apr 2024 01:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1713430583; x=1714035383; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iAjd20FqpUWfee/sE+E9RVYvNqy+Lu4inb3jZBzX9rM=;
        b=Nl/D8FQPMNeIkM1sx69Kt7oaQ1KTdajTTc3qdB+Vb79eGeIrNUeF+x49TpCzTp56mb
         J6zy+y5J2Qa28Jat/fDWQ+wO+IIz6xvUZ2oF3hdm4FsJl0HDH5TihVd25RxnUDhHjEEU
         QmbXtBFejpl9xFbiC8hBVbWqdokWIg4xgviis=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713430583; x=1714035383;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iAjd20FqpUWfee/sE+E9RVYvNqy+Lu4inb3jZBzX9rM=;
        b=mEfNrJCVsEIAIsNxBPVSI8x/ZkBNPEKooAbVRkMSgoziyYCrk+pnNRxjgOGilPWGic
         SEF5F9Ht2ZlcR2WVIxvYTHhoa17kuAAZ/v+1gVt1/1+UTMfJIKsUwg8ooENk3fJ62v3G
         NrLDc+BKvJQSboyo5a4bTvQEi7xkUcGv+cybMv+ycQSWAMAOFzkZXZqjG5qk9pMLvSfX
         Qaiw/rMZEVDedtvUK/55ZVAWFZrwZlHYp5pSJXUmo/PbdyLJoBszcEa7L+/DQpDIo0p3
         NYnnoBSFMdkJeppo4LxcXkVI3HUX3h+m4h+LXwPmOFMD0ohMxyijy6Gd2+EO7YSd6DEu
         eUyA==
X-Gm-Message-State: AOJu0Yx4Jh/SWFTDsjONOmJKCCmBV1iJqOi0A/DT53P27SctRC2fKFon
	xx1b6CUiuqhhD5eXI5pA7sEE0/ix5EI8Vog40G7hv8QIGdUk8XMY5/q9dH43Bo4cW3pKtc9gxxs
	xLQ==
X-Google-Smtp-Source: AGHT+IHv7TGAS1vKZVSf7AuFFhr5Tm+caR1hRuDgKQglvcSJqAu5UDR2bJ6NRa+llAS5IJSqgon7Bg==
X-Received: by 2002:a05:6870:5247:b0:22e:28e2:3926 with SMTP id o7-20020a056870524700b0022e28e23926mr2765009oai.46.1713430582896;
        Thu, 18 Apr 2024 01:56:22 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id v127-20020a626185000000b006ead1509847sm1021538pfb.216.2024.04.18.01.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Apr 2024 01:56:22 -0700 (PDT)
Message-ID: <4e5358fd-0c61-4dd3-b531-1374bbf39099@penguintechs.org>
Date: Thu, 18 Apr 2024 01:56:20 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: dead link for subscribing to mailing list on bluez website
Content-Language: en-US
From: Wren Turkal <wt@penguintechs.org>
To: linux-bluetooth@vger.kernel.org,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>
References: <980ac002-efb7-4ed7-92ac-fb0caca41b59@penguintechs.org>
 <3f2591c7-2523-47cc-817d-1f67630c8784@penguintechs.org>
In-Reply-To: <3f2591c7-2523-47cc-817d-1f67630c8784@penguintechs.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/10/24 4:01 PM, Wren Turkal wrote:
> Adding Luiz and Marcel in hopes that they may know the answer.

@Luiz or @Marcel, do either of you know who maintains the bluez.org 
website or where I might submit a patch for fixing the links?

Also, I see that a dead gmane link is also on that page. Would be nice 
to remove that as well.

> 
> On 4/4/24 12:03 PM, Wren Turkal wrote:
>> The link to the mailing list subscription at 
>> https://www.bluez.org/development/lists/ is dead. I was hoping someone 
>> could update that or point me to a git repo that I can send an MR for.
>>
>> If someone here wants to do it, the correct current link appears to be 
>> https://subspace.kernel.org/vger.kernel.org.html. There aren't html 
>> anchors on that page that I see on that page, so I can't find a link 
>> directly to the linux-bluetooth list entry in the large list of 
>> mailing lists.
>>
>> However there is an option for a link to directly highlight the 
>> linux-bluetooth text that only works in chrome:
>> https://subspace.kernel.org/vger.kernel.org.html#:~:text=449-,linux%2Dbluetooth,-Linux%20bluetooth%20development
>>
>> Firefox will not jump to the highlight with that link, but will load 
>> the page fine. Maybe use that link instead of the bare one to make it 
>> better for those that have chrome with no apparent costs to other 
>> browsers?
>>
>> FWIW, I am not subscribed to this list. Please keep me on any threads 
>> if that helps.
> 
> I am not sure where the repo for this website is. I'm happy to submit a 
> patch if you share where the website repo is.
> 
>> Thanks,
>> wt
> 

-- 
You're more amazing than you think!
