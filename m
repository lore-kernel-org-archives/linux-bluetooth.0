Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2849E311C35
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 20:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784925826; cv=none; b=ZBzDX2EdSGVUfLa67clxekdPdFrXVSsiNnGOORsevbB+owiaMa6Z+orQaoZer7YiTy/WtaaprFsz8nPXmtg8uLbLsoGpbjazuJ9+rDWtHCDKc74lpyi58hELPnAyKGZu1vdXk68k/8TWbHRP0sIZcSq5Kub2n7KendzjDc5gnXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784925826; c=relaxed/simple;
	bh=7YwzRmDugZNJn0YTLYYd6G9KslpXltdsbTEq+7n8N8Y=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=q2y3ZeoDT4KiNl2hTQnQ5JYzLxp/+kNlGDksWg/ACbIkuR3/X+I/o3KIzxaCRTq1oYlJWej0qyBq+OZWa1UEz4YYcj0WorGNbOg3UA7soavK25zWdY5hjSI2OElzomFg9r4iXLjoRQQXSDOV7d5aryzkBmczoXHq+dP4sKyvicM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUoFitKn; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUoFitKn"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cca0c5799eso9332845ad.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jul 2026 13:43:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784925824; x=1785530624; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fsL2WNW2J2Ht6kzOOdmXz4jT13y1wzYvqMX8EACX3QQ=;
        b=BUoFitKno7/TfTchsoD4JCz/QzFe4DnDHmE30AePGYrdSb1PJk7q6eEUQfuxFYWHFo
         nJhwHcJ+EtUKMk/GjQaxs0r0lr+X7zAZAQrWm1vpC/sTyYfz72gJiZAgCG1naFBgo+Gq
         Whym9zriU2E9TzvrYV73I4VoquPpcb5O3vlO76mPfXUCEvwkkDnaU4Ha7Tr4HiqpIyzt
         WiFYdK0KZXUD10xSXxmk2td8BnzVfBYoimfLJtPTQvyYI6eOHqBOZ1Aw7f+vLcODEPk4
         LDZL03kXp7n3jdPaBStL4uPWOa1dJ6te+k0HVT8yVClquI3/KhQnsew9TOObInWtWTWP
         OJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784925824; x=1785530624;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fsL2WNW2J2Ht6kzOOdmXz4jT13y1wzYvqMX8EACX3QQ=;
        b=AVYAcvEVLUcanoLTh3C+NFAvN8AYiSu9jC+sVemDhB+OwdW7F8XC9SMYioky3/p93o
         cpZFfgxJq+hQSfgM0gsganGfM8L0uLyK4u9gIbXpREPhCmjJqCQZ6eebgutj4nTBrsbB
         u7ZtBjHhOiB1YsqKJ+hBGb/9W9wcxCV6MCkWs8gW9c7hQbA7quylzazPO0P3N4POCHKx
         cRff3FJ0cXLYJrMTLNPZbI7mTNrrG5kKIda5sEk9qSyWm7976j+1aWZLP1WSoDAHbPEX
         Ew+YBk9ZGPnAUXKgeP+KbKzDR3UkSQjiwfsejV2THm/KOQkIBZWy5wR5rIwSt7Una0nu
         jbUA==
X-Gm-Message-State: AOJu0YyLk+3ZRfkPByKcEvAzpGiUGZoAVme7bQozVztXEcAl9LJCXGxv
	PB3bU03GQKCGLiOrBdVjYAaiSrTKS9dpjBWfg7IrqrQuqI2MY5/VmLpWMrBDnQ==
