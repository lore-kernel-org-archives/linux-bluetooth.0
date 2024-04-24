Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com [209.85.160.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E8D9159913
	for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 11:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713957936; cv=none; b=iP5I9M8lCOy9fcbcPZ9/kR1BNZnooI+jDOuGKScXiI23OzjadUZLysHLOLGtFQfTuEdmy5MQG77g53rOreoNHfbxYzN4b6SIZH4DvxwDmv3WF4TH5Pa+i3d6cKBls4OaYOE6siWUmj+eCtpVHxixLNzemf7kKrfbcZvee99coRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713957936; c=relaxed/simple;
	bh=OlyK9/DbJhCC0o4KxXv7H04VN0viztFvzGysswMOuuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qe7LtHm8UzgyTc6HE7Hgmkh5VXStlb/N0a5krIyEGGtVPr7KBjZFpjezsWcFMJv665o6JY1fW1FTHFVFSrCiZF2ZI00YaU7WFdKmeZEbOqlzbj2pFaN+fLnZo+1zgW43UXkuqOwihQW6blYTtHytBiBsWBY6/40n74CW7G8YJEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=auA/amJD; arc=none smtp.client-ip=209.85.160.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="auA/amJD"
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-222a9eae9a7so3336996fac.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 24 Apr 2024 04:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1713957934; x=1714562734; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dGYk9Mcks7zTmG6tyorPBUsdyDA+s6DwHQvlengwj5I=;
        b=auA/amJDS37Mx0ZNKy8JdpsChdzB259U1l/8sViKismJMoEEJ6+ucQNSHm0AD5Z1De
         y6lc2LPxjmA2jirrqYmOKnGscSGoJGKYxGpWyilSx7dGeUEuVw9/se2UC3TY+A/5d3wT
         PO8rTn7RECgtVQV4u/0D/bpMRaiSQY4G5vees=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713957934; x=1714562734;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dGYk9Mcks7zTmG6tyorPBUsdyDA+s6DwHQvlengwj5I=;
        b=w9pilRpzOYQHWUgcmaSPib7tYCDP7K8oR1G/4fehGB+ypx+0xuPj5gRcX69uhstyBQ
         AWfOK7WF91kIEhxSg75fToASqY1A+EkrfDK3aKualTm2fJwzE4duXBnOElMK+xVrHzor
         tMbHqk3otP832jgprBrfM4SZwQsevPnYVw8o6w3AddLpjdpZ+EkGSU8hjtzuZGN7L3up
         U85KhJgpmvAQ/ALR+FDHRcrsVsDTsJuTG6tS3VO88EDDGyYeh/xBkuB7Ffyhf+G0aRNP
         Z3Ho9TRs2CBKHia9z5rL70tho4StpEIO2istT/rsZIQTrVDMDO8JHBc3+By04Ah56RL5
         7w7Q==
X-Gm-Message-State: AOJu0YwAEe9yh7Jw+p2aed4OipirmXGnEeUunEPs265Ov9nFm3MifYfD
	DRS1/OJQ6UttJ80GObrTVbYfsvIKj2OIBkq7VWxNeMwF2fWBPHW6utpJNnQQ5A==
X-Google-Smtp-Source: AGHT+IHMaNpYNCLYU19bb65Coe5+3npsynVlSpQTCGi9nNN32qNQeLePNCdm5WrLJclKqYdC+F1XBA==
X-Received: by 2002:a05:6871:5b12:b0:23a:fb32:85a9 with SMTP id op18-20020a0568715b1200b0023afb3285a9mr1888757oac.47.1713957934339;
        Wed, 24 Apr 2024 04:25:34 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id v26-20020a62a51a000000b006e647059cccsm11250356pfm.33.2024.04.24.04.25.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 04:25:33 -0700 (PDT)
Message-ID: <06217256-8a13-4ebf-a282-9782a91793e4@penguintechs.org>
Date: Wed, 24 Apr 2024 04:25:31 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: qca: set power_ctrl_enabled on NULL returned
 by gpiod_get_optional()
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Zijun Hu <quic_zijuhu@quicinc.com>, Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20240422130036.31856-1-brgl@bgdev.pl>
 <99242a7c-53bf-4227-9623-7bc092f564b3@penguintechs.org>
 <CAMRc=MepDwUbAKrWgm0CXKObqy8=igtug0QDgo-CgwxjZCAC2Q@mail.gmail.com>
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <CAMRc=MepDwUbAKrWgm0CXKObqy8=igtug0QDgo-CgwxjZCAC2Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/24 2:04 AM, Bartosz Golaszewski wrote:
> On Wed, 24 Apr 2024 07:07:05 +0200, Wren Turkal<wt@penguintechs.org>  said:
>> On 4/22/24 6:00 AM, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski<bartosz.golaszewski@linaro.org>
>>>
>>> Any return value from gpiod_get_optional() other than a pointer to a
>>> GPIO descriptor or a NULL-pointer is an error and the driver should
>>> abort probing. That being said: commit 56d074d26c58 ("Bluetooth: hci_qca:
>>> don't use IS_ERR_OR_NULL() with gpiod_get_optional()") no longer sets
>>> power_ctrl_enabled on NULL-pointer returned by
>>> devm_gpiod_get_optional(). Restore this behavior but bail-out on errors.
>> Nack. This patch does fixes neither the disable/re-enable problem nor
>> the warm boot problem.
>>
>> Zijun replied to this patch also with what I think is the proper
>> reasoning for why it doesn't fix my setup.
>>
> Indeed, I only addressed a single issue here and not the code under the
> default: label of the switch case. Sorry.
> 
> Could you give the following diff a try?

I am compiling a kernel the patch right now, but I did want to let you 
know that the patch got corrupted by extra line wrapping. I'm not sure 
how you're sending it, but I thought you might want to know.

wt
-- 
You're more amazing than you think!
