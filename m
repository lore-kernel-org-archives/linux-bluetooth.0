Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B0F38DEE
	for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jul 2024 19:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722021964; cv=none; b=Yyiqhl5Ih/rlmXpO+j1N62EBp09PFxfyacp2Wg/ir568X3747v86gnoVQ7SmFCctVKWhJoKbxfKDdoBNXIHKyG3pWxP2LxI/weptqivk5sb09MoWZgHUCT704Ep4rpsyj5thQwOP+2bXBjABiuDF4vI1gyZkxfJj1BPDYECl56I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722021964; c=relaxed/simple;
	bh=QBrtgJ0sb9qnMX9evaaB4lvw4WPkn8gHPJUfV/hmvT4=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=jhdFGzsOPO4QDCA0lWUwK8I0ZS6AoQGsB9je+A31zC3pa2K65VI2nsnh3qUJvDKcfIKCdd8J/7UPSrlvyoKHL6V2eftZSI3g0vWHgJR7di80JqSiTOOlACG+Gilz4AKjQG0ClYigiFJ3QVLsaB+nGWtbjeXkXFlI3dcSshOBGXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=Jrt/aqWa; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="Jrt/aqWa"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-7a263f6439eso817120a12.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 26 Jul 2024 12:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1722021961; x=1722626761; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5mhqdTZGGY/68tSVA8mq4oINge5Hwd5xQD2zdua/oUk=;
        b=Jrt/aqWaoa4XOLMrp5EsJVVCFzB0k52ys6xP/v9snI3EE2GOhG5lu3zyTrqjcbJRER
         sdhxrZYjHi2/VEn6t4gsD3ae7TCDPz91cRtXvnd8MwpAPGpeutM+/kjh6xH1JT0yhXhA
         xoTf13pmsz6im+CwlwOXBnjmpGbepln15oq3s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722021961; x=1722626761;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5mhqdTZGGY/68tSVA8mq4oINge5Hwd5xQD2zdua/oUk=;
        b=HKwl03omPetWMJdnprgVFILO+sB7w4rAz+RlOvy3UGA9mGuKAYxtkvYtYifTW17L4S
         EDpu5Oe4Zr1SI6gEgpGWxTCbOZl5I2hAKj0Mf6hM8QQ0e5Xu5upxrbgWyFp5r7KfwWHM
         hAKIRhscd7zRMsklQ+JZyfGxq9i7lnGbVHM0xDVgm9EBy7jTFtrJQRTg74E9wkwUFL8q
         2LxIbcWVtpXxJnR17a3d2pTKQPHCzz4v+sDcwiXHpD5wLJO+7fMlBwLVoN0Hi9zWUl6I
         U21GYW/CsQyXpXBEnD9ELyMqrAGqsw+nkY+Y6I3fwTXirlLrMdKV0bqzwbg893Kxtjss
         2FPQ==
X-Gm-Message-State: AOJu0Yw509V3E5ovGlpZSE2xmowg/AB35H65bqU42P9o71ZBwEWSsRPA
	gXF1mEGTtW+7xSiq6HukytY2n2sKbsqnAUzkdsLf+Fvl3Z3e6pYHOCb87bwCLw==
X-Google-Smtp-Source: AGHT+IHnACPiP8Jv9mrE5QZVDVob90nu/FuhJT8F3Wh2KKDnSoBolSDiXVsDNfNQ+OOtSoU2u1Qo7Q==
X-Received: by 2002:a17:902:fa45:b0:1fb:2ee5:378a with SMTP id d9443c01a7336-1ff0489f4d2mr6233675ad.44.1722021960607;
        Fri, 26 Jul 2024 12:26:00 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c88a39sm36544335ad.28.2024.07.26.12.25.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 12:26:00 -0700 (PDT)
Message-ID: <21645f07-da90-4441-8dbb-d999298165e9@penguintechs.org>
Date: Fri, 26 Jul 2024 12:25:58 -0700
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
 <1a519b2f-f5cf-40b3-8223-162dc04f8ca8@penguintechs.org>
Content-Language: en-US
In-Reply-To: <1a519b2f-f5cf-40b3-8223-162dc04f8ca8@penguintechs.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/26/24 11:52 AM, Wren Turkal wrote:
> On 7/25/24 1:47 PM, Wren Turkal wrote:
>> On 7/25/24 1:35 PM, Luiz Augusto von Dentz wrote:
>>> Hi Wren,
>>>
>>> On Thu, Jul 25, 2024 at 2:35 PM Wren Turkal <wt@penguintechs.org> wrote:
>>>>
>>>> Hello BT folks,
>>>>
>>>> Just so y'all know, the QCA6390 bluetooth hardware appears to be broken
>>>> at least since commit 720261cfc732.
>>>>
>>>> The KDE and Gnome bluetooth control panels appear to think there is no
>>>> bluetooth hardware. Rolling back to 6.10 appear to function.
>>>>
>>>> I have a Dell XPS13 9310.
>>>>
>>>> I will attempt to capture some kernel logs in a bit.
>>>
>>> git show 720261cfc732
>>> fatal: ambiguous argument '720261cfc732': unknown revision or path not
>>> in the working tree.
>>
>> I gave you the sha for the built fedora rawhide kernel package, not a 
>> mainline sha. Sorry about that. I thought it was a mainline sha. I am 
>> trying to bisect the problem. Hopefully, I can get a mainline git sha 
>> for you soon.
>>
>> If it helps, the build date of the kernel is 2024-07-19.
>>
>> Sorry about the confusion. Hope this helps track down the problem.
> 
> I have managed to get the following commit id range for the issue:
> 80ab5445da6235..e2f710f97f35

Narrowed to 80ab5445da6235..586f14a6a182

-- 
You're more amazing than you think!

