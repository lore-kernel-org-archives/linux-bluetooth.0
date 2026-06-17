Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349CD3B52F8
	for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 07:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781681326; cv=none; b=frZu5X26ogYRdToVezzRKF8zqAwa0gVauDrXnPtBTfxGm1tWwceXAcYOHOphiPOqk+rSmCW4Pah5so+YRo3mToV3B8E6BUDERjSqKQomsPnw1HNFg7NHiobdOyknTfMRlSGOUrde7FtXzjxuiQcBaMoQcSFrm8eCaXvY3IrNpxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781681326; c=relaxed/simple;
	bh=zxW73jc1C12LCoyJ9yNj25es9PzCpEfa36rZoim8aG4=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Qt618Tqu6+w9ExnwoCalOO5IJOA65G8KmBlQzHfFCdlYR9FUzZJeOInVvp+4zvfQnvMABMgcoKAbeOpyoLh/w3xKGb284bvDwl7lpr7ONdcfFpxTt3W7f/z3V2+ZVQ8cIAZjpW0gXDZygn1D54rACp8KZy0Ig1rESGa1OOfOCi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6IxHy6o; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6IxHy6o"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-84226d0f1d2so3548896b3a.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 17 Jun 2026 00:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781681324; x=1782286124; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dfyhjrsu3jNz13EU445W6s1u2EAWZIpXZ/lgJG08pZU=;
        b=N6IxHy6o/SlFrxYUrO3cJIbiA1A/GmH9YNMqRuBanP3a9l8x9gL2fEQzX1A7MQIKBG
         jScaN3bsMRlJwHzNp8H5SdmKyOCPNSVxctxMWIfkMukAn5bSUonnLT7FcOUU/yXhZqFN
         QpeZxzuwj8D3sPXrb/aAqsSAtdaCz4K2wTPHsjxtaxC2MCorjrhzz9+VFPGclaU4ZUNG
         cveVP+aZ8BIPQY11T401QzbZm79imC93unUx3xgzAICNVtkx/NI78cRS3g8wO+gZaKNa
         uxYxhaPK9ykU7oR6q3LI+yrv7GsTO2xMRpdds9k+Rwcn3a5b7g0EaWCVW/sgRgyG1Kxk
         QFjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781681324; x=1782286124;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dfyhjrsu3jNz13EU445W6s1u2EAWZIpXZ/lgJG08pZU=;
        b=EEZ+zvvY54xZtPm+mqHrKYlGsDn2XpblUSapal1iBELFXXNRG8cGjou4kX7C56J621
         6+NxfkV/QYDc4e5QChLjg1vJOuL47+xaykJEiOGxpuoEk/mnbXSRq5Pwr/ZP4yJ8hgq+
         3QsYoPcBu040222h9qJUWlzu/mDs9aNWmMv3JL3YFcjhch4SjAo2fjrn6Yh90/OT8WOJ
         1DrmaD7JjP+lpiBzfkcRbWa+mgRJt8TDxPzK/xb8ns2XoEUjvc24htCBCXhqhfTk0bX3
         +yrBXDXZAqeDhgWmtZ4tbOBQr0mAQkNElzLRTkMqrcI1B5gVp4YuSIiS6x0eERY41T7R
         KRoA==
X-Gm-Message-State: AOJu0Yx1KMT7b99ZMbZL1ThtfotevUy2Y/UdW4ZJNk4UcnVB8f9RzhHJ
	NxLg8DpTk0cvRfoXc0Bt3pdXPUIo6aWvwQjPyKR8AoIOHKYsU6FtjlElj22XMg==
