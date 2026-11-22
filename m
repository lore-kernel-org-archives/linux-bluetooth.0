Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795368483;
	b=k2RgO2GyXUfaT9fof5AyU1ApL85wd2TUplAsX5cQbl2S3i+wC0bcFRdtBsspmseoFgHN
	 Mbd1h9zgHiTHqbf7ZGNemGs3YJbHyF0KLHUgXyrNsa9BUVjo6imaqhcILg8cHORellyRL
	 evRD215dnejKYU6HPot+agmT39ltwXOU/gaWDWybrWtthlRb5BIa5WnV+BLhdfHAyzIb9
	 wT9MSy0fVmVE+yo5abCU/JMMZqB+y/QHAbtYCtYc2N+h0r98oAT1Qu+kz0CXEa9GCdIOM
	 K0/hhiraiMPEUbUy8B2ruvs8kz6OHzVNdYpWrVx+MxyphhvkedJrGspwP+CVwc4/wAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795368483;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 Content-Type:MIME-Version:From:To:Subject:In-Reply-To:References:
	 Reply-To;
	bh=xeRWH8QRcUUNPnNfLd2GHEZPnWOfBOMinnFZukmNySU=;
	b=UWjPSYDsW93257k+EXwOh3dPlMrPU/Q65ku2xYR0p7if1FEgeIVM+wt9GNERxC9tvbz3
	 RcYJiLrr+J0fredcsTjAsAlS2c+bXmQvqUFusDRDeFVlmniDIgCnLu8MK4EO/+a3Qea03
	 DMFOx7yVNSsIR1GxxfX3Sn+nCYtTAK6cwA6miweB0SQzVTh/04YeD+mOVaPUacGGx0AmQ
	 PIoGIEFMkYtnaMmino7Ih9hVOmqfkmljMtxdMTOilwFgP2efAko6Opj8/KELLqScGk2d4
	 Yd0OoSnYS6F3ls2iInkGr7qj3rOxdmBpCGgluNTpry4DNUEmIsSQNTkauRmX25fLRaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QBaX+ous;
	arc=none smtp.remote-ip=209.85.160.52
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A222606A32A
	for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 17:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A222606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=QBaX+ous
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-483d290f398so1513491fac.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 22 Nov 2026 09:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795368482; x=1795973282; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xeRWH8QRcUUNPnNfLd2GHEZPnWOfBOMinnFZukmNySU=;
        b=QBaX+ous4+ZTvWF1l+RshHhdHjcG8oMoeVzakkEbjRLwaVKQGk3ntxXrJSyN39y1dx
         yZmQVkF2F37sSobxURLlHC6/NbARNwoOdjK7VH+IIR+KzWVgFh0GxAYzIu+UuXa6t4S/
         g+VlU/q4kjpaYAfBPcDtgJ8M6JJh1xL+m3N2/jj27zw5StbjRLFTFt9LCNb4obVoG9Zi
         9qo0B1XWbEScR1XlNN4oXdSHDOqglsENQqb1RZDZyO2Yjf1VgVQfYUTjKRjCwD7ZqhnR
         1y5QRRF3Y0+xMVpDR7h+my2DNN8IEg2cDwlkC5d2pDC6vN8yHqKLPKpIwk93rByBg7So
         +AfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795368482; x=1795973282;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=xeRWH8QRcUUNPnNfLd2GHEZPnWOfBOMinnFZukmNySU=;
        b=pPeBymFFwQRlFq+NKAoeV2PvfOzUzTaT90dogtKqBlGfJ2Czkm67llkV6Vex5x50YX
         N/eja6vdxNGR5mBtjJPGys9paPupWrUZGODy3WEBiEkX8ptQfqNUq27A/PT91Iix5cyg
         R9BhOcneyMAGzpk4ZHhXZoJY30yVSxHlY0frtRTi5peFp0w9pyHthQTvC144tLqiuwhD
         +UOFWIF1nQbB/JeipFgTdPsJ4vFoy/djM8pJXajUJwwrNYiDs+B8hq/q7k2m8oU6zw78
         G7TDTFdMuDh9+u59bFgFypK/Up6XEqjOsIb8QKbPoHJtTvQNtE6PUq8Qk4obYUfb91Sb
         KXDQ==
X-Gm-Message-State: APuU4Z9NlaE1VBx/OHmmqtXrymynG6R1Wt5GXANKY4M/JYG3BuQy6IKb
	VFyQmg/PDT/EIbYb9DPK+qiDZK1FrQW8W9Pb7k5PxemfSHrglHrOukXMnh22Ow==
X-Gm-Gg: AZFdTZcyvIWROjmpLuc8d2/J7JU38dAWCkNTZFloWpK8PuIq3NmH2Z9dUW0HWYCtcOF
	8+570aoqjRJHNmOn82c/trrbCzawV3j2ml3452W2HXBBbzC47kQf11ILIr8I0n6K/wsqgtNtW9a
	ls6GSLxnwtVSgGe+Pq61d191xUQwkrB97qaINT7G83LYlfuwIzvLuyqs4EdOSsTnlgeGmZj+e2/
	haC32CL05r6hMi8hSuhRI0ASskNlgYqWRSEmXYmwfPMdsF4XoudML2dnOY+6/MfbBDZ9XDYACMX
	jKu1kxbuoNz51fY6igK/gFEaj65yJK56W4QE112YtR6IGi/e5EMS4pcmcFbJywNCjnQKzcb9k2B
	vjqRSU5Zd1NMivLrOAx+SZRP9oOojzowPbGwGQX8Im5aN25jrsyHDj6cDsrbAwtjvWafJiD92SB
	z9bIXRqm7AGOpncgSQJewHKFnspoG9gMPqawChj67OzRdD6bbNMjA5Dxk9iQ4n462x8FGj+nBuX
	wWBgUNPdpN93w0MZA9pFNYpmbRli81S4X8+icfrkktKViqAGb3do5RNQKUMZeGB+TrtCmeuyz8O
	s+tpp2ERtaE=
X-Received: by 2002:a05:6871:878b:b0:48f:e290:252a with SMTP id 586e51a60fabf-4bc858fc822mr7818328fac.55.1795368482078;
        Sun, 22 Nov 2026 09:28:02 -0800 (PST)
Received: from [172.17.0.2] ([172.183.135.240])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4bc61081159sm8738933fac.15.2026.11.22.09.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 09:28:01 -0800 (PST)
Message-ID: <6b032621.73f9ae50.260d4d.dc54@mx.google.com>
Date: Sun, 22 Nov 2026 09:28:01 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============0195300879905425454=="
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
Subject: RE: Bluetooth: SMP: Check the key size against le_min_key_size
In-Reply-To: <20261122153336.1527432-1-simon.mikuda@streamunlimited.com>
References: <20261122153336.1527432-1-simon.mikuda@streamunlimited.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0195300879905425454==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1218699/

---Test result---

Test Summary:
CheckPatch                    PASS      0.71 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.32 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      28.11 seconds
CheckAllWarning               PASS      31.99 seconds
CheckSparse                   PASS      34.34 seconds
BuildKernel32                 PASS      28.17 seconds
CheckKernelLLVM               PASS      30.06 seconds
TestRunnerSetup               PASS      659.44 seconds
TestRunner_smp-tester         PASS      7.12 seconds
IncrementalBuild              PASS      26.91 seconds



https://github.com/bluez/bluetooth-next/pull/1183

---
Regards,
Linux Bluetooth


--===============0195300879905425454==--
