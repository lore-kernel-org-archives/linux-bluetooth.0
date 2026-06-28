Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9EAF34E74D
	for <linux-bluetooth@vger.kernel.org>; Sun, 28 Jun 2026 11:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782647851; cv=none; b=CjC9P/olHl5Cd8Q4VSVHdBQeHm7T8s0azvsraY2hR9s7196RbQaAT19edhDBa1PlUzBtn0DKM528uO+ZQwny4uOylB6Ix1W54dGn2shfMH77qxez7Q5uAd2efT2omCvGB4YGNw/x6Q1Wwo0XwZO9wgEExpvkJKzkv8ppMdhFe2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782647851; c=relaxed/simple;
	bh=ZZ08aOUUjYWK5tS+frMaMVv7HyK3SuTCszo2vf5A0U4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fIaXTTupNje3hNz7vLEZFK8fTUCmc69/kphQcB6CWg6quHtOhNjsHao9kC1Kvmmsic/dyrGx6ACNN/adZ0RnLv1cv6amMFhQCQ4Bg9Dgj8qiOjbVHLQiKuhSBvKBmc/JfUmo143Qs6LqIfUwnD57qUoQVfImGQ1FEwlGlZj5Vfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIZpBVuV; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIZpBVuV"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-30bf8b2bd20so5068735eec.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 Jun 2026 04:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782647849; x=1783252649; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AJbYeu/FcYz/MhPqnJa5BwtQ/2u1feY+IHl265l1Bns=;
        b=GIZpBVuVfDGflAo7MeZ1t4qkI4VJCZ40/QGzhIpM5gCMEMMueCP3gTeZC2EIxeATck
         fGNF+Q+0M44iQTRWs5JL0TvoA1QY8Eqc31EQPq+frGUwAE31r6ewMg1u+iI0wcrQ6giB
         QfA9aywfwFtciTn/26FuoK8W9fTKXNz2jRkQlc6fmEFfrMZ01RAQPqG89ndP56SAIIPA
         VpNF7hJ42sYGINPLWDL4GjHmGDmNgk6PhrQSfRZdN7wcnsPtEtO7YzJqSrM8p7gMgc8i
         4oVGfrSBXyUeN8C7qm4Bbtv28ostwDGUUuJ+cu6sgwpd30xNPqogk3EuPd78I3SslDrc
         hZSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782647849; x=1783252649;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AJbYeu/FcYz/MhPqnJa5BwtQ/2u1feY+IHl265l1Bns=;
        b=BmXCXzojEU9mk3mp8V+uY2hAJGARJgKf+dB446wGj9GOZt/NgCmTbbiQp0IlQt57uD
         SMYgiWin+HTjjM8rHrHaaI6O8BrlrgfN9NBjX7sSHdlf5gGVW1M+gqrdwCBb6whmh5fn
         C3p9h4bsARfmgqlqNc6sxctqbwaw0VgVbLEfI6qt98r6RqdI45YLHWEG1LVaYG2bhVkQ
         3y2yHx+WSr3M+q/THyQLSpStOgY8pLjA5x3Lc8youfEQsbF9J2LUbrzRSfM4RhNmwEFv
         LMZJpbyousxjG1A3WAeAmzH4uCRSlyF/V0/Q7xJ0+eONYUvO8mYY/oeIVsXQ7T5tFOTT
         bSrQ==
X-Gm-Message-State: AOJu0Yyc4AtsitEgjEoQhx/clihrHySS2DV6yqqFM7KOMbTmURWrRBEK
	IL1zHVwr4jh4gsJrY3GfUzZyxLZVpy4n7U2HzMJlfUnw7u/wYR5LAGtdedAqtQ==
X-Gm-Gg: AfdE7cnb/fLwZwJ2I7fvlFbfHdB9vgVzSsHCMWvvMi+Lh5YttJd0A3HHInZKCiuacCD
	uCO3HrgFtyBHAhjeHmdP5YQ1UvQP4/ZnhE5hrHkNzR19E2297yw4ByxvoKdb7GWj8rKGBkSqseC
	WKkTywNx4YTa7dHSUdhfIlr9DQh5dJZxLdH1Zxbp53HOqIrY87tTI3TLFid9uc7fbW2NMlXJmOf
	Viy97fwnuMbpVQvoJfBuAnbHR9Un4YF67yrhG2cfsNklqONCUuNWtw5nZHZoQYIHQid2GoWhPtl
	lqNRUMI6CoEV2WRUovvxcHFigZtVwHuMJFg+0ofCCcBM/F3YjvfuTj2gF/ilnNYR4aaIQqE1gvD
	CxyghuO/TEnCkr20axq4UyXsbemuSFIFe4Jo5zJhJB9ej14QfOkt66LwcZCwA++bkRFIAcOf5o7
	+pLchCevjjHoGOY0W3zqh4z7uZCe39SA==
X-Received: by 2002:a05:7300:a145:b0:30c:38e8:54da with SMTP id 5a478bee46e88-30cab36a243mr8847367eec.24.1782647848716;
        Sun, 28 Jun 2026 04:57:28 -0700 (PDT)
Received: from [172.17.0.2] ([20.168.118.83])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c7ca87caasm34641681eec.27.2026.06.28.04.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 04:57:28 -0700 (PDT)
Message-ID: <6a410c28.f732ad81.10382d.1df2@mx.google.com>
Date: Sun, 28 Jun 2026 04:57:28 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5026762720170776461=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, hugo@whynothugo.nl
Subject: RE: [1/2] Bluetooth: hci_bcm: add BCM43752
In-Reply-To: <20260628095500.29810-1-hugo@whynothugo.nl>
References: <20260628095500.29810-1-hugo@whynothugo.nl>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5026762720170776461==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1117624

---Test result---

Test Summary:
CheckPatch                    PASS      2.08 seconds
VerifyFixes                   PASS      0.32 seconds
VerifySignedoff               PASS      0.29 seconds
GitLint                       PASS      1.22 seconds
SubjectPrefix                 FAIL      0.42 seconds
BuildKernel                   PASS      25.51 seconds
CheckAllWarning               PASS      28.00 seconds
CheckSparse                   PASS      27.43 seconds
BuildKernel32                 PASS      25.02 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      462.90 seconds
TestRunner_l2cap-tester       PASS      62.48 seconds
TestRunner_iso-tester         PASS      89.52 seconds
TestRunner_bnep-tester        PASS      19.52 seconds
TestRunner_mgmt-tester        FAIL      221.18 seconds
TestRunner_rfcomm-tester      PASS      25.99 seconds
TestRunner_sco-tester         PASS      33.52 seconds
TestRunner_ioctl-tester       PASS      26.80 seconds
TestRunner_mesh-tester        FAIL      26.10 seconds
TestRunner_smp-tester         PASS      23.26 seconds
TestRunner_userchan-tester    PASS      20.01 seconds
TestRunner_6lowpan-tester     PASS      23.05 seconds
IncrementalBuild              PASS      26.21 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.257 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.418 seconds
Mesh - Send cancel - 2                               Timed out    1.988 seconds


https://github.com/bluez/bluetooth-next/pull/362

---
Regards,
Linux Bluetooth


--===============5026762720170776461==--
