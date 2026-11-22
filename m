Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795387534;
	b=08/PuL8QUeD6IGXFIyrB/TbI+W+3ADPxZMhZE4br5w/Jk08fjteW5Jsj01zEMjvWVfKk
	 aRrQHrXvfqCI8HZVpRCKyG5RGbpHQSYC95KHKfT0pl2IXCPUP25Om3nvmJJDUvnQYVBv+
	 rDMycgy62VerCWMVIXN4UfrrWy9tYJ7nuFm29mf0I569mJpX4bWCxeYG01ZploXC1K1Mi
	 0n7vKdXBoFmq2UvogLBGBEVt6gIAVc5pW9SCL1CwijB58HAoMl5qGeSTTuNEypDA2nGmb
	 pxU3BTLIvHa49XWvziWjMjTZ9ltIDsr5NEHge+Se6qRHKDXow8n3pgTO23Qv77eMAeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795387534;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=afsr3M1tFJZk400Hlvg9YdS12U8Q1Cps/UNgIGTrdR8=;
	b=U2f80/qcLlxMe41S0JvEL6pleVLIdijpUUZeq34D3EKUZQZsG/vHy2mT4cFvClJtu7oq
	 yHqwjE294m4L1/XkoZ1TzNNBDzuAP3PTM4veHVcextxuXD/bUfNzLwNPwbLu3xh05gm7F
	 y+m7nd67hPJJQsHOMiBYwkBAgfM78NLSERjEJLOQhrLbvFRU2Eh+SAJKde1IBO1DCAX2F
	 g1MXAq0swhrGVl8vNXZvDHyKScY05nRrHMivvFfQ93m44go7gzhloooIIVaxkzz3uCngT
	 gPHLqXjwqELi8D8CCWbp6iyV+BZswGUAMYmQ+tnswLcJxJw3T7E5NsSker5pbpObAEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wn3YNSAI;
	arc=none smtp.remote-ip=209.85.210.173
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5D6606A31D
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 22:45:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6A5D6606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=wn3YNSAI
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8c700d6cc0bso1914317b3a.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 14:45:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795387534; x=1795992334; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=afsr3M1tFJZk400Hlvg9YdS12U8Q1Cps/UNgIGTrdR8=;
        b=wn3YNSAIyCHjnfs1nlgBFGPdSSzU7LAZ3Vqv0C10uoNM8+nFeNN8Y0c5bzWqcRhRiT
         7Xof8bpLiaGO4lP2mejzGqcmEka+2P4nOZ6dY4VJdPCtrG50TRz4oL3vifIg4KmhlEuW
         WrMkbNh0fiAzxSmMwh7JKCbp+FsC929ndP41E7OFBrhVOvJYXtr9eDdb8XW4jXS0xj/A
         1AmBzLfUpKPtCwUQamugIo2VAE+xY5UveqJAKZuYP0ZTyt9WYPEEPnuYsmIstAYooQiy
         x2MxFzr34kmFaESU2dEz2nv6hDM7uQ7fKd45rpGtdJQx6EuElj7s50hRLPNfUvfav2GX
         JNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795387534; x=1795992334;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=afsr3M1tFJZk400Hlvg9YdS12U8Q1Cps/UNgIGTrdR8=;
        b=d2wtnJp6VSaPiJZ9EpXlWR9u0hksw2GA5wmg+oSWSIYdAPPhWQxESFc8rVekJ/fjqL
         Wht60Wj9ipaejXpEfR86QXBLGp4e5dZLVMUwzgi9FhP93fUzgxlZt+qQgQl8AcWSBA2Q
         0nLbOf79uZIzhz+Aog72AAsJrDi9GpYE8tILp7n1dYcWA8pcjUKjUGKFJGpqUs0e7lwE
         0STiF+poqCZRu+6QhrRKg/JzIP0chYXjaegE1cN1MriHoAKqSV9ChI+tBFd0tXNEOKeD
         eZ7YrsZnncK/nCGheZPEobMMboBoxH/uxDCAeRK/ncPqbchCe0g36rHlObXFJrkpRxo7
         z32g==
