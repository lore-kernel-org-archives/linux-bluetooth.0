Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1454CF49D
	for <linux-bluetooth@vger.kernel.org>; Sat, 17 Oct 2026 10:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792233170; cv=none; b=bPfeUdxLtJIjm09/0fQeUk8wcD87jxJaTSCwhT9hflHrcKYHRzFHIZGSlNqQPfI8PGs3M6RnMAuyS4VLBBt31F+qZt/wxo4hueUauxPD6MioIX2uUKvKiHEGC6eN0bWug3+xgCNdZj2u1CrllZT9Qik1ElX5zzyCUOyqGYXmttk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792233170; c=relaxed/simple;
	bh=KJzBV7ueDjnt7YHplQdPYgqhnVY8i6nuODE6pK9e2y8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=q9vRoJbXhxY+3R7dsuOwesShNv1X0ghj3pM9RSq0CKDCAWiGCM6y9CcD55O4K8bg0X2TBTCD4b1OofezxSr5Y6yumC/6hqvkj3RrzGEdX7FZqOOrOCfOJ7emQok0PiReArDek6BCnvJv1xffo1P4E7iPlthzt6DnLDulhLU4Oog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5ABrSnE; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5ABrSnE"
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-93f2b8cf033so63539085a.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 Oct 2026 03:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792233167; x=1792837967; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=gyY93KApVbF2JsxUH+KmIBLHCJpQzFKCqfXNEFBM9Rg=;
        b=I5ABrSnElveXkge1VoidikrxmuEb21OLXL+MXbO7EdCDT76grwDmjswQJcpHXV2Z45
         DwqSdw8PToX67GMtV94V5k9BkVKrxG7NYcTqbvjExE9r3mZJec60Go5tt4FMiZ+5oFmb
         I1VK8Z2PlwOkeVPEXnWqlS5zNBHEcJqnuq/0p0tDpXSz7ZFQdC1v0qIGlijSy9IHTE79
         d3CowYMpDa1GxhsMJiyceAmMGhP+yYcBTpCT4sshfY3K5gh+QW57OgRTBbicMDmJyw62
         dswhTPFf9DUmPnRuzpoJaIqA+rD4hb4DwFyDDY5xOSUxEHPsFWgmtoFE8D0QBLdLComX
         z7KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792233167; x=1792837967;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=gyY93KApVbF2JsxUH+KmIBLHCJpQzFKCqfXNEFBM9Rg=;
        b=Mrdoloc+GCx1u7Oqk4Ip55FjwJ38KqDEEvujMMjoe5HUt8DVNIoZx1p3LWwvOczQ/0
         F7PjT8qHlGnt36pQywA9urs+vnBz8BIrraOykZBrv/rHXG4CNrDSsXn8gnGeFwDOMrNg
         H5iDZihufb+ajcxeaerdIfOWHrbJEz7my/LfBA6k4llHRXCfKYe+WJSkE0kEnMVptE1A
         1fJOHMV1VlWXUQcloD5A6jW0myfUDYBvAiRi0Wfi92ISEvIZyvxsD3kc1aZnEvXURLVt
         9VASW4yej9TLivHDDpfyvkBKEC0HhBgR2LfvB8urfYxA+KeCCyG6Aqm3m6M7YqYe4jQK
         FDqg==
X-Gm-Message-State: AFq9FYK2aLyWCP990hgAAiAiH4awQ/mDWXndH1nEuSUCMpIPjmW7yoWt
	qftRnvBsxEBIB8al/C/5grt84PLgbI41IVcFDVsGjHUKKc6aUaCH29T7u75wZQ==
X-Gm-Gg: AYBFou18IcKFugNusloksi9/UzFpBgJqI+pmjUucbWKc6hduhuPMkZk5QBYQtrJYUtI
	Na3iGqG3ittyKw/BQgIXMB5/khET5jVHa7ByRadBpkEy/hnfwEJYtqzGbDPdUxYJn24/zna6QK4
	SlOfEp4oVk3FNxdXSV7yOlqkAyNMFcm/TQpws13eYqAp3hkbDEn/3mcf34pctc4ibqTPfwP25Om
	UvO8YbHjWQDyEGXYzkMpTeCjK5iAIuElcjluOSEP0d53rjwtnVczofvO142XCnzZDIhcuvQihVc
	zrI9zxQHsbVd4e463qdTEdbUw66xOCf2t5NIt9u7xD/M86mHWM4D8EktFfapz7QTSS3WEgYxVi7
	/T3XjNGZeVsPZX3RowtRDxUzqDUeggCgJmF6jqAUB0uqffPJiEt602oLCJy5s+MPsyHmLGk8Ruf
	ZaOKyx3HkxoEFYX0HG+RQWIl5y4d5DVp7ut3wEUEXmTk9iwXaoKzDfCH/gyXS7cJcJ2nfmsp40o
	u49rQ==
X-Received: by 2002:a05:620a:4402:b0:937:6c0a:9b65 with SMTP id af79cd13be357-93f29ba0aafmr393837085a.7.1792233167478;
        Sat, 17 Oct 2026 03:32:47 -0700 (PDT)
Received: from [172.17.0.2] ([20.83.158.241])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93f1a1850cbsm431106885a.24.2026.10.17.03.32.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 03:32:46 -0700 (PDT)
Message-ID: <6ad34ece.6cefb47e.247368.b6eb@mx.google.com>
Date: Sat, 17 Oct 2026 03:32:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2026495531725850552=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, daniel@makrotopia.org
Subject: RE: device_schedule_reprobe(): core helper and conversions
In-Reply-To: <4ffa0608d32b6a68e064b41b17b6d35096b9a7fc.1792203271.git.daniel@makrotopia.org>
References: <4ffa0608d32b6a68e064b41b17b6d35096b9a7fc.1792203271.git.daniel@makrotopia.org>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2026495531725850552==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/series/1187879/

---Test result---

Test Summary:
CheckPatch                    PASS      3.81 seconds
VerifyFixes                   PASS      0.12 seconds
VerifySignedoff               PASS      0.12 seconds
GitLint                       PASS      1.29 seconds
SubjectPrefix                 FAIL      2.34 seconds
BuildKernel                   PASS      28.99 seconds
CheckAllWarning               PASS      33.40 seconds
CheckSparse                   PASS      36.18 seconds
BuildKernel32                 PASS      29.23 seconds
CheckKernelLLVM               PASS      34.71 seconds
TestRunnerSetup               PASS      700.37 seconds
TestRunner_l2cap-tester       PASS      12.88 seconds
TestRunner_iso-tester         PASS      10.82 seconds
TestRunner_bnep-tester        PASS      3.12 seconds
TestRunner_mgmt-tester        PASS      87.78 seconds
TestRunner_rfcomm-tester      PASS      4.49 seconds
TestRunner_sco-tester         PASS      5.64 seconds
TestRunner_ioctl-tester       PASS      4.68 seconds
TestRunner_mesh-tester        PASS      5.54 seconds
TestRunner_smp-tester         PASS      4.32 seconds
TestRunner_userchan-tester    PASS      3.21 seconds
TestRunner_6lowpan-tester     PASS      4.39 seconds
IncrementalBuild              PASS      32.84 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject


https://github.com/bluez/bluetooth-next/pull/960

---
Regards,
Linux Bluetooth


--===============2026495531725850552==--
