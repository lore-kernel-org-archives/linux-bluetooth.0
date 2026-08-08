Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A531DDC38
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2026 08:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786176024; cv=none; b=oc2wG9T3t6KB5TbJ/ch4OEoR+N2rT4p6o+C2TULcL9QQstS8jXl2QlWg0eiLNfm9TkbRE9TroB0Hd4MFy2u7BjKyc8LA795RYa5gQ7pfhxf51jgizsEhSZw6a/8KsMiAC+Dc2mdzQ7RdtgMsnA3K2C8d2kVqdeb+DyCQIfSFdzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786176024; c=relaxed/simple;
	bh=IcvB9hCsje44D8/+GJW7QqGZy5SmnvtY2modLSnqiCg=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=fHsXdHt9X1PRPt5FOYLqVeEn5WpcBhgWSqtp7wiegFd9opuYzeLW7gvpbG7IQ9YHHXn7/m8bIIpf7hM4rJJjZIxR8jzGD3g17MA5TEN8bKQuLZm+ubhyU4cYultzdPrbQ/D0eDFtTqk95WDuk/1bwyp+0B0U1STp/TSRPe4b+8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lwzJ1jyz; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwzJ1jyz"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2caea3f742bso5650455ad.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 08 Aug 2026 01:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786176022; x=1786780822; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=BecfFIa0aBgSwwvWkkSwW2jId+Luwg/RoN/KYjYNhDk=;
        b=lwzJ1jyz53nAsM/mZ1XQQXjDN67oa7MQavAlPNfooLD8/dV8j/+Diz/mT0QpuaGcKl
         0x2RMvDDSJ9VskLAs/U86HoD7sGv9Ai70b3L7h3fwWLt5KLnHvRLDxNinBs5cBBq/eo5
         IZjiUB6NOfaU92BZ2JVBGWpBxFMtaoYW5Y/Ea78nR1t94AvNidZ0oPd+FVBBKJYQRsgc
         JG2E0bKomJdDuATdovnLgmNWiuhOTOsFibMLhzfg8h/rQx9f+O6AI6Wm9PHgQO9P48fF
         AgwVknXfERTpTu++o+hydSo4qQw3IpFVpJW06Vk8dOMPY3c9o+I7ivj/pyc5/04o6tFR
         PeCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786176022; x=1786780822;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version
         :content-type:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=BecfFIa0aBgSwwvWkkSwW2jId+Luwg/RoN/KYjYNhDk=;
        b=S0LkO3YF525ORKBvieWrAHznRn99y+ZE4TKqZ6rkGP0LQcnq/SZaccuwytGHxHxLNi
         ynHD7DnJE2Aj8Q7NZZGKQukhze1Hq/B4U8E3IRhNygoeC0UPwCAUwnpNS8RxagAtoWmH
         qb4Kk+bz8S+4j3ehCk7ZauDmPLzHRvSN2TVWPS61OzyNzxm2lGBhY/Trf8oNda27qJWT
         YycJVQtYQ8dYItlsBAQA5ZbfTv8sLvP5To9BGFOx6kCz+3+Z/QkacfRCNf63AjpCR3rl
         eLak5TKWa7KxB9xNtHY3j1q3TbTW1BqDqa9kuxyq5r++PQKGS+3oXpO0aGNux4tizySw
         Oq3w==
X-Gm-Message-State: AOJu0Yw9Ko61/xqkxI/w7OEUpjhrrMc66fl4AAJhYCDaHP2YQJSfjME3
	McIqMrMVNuQxtenYYSHvlfl4s6kblKDxPfO9iSWC+NGia9YXbs3phX8zf1/WiQ==
