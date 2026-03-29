Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6A20346E58
	for <linux-bluetooth@vger.kernel.org>; Sun, 29 Mar 2026 14:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774793467; cv=none; b=cqF7YbVfjDu1s64qzS5yvq8JtH9zOgO6RwXMRfUsiXJ3QdzxRCQGHw4uEigBydeZfa5XE0AQkqEXOqIQjxWCcht+x6/fQFgoA/WWmZKl5BJqs58B8F3O3ohdMr3NEVTbmTC5CpCX0HS6W4BYDSwnRcIWLjSiQctB0b7L2/BqXCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774793467; c=relaxed/simple;
	bh=Ay2ttgsyh9f8S/o4TfzsQKTeqPeCZaK2PeOGAGX7SR8=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=sF8L5OqnoYhWIpv/eTu43FDg/3+xDaIpf3A/3NWaZHjndbLFglEP5Z96MgCNhnFBi4MoGgs0zqeps22lgpN91aGOdwlBHuDiqMxkxXcwKMzxkbPQAsFhfPqTQnusYlHr6PYQPxxqzr3p/pEf94bjc5WXM47MY8R8RW5b1PUmAVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rcI7+WUL; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rcI7+WUL"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7d75371d873so3639758a34.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 29 Mar 2026 07:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774793464; x=1775398264; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1jFZRKr+eqBEl+jOrNDcbJQJIQS/YGj8+I+9yz8ipws=;
        b=rcI7+WULmr788yGrpCoQqD/kvJrqVvTK7HCwHRWrBSLWsMPGJZ289GANh6XJ2vf2Wd
         s1RMn+GgdvikZ44cAcK82t+kXoU9cMYnROHRJS8+zArpW9ene9Yg9WrHbSiz0bQxONM/
         PmAuyKHqvvI4d0kd7oTce8kpz0OG7QuXZQQu/CrTq7WPanrJvxZH6+svbpnGE83eE7uq
         c9Yh71oJWhEARML7ubsC6sM4RhE/DFh8bsLfhsMLZ3hVBkJnmXlve/UR6QxgjB3kvpof
         LuUV0ibtBongtifpRrtbcDbS0/hMB+WkoA63dB62tQYGGlczcFeTsBMlpnrSMaCNMPi0
         M2Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774793464; x=1775398264;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jFZRKr+eqBEl+jOrNDcbJQJIQS/YGj8+I+9yz8ipws=;
        b=pKh22R3LD4/+08tZ1W8l/JEQdwIULygC8Odcsl22AL4sAhyxHx2UgyL+gdLVnyxngC
         8spiiqkHIyFl+45VNLL/RL4FOD0fFxknunqdqpE3x/M/gtWDPIR2mcI/94eiEDur0ou/
         sa5jTb6KoPO2oJ1PBigqnKLvnTXYDae5jvk5V8NEAf57bHYIrKCB8gkazcpmNwrMlcLg
         /aNo2w6KKv8gY0R5VqpoEODDlnc27ZJrEpxd8Js1m6d8Y8t2mJZBl/Q+K+NXC8RyyEfD
         LXpH0/He7P7ssJ8Mliud5rrv/7LawmILY1Ha1qlCwi7DvMAV/WTrZTL+EUO9V6L3ImlU
         guoA==
X-Gm-Message-State: AOJu0YyarJGqd70QKDU372VL73YkVZ+zPTZ5KlF1h4o5umYrdKzySYV2
	CAuRq1CkOJFB3uGp3AGlOmjG53I19GZ49DPqi0Y4dW7SAdArLeJEe8Oc8MDtPw==
X-Gm-Gg: ATEYQzyHTMm0ugHdB/6MDOBNAPJshqwyCAZZAyyjPhEC1SHiGS+TtYza68oE28BPYpd
	eenybNZxCMpNjmGDDpJz9BMw+ecEpN7OKaG0xgbRYU8BV0R/eWLXI/wejqAH7PVE/aAWOGwY0S2
	BLJJC9eB691SReqj6OGiSyAdQSAwNbOh9P39OnqikQlFZfd60VXnn4+F6QB/txOqWPwvfatF1mA
	023xSf0CgLrcxg1cpp0pxh139ghKRzOGsg8c5CmNZInvCu7b8ZFWAVYFjyjFFuCcfEBG+iKOgiL
	vk6lcYKWZVxKSPBhhYA4/bKJmJga79KsOUlk4Tg7k71CdhpNLY/svYzUa39nj6YHWfY/ufEOBB8
	mUnb+UH+Qk0zW440RgDXr9wo0/OfGjRl5Hyy0OboSBM7arb/k65w0p9KZZzMeGRTJ01r9PJOqfR
	07ZDV5Qsx1GnEEEPqykDP5U432MR3g/UQ=
X-Received: by 2002:a05:6830:67d6:b0:7d7:daf8:dfee with SMTP id 46e09a7af769-7d9faf0611dmr4984763a34.27.1774793464112;
        Sun, 29 Mar 2026 07:11:04 -0700 (PDT)
Received: from [172.17.0.2] ([52.165.251.164])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7da0a821746sm4094326a34.24.2026.03.29.07.11.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 07:11:02 -0700 (PDT)
Message-ID: <69c932f6.050a0220.178cc7.2f7f@mx.google.com>
Date: Sun, 29 Mar 2026 07:11:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============1706456879423762603=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, pav@iki.fi
Subject: RE: Bluetooth: hci_sync: fix refcounting in le_read_features_complete
In-Reply-To: <4677ae5da08686a59e6d7d9f12cf19f3ff2b0e31.1774787570.git.pav@iki.fi>
References: <4677ae5da08686a59e6d7d9f12cf19f3ff2b0e31.1774787570.git.pav@iki.fi>
Reply-To: linux-bluetooth@vger.kernel.org

--===============1706456879423762603==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1074196

---Test result---

Test Summary:
CheckPatch                    PENDING   0.36 seconds
GitLint                       PENDING   0.25 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      26.06 seconds
CheckAllWarning               PASS      28.52 seconds
CheckSparse                   PASS      27.52 seconds
BuildKernel32                 PASS      25.18 seconds
TestRunnerSetup               PASS      565.07 seconds
TestRunner_l2cap-tester       PASS      27.82 seconds
TestRunner_iso-tester         PASS      33.58 seconds
TestRunner_bnep-tester        PASS      6.39 seconds
TestRunner_mgmt-tester        FAIL      111.99 seconds
TestRunner_rfcomm-tester      PASS      9.49 seconds
TestRunner_sco-tester         FAIL      14.24 seconds
TestRunner_ioctl-tester       PASS      10.12 seconds
TestRunner_mesh-tester        FAIL      12.44 seconds
TestRunner_smp-tester         PASS      8.61 seconds
TestRunner_userchan-tester    PASS      6.65 seconds
IncrementalBuild              PENDING   0.88 seconds

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
Total: 494, Passed: 485 (98.2%), Failed: 5, Not Run: 4

Failed Test Cases
Adv. connectable & connected (central) - Success     Failed       0.132 seconds
Adv. non-connectable & connected (central) - Success Failed       0.125 seconds
Ext Adv. connectable & connected (central)           Failed       0.176 seconds
Ext Adv. non-connectable & connected (central)       Failed       0.179 seconds
Read Exp Feature - Success                           Failed       0.105 seconds
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
Mesh - Send cancel - 1                               Timed out    2.741 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============1706456879423762603==--
