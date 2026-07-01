Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52AD83BED08
	for <linux-bluetooth@vger.kernel.org>; Wed,  1 Jul 2026 09:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782897199; cv=none; b=WTAhKXYwMD+KXAIeajSKcwgLzRRSETM+/eLSHOeqxpt/QNRVKgAcnZkEaxpFOQCMCA4B6C+JzPjQDGtmnLFmTqxTWCfJffbhVBFK626G+8577r9V651kbrnizRb9zVOg4A1KCXgZtAmpZqQB6H3+1RSBoWW3U+n1XE3RcAgKbNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782897199; c=relaxed/simple;
	bh=1BtVrj+I7ULA9VHQ85OdzhVoUNNIjE8F4Xf6FogYYR4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=MsA0C6Q1zJco+IWkgjj6e2zrC8nDW+i3bbyEI08fNrHvmTaspU7CIyu6fHwuyBvKca3q8YFHGzLARVzyONWd/yDDHCKYziU5zx/H4xIJ5xwSDDEFyVJH/wO1Z4/CmxQKh2wB0LHQ9Yhc2fUQiN1n9e/CoS12hVIFRNnYHH7ht0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nzj9NRRM; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nzj9NRRM"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-30bf132969bso521820eec.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 01 Jul 2026 02:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782897197; x=1783501997; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3tbPAcPFUlYLSWx1Uyp/z7NgoEF0Fs6UohbmBspMkuU=;
        b=nzj9NRRMhmzpWmgays/xh2vKHgikJwEDYoIXC8wrel9e8oJj31eBT4WRFe5BSwd0jI
         b3OfJCqE2jnszVhgWa+bg3IkhQSzCstDfpFzneGLp37V7rcO791Y7gBwqPrmwr/5d25g
         AdjfB0IVxLCQBSd6Rfm2Uji9Yg1Aj6+PuOjk4y4T5aFrMHiPoym4xbvV8qWjC36sfF5p
         mBBHyLGSvPWCqxN4SU2G5od2fW7qmOb0Adn7Xeq5+ygK50w+KnMcc0YbXZHHdDnm9cEZ
         Bj0RKgQ9W9FDB1YPZJk4gWEUTTRUyhZiBUzA3gK24RbRMxAYExe/6tEzg9uEJMm2B6dW
         IWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782897197; x=1783501997;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3tbPAcPFUlYLSWx1Uyp/z7NgoEF0Fs6UohbmBspMkuU=;
        b=NMI8pqhPqUgHFIVvF1YKWnMD8ejH1g6X7GAGseQqFQXcdt2kAncHVSFOwuOeMLpp4c
         tH55xhvngTMfPWVsPo/AhQ6Epyu3rvX76qr9PbJFd6CU/3vogqIdH6UeHCQC96wuuuMy
         lWsHfMWcpd0HAIuvLf0LptV5rIKGMw+VLMHEnIg2E4qixRrKaw947fIsb/zs1/nSR4Py
         KNUeRd5Uw5Ty86lwBdTAUXhPKiPlpI7ICnT7mNGVdwYVHx32d2vIwycngEgyHRNarPXJ
         2MawFkM47GsYWJusspDV0PUj99pvNFH++aToHUmbHuozklFpVAm2gf1KRzvGSlFtRj9L
         MXpw==
X-Gm-Message-State: AOJu0YzH70Ahu7vDI4xT7Kwwyt3I8Vbms5l49+7mO3fxq3UV71q78M10
	VrUJ1v8XTuzFtRK2aXgWLgEOhAi9MuZY2Nq/3RiuIQfLRQ0gCK3TeevSCrLilA==
X-Gm-Gg: AfdE7cmqdQnaLfWvKoHg9ucRlXcKXKjMakxjip2/rDYZZgVMYPFkWr/34+HrfAYUO8W
	q0XmoKdW4oHC2xy1WSN8JT1Y+jipRi0VQfPLuwt7bG+q+EblU5eZWLy2IFjp2xVcLGSbMmi0cqI
	/d1xyOlediVvwh2fAu/1Ke+0yh/0guFLxtopW91yJp5o5cmhZOQfqpCIMNxoUat7Nv9Q1rLZPck
	WZlMEKEAsZLOhyCJRna8i9v4y08eLA4zHL+tajc54NhEb8kgu27AAaqCe3Ia292FONxgFAxVwXt
	5z3hluyaGX35iE7ExYjADUO7FL2tIWq6q6BBIJb3MRQ6nmdU29Yf61SytphzGMzJ6kBaqrwHB1W
	/4TpmU9Qb9eTrO6a+FcdmAtXV7TqcZTUlIDraxeEMy0TIGH8d4lmVO6ESH2Qp1qluxutq8ZfCXq
	dtMWOFXzx2ZsnVyFfhaNY=
X-Received: by 2002:a05:7300:6420:b0:30c:536e:3a87 with SMTP id 5a478bee46e88-30eff05464bmr912073eec.3.1782897197252;
        Wed, 01 Jul 2026 02:13:17 -0700 (PDT)
Received: from [172.17.0.2] ([128.24.161.17])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ee300e4a7sm17367035eec.13.2026.07.01.02.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 02:13:16 -0700 (PDT)
Message-ID: <6a44da2c.ac469dc7.22d7c7.86d6@mx.google.com>
Date: Wed, 01 Jul 2026 02:13:16 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8879210692122911116=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kaihsin.chung@synaptics.corp-partner.google.com
Subject: RE: [v9] Bluetooth: btbcm: Add Synaptics 4384 chip support
In-Reply-To: <20260701080138.3786003-1-kaihsin.chung@synaptics.com>
References: <20260701080138.3786003-1-kaihsin.chung@synaptics.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8879210692122911116==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1119519

---Test result---

Test Summary:
CheckPatch                    FAIL      0.90 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.09 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 PASS      0.08 seconds
BuildKernel                   PASS      27.59 seconds
CheckAllWarning               PASS      30.11 seconds
CheckSparse                   PASS      29.78 seconds
BuildKernel32                 PASS      26.70 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      515.07 seconds
IncrementalBuild              PASS      25.92 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v9] Bluetooth: btbcm: Add Synaptics 4384 chip support
WARNING: DT compatible string "brcm,bcm4384-bt" appears un-documented -- check ./Documentation/devicetree/bindings/
#165: FILE: drivers/bluetooth/hci_bcm.c:1595:
+	{ .compatible = "brcm,bcm4384-bt" },

WARNING: From:/Signed-off-by: email address mismatch: 'From: Kaihsin Chung <kaihsin.chung@synaptics.corp-partner.google.com>' != 'Signed-off-by: Kaihsin Chung <kaihsin.chung@synaptics.com>'

total: 0 errors, 2 warnings, 31 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14655389.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found


https://github.com/bluez/bluetooth-next/pull/378

---
Regards,
Linux Bluetooth


--===============8879210692122911116==--
