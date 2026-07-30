Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8B4399003
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 17:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785432041; cv=none; b=RgBsSo29ywXhRNLWVt9bcd5Ppv0fjgCM/b7pzozgtSrI5Iny13JyRRFQ3mkF/0XwyKqZGcGLrHy9BhgU59/1A0l738dT/tQLwhaxqgjRBXSAprquyEGSfj8SWyyhI+t+/LcFQ/or5P/Ak9h/V5wMXiZ9zpvVQGsnbmhYZtRggVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785432041; c=relaxed/simple;
	bh=FoBndWnkx3bHnMVCpeEdK7uG0iwJ7A7Re4W1fCzE8Yk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=PH4JKw1BeQkIgXajuc/1v754rykFTU2h9fjSBYQDRlZ+IfuHDxn8HlHbCTl7MurZ50rUFBGZQrLJSy7V6pAetrCJylQUEEQufxSOq+t1y07RPJBTNsVIZfXfjk+K3ex/ntNAZ+S8Jl/hR4KFK80hV6p3IowY19b6/JveiuzJT+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7PuQXn1; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7PuQXn1"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-ca12086c06eso41776a12.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Jul 2026 10:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785432040; x=1786036840; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BXlM9a5Pge3PM0rve/B8EbegB+uQKXYZMNZNvXLv128=;
        b=W7PuQXn1D/lIMKPl9ithpe3H7DRvHq0f0pyw48n3+fo1BmeSYfH6W2IgA/xRT/Rd0z
         pjoW26XT2qR4LfeJhDhr1iRvZXrQjqU0CkCtUFVpU3W0eZGrZSTeaey3Jbzi2PJPVFiS
         GBmMGuDzlvZDbci3X0ZVakESFNSMw4EbfH0qjdGauiYfSdIbN/Mzov2XjtzYu2cNhiy5
         zCoka2ELQdEZz8xgWhEqjI7pdbGDTHGpjNL8zZOAQD3zjGAsKpmMKyS5VMPebxvimEnz
         p1PYsCOizdK7nv0Wg5EC0qKcY1TJ4zY7DQJUoYi4PLfm/3PaQYXM+uHk1Oj1pIMvqhyh
         sebw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785432040; x=1786036840;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BXlM9a5Pge3PM0rve/B8EbegB+uQKXYZMNZNvXLv128=;
        b=NvsWa+kyioe1cQt9eKNCc6hhs8KaQikFLgkVIefpGNN6+PzcTjlHai8DudiJlyZIxK
         0tqv1k/SvMPaeGHgT2H7Sg1LD1nGN60yxbH6/XhvPvtJo6pzUKJzyjc+jIYe/B+gP13l
         1/lgFhccC4MkMijM0NK5aw4mz9laQjbgpv7Itk/F7EFd4bl8LpoFBFlVgn8wYxuHnGxP
         sjXlJuB7XTPmcGiZ3BOqfyHlIlGHhtG9OzZUH0r22YXhjPqM3ov5JEDLoS/m0ja8Elkj
         S7C19cYvBk8aOau0o936MYfkCcHeP/RXfQmMNomQHGKcXqaMBlwc5YoG7luSnSnHA2Vc
         C+nA==
X-Gm-Message-State: AOJu0YyKy5CROW4QVLoq/tyW29gv9TeY5AZFK6RT8KLyZEqVN5PgElQC
	6UgO8wR7xeBb/KYyYuW3dFRO3rNslHPn79VKaxK5d/nEzTFdAfPUZBJX77PntQ==
X-Gm-Gg: AR+sD13+aFbWz+BLYckPNfSJCLzTJBzZRtx+gJEs+QmUa2y54r8KWdCzHKS2S7+i6P6
	l/mMDMOYL2Xun2DljRgyvHHmFqDyHiwMtQ5QPtS4tN9mNvOuuLiicuSOrYpQtq45p0/pryasXIJ
	XwVM30JCGenfYzYiHaOgaTbsP7pOEkI5XOxeu48oDnXMnc+bXVdZTj3cVaWPpuEgCte03hktFLs
	ItvgKjmofRvXm8gn/fqhWAjYGXYUu3SnoRRmbjxZZXF6u+ss8yyZP3djSv/fcelKou6g4MxEs+1
	I68Awe8+v+YzUBagjsh0HQO3ILA7URU1i536NG1VjNo6rmkMcjzLbqBAbOQQKngjTSu3/R0SgLT
	EwEeBchrFG3ZUXVqWCfLCdGWVFt6Nn9HUnKhiNG8p9ggtm6680hTovs+vaYWF3k6u07mM8wLC7U
	LXpgoGsDB7B1AmE4MJipybu7MnE4Jl3NfZvS1zcev0kQvCUgvYIdJ8r47VpLenrpBOq69/2XaY8
	SiD
X-Received: by 2002:a05:6a21:1f85:b0:3c3:83e6:c705 with SMTP id adf61e73a8af0-3c9008d2508mr3424625637.35.1785432039677;
        Thu, 30 Jul 2026 10:20:39 -0700 (PDT)
Received: from [172.17.0.2] ([13.83.161.83])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504b1246dsm21199749eec.2.2026.07.30.10.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 10:20:39 -0700 (PDT)
Message-ID: <6a6b87e7.7270d2fd.e7b35.b940@mx.google.com>
Date: Thu, 30 Jul 2026 10:20:39 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============9219614576693566492=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, acharyalaxman8848@gmail.com
Subject: RE: Bluetooth: btusb: validate QCA rampatch size
In-Reply-To: <20260730161820.11631-1-acharyalaxman8848@gmail.com>
References: <20260730161820.11631-1-acharyalaxman8848@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============9219614576693566492==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1137581

---Test result---

Test Summary:
CheckPatch                    PASS      0.82 seconds
VerifyFixes                   PASS      0.15 seconds
VerifySignedoff               PASS      0.13 seconds
GitLint                       PASS      0.60 seconds
SubjectPrefix                 PASS      0.07 seconds
BuildKernel                   PASS      26.84 seconds
CheckAllWarning               PASS      29.02 seconds
CheckSparse                   PASS      27.68 seconds
BuildKernel32                 PASS      25.88 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      504.95 seconds
IncrementalBuild              PASS      25.80 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/519

---
Regards,
Linux Bluetooth


--===============9219614576693566492==--