X-Gm-Gg: AR+sD11KYcvyz+gwEvf1MmU50/5hgVCys7yl6HZp4I6sCvexxZGvra02/oV0qoazJR3
	gZwISDDCL2yeEEgNIdqcW6IeqeEgOfQfzg3NXzxsBikyvrIjd8xiYjUrTf/40/xxj8L9d1g0gha
	FaFcKpLeD0k9z52Tw1IS790MaCtz46KA3Y5Pw9HiB6sD0VGYt8m44TD4y63nkn8P5GOmeBSzthc
	XJtSPItG5om92i2TDCRk9Dk39hUL2tP5/O3kgtmZg3nuVRNBmziItWAFjAzUX8AzjP3hYX8tWwm
	yhlLw3LaxBaXeB3SghxsoKUMkeF+JcluH6khj0IoEwFHt/ZVXPEfYZt8wm80KHxjl947wn/YWLm
	tXiMRehSzERsfqgWraxxW5dgykpMKTuyji3t7nNh3WRCAABuA35pnduO1Gh0vlT66keWGnRwg3E
	uUtS/aREsaGYDqwVuodhNIbaVPMeB1O8USBQKAfg4j9f63Jp0iSy9DOL869I6akLGsCrF6
X-Received: by 2002:a05:6300:220a:b0:3c3:a1e6:a626 with SMTP id adf61e73a8af0-3cb86026fc3mr37330986637.32.1786176021850;
        Sat, 08 Aug 2026 01:00:21 -0700 (PDT)
Received: from [172.17.0.2] ([57.151.128.137])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-315be86e90asm15889529eec.3.2026.08.08.01.00.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 01:00:21 -0700 (PDT)
Message-ID: <6a76e215.4a342cbc.f12fe.5122@mx.google.com>
Date: Sat, 08 Aug 2026 01:00:21 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6229015737024296344=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, zhangchen200426@163.com
Subject: RE: [v4] Bluetooth: hci_event: Add HCI_Write_Link_Supervision_Timeout command/event structures
In-Reply-To: <20260808062541.3705446-1-zhangchen200426@163.com>
References: <20260808062541.3705446-1-zhangchen200426@163.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6229015737024296344==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1142545

---Test result---

Test Summary:
CheckPatch                    PASS      1.24 seconds
VerifyFixes                   PASS      0.09 seconds
VerifySignedoff               PASS      0.10 seconds
GitLint                       FAIL      0.25 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      25.86 seconds
CheckAllWarning               PASS      28.40 seconds
CheckSparse                   PASS      27.13 seconds
BuildKernel32                 PASS      24.78 seconds
CheckKernelLLVM               SKIP      0.00 seconds
TestRunnerSetup               PASS      458.71 seconds
TestRunner_l2cap-tester       PASS      61.52 seconds
TestRunner_iso-tester         PASS      91.80 seconds
TestRunner_bnep-tester        PASS      19.64 seconds
TestRunner_mgmt-tester        FAIL      219.47 seconds
TestRunner_rfcomm-tester      PASS      25.64 seconds
TestRunner_sco-tester         PASS      31.55 seconds
TestRunner_ioctl-tester       PASS      26.45 seconds
TestRunner_mesh-tester        FAIL      26.23 seconds
TestRunner_smp-tester         PASS      23.57 seconds
TestRunner_userchan-tester    PASS      20.05 seconds
TestRunner_6lowpan-tester     PASS      23.05 seconds
IncrementalBuild              PASS      23.90 seconds

Details
##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[v4] Bluetooth: hci_event: Add HCI_Write_Link_Supervision_Timeout command/event structures

1: T1 Title exceeds max length (90>80): "[v4] Bluetooth: hci_event: Add HCI_Write_Link_Supervision_Timeout command/event structures"
##############################
Test: CheckKernelLLVM - SKIP
Desc: Build kernel with LLVM + context analysis
Output:
Clang not found
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 501, Passed: 495 (98.8%), Failed: 2, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.248 seconds
LL Privacy - Unpair 1                                Timed out    1.860 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.484 seconds
Mesh - Send cancel - 2                               Timed out    1.988 seconds


https://github.com/bluez/bluetooth-next/pull/558

---
Regards,
Linux Bluetooth


--===============6229015737024296344==--
