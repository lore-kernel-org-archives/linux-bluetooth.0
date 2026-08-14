Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3415C39EF33
	for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 09:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786700517; cv=none; b=n78iUqbIpczfbfvmSNiDHbQDTEQ7mQHO8j5mSPHlpKOw5kU3gLNAgT5Pjs0uzcnIvfY+4Ve3sZAphcXjTzpgmjVZHh77fCMTM6IayHQipR6v9T0WwiNEOSA31uQntUqV9HuldrlhTWAO9W/maItwa3ZIHWvEUFn1Eh1qoGBCA/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786700517; c=relaxed/simple;
	bh=qL0nxc3JT3gg63mdy097OqIp0Bk94CClicbSPYM+scw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=g+ppvAtTS+eoHj3ZmukmllKI0FazpcvSTa3yBjSK7QFsUtIAWff+7OY5DtSPR2CimLKw17dOB/wgHjgsCqSEi///nWw/g7iUJAY9LwupFRDgarFVYFF4M+LWXwh0XiPG58xKY/EJ3o05eSoevijEKy7g/UzcAm4zcT8DTtsbsjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ptcFdSS8; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ptcFdSS8"
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-51c0ecfaee7so5506591cf.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 14 Aug 2026 02:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786700515; x=1787305315; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=8kM8wX13SKcM49GlVIAqPErYYpdpV+CBT8aDrisvJJ0=;
        b=ptcFdSS8zH6vtMAGN02UTXNWkLi4IbRV/4S+oNEIOlBGfLoqQrXsTyAZ3qnvYsH+rW
         Af5sna7p6rOKGq+Spa2mXA8egWBuB7swsg1J0MdQK0zRpPsR2D/l9Vl44sSxOcyQXyMl
         zk2ys1cnZtvl6HWDGi4FAm9whRcFV064U7YsXwleYuZYk9pCysEy85BPrI7FWjV01lUZ
         5H8N5jO++6d80Qjfer0AtmMML5e/ucsePRerLw5h+RWfGQM4hrK4RrbDLQ499sHMi0+r
         k3+QtAo0r7ijMV1khh4JEUM6FjGAUGwGFeh6epEtKWE3INwMViNfoo4lVR9SWD+KGnLS
         PA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786700515; x=1787305315;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8kM8wX13SKcM49GlVIAqPErYYpdpV+CBT8aDrisvJJ0=;
        b=NFOtFNzZCiVL5GecBNfQ/+7+qvUPHyBEyb4nqt1kPRDeOelLGebHkcfquEqIEn1FWm
         HzpCVC5CriGHViZYoOH5lql72gj1UjYKAF/brmHH3ye4UtaV2LgJaDARHYgoNtIjif08
         5vizW3jo4BnbHD/SfewbnWIaw8NCyU/SG6ggC+8VN5RtaNMYU4n0ejyJ6IJP68gMtz3G
         HTYgALNhX4+HmSL+9VF9K2gJJUz9q/soKjg4MK2dkgfv3kK0B6/6MMqkfjsDDws1p1gV
         j6EXT4y8HP/A4WyESvLCfcyOjmH4ijHBQG1P17V36B0gqZU+3B1Ol7aJjckKo7Din0Dg
         HmEA==
X-Gm-Message-State: AOJu0YwgYrbM4cIELbsvKsCNtjkNbJqkwGE3BTTgYRcBwjQG5Y4KBHJF
	LKwcwWdEk15Il7LEZSakzdn+JoqKR9X3OJVAKFnZp7XFaWd/4UIIYVs03qsp9A==
X-Gm-Gg: AR+sD13sM+SEBjL4QKLc+NiukyRHup39zJAiJMkZiak6Be4h4GXXeT1NI38FRn8eUa0
	BQBNfC8GGOccgXasEiFASC/9cqs1/lAH72bqHXalBvmgEBP1daN3BqeM8mePXuxwW1DTr7hUrwF
	ZyBI36vAr+QwJo10Nih7Yu/Y4XCDh7QmhTiyEdHiEqUJK7aPRWQqN/45c/J4vL945H8IWqyussL
	gEVM7Sk2V1pZE0ruHEUYbMC4XhdEIy8cx4cSgesznWZV+5QaR8X/J0oaE8Qgo1Kjp6dZoqIowES
	1NF0wsNl2jAJ80c/kMBJ1hdNKv/3rCLH4pIImXuPhMhvPg92+sg9pu52RpTfAe5Jgj9mmOHlqEX
	IxCbAEuUFYCfHwJMlzLl4J538XZHbdKnUmjhAG+HnedsCRX6W7jya7lkSxJ4zkg6jA/jSd6gIx8
	zzoZpNV5G/5EjWCib67yRTICP3agAuX/ywF7tzsIZPexhLwwuJEfYEfv9/kfzTHxHT6TFh
X-Received: by 2002:a05:622a:1811:b0:519:fca2:346a with SMTP id d75a77b69052e-52d85439d3amr47596571cf.23.1786700514901;
        Fri, 14 Aug 2026 02:41:54 -0700 (PDT)
Received: from [172.17.0.2] ([172.190.102.82])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52d840437f0sm17332681cf.18.2026.08.14.02.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 02:41:54 -0700 (PDT)
Message-ID: <6a7ee2e2.4e600794.4530c.cddb@mx.google.com>
Date: Fri, 14 Aug 2026 02:41:54 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5679894122396978530=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, ali@iusegentoo.com
Subject: RE: [v2] Bluetooth: btnxpuart: Validate the FW dump header length
In-Reply-To: <20260814084110.920879-1-ali@iusegentoo.com>
References: <20260814084110.920879-1-ali@iusegentoo.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5679894122396978530==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1145953

---Test result---

Test Summary:
CheckPatch                    PASS      8.64 seconds
VerifyFixes                   PASS      0.14 seconds
VerifySignedoff               PASS      0.14 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      27.85 seconds
CheckAllWarning               PASS      30.62 seconds
CheckSparse                   PASS      28.89 seconds
BuildKernel32                 PASS      26.76 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      506.96 seconds
IncrementalBuild              PASS      25.54 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/581

---
Regards,
Linux Bluetooth


--===============5679894122396978530==--
