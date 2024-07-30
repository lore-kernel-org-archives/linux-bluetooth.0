Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC9A1AA3C5
	for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jul 2024 19:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722366188; cv=none; b=PGKsHBBSQzw+kVFDpjmIEFXzBrCGafxmzghGx9Gqd7onTsY2WKsCe6D93M7yCCxLJpxXSkeLZcQ6PdB6LVAhpy6RKQJW20wDcRg5mLHYP+9tdiDIFfVNOhK0a4/AhVGpL+Gy9S2MiBn56mAxPrPIp2DjO6LDrBczZkxRGv8l8aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722366188; c=relaxed/simple;
	bh=Bs9thm8Qgh0T0becBCyaw9sAR37T/hby4qRyu6Og4DA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cEvOEUcri/1aKKsuJHhXnND5QwP+WtN1eubFQ7sC1ijMhjfzPuqqdbDfBDL8lojz/Levnqg9e0qhVjUYquOIyfN/qCv3kfNY7srXWnUsU6kjz7GEdCd3q9ljX9t53plFdrdwkI0GMs7S46qxLGnZx3A8/nw8snRC1N84SKUHaRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=Lyc1n0wx; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="Lyc1n0wx"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fc5549788eso36546705ad.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 30 Jul 2024 12:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1722366185; x=1722970985; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JOOj6zlqwBh9BWCCWDgnYay0iP3BKz/borBp3X6roRc=;
        b=Lyc1n0wxQI3SZ+Ofvwf10tItRZ1X2cU8/ZJmEd/ODLbablquTNGwGGq1seM3R7Md8g
         /WnNF9Gl3vUhomjRdqlQKU0urSpErRNHhq/S3McEh3qboNfTXQSQhocxfd2M5jRFLg/u
         vK/Nt+QVK64+8H+xdnE1vnYSNKRAkeWDDMSWY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722366185; x=1722970985;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JOOj6zlqwBh9BWCCWDgnYay0iP3BKz/borBp3X6roRc=;
        b=IMWjjGQiZ8GMVqIPMz9ZVRuyKb5E6CJzm/AsApJAZL2XpAC4pVGi1AxU5ofRJyuHFS
         toAoDauobx+l/qDuyK3xVstVDJ4b9o6OnqOnzWAi892emSH+llLOJ19adX+kf0dhwaNp
         JqmEfibIAKeylXqgHswWHH4kUspGzEYnXOLckE5usk+UDmw1QWj63G89F7PIs3sYQVNF
         DI++V1xAhooyAhzEMXUkHq0f3eTLjVppsoUNJA74dUZRAZBMAIppA66YAZTuFyb0zyVU
         2NUoksyz6o87b26Q96uKUrzYGP+hLKboE2iakWbXiLf4Cx+YY6MVwaYSnOx4XFUtzxmv
         n+5g==
X-Gm-Message-State: AOJu0Yz3mfc7C9C+cAmCa6ExDmAMkRp9OYdLrjHl7roC/0bbxngasCin
	1OOLrNA+jTafU3Sm8jUy0JZnqjUXK1CKIDEYEbX44v0m/naCaAzJGSkJJQl+eg==
X-Google-Smtp-Source: AGHT+IFNUIItEJeeSZFhtMLTVaOU08TLWgPTYCeK+/1FMjzTPShpXX2e9wnB45gX8UXy0bSleli3aw==
X-Received: by 2002:a17:902:e741:b0:1fb:8aa9:e2a9 with SMTP id d9443c01a7336-1ff04808f77mr139370475ad.15.1722366184324;
        Tue, 30 Jul 2024 12:03:04 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7fa8806sm105428695ad.262.2024.07.30.12.03.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jul 2024 12:03:03 -0700 (PDT)
Message-ID: <b1061ec0-5f8f-44af-8955-2d6fa11f94b3@penguintechs.org>
Date: Tue, 30 Jul 2024 12:03:01 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QCA6390 broken in current kernel
From: Wren Turkal <wt@penguintechs.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Zijun Hu <quic_zijuhu@quicinc.com>
Cc: linux-bluetooth@vger.kernel.org
References: <27e6a6c5-fb63-4219-be0b-eefa2c116e06@penguintechs.org>
 <CABBYNZ+vVFUm1Tb+BvViYMJd6XQczTYPgyO++GGbCcWrkaC4Kg@mail.gmail.com>
 <30319168-9456-49dd-be27-480b2a068fe3@penguintechs.org>
 <1a519b2f-f5cf-40b3-8223-162dc04f8ca8@penguintechs.org>
 <21645f07-da90-4441-8dbb-d999298165e9@penguintechs.org>
Content-Language: en-US
In-Reply-To: <21645f07-da90-4441-8dbb-d999298165e9@penguintechs.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Luiz,

On 7/26/24 12:25 PM, Wren Turkal wrote:
> On 7/26/24 11:52 AM, Wren Turkal wrote:
>> On 7/25/24 1:47 PM, Wren Turkal wrote:
>>> On 7/25/24 1:35 PM, Luiz Augusto von Dentz wrote:
>>>> Hi Wren,
>>>>
>>>> On Thu, Jul 25, 2024 at 2:35 PM Wren Turkal <wt@penguintechs.org> 
>>>> wrote:
>>>>>
>>>>> Hello BT folks,
>>>>>
>>>>> Just so y'all know, the QCA6390 bluetooth hardware appears to be 
>>>>> broken
>>>>> at least since commit 720261cfc732.
>>>>>
>>>>> The KDE and Gnome bluetooth control panels appear to think there is no
>>>>> bluetooth hardware. Rolling back to 6.10 appear to function.
>>>>>
>>>>> I have a Dell XPS13 9310.
>>>>>
>>>>> I will attempt to capture some kernel logs in a bit.
>>>>
>>>> git show 720261cfc732
>>>> fatal: ambiguous argument '720261cfc732': unknown revision or path not
>>>> in the working tree.
>>>
>>> I gave you the sha for the built fedora rawhide kernel package, not a 
>>> mainline sha. Sorry about that. I thought it was a mainline sha. I am 
>>> trying to bisect the problem. Hopefully, I can get a mainline git sha 
>>> for you soon.
>>>
>>> If it helps, the build date of the kernel is 2024-07-19.
>>>
>>> Sorry about the confusion. Hope this helps track down the problem.
>>
>> I have managed to get the following commit id range for the issue:
>> 80ab5445da6235..e2f710f97f35
> 
> Narrowed to 80ab5445da6235..586f14a6a182
> 

The first broken commit is 9a15ce685706e73154.

commit 9a15ce685706e73154f03341b35ff5943e46d039
Author: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date:   Wed Jun 12 10:01:50 2024 +0200

     Bluetooth: qca: use the power sequencer for QCA6390

     Use the pwrseq subsystem's consumer API to run the power-up 
sequence for
     the Bluetooth module of the QCA6390 package.

     Tested-by: Amit Pundir <amit.pundir@linaro.org>
     Tested-by: Neil Armstrong <neil.armstrong@linaro.org> # on 
SM8550-QRD, SM8650-QRD & SM8650-HDK
     Tested-by: Caleb Connolly <caleb.connolly@linaro.org> # OnePlus 8T
     Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
     Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

  drivers/bluetooth/hci_qca.c | 74 
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------
  1 file changed, 59 insertions(+), 15 deletions(-)


Bartosz, I added you to the thread since this is your commit.

Luiz and Bartosz, is there any other information I can provide to help 
in getting to a fix?

I will next try Zijun's suggested patch.

wt
-- 
You're more amazing than you think!

