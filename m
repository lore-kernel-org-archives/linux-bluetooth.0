Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C613F0AA0
	for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 16:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782748809; cv=none; b=iK6iA0xWS23cgtWTzCxibmOPvXdf0mlJ6YkDM7QbcR6/KE9U+XrF9kYEYkap4yTrtadKq4h1m10BjLX/6UE5VA5IBWeXfdeFfgKOWwjWkYrba2c3DhJrXBnPSQDbixNtG3RZ3f0tY0KX47phSdaJr04dYt0ygOBT0MHX6iebAUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782748809; c=relaxed/simple;
	bh=TPTRxN9rtT3+ReelBeL/J8n1fnyXyrkqljiQ6FJsaHo=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=St6nmzHUTbBUZJDiWJ5H9Jwiqr7l9sVhLIHNUVRCewuovvl7gGYRMsnzs3Cjq3mvJOOuqdac1HeEuoJrHE5MuAQulBGDtN4fCkHvkES6MRa0vDEvI1V8eq4QTSefFTvEYt5ijuTEZAhi1W+jqyQ/+k6v0Owxiq7ljEYRE+exo/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=INkBPJvm; arc=none smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="INkBPJvm"
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8e5be46f663so26469016d6.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 29 Jun 2026 09:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782748807; x=1783353607; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wdCeN7fVIkAJ2K30CMRO95gFuwlVhysFT2M5ab5h9rw=;
        b=INkBPJvmQSx8KGIzMyUt+pEQ5G10l9BQDzgY15Fj3QW5x7OAdalbfbdeYbkO6ZrRNG
         hyGSZuzOXUXrj0ECwWoFxc6uat3vgxINUfXI64cjaAwjbS6vhkCI1JJNCYfkdRG/LNmS
         OB0h5VfuVQYVE5y2cNGtO2MEqNetZWoyQYzF/5VOA3vRAFEHRVypzwfyWeSl/E3XxhgC
         QEkkTDaYLAsd1YaNmuCwDmGFhjOxxlcSG2G8KW+HZkQDmA/p1GsPAB3RFgQQ6qSw+b0e
         kO/kL6NkF+BxGxWKD/o30LZgqK2r9vTuiCwxZL65kAWWKEEkT5XgI6x25Q19P9Bw8ayu
         WuQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782748807; x=1783353607;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wdCeN7fVIkAJ2K30CMRO95gFuwlVhysFT2M5ab5h9rw=;
        b=r9bFkB1KajD+Uy8zF2GrybVcji15FRTViyHaSbivXRSsUi7Ftk6w7dMtExiii5NbkR
         FR1nw1pQ9bQpM8jy6xwnCB/b2iNGxtjhPCD+aymoYPE7sufOIkIMnBlcQVto6QENVOXQ
         svMwRnl6fvDU7/zPScs1m0Ects2Mf5FG2m+XD9o7UH2aDg7Zh6rwlWTyFNkCAxwv7Z9y
         D0gFAqsWn3aUl8C50NQpHy+fNVFjiI2g280n/4f5fxoPjFV5R8SGVb4CDTl1UP0+qRE4
         E9gygAsSnwBHe7HgY5+yop7fAsie0eGRXSPm3NfY9Kx1lLfFicG6CDdB0QD84gXiS/9n
         /XGA==
X-Gm-Message-State: AOJu0Ywzp2mAk2KuzbrRGzpX6O6Qb1XftWDhG8FY2MAiRrzIazZso9im
	rnw9884NxFj2luMbXM8cKGZTQwMIa+xe0zOqWiEewYX7AR5ze/aY2z3KacfSNA==
