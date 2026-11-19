Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795048374;
	b=EPGC563Evd+clHB9kjU8ftTrUbbP//S1oGnONb5G31t8HmBbxRN6HVmoBIGvMD2Thl1R
	 7qsfeXt2jcuSGcxGpaFbZPyM6ZNcSr8fwjqYbIogSFrfnpc/vRj4xMLl3sDy7n6fvJokR
	 Ns3M75FcGHhw5drWGkSS7GvEv4U1YTTqcITL8950hwxYlFaEMkBIovP6FoxFqeeBCcLzz
	 Z5A6nlJkk97vfTkr8wwERL3VhsMSOycHQEZP1K60KsK9DcD5jHZ41Scs4WNISIINDdeao
	 6pTBxFrrwBsnrMhjpcx9no7dANgdgHRlKVINKTxuRneZNrUoX/dZFSM5ARD+yun2rEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795048374;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=rffgUGkVHnEqpaThmuNJhXv5TM/nY+7d/A13Ey88Qs4=;
	b=HnRleEB18l1xJtvNSHv2VMMUMQpqw/ptYDQ4H6j3Z1Jn1lqTroEx6PsV1ee6yKsxrAsK
	 iomdcqFddqZBXx3qsxvQJ06vKHpiFFvdUgoIUgzTXpsydH5JIdNtIGzmQM0Qj8do4tRZy
	 IqI8+wdfpeU3sdOlSp+7Kgp9Z4jFHPtlVfCnubaZnRgOAVmFTfafqhWP6CuCcTHwUcTBo
	 zjNq0i8Z2MtVkAhIi0f6edr32lDaFJlS810JETVbNANzNdmVMwY3yc9yLPs1y9QNnar+P
	 gBGAwXOR5MfbHJ0SN/G/gwaxRPsOEblyYWDmUy7w4Awdbkw3weVSYt9Rb48WnBbp4rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nBSNWY2z;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0291606A32C
	for <linux-bluetooth@vger.kernel.org>; Thu, 19 Nov 2026 00:32:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0291606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nBSNWY2z
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3adac5b29ebso1055021a91.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 18 Nov 2026 16:32:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795048373; x=1795653173; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=rffgUGkVHnEqpaThmuNJhXv5TM/nY+7d/A13Ey88Qs4=;
        b=nBSNWY2zC9vTGG0tKos2I67rOPSgYRC47kUdOyEXf+eClZlmWe54juBZsz8zFLwQOs
         BLKFIpcfBkL6bH9Yyfo2n9Gl9McPoGkAJXiHpkRDQjfFLJDG/46gdj+JOlmVNNEvGaKx
         MSq3wiKyOV97DIcxFTyd2ZQ6VUu9GN8O0GB7494gruztfiQihfEp2fI+wr9uC6AYwLGC
         FXR5Eee4dgH1L6ODs9B7fMBRHxcDUaYiWpVkAiSutF5zIERy8rm2uGyY5ah/modo+bRD
         bNv4+O3YlUVMzbX38xHxfJ79kAEKEgjutHzhBJ0UcJB48qn3uH9yYV0M7OWR138t7Kro
         XebA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795048373; x=1795653173;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=rffgUGkVHnEqpaThmuNJhXv5TM/nY+7d/A13Ey88Qs4=;
        b=tOAnbsAKuPQ6ZeZs1ZG/gdimgJMcNv9Xi8wOGg+rBRBrC0yiIPgl7y/VQ9wlNHVqV9
         flk/MzT7vJHw0O1slKMPTbUk+XYLkItLKIrv8knnJhkhcAggKnJMp2p8GkYPzlgmi0lk
         //GlLb86MW9EEKqEs/V7JVklcJatC1p0mPn2QrMIfimImXA80Jzwhz9Exw3Hyp8A9eWC
         ZJXUC/o94BoSZ33CfyPZzn/VuybyxCB0f7RijIyb9lYIwDUyRYhIgEy6H9mp0TKdCFB0
         xq+63fmmkrcFchkblh37dYXly1nW3hoplkczVZOTfiAgqjIWo84RxKulLFhtVzkrlTju
         q6fQ==
X-Gm-Message-State: APuU4Z/LgCzQY3q6+stYeh+c/ji28k3/nvxgOav3bO2vKCTTmVuY7+4o
	HP9B+DNjxmFSCbfQqVtCnRkNG6EyRJD1Dk2owgctVceuCeA6xpml5KqwkMtiPw==
X-Gm-Gg: AZFdTZfYvMrtqTKTJv8wo9FtyfH4WEVm978s+1uIjKzwgWUsdqwxsRlRl2qk2t7JY4w
	fyb6AlqGZ3OKoEX09ELXZRUpYF3uKDGkbu0zSKI3IcZkNiOY/f6Gw4/3lNROPIHmgKwaxAbRQDu
	GMgcjCd9f3t9SWiMQvjpQZe0swizDGrfcI5WlTcVIbamR+Tf7+h4+8E4gOAW6/W0ogsIaD95Nux
	yeWLFdhI3+e1jpj5rD+HIRcu2DF1X8W46m9ZZ3jSTJ5/fFBHyA0qyu65n9AZV91CqxO2hO7mzJV
	usFGONVvnJJAOEYdtIkfxTutxZ6oAzPxelwyvMlr1GUKzMuC9goiekfmxvdI+zbuW+IDfuAUkZN
	pZawhAJGrYaqHQRvULZ/8EZBMej8jyGoaQXn6sv0dgwT75vjzs6TooOLU/CEXYB80lZII+PHq4M
	1idaVAB0u/KwCmr+gOg7DsAdaiTIbEsF0m2BL2Ol5dg1W2Bc20zhDpzNL44bUIQlzfoUWAste3/
	rGUMZzEXB1ayKK06pF/tjHvQFcYp6FRuRITaVU/DCP9s11N+qaAnwOrXiwXoRDbZcFO0xZHj8Kk
	Z8fbsCsZylXYn1AN2O5fXh8SYca1fDnShBxTy/ZYM8k=
X-Received: by 2002:a17:90b:4490:b0:3ad:c4e9:7beb with SMTP id 98e67ed59e1d1-3b3d07aab52mr4096283a91.43.1795048373240;
        Wed, 18 Nov 2026 16:32:53 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-42-157-127.us-west-2.compute.amazonaws.com. [3.42.157.127])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b3fdefd78csm552335a91.7.2026.11.18.16.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2026 16:32:52 -0800 (PST)
Message-ID: <6afe43b4.9af75b30.4c355.8a9b@mx.google.com>
Date: Wed, 18 Nov 2026 16:32:52 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============5933365075326746141=="
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, leon@kernel.org
Subject: RE: driver core: Authorize device trust before driver binding
In-Reply-To: <20261118-device-trust-core-v3-1-d655875c4bfb@nvidia.com>
References: <20261118-device-trust-core-v3-1-d655875c4bfb@nvidia.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5933365075326746141==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is an automated email and please do not reply to this email.

Dear Submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
While preparing the CI tests, the patches you submitted couldn't be applied to the current HEAD of the repository.

----- Output -----

error: patch failed: include/linux/pci.h:616
error: include/linux/pci.h: patch does not apply
hint: Use 'git am --show-current-patch=diff' to see the failed patch
hint: When you have resolved this problem, run "git am --continue".
hint: If you prefer to skip this patch, run "git am --skip" instead.
hint: To restore the original branch and stop patching, run "git am --abort".
hint: Disable this message with "git config set advice.mergeConflict false"

Please resolve the issue and submit the patches again.


---
Regards,
Linux Bluetooth


--===============5933365075326746141==--
