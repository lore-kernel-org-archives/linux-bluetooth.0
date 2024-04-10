Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5551F79CF
	for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2024 23:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712790072; cv=none; b=B/w7WQDHDFhoPS4lAEfd3my4ihzCEjJRetjPpTO2+r6vSId/yBbNQPjYgoMa9bfi/bvInwPSOICmSrNGdV5RhfC8PsHZWoTWBf3c1CoHt7NxNSnsUMT1ZbmksWND1BmUpvEBJZQdbYwWHkWcFFu+R3CDVGSk+x8lfZp7aQoH6bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712790072; c=relaxed/simple;
	bh=ilLFD4vOBSIwNehXlfwZt7AygpzZEnRLF5H30ksXejo=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=XM+RL48aD1V613JvpQ8Esc2hIwtP4Rp82uf3pfbBNYnwS2WeOK05jh4c0ISY8JEZzu0sBK7gInqbE7EYGrLt/oQ8AaPQVQVkIbeJNT/eFoUWvN6NKG1xJsAXtKR6IUB06EIjoEBPVHQA4bRUdCVq8tnB1CuTAm2ZGR+lJK7JgFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=OyNwtBKe; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="OyNwtBKe"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6ed627829e6so2826862b3a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 10 Apr 2024 16:01:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1712790068; x=1713394868; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=N9atpKvibNMMPDU/p/6YOaCxNbIU+vS/gVjEm2gnxV4=;
        b=OyNwtBKeHcH2DT9UryR2joUjUbArMnWEB95II1UCJFyyq5KwvaSt8NuGRER+infDCJ
         OP5fXPfqfA6ZyTlTQR0xbnRTmVc8U2b+LZZq0QHjPO7685BHeGlSy3j3dttcMrU61UpI
         jN+2spMcomdlF/IujWcyKL7EngHW3FDtlgibM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712790068; x=1713394868;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=N9atpKvibNMMPDU/p/6YOaCxNbIU+vS/gVjEm2gnxV4=;
        b=XwxqidtjNpvDIER13na5GRD/PJoMHTfTj+4gzUc9B04eWbDn02xcQl6OQr0Ck0ivkO
         cTs8uDv3+gROzGz4+seSRPHZhu6cE9kpErDpXrA9GkujhczK3uKmYhTbyIpfXYSJCkNf
         9SHoFtS+TA9RnuQy52pszLYJHVs8qQOMqpyYI7TGh4agwZNEmA5JNLmGxWNy36vA7j7m
         FXlewhBbkHZUudyaaKJ1ORb8xQqkuG7zsSGsvvxFnI+GYyegCS0f3W/TYSln+dk6z19P
         P+oYwMaDEKPUPor589OQ3FSC/RrlY1EzoafpN3du5ShLRwEBK1okkzuE/YWe5J4Mu7Az
         I9QQ==
X-Gm-Message-State: AOJu0YyLYGo/dmuU9OdCh/r0o4SUhsJchEdMXblzY/3nS7ay7Wj7LGcp
	cM3cGqmOPam9KBXD6KIX2tak/Y/1O7AKQ3bOYmhp0541nhWuCcbLO1W6mulWbWT9xHyuOHUrElP
	Xlw==
X-Google-Smtp-Source: AGHT+IEtv0ybuu5yXi0HbR/ZSFNpWnPLHZCH7C2nLUP4kN5ai4Xvgkx4B/ORFnISO39yrTnaPIjKyg==
X-Received: by 2002:a05:6a00:4b55:b0:6ea:bf1c:9dfd with SMTP id kr21-20020a056a004b5500b006eabf1c9dfdmr4423849pfb.27.1712790068485;
        Wed, 10 Apr 2024 16:01:08 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id go16-20020a056a003b1000b006e64ddfa71asm172349pfb.170.2024.04.10.16.01.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 16:01:07 -0700 (PDT)
Message-ID: <3f2591c7-2523-47cc-817d-1f67630c8784@penguintechs.org>
Date: Wed, 10 Apr 2024 16:01:06 -0700
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
In-Reply-To: <980ac002-efb7-4ed7-92ac-fb0caca41b59@penguintechs.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Adding Luiz and Marcel in hopes that they may know the answer.

On 4/4/24 12:03 PM, Wren Turkal wrote:
> The link to the mailing list subscription at 
> https://www.bluez.org/development/lists/ is dead. I was hoping someone 
> could update that or point me to a git repo that I can send an MR for.
> 
> If someone here wants to do it, the correct current link appears to be 
> https://subspace.kernel.org/vger.kernel.org.html. There aren't html 
> anchors on that page that I see on that page, so I can't find a link 
> directly to the linux-bluetooth list entry in the large list of mailing 
> lists.
> 
> However there is an option for a link to directly highlight the 
> linux-bluetooth text that only works in chrome:
> https://subspace.kernel.org/vger.kernel.org.html#:~:text=449-,linux%2Dbluetooth,-Linux%20bluetooth%20development
> 
> Firefox will not jump to the highlight with that link, but will load the 
> page fine. Maybe use that link instead of the bare one to make it better 
> for those that have chrome with no apparent costs to other browsers?
> 
> FWIW, I am not subscribed to this list. Please keep me on any threads if 
> that helps.

I am not sure where the repo for this website is. I'm happy to submit a 
patch if you share where the website repo is.

> Thanks,
> wt

-- 
You're more amazing than you think!
