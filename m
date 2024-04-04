Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDB312C7FB
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Apr 2024 19:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712257388; cv=none; b=I+ItPhccnwa5H9VxlPyeG//LPcJqhT3t4X36or8iAb92m2YBdztlBUORZBoctzt5XkI5Rdf4yVYT6G4bUUJHk0feVBnZIA01Ai+tDMEhP4LHlWZyYzceo+OXrOA4X4jvohZgz2w95pFvJJTVZMGrawNQtIDbj0x2hDQalbkVNKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712257388; c=relaxed/simple;
	bh=/BgY3Rb4KGTUE8LNU5ENR93N3yPOpkP5eThWZKYeMSU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=Cp+YlMosZbVeYPt8fkuWsXZOF4QyIO7FBjDP2Dzsku672/3L+c5UPxPa1Ub+XwknRUY59HnpszALsanS3hRgzbICzyo3XzcpxzwBOSTsN1RjdlTmEtCRlkX7wrQMNdmtvvStJHCxp1PpAapZ2ZQk0MI2zeYNrc+aLFOdsHLzdmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=d8908FJU; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="d8908FJU"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2a226f8e44aso933174a91.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Apr 2024 12:03:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1712257385; x=1712862185; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F+dc1DcxVAxBWTys4V7Wa8EiTvAGlJvNoLSLbyF+ei8=;
        b=d8908FJUEtkHRWdCW1afd21Y9hGhIV2nDcRRW72PfbTCSvFkxF6S3tD7zHcXLPEg/Q
         slbgoGWH8+NJvyYFh/J63Z4nte0tpLgHGHmOoxTlFKY2caOryM2sSxRr67Tp/VUlsKu4
         1K91pYwdun0fpBBV17X/nRoYKCRbv+vrfNb8Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712257385; x=1712862185;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=F+dc1DcxVAxBWTys4V7Wa8EiTvAGlJvNoLSLbyF+ei8=;
        b=SqF6GUGSd7IaROrUHwBkTD2lGqdT36MvV2H24ERvUJ9ESDLBM3uFSnbL4l2n/zNT3b
         cvv0ixe6yO4Rd0t4lozmGS7It8aU/t48jGaV6TmM6w+qmLOaaR1sZGHAV/5KYKLiVZms
         k+QXHMz/j7tUO/NSUfXl+8oCx97pXG/n94Gme6eQW6KKV0bXl4633Rejof1HCC3JNLS2
         GX3l7IMb80sMZwrmwK8WyxXOJIcxRoBBHW1ASwZ5K3B5KR5K/55sVeOOBPSRElsdkkvH
         UvzzeDvveED6tV4NYOcF1c+Sx+x99+YoQz304zA+Fckig7Vdn1OMExx9TyEdZUWaYoaq
         eItg==
X-Gm-Message-State: AOJu0YzID0YjJA1A5YLmSkyfuQk/ia5Tadk/m5D1aLJvU0fKTtEXPU1L
	brRpPtKEnAyvhmPw2jgGYA94JpN3T2xwxvLRSL5zxz0m0AZt3YG//NUFE82ZkduOjeHSltkjSTt
	06Q==
X-Google-Smtp-Source: AGHT+IG+JgXXz58Ua9WmNYk9Ka74bb8u0Vf27OXPB04pp3RSnWxazValEorWWNAwb1+DHqSaq2jlzQ==
X-Received: by 2002:a17:90b:1e4d:b0:29b:8926:c161 with SMTP id pi13-20020a17090b1e4d00b0029b8926c161mr3218857pjb.19.1712257384739;
        Thu, 04 Apr 2024 12:03:04 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id e21-20020a17090ac21500b002a0981a7af5sm41201pjt.32.2024.04.04.12.03.03
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 12:03:04 -0700 (PDT)
Message-ID: <980ac002-efb7-4ed7-92ac-fb0caca41b59@penguintechs.org>
Date: Thu, 4 Apr 2024 12:03:03 -0700
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-bluetooth@vger.kernel.org
From: Wren Turkal <wt@penguintechs.org>
Subject: dead link for subscribing to mailing list on bluez website
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The link to the mailing list subscription at 
https://www.bluez.org/development/lists/ is dead. I was hoping someone 
could update that or point me to a git repo that I can send an MR for.

If someone here wants to do it, the correct current link appears to be 
https://subspace.kernel.org/vger.kernel.org.html. There aren't html 
anchors on that page that I see on that page, so I can't find a link 
directly to the linux-bluetooth list entry in the large list of mailing 
lists.

However there is an option for a link to directly highlight the 
linux-bluetooth text that only works in chrome:
https://subspace.kernel.org/vger.kernel.org.html#:~:text=449-,linux%2Dbluetooth,-Linux%20bluetooth%20development

Firefox will not jump to the highlight with that link, but will load the 
page fine. Maybe use that link instead of the bare one to make it better 
for those that have chrome with no apparent costs to other browsers?

FWIW, I am not subscribed to this list. Please keep me on any threads if 
that helps.

Thanks,
wt
-- 
You're more amazing than you think!