X-Gm-Message-State: APuU4Z80TUTF/zxYGG8PV1gv7ICKNPNPaBXTpdItyzlzYZ7d5eSLHkNb
	ivKrrh4bRNYAOxof+ALu+VqcyboZqTKnGsP9nzW+kJUcmPFy2iaaiy/GhI8L2w==
X-Gm-Gg: AZFdTZffWJegB2reM33y3028giXUnk+BmoA/h7zS0iVv6AFwDZJOhHpvQgnhRDxDa+t
	mV/sO8vulQRXVGkGLRU+8C+HrTBIeCHxw46oAlFC4+njXQMS9UEUW9r+uRsCEm7a7vJQ90SvtN4
	myMckwvK1YqrJZTcdQ30Cw3dizvR1uc/bwW3sLaNYanBz8c8pUNlMrrPNfTzRxE6imWkqHCjxEZ
	dHhbf6mH2DfeJOLoJ1R7SiK1BlSHWv25x9Ll8EXfYU8ElPbpC4BZxV2fxLYPg4HurRiEai29k0z
	jJzKSg+qeUx2eZubLue1Ng5OMN2xZj2fS53qVpDA7+I4QPwbVM/caH5irLlGYCyv39sVGUvPm1F
	EFGfR2cW2/lkpkORWCMmWqlX+g41SvMnSEvLDbNsEw+QW3wIkVXfU7WEgagjZ0A2W/7AiCIbYDo
	K6qA3aI2CiLFUKgDyPCZQrtQVBp3kq4t5tOplNHMHlRz7gS+cSJlQC+ooBAYfiPWdWM6x6lSd8r
	N9xo6ha+sBnkihmXj1kWNwsfXRYhyla3XyTcIBvnY5Vu3VynCtFzh6tUE8DuCuUjzc71gMT+J73
	vknMZemKAi3fLYOz4h2Bl4r3NcECQy1Fa7sT1rnP
X-Received: by 2002:a17:90b:442d:b0:3b0:a413:dd8e with SMTP id 98e67ed59e1d1-3b41c982edbmr5857276a91.43.1795387533691;
        Sun, 22 Nov 2026 14:45:33 -0800 (PST)
Received: from [172.17.0.2] (ec2-3-42-157-142.us-west-2.compute.amazonaws.com. [3.42.157.142])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b44b217a5bsm5794226a91.0.2026.11.22.14.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 14:45:32 -0800 (PST)
Message-ID: <6b03708c.856c1b21.302ee3.3b73@mx.google.com>
Date: Sun, 22 Nov 2026 14:45:32 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============8606115593259809460=="
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
To: linux-bluetooth@vger.kernel.org, simon.mikuda@streamunlimited.com
Subject: RE: Bluetooth: ISO: Release BISes left open for rebinding
In-Reply-To: <20261122201356.2854729-1-simon.mikuda@streamunlimited.com>
References: <20261122201356.2854729-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8606115593259809460==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1218952/

---Test result---

Test Summary:
CheckPatch                    PASS      0.41 seconds
VerifyFixes                   PASS      0.05 seconds
VerifySignedoff               PASS      0.05 seconds
GitLint                       PASS      0.17 seconds
SubjectPrefix                 PASS      0.05 seconds
BuildKernel                   PASS      20.48 seconds
CheckAllWarning               PASS      23.39 seconds
CheckSparse                   PASS      24.76 seconds
BuildKernel32                 PASS      20.80 seconds
CheckKernelLLVM               PASS      22.64 seconds
TestRunnerSetup               PASS      486.48 seconds
TestRunner_iso-tester         PASS      20.18 seconds
IncrementalBuild              PASS      19.66 seconds



https://github.com/bluez/bluetooth-next/pull/1197

---
Regards,
Linux Bluetooth


--===============8606115593259809460==--
