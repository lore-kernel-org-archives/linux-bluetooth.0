Received: from mail-dl1-f65.google.com (mail-dl1-f65.google.com [74.125.82.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F0044B674
	for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 21:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772141207; cv=none; b=anDd3Il+8HgE7r6L4rxSZ+TbdNXA9dlp77SgVH8L/AB1lqSumvmAJJJwBD2hDVNDnSdYsdwrtSfkIzuMfvAfiJ+fyqbcgbGeqS1/7AQItz6fAptjOTJyHW0awnnYYq5C0PjzYmgb0GkggrXKequbahZhTbcJTRbYavJ420AxaCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772141207; c=relaxed/simple;
	bh=RW8JGDCpIcKrzxIm14OJOWAxuNEpxyXiQWs7i7TT8Gw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=DlxQnlR/pqLRNAhIyymj7g/BWETLQ2eVdcqZz08S9hrDNhKcClHTE4VnmQt5eI5hf2vfIisormHrweWi2bxOi6Ze4dI7+walwxVYaAv5RSyhpLCgK/Q+vpjMZZqx8GGjp2hTY63xVhynxuKKN3sMj3JveiqvV13LH9zMJg3rgQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i+6pvtTl; arc=none smtp.client-ip=74.125.82.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i+6pvtTl"
Received: by mail-dl1-f65.google.com with SMTP id a92af1059eb24-127380532eeso2894016c88.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 26 Feb 2026 13:26:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772141202; x=1772746002; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mZW5+8bpcp7jCYvU+zOeQTIA2poApqluY8dCQc7PoQk=;
        b=i+6pvtTlgpxpwVQ6kvtDt2o0qM4Rovu6fFT4Zj5+eaM9apLa+TrOgUyHUc9TWMzgnV
         +gfHXQJnxK4UNDVEx4FW7OZ0lGOdbSOF0YV4gtAhFzBUuggrmwuD2O2cbCrgFe0wgaQv
         +Xn1Y2c1uQ9Rl1D6+KDjb9M3MjWReqhL5IIazYmry9t5s1+6oVu14tIbqMQjop9gZRo/
         j8RknxyMM9oqRmUPgqrCmLNLZiyYwsoef94NWNlwmDl9GM4Ls8q76/Fl+shTERJXLiii
         2AQHNPm+Lk6AEVqu4WtiQTaTcfBKHF+huIbB60R1gsM0MdldDSYkVTPMpER+aoorJLyi
         uIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772141202; x=1772746002;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mZW5+8bpcp7jCYvU+zOeQTIA2poApqluY8dCQc7PoQk=;
        b=wzeGMJcpWCGVwiaWE4PGa1QgKQFNrDWZuPyWPc48uHstdvopsxYcjbkfiEP4s47dLZ
         UV8JitWlYsVwqW0f72U+bdDz24K6oupSweqAsZmQfce6iy79tJnPyHmKj8E4SyNW9Q9V
         hi7q0nEsapx7ug6pd63sDe7I/f7o+c2j8NXmKIPJiXspSnTXMgHz+Kf0FhvwbZB4xqKR
         UNpJ1V3KyPVvsEJa0WkdNCcftGQf2BBlrh6BuVsh9JDogsj+ccLkjDfbPoR+2IOhjlbo
         Ivlr4lO0vrqve3dyg5kOW7za+eNEXGyIY9QpiWlaUEZq6dI0MbvsTMcXNURC60DSQsKo
         fSQw==
X-Gm-Message-State: AOJu0Yz6ZH8kYJ3FlLrIoixCBYL1wHjK/rbb5XfGfhw54d3+5ASfzMsM
	ZdHqx0V1zycv7UeaK8ZSG+wKQZVWr3S9mykublqdXXNoTkAAwEnMRg8Sln6AQ2jN
X-Gm-Gg: ATEYQzxl62IKNS7yx/hzumOamVC4X8d0qnLh0Cs0uCjTPWXksMQwI+ohTFLpjdX4z+5
	qP+Ef/DAgL7Ff/DFngJbhdf5yIAhpVrWCE3HSMxPCmshjoT0SJ62K61ky/FEHpJzT1fY7AMf0Lx
	7qWrMk2gsp5R7pGlSoaKt8FQJoc+UIQTXxJubYh8BLlzZGFfHfVEg7oJCbi5pwY0G9IqKPCwAdm
	I8ZrD8rETR484JPoYo1xhF2xwevpNzDkHEic3DcKoteIVJc7HK0opUfD5E7LIV++4jkclZ5k8cM
	DBlPGLcINmxpf/oXWu8ciZeuG0A0SX+zJuD8czF++L5tuAwTomKxoq2zC8Qzk9JMJcLaIUJHsOC
	stn/wVTvLHBf602V0Ygii12WMRjHgJMfd4mKO65dpaZF0PmQUkGy30SLbgh/jCE7u5ndipwH9Rs
	Rn/zh1BDlAkKRy/F57CHxDTLY7CT5LC79kRx7N
X-Received: by 2002:a05:7022:a88:b0:11d:e25a:d9ca with SMTP id a92af1059eb24-1278fce01f3mr192153c88.26.1772141202031;
        Thu, 26 Feb 2026 13:26:42 -0800 (PST)
Received: from [172.17.0.2] ([68.220.58.2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12789a32633sm3660146c88.9.2026.02.26.13.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 13:26:41 -0800 (PST)
Message-ID: <69a0ba91.050a0220.4804c.0511@mx.google.com>
Date: Thu, 26 Feb 2026 13:26:41 -0800 (PST)
Content-Type: multipart/mixed; boundary="===============2461959876655827845=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v2] Bluetooth: L2CAP: CoC: Disconnect if received packet size exceeds MPS
In-Reply-To: <20260226204357.361000-1-luiz.dentz@gmail.com>
References: <20260226204357.361000-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2461959876655827845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1058650

---Test result---

Test Summary:
CheckPatch                    PENDING   0.51 seconds
GitLint                       PENDING   0.41 seconds
SubjectPrefix                 PASS      0.06 seconds
BuildKernel                   PASS      26.47 seconds
CheckAllWarning               PASS      28.77 seconds
CheckSparse                   WARNING   32.37 seconds
BuildKernel32                 PASS      25.65 seconds
TestRunnerSetup               PASS      572.31 seconds
TestRunner_l2cap-tester       FAIL      33.20 seconds
TestRunner_iso-tester         FAIL      43.43 seconds
TestRunner_bnep-tester        PASS      6.53 seconds
TestRunner_mgmt-tester        FAIL      115.20 seconds
TestRunner_rfcomm-tester      PASS      9.37 seconds
TestRunner_sco-tester         FAIL      14.74 seconds
TestRunner_ioctl-tester       PASS      10.20 seconds
TestRunner_mesh-tester        FAIL      12.42 seconds
TestRunner_smp-tester         PASS      8.53 seconds
TestRunner_userchan-tester    PASS      6.57 seconds
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
Test: CheckSparse - WARNING
Desc: Run sparse tool with linux kernel
Output:
net/bluetooth/l2cap_core.c:7792:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7793:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7795:1: error: bad constant expressionnet/bluetooth/l2cap_core.c:7796:1: error: bad constant expression
##############################
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 94 (97.9%), Failed: 2, Not Run: 0

Failed Test Cases
L2CAP LE Client - Read 32k Success                   Timed out    2.371 seconds
L2CAP LE Client - RX Timestamping 32k                Timed out    1.896 seconds
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
Read Exp Feature - Success                           Failed       0.107 seconds
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
Mesh - Send cancel - 1                               Timed out    2.718 seconds
Mesh - Send cancel - 2                               Timed out    1.991 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============2461959876655827845==--