X-Gm-Gg: AR+sD13MvEegtqcOQA21AmI8IY/oc7dRH2dLctzDTNlhMJsKse+m4MeB0XeFArvey5N
	6meozZrKUl4LXL3A90L8LMQzEKbiAGtO3utbipgXfLpuVU0nkT3AEKMQPyOniV6jcaPU5StjBW1
	QuUbkTI+3o4VIg1JDtr3ndc5WNoXNehY66IYOWNdyMnBXd68Ig3nZGadP5SdgR3GY1B8e8t+neA
	c3jNgQ1ycu7wDUaDmJsbgtoROyP8yxHBYjjpfhbMZl1u0UAAQBgNBRthIMCFeeWwDC1TUC71EEv
	MJY/DrYLiHOg5dG9qn6g5wFvujhVZpMEavCXUvydBLPCN452ghC98KxVHjQcCcfY4fNWClVgQ3F
	A2dQjuJ+4ID+jzszICHbpHCM0bGl7v8ZKXxDjV1bMmLT7ibAGduei2vshc63gebThxx2aqMCECg
	P3pBmXeavv
X-Received: by 2002:a17:902:cec4:b0:2bf:27b2:4b80 with SMTP id d9443c01a7336-2cfde797787mr386405ad.14.1784925824388;
        Fri, 24 Jul 2026 13:43:44 -0700 (PDT)
Received: from [172.17.0.2] ([20.55.163.176])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc593b57sm3249262eec.25.2026.07.24.13.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jul 2026 13:43:43 -0700 (PDT)
Message-ID: <6a63ce7f.bd93e731.32a2a8.54f5@mx.google.com>
Date: Fri, 24 Jul 2026 13:43:43 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============0895417838180588389=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, chandrashekar.devegowda@intel.com
Subject: RE: [v5] Bluetooth: btintel_pcie: Add vendor_reset PCI sysfs for PLDR
In-Reply-To: <20260723094443.855492-1-chandrashekar.devegowda@intel.com>
References: <20260723094443.855492-1-chandrashekar.devegowda@intel.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============0895417838180588389==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1133204

---Test result---

Test Summary:
CheckPatch                    PASS      1.07 seconds
VerifyFixes                   PASS      0.10 seconds
VerifySignedoff               PASS      0.11 seconds
GitLint                       FAIL      0.26 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      25.24 seconds
CheckAllWarning               PASS      27.80 seconds
CheckSparse                   PASS      26.61 seconds
BuildKernel32                 PASS      24.69 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      458.33 seconds
TestRunner_l2cap-tester       PASS      61.74 seconds
TestRunner_iso-tester         FAIL      91.79 seconds
TestRunner_bnep-tester        PASS      19.37 seconds
TestRunner_mgmt-tester        FAIL      213.46 seconds
TestRunner_rfcomm-tester      PASS      25.34 seconds
TestRunner_sco-tester         PASS      30.96 seconds
TestRunner_ioctl-tester       PASS      25.83 seconds
TestRunner_mesh-tester        FAIL      25.93 seconds
TestRunner_smp-tester         PASS      23.32 seconds
TestRunner_userchan-tester    PASS      20.25 seconds
TestRunner_6lowpan-tester     PASS      23.01 seconds
IncrementalBuild              PASS      24.34 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v5] Bluetooth: btintel_pcie: Add vendor_reset PCI sysfs for PLDR

15: B1 Line exceeds max length (81>80): "  - Added ABI doc at Documentation/ABI/testing/sysfs-bus-pci-drivers-btintel_pcie"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_iso-tester - FAIL
Desc: Run iso-tester with test-runner
Output:
Total: 141, Passed: 134 (95.0%), Failed: 7, Not Run: 0

Failed Test Cases
ISO Disconnect - Success                             Timed out    2.207 seconds
ISO Reconnect - Success                              Timed out    1.998 seconds
ISO Reconnect Send and Receive #16 - Success         Timed out    1.995 seconds
ISO Reconnect AC 6(i) - Success                      Timed out    2.567 seconds
ISO Reconnect AC 6(ii) - Success                     Timed out    2.003 seconds
ISO Broadcaster Reconnect - Success                  Timed out    1.888 seconds
ISO Broadcaster Receiver Defer Reconnect - Success   Timed out    2.360 seconds
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.243 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.752 seconds
Mesh - Send cancel - 2                               Timed out    1.990 seconds


https://github.com/bluez/bluetooth-next/pull/490

---
Regards,
Linux Bluetooth


--===============0895417838180588389==--
