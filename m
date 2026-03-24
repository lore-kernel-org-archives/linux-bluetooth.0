Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B503E1CE0
	for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 10:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774347200; cv=none; b=siendDDV/benhyVGeYB275INYPZLaofl8D4UYVTKsordRRohmOwe85VCiQ8EhC0+O0wXUrSIZxrvo7OeIZeWfqAY2BYhOBYQ6PFSn4nZcR0vqLP+b5sUjaCDbb/YGcN2lNm6N0J5DhR1mb2PQ4e63TLSHK7w9ahaFBUT2jIseDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774347200; c=relaxed/simple;
	bh=VYjTNCJBB+fq13wdFKJXRXVdgvYvURQ99SDWDzsX4nw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=IvjsggecVJt0t6FwI27FDVMW2dozp61NTKjgpOS0pPgw0RBCwTHTvymWxvYZVQWV077oiODL0TQhr3CWaCyrzjryoHea2HSV20KpSX526qAfmRygR2DZHIWADtJrYzOCvxDOsQtqz3kKJGuJGiVHlEBWiQ9zEb4wMwtHz5twzaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sVvFXs0L; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sVvFXs0L"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8cfc795ca97so97620385a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 24 Mar 2026 03:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774347193; x=1774951993; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7KIM55sGjYyiPtC80NTYnnaGfkCkLB90rGlmlOd4Y7Q=;
        b=sVvFXs0L3iOk980FQQqjAaA5ZExxYRUeItMGgNaQKNHRWNnoIOYhdIL2M9ZeTHzKjE
         ckiWgzH28uMNEg5smsQ3VK6qZgb/mONj600+P2uDBo3TKTxs1mHRsxC1dXMShZDPaSU5
         u0oAcN77BfxDocm6YucpKrEqoauRC4P3Lwl5IqJp6ZqoqXq9OisHO/eyVCYREIBPFdck
         J1UIVBnhGx6wtgceHDSOKExQd5nv4nmaF0OYkOI+lnDzYxeOWpum8g7GRNiswSfDItWS
         MXPYyw9RPHtIAuOtIvsjcVTK4jy1HvStWsY57Z/FwhvbtRkRbYdkHaurXcEhvYMV6nUM
         sBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774347193; x=1774951993;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KIM55sGjYyiPtC80NTYnnaGfkCkLB90rGlmlOd4Y7Q=;
        b=g+T57vJfd/UbZdOHNZ3QlW+pq1TCpw+HGRbGIopPWCRDN2Dd0zIlvjvmK9Tje1Z08S
         HUpD8zYI89b18NYt6J1sUqsbCXje6FJZPijQXu1TgON3ax5DuzGrwffaUrGvPiLWJ3Mn
         Jsk1ZgrmOQTS9fD8lVm6r9PGJY2bFO6q/naclqpF6u9yLIKz91TIp4uxr+LTvqSveXxA
         qaIZjaE/F86MvdIqLiLppsc3x2DyrJUVn1NEKfCS6Vi9TvUChVAmXZPQDPdHblDZWPJb
         z7+LK7LmC3kmy2dOWJRMTpyTB+Qo0oXBvgUyXIYY973uOGOSjwe5m3sP/01yskxS75P6
         iJUQ==
X-Gm-Message-State: AOJu0YzXZk/WrBRE/wMCs1/4X6E7fz8UgOOqig8d1C92K7ZqZPSBKv8I
	SRuUWAhaYBIUukrHOxc5s2TPI3nI9kxH6cfOVy5DXmakgYDBR9mRoR3hviJrEw==
X-Gm-Gg: ATEYQzzHB5n5EBD2LzzitTL2UiU3celRa0lsQPMuVGJIxE3qPMjglWpa4rvstWIa60C
	fbQTkdZ37CS4tUkPEvb+ktkWY5xy/+QorrytN99XYRl+bCSJIY9oVFnJhoGpql22/xV46jvJ/qr
	KAuZUgTabAXSOne+7MtC1GWI6UVPLBLz4zCHZJORasRMXLRMKeou+CQC91Vtshb2eQycMa7kWhh
	/32c/53YU/dIqp0NL+HSbNkp8LoP1BTy7EU3sguEUe3izO66F8VAdxTXVi7mG5b4tSGrbzAPQBg
	zNBM/V7aDGqK18u0nUKqsxjC6ggs62xPyg4AXtTG+gF0SVLHSAp5Ma6tyvgebaUyGgOVGQVocnQ
	yuKL7En3UfoISz/nX/M/xEVzP3QPmItexkC5Xo/YR+MG5r15ZHVAKYlMTh+FBb4OomnlvHH9wMU
	0oj+QqwYw4dG4B89Yv/KxWlu8Hek+G
X-Received: by 2002:a05:620a:5e08:b0:8cf:cf0e:41b3 with SMTP id af79cd13be357-8cfcf0e451fmr1500612085a.35.1774347193103;
        Tue, 24 Mar 2026 03:13:13 -0700 (PDT)
Received: from [172.17.0.2] ([52.179.93.130])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-89c850f5fe4sm111697706d6.0.2026.03.24.03.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 03:13:12 -0700 (PDT)
Message-ID: <69c263b8.0c0a0220.1aba2b.9f3c@mx.google.com>
Date: Tue, 24 Mar 2026 03:13:12 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============4507578187934386031=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: RE: Bluetooth: btintel_pcie: validate completion ring indices
In-Reply-To: <20260324085143.74785-1-pengpeng@iscas.ac.cn>
References: <20260324085143.74785-1-pengpeng@iscas.ac.cn>
Reply-To: linux-bluetooth@vger.kernel.org

--===============4507578187934386031==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1071502

---Test result---

Test Summary:
CheckPatch                    PENDING   0.44 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.16 seconds
BuildKernel                   PASS      27.27 seconds
CheckAllWarning               PASS      29.92 seconds
CheckSparse                   PASS      28.32 seconds
BuildKernel32                 PASS      26.05 seconds
TestRunnerSetup               PASS      579.91 seconds
TestRunner_l2cap-tester       PASS      28.33 seconds
TestRunner_iso-tester         FAIL      33.32 seconds
TestRunner_bnep-tester        PASS      6.54 seconds
TestRunner_mgmt-tester        FAIL      117.04 seconds
TestRunner_rfcomm-tester      PASS      9.65 seconds
TestRunner_sco-tester         FAIL      14.71 seconds
TestRunner_ioctl-tester       PASS      10.49 seconds
TestRunner_mesh-tester        FAIL      12.61 seconds
TestRunner_smp-tester         PASS      8.83 seconds
TestRunner_userchan-tester    PASS      6.91 seconds
IncrementalBuild              PENDING   0.81 seconds

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
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in le_read_features_complete+0x7e/0x2b0
Total: 141, Passed: 141 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.113 seconds
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
Mesh - Send cancel - 1                               Timed out    2.733 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============4507578187934386031==--