X-Gm-Gg: AfdE7ckxN8WnQ1zSA27xwe+dQbP0NEKaEWAD2rL3LTfXrtQUjUtzAi/AdxjGAnz/VPa
	0CpGJdDTZm/jq+SYcCHQcjgvciagH7p9qaApGJVa7VXdZ6noXYtLwGJE85rtV7x6IeMBcDiEp1Z
	KXAppDmXieaEGr/q+JPel591NEkiDknw40KSwpI5XE4KdyW/ASpkTbTPa6ezuG+xGE5n6dxtX0s
	Khwq3Of1CgacHG7mYG+vHiSo7N/Q96d4yT/Tqg15GxoYilk7aIsp0O2fDZbNC8E/LIG95EPQXhX
	TCOypnX+wyu53kwnpsVBhpgHWUoTJmhfJa022VnDXQjpjBiCrjQNcIhOYs1AlTvz8XHP89Q8jgS
	8g3Yen2Cgrxt+sbehnlinPbr3oN+yNtAH2Tb7k2LIragDXBYVguC/XT/+xCeMF8bSshkvCKDMW4
	OPqamHY9A38iMYx1sgcfWC
X-Received: by 2002:a05:6214:810b:b0:8e8:7de7:ec20 with SMTP id 6a1803df08f44-8e87de7f75amr188912326d6.4.1782748806197;
        Mon, 29 Jun 2026 09:00:06 -0700 (PDT)
Received: from [172.17.0.2] ([135.119.239.42])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8f1a69c32c0sm1116026d6.29.2026.06.29.09.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 09:00:05 -0700 (PDT)
Message-ID: <6a429685.aa74d419.371192.904e@mx.google.com>
Date: Mon, 29 Jun 2026 09:00:05 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0165990193940147268=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, george.moussalem@outlook.com
Subject: RE: Add support for IPQ5018 Bluetooth
In-Reply-To: <20260629-ipq5018-bluetooth-v2-1-02770f03b6bb@outlook.com>
References: <20260629-ipq5018-bluetooth-v2-1-02770f03b6bb@outlook.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0165990193940147268==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1118237

---Test result---

Test Summary:
CheckPatch                    FAIL      10.52 seconds
VerifyFixes                   PASS      0.21 seconds
VerifySignedoff               PASS      0.24 seconds
GitLint                       FAIL      4.28 seconds
SubjectPrefix                 FAIL      2.16 seconds
BuildKernel                   PASS      25.41 seconds
CheckAllWarning               PASS      28.30 seconds
CheckSparse                   PASS      28.42 seconds
BuildKernel32                 PASS      24.73 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      457.14 seconds
TestRunner_l2cap-tester       PASS      57.17 seconds
TestRunner_iso-tester         PASS      80.06 seconds
TestRunner_bnep-tester        PASS      19.10 seconds
TestRunner_mgmt-tester        FAIL      208.31 seconds
TestRunner_rfcomm-tester      PASS      25.26 seconds
TestRunner_sco-tester         PASS      31.86 seconds
TestRunner_ioctl-tester       PASS      25.76 seconds
TestRunner_mesh-tester        FAIL      25.21 seconds
TestRunner_smp-tester         PASS      23.11 seconds
TestRunner_userchan-tester    PASS      22.68 seconds
TestRunner_6lowpan-tester     PASS      23.40 seconds
IncrementalBuild              PASS      37.85 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[v2,1/6] dt-bindings: net: bluetooth: Document Qualcomm IPQ5018 Bluetooth controller
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#106: 
new file mode 100644

total: 0 errors, 1 warnings, 86 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14651116.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


[v2,4/6] Bluetooth: Introduce Qualcomm IPQ5018 IPC based HCI driver
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#154: 
new file mode 100644

total: 0 errors, 1 warnings, 1076 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14651118.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v2,1/6] dt-bindings: net: bluetooth: Document Qualcomm IPQ5018 Bluetooth controller

1: T1 Title exceeds max length (84>80): "[v2,1/6] dt-bindings: net: bluetooth: Document Qualcomm IPQ5018 Bluetooth controller"
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
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
Read Exp Feature - Success                           Failed       0.238 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.964 seconds
Mesh - Send cancel - 2                               Timed out    1.989 seconds


https://github.com/bluez/bluetooth-next/pull/368

---
Regards,
Linux Bluetooth


--===============0165990193940147268==--
