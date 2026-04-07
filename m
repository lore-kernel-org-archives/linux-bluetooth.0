Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0983C3A872C
	for <linux-bluetooth@vger.kernel.org>; Tue,  7 Apr 2026 10:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775557517; cv=none; b=GIjNF6kTB9U2UpXoDxEgnUUtlktxMuN7v2dwxLkK35F1QeOKJMQMGoNa4v3pHaDVm8m6EPzg+7HcFl1gNDymQ9E9t5BlYpnRPlRPQsmyxRE5EQoXgTY7vuTT2xuETGs+LcNMSb9bIfj+1Gr1saG0s9JtEXSNnMak/f04HIS/tzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775557517; c=relaxed/simple;
	bh=2A6OQL8RezmS+kZvWWaZ9SsogD51Kkgult/n4C12Brk=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=raDcCPp/1Q3Eebe4XWCbKiFY8RaBGE/blkWuMxWx3zkWmVuOh9B6Z4+k+iZViXECdI+lDsyrByUcU1ATXdt4869fK5VpTYawQ2nRjtx41Q1QeIRmHAB7/1zGHvC1QOc/uM5NyJLkybOBleCkPL0LGkvz2Km0v7VHuXQW1H1VsCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fuJCvW6o; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fuJCvW6o"
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8cbc593a67aso497972285a.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Apr 2026 03:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775557515; x=1776162315; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=L6YKizvzek4GavyjMqe7DxLAVe5MrWZPNYpQoLxyAhs=;
        b=fuJCvW6oOdR1v62O0WA7BhqE5X7Wy0CpoT8dfIodh9J04MuRj6jzWlJSk7SIERxEVA
         ku59R3dVyEW41o/buVMFm2c8JijoY8nviPZzntGxTNUcVSPFR8X42hbKQgblhyS4KeYS
         fvKcxBlO4Bthz1Kp2vNCw8LcS9jWMyJU41pV/mR3ULPfXFrntp7IM9JwJFRsp5KGhVfH
         tviOW/8j67cM1h16wD9qsfeQTufaKNPWssx4flPd/detNszCWXXRQa/Ln5gp/1jlTQ9y
         XKF5l3s89nBrqm9w4MuMPBP9Be8/3DdYX7WdpiPgY7M71tdn9VIzke4u72v2OLGDKFJd
         az9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775557515; x=1776162315;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L6YKizvzek4GavyjMqe7DxLAVe5MrWZPNYpQoLxyAhs=;
        b=pdhrO1bzIf5Ko7ZpuE2/1pvxHsGGuyP6PRmnYM/QCAxRht9uuC1/MR7h7UI82mfLIM
         N+o09P/36DyUuyAiXl/9kTDVE5KmhEFxBYjz3wL0lO+7LEtitwj58YGIz9uGQH6nCTko
         LvUFgJUAtPrclaSNDnov7CNMxoXJEf1o8F1Mnwyy6QiEytxMO+MxPZVSUHh1Lpsn6eNi
         rDYXSsnOTz1ru/TRtiM+0UrKH10KXAtcLAZXyBNs2b2XO7StOMhj9l/uKQV8TWQyK4cE
         g/GwMfc/MaROxJp9WrkCP5AwxIB7Bv8caNYr1vfTQC+IkgXL2nz4jCyvFWUZN2UgACk/
         HYTQ==
X-Gm-Message-State: AOJu0Yxz9lbcnXCR9m7saSuqkOWkvt2PTngSzkbHsJXgtOPNimlGFR9q
	gBNr+GxIu+6G2VGPX7Zw8cPRiFCELH5lj3dNeNrCqEbgPz/1/25VUyS/c7Ptmg==
X-Gm-Gg: AeBDievZZp7a6EXeMeZZU/SZ3GCE0gyF61uIDJYpQ9auJKN1dytBYPyRvZtr5v3N0dQ
	KaB3ZvVzhWCQ2B0mFDVYKOvXHSn2H3Lu03SW7BvtWjChDsRk/ihvou4hU/3CR+CzkpbtBIGESJM
	Dt3E8uobKksI/rRRklBM68+TeG6G7rt+v5uYB05fpEdGusXzBEJQ3daRfbREF3nfeNsin+LTJ2v
	TtYcnPRaKwUIRloMGVA3kqsIg0I+47blxwKIosGJsE2QCPPdG3mtnWYTVuRzrDH63UsbzCPFtue
	jCGe7sJfhHKWGN7BV4oifmUBmXuGuxY/1GNvYSaIBggthAnro9dPLmqTJRShRhbMMFEHsabBSJv
	SK3PuSxDsuBFp25Ds8/LSrKxPJr20NcX4NAT6zEyksbKw6mKJ0V0ri4JcWgGlZ/UncG3E1WEKq3
	/xViDEJ5ZE5yhljbwaqYC+43ptT8y63M3NwynwNuRi
X-Received: by 2002:a05:620a:4050:b0:8cd:8f94:258e with SMTP id af79cd13be357-8d41e537481mr2338731185a.59.1775557514658;
        Tue, 07 Apr 2026 03:25:14 -0700 (PDT)
Received: from [172.17.0.2] ([172.172.157.5])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8d2a5393a07sm1281259085a.4.2026.04.07.03.25.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 03:25:14 -0700 (PDT)
Message-ID: <69d4db8a.050a0220.2d011d.8702@mx.google.com>
Date: Tue, 07 Apr 2026 03:25:14 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8754485965283044147=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, kiran.k@intel.com
Subject: RE: [RESEND,v1] Bluetooth: btintel_pcie: Align shared DMA memory to 128 bytes
In-Reply-To: <20260407100240.757910-1-kiran.k@intel.com>
References: <20260407100240.757910-1-kiran.k@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8754485965283044147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1078050

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.30 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      26.33 seconds
CheckAllWarning               PASS      28.72 seconds
CheckSparse                   PASS      27.87 seconds
BuildKernel32                 PASS      25.58 seconds
TestRunnerSetup               PASS      569.48 seconds
TestRunner_l2cap-tester       PASS      27.94 seconds
TestRunner_iso-tester         PASS      35.81 seconds
TestRunner_bnep-tester        PASS      6.38 seconds
TestRunner_mgmt-tester        FAIL      115.46 seconds
TestRunner_rfcomm-tester      PASS      9.43 seconds
TestRunner_sco-tester         FAIL      14.24 seconds
TestRunner_ioctl-tester       PASS      10.19 seconds
TestRunner_mesh-tester        FAIL      11.53 seconds
TestRunner_smp-tester         PASS      8.68 seconds
TestRunner_userchan-tester    PASS      6.71 seconds
IncrementalBuild              PENDING   0.58 seconds

Details
##############################
Test: CheckPatch - PENDING
Desc: Run checkpatch.pl script
Output:

##############################
Test: GitLint - PENDING
Desc: Run gitlint
Output:

##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.111 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
BUG: sleeping function called from invalid context at net/core/sock.c:3782
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.809 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============8754485965283044147==--
