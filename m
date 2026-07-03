Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64138220F2A
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Jul 2026 16:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783095146; cv=none; b=MxcUFlcnW9mWGOje9dUnWMilz0VpmPVitK4Pc356Xq1MY/2zklvUZVvQD+5Xwakawlrt7t8tjjpolQ5YziAwhhtpAAyXk0/I02kn/d928R5C5QvAVX8++GRqpRNTL9JayhkSgQX9IOaNHieU64dxEnhzYJg7jkixtv5GBTdOJ9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783095146; c=relaxed/simple;
	bh=mix64jh/jKbx7U0WmZJMU86O7tO364SbgWgn85hNW2o=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=CdI/nJwIZ7l2tecbNKIoWBtXLjm3+8UtLLtxM4VOOjv6X90E9Rp/EwDqG2dHfPXRsxT9Ze+iRUkyI6RpfhcSVn5gq9zN5lECdcIGXsFWopu7gg4RmUCDTLpuKFrsKkFwOulS9fAr8LAjDkiJKjZIYHJfBEmRIukqdYz4tFfaI7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M27ILlwx; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M27ILlwx"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-8efef6533aaso5050646d6.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 03 Jul 2026 09:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783095144; x=1783699944; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FfzFyc+6w7ymfO9MubFp0hU/XXvUjaM/ao6+InCemdg=;
        b=M27ILlwxDZR9NwIHBagBLXvTQpAMNxuAp12rH7GnrWZK1MR773CIVTt079pl4n5hOJ
         bHHBl2QactTz8xwdnsr5MoCFlo2ElJqFM50zXPrmpHoZL9Z1TW933rBEEGe9WEl2rbIc
         n4lH8kBXjXEiKBbU1VPlJt/1b34GOxWsrAQuPOxk5Ocx7xsmMNCopeJYDdIW851Xb6xt
         8fWvuG1T1f0Fgi5dHcjUElB1xYpeMeThTanXK3PhiXn9HF4ze2vQlODmaBfocbKeVUAC
         6GOZzB/nlTCgfrYL8jpxrfRByTokuxMKBtrj1GCNcdnXS18z6M6xwoKsSjycHaRDYL06
         O8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783095144; x=1783699944;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FfzFyc+6w7ymfO9MubFp0hU/XXvUjaM/ao6+InCemdg=;
        b=LdaxKR35qFJRTGTK5XUzq9Nmx0Rvi5yjJ4llzFaO4iftPe2ctzLik+hP+gyQngura+
         FhyN4Stkb8MXp9IgkWOKjoQ5zZf42TSPlpP9kuJX9UtNIuMCLHxfohfkKZU+GWrHnQCM
         zIAY7oiv7IpphRdMy0xh823/RMXuL/yaDaPddT1fxOo3IfVnxRbLmCNwbq2SAWR9HqtC
         ue6nIv26HS2VeDvyEkIWOHJ4OHOpsvlrdlSf8Yjc0ZWsrbW3hC0bCinGelgPiKtvtMQ/
         sgOFooBIzguVSQoxcAipJe5VbL1gCwpEBPYI8PLOdXvxey3GvRAXflHv7LdOwgx/sAOO
         yIEg==
X-Gm-Message-State: AOJu0Ywm48mlxpafD+l7g0hog3Yoxf/jhN5JxPymiqg3X7KaWz+bnMb6
	UV/4I3WFFutAsbQysdQHzS0MteGOjmCGV97gz4gsMEcOh120gfUJTmUGL6jm0g==
X-Gm-Gg: AfdE7ckx0atcX80x1QeLYi3yHkALTu2g8hozkhRAlfHZiaKDXD459aH0DUCLFl8wxVV
	HVuFbK/S60JgXq30+exyWrFLRZ2Rv0iM7ciCkym80GGCa8eQHoPNpP/a4t1rmn4BI+12/kb+cqm
	PycbNbLycd6+XbGE+0x/hrTNz8Fjr0JI6MhKe6T9BQRuv3njvOLOIkPoNZbcPl0Q9dkKLkTNwfu
	6bYYr2hRgue//gyhpfeavFGENNkynfvFjDT+uwpXO5lCGtsCeX0aAqyCBbjPBbH0qspCsAoKT9W
	3R9v+MXajlzBmTUq2NP9V1XTMhPi7adS9Qbzsv/E9BDWkGXs11ZKMxo0ugn9q8ChpPkunROmSIk
	CgPtufDxxrlh0rByCzDX/kLXJu/ws/lbhJXb/QzETKPudBX8dgLe8YUV7CSrl8crrJ6bTbjKiMS
	uf+7bCqdDefNlu0lH/ATQwPpJ5I/BEPI8=
X-Received: by 2002:ad4:5942:0:b0:8f2:bbd:dd6 with SMTP id 6a1803df08f44-8f422685ecemr141317676d6.20.1783095144268;
        Fri, 03 Jul 2026 09:12:24 -0700 (PDT)
Received: from [172.17.0.2] ([135.232.216.69])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f472a9d8c0sm57678136d6.49.2026.07.03.09.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 09:12:23 -0700 (PDT)
Message-ID: <6a47df67.8bd82347.1f3390.8534@mx.google.com>
Date: Fri, 03 Jul 2026 09:12:23 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7708918989933539088=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, loic.poulain@oss.qualcomm.com
Subject: RE: Support for block device NVMEM providers
In-Reply-To: <20260703-block-as-nvmem-v8-1-98ae32bfc49a@oss.qualcomm.com>
References: <20260703-block-as-nvmem-v8-1-98ae32bfc49a@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7708918989933539088==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1121189

---Test result---

Test Summary:
CheckPatch                    FAIL      7.96 seconds
VerifyFixes                   PASS      0.11 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       FAIL      2.58 seconds
SubjectPrefix                 FAIL      0.91 seconds
BuildKernel                   PASS      25.39 seconds
CheckAllWarning               PASS      28.53 seconds
CheckSparse                   PASS      28.03 seconds
BuildKernel32                 PASS      25.36 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      462.87 seconds
TestRunner_l2cap-tester       PASS      58.99 seconds
TestRunner_iso-tester         PASS      79.01 seconds
TestRunner_bnep-tester        PASS      19.47 seconds
TestRunner_mgmt-tester        FAIL      212.37 seconds
TestRunner_rfcomm-tester      PASS      25.94 seconds
TestRunner_sco-tester         PASS      32.96 seconds
TestRunner_ioctl-tester       PASS      26.35 seconds
TestRunner_mesh-tester        FAIL      25.96 seconds
TestRunner_smp-tester         PASS      23.48 seconds
TestRunner_userchan-tester    PASS      19.67 seconds
TestRunner_6lowpan-tester     PASS      22.61 seconds
IncrementalBuild              PASS      73.63 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v8,5/9] block: implement NVMEM provider
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#237: 
new file mode 100644

total: 0 errors, 1 warnings, 175 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14662256.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v8,9/9] arm64: dts: qcom: arduino-imola: Describe NVMEM layout for WiFi/BT addresses

1: T1 Title exceeds max length (85>80): "[v8,9/9] arm64: dts: qcom: arduino-imola: Describe NVMEM layout for WiFi/BT addresses"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
"Bluetooth: " prefix is not specified in the subject
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
Read Exp Feature - Success                           Failed       0.248 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.024 seconds
Mesh - Send cancel - 2                               Timed out    1.990 seconds


https://github.com/bluez/bluetooth-next/pull/393

---
Regards,
Linux Bluetooth


--===============7708918989933539088==--
