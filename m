Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EE523815D5
	for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 07:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773730822; cv=none; b=aySJAjWqvxKEvG5xDN5RrNsSLwrPornRfPayx86CYit+MPDNNY2XcWbzdvHmqiPnkQ8ksVXhV6xSLnpS8ix+FrXbpcSKk8f6nt7dw9ntlCSi5tycP62gyi/ToHZ3vAJjToQg3YqsL03+dhhD2koHnRQT97Rkm0+GfQiKD1Am7Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773730822; c=relaxed/simple;
	bh=dwIIqGU6pQhLQ0yAeFRe8wQnUfb1QFdyR7Vk0xbBZLw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=FdWPL/Mna/dMXYmGLkzgKdH7c0yvGwr+nZmQoX5EaLGW7gDYRiuuSiNvTO2Mc8V6UTvqSL4egUXDz7bywDs7ToAKBdLs6eyiHGa8sTHWOpqLiySMRr+n57BLG6rGl4NFo8msi2SkzMf3quJ/7y4NoRWZhXbwC99OAF0qVUXOJCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DE/hReNO; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DE/hReNO"
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-8c70b5594f4so57249185a.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Mar 2026 00:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773730820; x=1774335620; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=i2wTxBb4nL5T1kh3wM2Th/ab6XmkJ2L0wTuSQq++FxY=;
        b=DE/hReNOZfp1GtG2VfMYD7820VsL74w/+ap+Mtqn1fH64k1OMSotVxhMazwsYVSu+/
         6J71M/iqCZ/Zgr172SdwcNU6d25VJqdA8lXXyq65+s3lO5MdjgZ7wdY75+5AGIRKOD7i
         eD75oyDQ8rCIb7CTQotuAWRKxylo2wBRtHiBb9roTv5SH5bfbijyLCHV4OzBQXMtxmOg
         FQZWNOufLBl7kIOXL+LbFGoeO9lodTTVN6qF3MTbNsbkKa/rQXSZUmnsIh4NkzmuUum9
         N+F1553X+AvHK3dZ2fBGOmRY2MmNpu51w+mScF4u5Cyuut28Wsc07BLOTt2PctlFAQvl
         7QQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773730820; x=1774335620;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i2wTxBb4nL5T1kh3wM2Th/ab6XmkJ2L0wTuSQq++FxY=;
        b=suWiAM+NKMsp6+DTKbgvKPSUArSyhgJTjuE3MLmtGQ/mx9IHuLCqNcgCyw19LsZmQz
         Zk/MclPpZ9Tg64+K+b0RbLS8Avj1c47wEiZXAgZAC0oaW/Xo6impbHrqri1mfMEzo7pF
         IKGQueJ5U/qk1ddlatQa2fp9uw+sRfnvakqkf3nyFiSRzPPclpLfxLsVW+4FM2E48746
         dqIwc0zpfuciegEPfdLJm5t6IfBvMX9WDOGkhRaUh7l7j0ys9WdJwWzyvSmUrLknpCRt
         lu+qdb+QW6ILfnQuKTomEWW1eVP+rG+ZNTGCPqTvJmch329pS6u0YxLOHYkMzfZNnCEt
         IqPg==
X-Gm-Message-State: AOJu0YyjXt1HmlJcbHzmmD0AdPsY7E0idty8/wCsPwUFWeM/CwuyYgWt
	x8ia16csvptrm/A68f0/2hXfgbEr06HMvf9Kw3w55k8r7Zzr2J2EXhyTsq6s0Q==
X-Gm-Gg: ATEYQzzqLkCzSfy0kbJsBzk6EDGbDgqCBZayjCxAcizq2uBtHLfgKFsjEZzGw8drmIk
	xq1auKJCJ33VTlwzabElxydb8xWIpkMa0Lfg7ED52/vLK/PlXp9cNQt9nSzMSqPCDUg4QV08Qhi
	56P2EI8LF8Tnv+MaLVHPQXq59eZQS8HuANmkq2mHHAVWBixoKEoKOaJJatzDilpnWLWBGdMXqAd
	VXiEr0TMaOQiYiQ5UvN+T1W3UoTcYaYN3g72o4dhkYW/eP8SpeUBUGxcvoeQc+rgaFBHMFZlnHU
	ac8eJrzBrG0Xmu1X3oS9d103O4z6ohdHOnCjU2c1zozK17NXW+WsIT2q4ejf0wEaO5lGh6fEs0V
	7Nab223dXlK7qiJ9ix+NXxFfnAw79+6NChaZwwRlIgaxW66NnuenVmHVASwRMcHzKqSwxIkw0WR
	IkloX8Fiq+u1SQSqlz7NmwP3ktRxj86iZJDsTjiac=
X-Received: by 2002:a05:620a:4050:b0:8cd:a828:fef7 with SMTP id af79cd13be357-8cde14bcc5bmr290949885a.30.1773730820081;
        Tue, 17 Mar 2026 00:00:20 -0700 (PDT)
Received: from [172.17.0.2] ([40.76.117.229])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda1fbcd23sm1593050385a.1.2026.03.17.00.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Mar 2026 00:00:15 -0700 (PDT)
Message-ID: <69b8fbff.050a0220.a09fb.a440@mx.google.com>
Date: Tue, 17 Mar 2026 00:00:15 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6884394527225419745=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, moonafterrain@outlook.com
Subject: RE: Bluetooth: btintel_pcie: validate RX packet length against buffer size
In-Reply-To: <SYBPR01MB7881DD95CE054BC53AED4A21AF41A@SYBPR01MB7881.ausprd01.prod.outlook.com>
References: <SYBPR01MB7881DD95CE054BC53AED4A21AF41A@SYBPR01MB7881.ausprd01.prod.outlook.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6884394527225419745==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1067754

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.22 seconds
SubjectPrefix                 PASS      0.12 seconds
BuildKernel                   PASS      26.42 seconds
CheckAllWarning               PASS      28.71 seconds
CheckSparse                   PASS      27.52 seconds
BuildKernel32                 PASS      25.53 seconds
TestRunnerSetup               PASS      573.77 seconds
TestRunner_l2cap-tester       PASS      28.55 seconds
TestRunner_iso-tester         FAIL      36.80 seconds
TestRunner_bnep-tester        PASS      6.50 seconds
TestRunner_mgmt-tester        FAIL      115.39 seconds
TestRunner_rfcomm-tester      PASS      9.53 seconds
TestRunner_sco-tester         FAIL      14.39 seconds
TestRunner_ioctl-tester       PASS      10.27 seconds
TestRunner_mesh-tester        FAIL      12.58 seconds
TestRunner_smp-tester         PASS      8.90 seconds
TestRunner_userchan-tester    PASS      6.87 seconds
IncrementalBuild              PENDING   0.47 seconds

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
Mesh - Send cancel - 1                               Timed out    2.676 seconds
Mesh - Send cancel - 2                               Timed out    1.992 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============6884394527225419745==--