X-Gm-Gg: Acq92OH4fZr2ANsVmJWEkNfbkQP1WrMbjBnzv57lt3A6rc9M2iRA0A0YcLaymHnPMSq
	lI99THnh2IaNa5VrOWQwmNSm5NJDAPgeRe1i5jdwWNzE9Y3inGKwpXpmeEaeE3i7HWFplna7EdS
	JT6iT+aipCDmI+BsZkDMji+8YO1CmJ6gX3LgWKg33g9drNqw2rEQ8exH6CsjCbHnYouasfDJ9A+
	prSWN0NA+YdkRNSlJl7pdw12QdN0pnOm16VWyLt/7/JMZCu5zdAr0o3iL1FyTnz6wxzAxsiB9Vg
	F7Q7XkrvT3MECGVD/PtRZRsMPeSDPEvAi5bd8cQbWVlCZ5PRWJK9F8hjeaGZOdtb3GPSegK/9E0
	pmTe2tFvtsihOe2asEiVOLIJf12HyACKbyQvjN/MQl75N92g9E0GBdbrHp5auqq+4I9yGtDmGoC
	q/S97M2hq1sKpuw1og
X-Received: by 2002:a05:6a00:3cc7:b0:841:58b0:82bb with SMTP id d2e1a72fcca58-8452442f4bbmr2774041b3a.9.1781681324539;
        Wed, 17 Jun 2026 00:28:44 -0700 (PDT)
Received: from [172.17.0.2] ([20.3.166.88])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ac9bfe1sm15498292b3a.12.2026.06.17.00.28.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 00:28:44 -0700 (PDT)
Message-ID: <6a324cac.21153faf.105669.7bf1@mx.google.com>
Date: Wed, 17 Jun 2026 00:28:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2881794581136389710=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, iam@sung-woo.kim
Subject: RE: [RFC] bluetooth: hci: Fix null-ptr-deref in hci_conn_timeout
In-Reply-To: <20260617035421.341457-2-iam@sung-woo.kim>
References: <20260617035421.341457-2-iam@sung-woo.kim>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2881794581136389710==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1112652

---Test result---

Test Summary:
CheckPatch                    FAIL      0.51 seconds
VerifyFixes                   PASS      0.07 seconds
VerifySignedoff               PASS      0.06 seconds
GitLint                       FAIL      0.18 seconds
SubjectPrefix                 FAIL      0.05 seconds
BuildKernel                   PASS      26.51 seconds
CheckAllWarning               PASS      29.50 seconds
CheckSparse                   PASS      27.67 seconds
BuildKernel32                 PASS      25.72 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      574.33 seconds
TestRunner_l2cap-tester       PASS      57.14 seconds
TestRunner_iso-tester         PASS      76.29 seconds
TestRunner_bnep-tester        PASS      18.68 seconds
TestRunner_mgmt-tester        FAIL      205.98 seconds
TestRunner_rfcomm-tester      PASS      25.72 seconds
TestRunner_sco-tester         PASS      31.21 seconds
TestRunner_ioctl-tester       PASS      25.32 seconds
TestRunner_mesh-tester        FAIL      25.80 seconds
TestRunner_smp-tester         PASS      22.85 seconds
TestRunner_userchan-tester    PASS      19.58 seconds
TestRunner_6lowpan-tester     PASS      23.13 seconds
IncrementalBuild              PASS      24.93 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[RFC] bluetooth: hci: Fix null-ptr-deref in hci_conn_timeout
WARNING: Prefer a maximum 75 chars per line (possible unwrapped commit description?)
#119: 
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000007: 0000 [#1] SMP KASAN NOPTI

total: 0 errors, 1 warnings, 0 checks, 14 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14632510.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[RFC] bluetooth: hci: Fix null-ptr-deref in hci_conn_timeout

38: B1 Line exceeds max length (112>80): "Oops: general protection fault, probably for non-canonical address 0xdffffc0000000007: 0000 [#1] SMP KASAN NOPTI"
40: B1 Line exceeds max length (84>80): "CPU: 2 UID: 0 PID: 408 Comm: kworker/u17:4 Not tainted 7.1.0-dirty #96 PREEMPT(lazy)"
41: B1 Line exceeds max length (115>80): "Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014"
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
Read Exp Feature - Success                           Failed       0.238 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.584 seconds
Mesh - Send cancel - 2                               Timed out    1.980 seconds


https://github.com/bluez/bluetooth-next/pull/322

---
Regards,
Linux Bluetooth


--===============2881794581136389710==--
