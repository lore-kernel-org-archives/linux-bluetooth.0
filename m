Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313363B14B0
	for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 07:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787298112; cv=none; b=nEzskGmqlshMWkEjCFO7INGq37m9hKxEM1Cm2ROHpYmkK7MT/Y413n+2jJibL3q2Q1QuhJ6d6L2Mpr7CHL2YkkYob0AcAGeNP6sEeHFCG6epdsHR/zJeo4RWEUleVMdKdgOM1cbqDJhUcbaIddKvUcSF9/6jPMRYMDMmzhYpBXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787298112; c=relaxed/simple;
	bh=WCHVsnz31oxU5Dq8a378ZTfR91wi5eIwZ8S8o7XqXg8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=C1fcc3vBjfGpAsuE+ubcTmaVA2pB9f4d8vQyw6V7eyDgfMcpxlxrqX4vnftz82OCgkgsrn+ZhwfrESO21uQkGe9eDysl5HyAjot4kbeCvCTfmgMuY9Xi4SJF1u2OHvjBRHxYDqDa7lKbcd0SFqGDFIVGwDG3UizCiFXof0pFlvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lo1pohvA; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lo1pohvA"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-93703cc9e2dso32169285a.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 21 Aug 2026 00:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787298103; x=1787902903; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=e4GKEjd2fPrMcQoW9q4btiGjdOASQfj4Kfyb/0HLx4I=;
        b=lo1pohvAeyWDQmC0/UmfxOz5x1BA3c7hDU2wBif8YIadA/A81FH8U71iZuqgbPQX4u
         95VjahSCrJwwkdG6/VGEcvNMYVP+jSQDJauIpWbRvyJqoftOBy3KoytnJARCu+Gdpu5D
         q2PQhkDnAyfdWT5HqpVIff21dj7KXDixnVt0lEfCdYA7W0C7wAd1rUiSnVpZrJJLiyvZ
         S+f/zBkD4CiJLqebV/URhj0qo+wMTFcSYAXRSp38Lrm1zHf1fJG8ChOsWlwjQVA6vpN7
         e1Iz1bSmh8sLi24xTkDLIqfwFek7p2yS8gLzcbbfQpPPS9hY27QG/x7RP/beYJtT0tLo
         inNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787298103; x=1787902903;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=e4GKEjd2fPrMcQoW9q4btiGjdOASQfj4Kfyb/0HLx4I=;
        b=kFudHwKT/otihvO0y9kGuT18Y/r/zwpOivMbgR/q44I1mtdkZKFCmjQwRh4yNSZmLX
         NC6bGujKqQ7l//BO/ETJsPJ95wt0La1Sn7bgM7M895zLchfKLF2dG4BNJBL72eQusfpJ
         zhrCz6APS95SpMQ8QFnI2Puiw6A8OlPAFl4j8+x793TSB5DrGlN14MsSpCMZ/07sy8hI
         B3T2/G2c4WfAnnlbXCyxDD0MK7DdkWIqMBy/ey/ZnW1iDGGkK5KORxfGAKKvoZKW5koL
         6CDQHiJS0goK4WvNJRvK7ISDviGfWDM6XS2/7oOD2jwGFNtkPR2GTXXrpbLMjkNBtKp5
         ZuDA==
X-Gm-Message-State: AOJu0Yye43/D90bntZliJpF7WuJ3tPcKc18Mw+XzUmZA9bhxbXbVLZEm
	Ma6Z8ecTAA+uqXDul39cqxvlE+c6FUI8PPT3zw8Z1uB2X4xkoXlvz3ONNc8uedKZ
X-Gm-Gg: AR+sD10SHUNlfIheeDIW/WOuKkR56Z2S6mYoymG/SiLp8jh2dp2nTN1csqHD24HQnj0
	re9r8zWMxEr6omdUaI0bnvboQGJ3xQf7MTJDR9SK75h3XGbnp8aCcRgq3xcGE0+DOTFjD53Iyvu
	JIeL3Tza3kp1bT+DBioq7eOhew6CZ74ulLLkcEvhUj1n8cWAnBgPlLHQ37zsR565am3LSn5OZyT
	U/QleBFQ/C1uBs12q+vitIoIAyEl4AdPbr2JJVehsrHQT+iJR2ah8MiFq8fw9Y59OoeCVWrKmbv
	Qb3JiF+IzkuYoohVo7XUCQJ1wmcwFv4N7Ice9YfknpcZD4rUYtcs4RrlEd/X+veWodRmvzGOllC
	ObaoicnhzNnUmzv0cNE1VaOEjAu8Efa66Aq8ZaJgR+vR+JT3ZlPZcXvtkCwgxWRBl3wOEMSktLs
	xQRDJZNZsfU4Ptmx90E34WqwU+1lj1YgHD5lH2zKNEmKw1a5B0NGQTV4GYOhuj1zBoyQ==
X-Received: by 2002:a05:620a:3198:b0:937:13a1:dee0 with SMTP id af79cd13be357-9373944fe40mr341346085a.5.1787298102769;
        Fri, 21 Aug 2026 00:41:42 -0700 (PDT)
Received: from [172.17.0.2] ([20.161.78.66])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93720582197sm530573985a.34.2026.08.21.00.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 00:41:42 -0700 (PDT)
Message-ID: <6a880136.64b4ec9b.74772.ec79@mx.google.com>
Date: Fri, 21 Aug 2026 00:41:42 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4769161708491752266=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, liujiajia@kylinos.cn
Subject: RE: [v3,1/2] Bluetooth: btusb: mediatek: Fix leaked runtime PM reference in reset
In-Reply-To: <290cf3c065ebee3d1dcaaa4e805e1875d0f999e8.1787292206.git.liujiajia@kylinos.cn>
References: <290cf3c065ebee3d1dcaaa4e805e1875d0f999e8.1787292206.git.liujiajia@kylinos.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4769161708491752266==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1149487

---Test result---

Test Summary:
CheckPatch                    PASS      1.43 seconds
VerifyFixes                   PASS      0.13 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      0.64 seconds
SubjectPrefix                 PASS      0.24 seconds
BuildKernel                   PASS      26.34 seconds
CheckAllWarning               PASS      29.44 seconds
CheckSparse                   PASS      27.72 seconds
BuildKernel32                 PASS      25.66 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      477.02 seconds
IncrementalBuild              PASS      26.93 seconds

Details
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/628

---
Regards,
Linux Bluetooth


--===============4769161708491752266==--
