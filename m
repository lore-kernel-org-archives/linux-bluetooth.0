Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C79157E79
	for <linux-bluetooth@vger.kernel.org>; Tue,  9 Apr 2024 20:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712693489; cv=none; b=l7BvZqHr0yRAmWVsvT3mwhnUZk9Jjnarm3g3DTwQNrIqYDz8zmg63NM+KxIqpHMCKfmrmRnSUivpV8cMpj5NjjMkj/RPXA64CxeDLk6rGySg05mhkxEQcUZ/Oi8F8v2DEODn8CpCfuYhU5bma5pwV1sa/vCj6z1nVaoVMnxLIF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712693489; c=relaxed/simple;
	bh=OFKVGqtAm3ScyVUb9HOv6mXblIRTAFlAKlj1LU8NeV0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NhfdtnO6XYvVuGwWucuyus78s4V2nXw9yuQIOvD03wuZzCJnFNXOBwSWhxU4amnY2anP10AZpnnVVjbz5WWAPRgUabZSIDzMl0rkb1UvlkXMvPyWWN9LIn6mP1FetxDOun5PkdU02I3AICmjoOnaGgyhrtxgZeO1pSP3nP028cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=RjXWFNTn; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="RjXWFNTn"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6ecea46e1bfso5695184b3a.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 09 Apr 2024 13:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1712693487; x=1713298287; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=quR69Vph6QZk8wTj3CxA3Vuk+DHTtNPbi3L7fQe7qyM=;
        b=RjXWFNTnf/UqRHp3bSATFpVNnzFXQOZzF78cdlLpAEkpBb/iGr7FsgboDko74nNdea
         HnaUgwbrwrL+1KTwrC0JTn0clvv9Q8aQ9sgTm2wSsHpDw6gmVJuG2xeKe+8IvPcyjfTc
         STYisy5pFStxTs1dLRyCGALmHYma73yrE2FPA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712693487; x=1713298287;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=quR69Vph6QZk8wTj3CxA3Vuk+DHTtNPbi3L7fQe7qyM=;
        b=gFo5Rjg/XCp+RPOpb84h0afWLuPqEACDXO9ZXe982D7UVVCw72PvCVw5UruP3KiPkk
         AHw30adh2uQAoN6AytNkz7ZhoRPlc+80k7E57vMMssjrns4C+75cbhAOx01tx7I4Obf/
         XGb6AAvx2GK1P8+R4fKPnfNCv+lUWWw+JP9DW6hXQOCktboRShnARvu8dE6UWuw48Rws
         QOs5ho7tkjhHwmTW2qAk97AzhBopQbuK1VdYL2Un7w0U/pALVKvWg6oQz80MPE9Pmj/c
         PxNqg5knOCfF3HgiufshVwmPL3uJUZiIakXk/k6c/AxknuXYtIQel4Xe5mbbevOJ1CY9
         /Uig==
X-Forwarded-Encrypted: i=1; AJvYcCW2PzV4RJw2iHcO6ZDUPl65PCGsyh5t/pc+T0zkYKkQ/+JUSGMM7WuCXFB+TPm0Oy0iXQ8GdOkKsz2+AT97cyy/snr2aUG6bT3zu4mxU/fW
X-Gm-Message-State: AOJu0Yzh7ES75UM7f+Yes9C61r36Lo+nbzLyN/h0NZv4Wrrzg7oBwjvr
	LJo8+MXqqSBjRlewHK+IHRHG2xUMLreEu37JEwrhVUQuy2clE5y4iweUZd0y5axaumZSa9RQAUq
	xkg==
X-Google-Smtp-Source: AGHT+IEV9FjHyEeFBCNWZRzeMlmeuVqoS+Kkk0tZB1U5HYbzCUTGFX+rT3l7FC8S+vG0ZdHPRJ40SQ==
X-Received: by 2002:a05:6a20:1582:b0:1a7:4887:771e with SMTP id h2-20020a056a20158200b001a74887771emr1004728pzj.44.1712693487464;
        Tue, 09 Apr 2024 13:11:27 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id c6-20020a170903234600b001e4478e9b21sm3859461plh.244.2024.04.09.13.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 13:11:27 -0700 (PDT)
Message-ID: <fca46585-c1ed-4a60-91b5-6da39a5bbdec@penguintechs.org>
Date: Tue, 9 Apr 2024 13:11:26 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: QCA6390 bluetooth doesn't work after warm boot or
 disable/reenable
Content-Language: en-US
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: ath11k@lists.infradead.org, linux-bluetooth@vger.kernel.org,
 Kalle Valo <kvalo@kernel.org>, Marcel Holtmann <marcel@holtmann.org>
References: <a03dace1-ca0f-41d6-8e2c-636e3b053a3a@penguintechs.org>
 <31bb6e18-ecee-49b3-87d7-50ab53e07447@penguintechs.org>
 <1b3d3937-6679-491e-a5c6-818ae8ac639a@penguintechs.org>
 <b592d037-41ed-42e8-8c3c-286eb1a68ceb@penguintechs.org>
 <68a31d6a-8eb8-4d78-819b-fb67367cc41d@penguintechs.org>
 <CABBYNZJQUy37fxWuCXV1OgM+DNnOr7V0h_rkgcSdw-5hF7iauQ@mail.gmail.com>
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <CABBYNZJQUy37fxWuCXV1OgM+DNnOr7V0h_rkgcSdw-5hF7iauQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/9/24 1:03 PM, Luiz Augusto von Dentz wrote:
> 5.19 seems a little too old, imo, or has it been broken for that long,
> did you at least tried with bluetooth-next? Try contacting the people
> who actually wrote the driver.

Sorry, I didn't answer your question. Yes, I do think it's been broken 
for longer than that, but I wanted to confirm.

wt
-- 
You're more amazing than you think!
