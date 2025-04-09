Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E4E219312
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Apr 2025 22:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744238089; cv=none; b=n8k5uy0xxIe6eVY/kfp4fk4wz8aXVj+OY49ogkEfcRdaqBolYEAUsYypiCCv4mVzZq7AYcUDN+2A8dflZbbikzBsSwj6qYHk7JvVjDnXwoSDELyugJEk8E+xDyU8fEu0tyuUVEWK0shh3n8+gX4at2NjSIVc41aAvquwhKOMm/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744238089; c=relaxed/simple;
	bh=uagqODZ+pKwR/+ierBw9Ml6Hfqu/zNVzxI359bVfj1c=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Ntk+5xrTJun0nOipyhDJgRJppKyEuWayuHlMiF0zqpLomh0iruW3IfYdGKZ7JUgmSt/JIbCI1/Zbva87TJdLkdYLXiuvEgaxQlpLNTj3/BBi4/B2sNZqRbeIT1fASE+wQkfvajlw59fjukPGNsixqQTcfB1AOHd3bzxBLtte9Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbsKaqf1; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbsKaqf1"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-476ac73c76fso1313851cf.0
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Apr 2025 15:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744238086; x=1744842886; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LrwVfqflHc88ZNH+8zl4Z5eWGP86dGfdbwsVSeG61AE=;
        b=PbsKaqf1nnyw7Kt/zIXPdWRLYFZQ3nv1SfHbbQMbn/gh2KRCI6mc5Gt8Hb0HwQ9znH
         /lI8FSW5nMk/htNkg51yFCnmKKhcEdgcTdw412rLZX5nqVmNSKIg1sCVcrAiUPd2PgH9
         +YPRg1ucl6SKaSBM9cQLhkvKoDmQR5fPEdyQZ09eA4nmDM8YpEfHbZsFdAYSLzNt73Gu
         kVq8/NJB/K38awHk9kHkgQPRWg/4PuU8nBSg5DPiozdWHDwFl/8eQ7s7Jl4AkVpTq8SU
         WxEeo10QZDOjfBUhaLjLMeo1UQOg1ZU8uMcuCtMcrGxkQEB6LejTGLXq2AIZxhlYFQnx
         j9dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744238086; x=1744842886;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LrwVfqflHc88ZNH+8zl4Z5eWGP86dGfdbwsVSeG61AE=;
        b=uqxUZqGTZXeiwBmq/Epq+Ntu/mgDe9M2zGZuFzUX6nCKolYQlsLBk8e2vw+xWLrouN
         ya3nerSYZLPqUZhh/uP1Ncs2zXqI2Hg58Jd/10t20Jr+1OIYScumeHcNlYD969K8RRQS
         gTpi7McOYKZnBPxrU7UQjuGhmUh4tKgcOSijScua31Q8+CQPN0YbxtTWYkeLjQrhHdpH
         bte5ztGWJr1zpfduN3/S3c0yLDiqNrPR3yfCIRZpRmWAYpgPtP/QhZdBBrDe/OR3ayS7
         2/3/Sua6TUgUBuGuIdS1FgeSCD/YFdlnxwjw/I+1J7Z8/SKOUOwCVbpy0/+o2Zj7FMH8
         DQhA==
X-Gm-Message-State: AOJu0YxnY22WJFPnCNqbJZqe9T7UyQxas0/kfH7HY6MZY4MsKMTthzvI
	0KdnWpvErSJXhnXqApuZFeUJcvj0TLWoOFdEBk8PRGdjI4UHeSZewXaMYQ==
X-Gm-Gg: ASbGncs9F11PxAebVMrrL3jQ5u+hg7KiO5bJJWcdh7Ku7GAQlsRimmGg3oXjTqpLw4n
	v5jQMSHyhr5mYR0RUyk+DIb9+qUhxdCbcHF1bh0pNdteBSXN1c9fyWedwsr4qIVmpng6gcRVBbs
	u5FK54WVxjbGzkf7+FsMNMIu7FwdThJ1fvHglSgeMO9wpEnykwUF/H/e8mxa5Yr/saou71ACDug
	wGOVbTenYUjU8WluJsJQZqBgf5d9G9ebzuf+IZ8UfCZWEEIMF6/d0WRF2P2hde29moXry6NV98o
	sVNTl929Bdz3aqsYwHkg6Wr1eeiTbNnZ/Zk8HO4ax8lRaF1B0GtFvLQ=
X-Google-Smtp-Source: AGHT+IEVZeQXE5K8BisN+3Ap0MI9VSsOfekWut7r6iqDOCyJfXvWYFq96ij+KGhAKUtzDY0W+qjgZw==
X-Received: by 2002:a05:622a:205:b0:478:f00f:4440 with SMTP id d75a77b69052e-4796e36318amr2098091cf.40.1744238086088;
        Wed, 09 Apr 2025 15:34:46 -0700 (PDT)
Received: from [172.17.0.2] ([20.42.51.85])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-47964db6ab1sm12524931cf.26.2025.04.09.15.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 15:34:45 -0700 (PDT)
Message-ID: <67f6f605.c80a0220.1670a1.513e@mx.google.com>
Date: Wed, 09 Apr 2025 15:34:45 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============5996942061022168302=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Subject: RE: [v1] Bluetooth: hci_conn: Fix not setting conn_timeout for Broadcast Receiver
In-Reply-To: <20250409201455.345144-1-luiz.dentz@gmail.com>
References: <20250409201455.345144-1-luiz.dentz@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============5996942061022168302==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=951731

---Test result---

Test Summary:
CheckPatch                    PENDING   0.33 seconds
GitLint                       PENDING   0.19 seconds
SubjectPrefix                 PASS      29.43 seconds
BuildKernel                   PASS      24.06 seconds
CheckAllWarning               PASS      26.49 seconds
CheckSparse                   WARNING   29.70 seconds
BuildKernel32                 PASS      23.68 seconds
TestRunnerSetup               PASS      453.02 seconds
TestRunner_l2cap-tester       PASS      24.70 seconds
TestRunner_iso-tester         PASS      30.66 seconds
TestRunner_bnep-tester        PASS      5.78 seconds
TestRunner_mgmt-tester        FAIL      123.23 seconds
TestRunner_rfcomm-tester      PASS      7.72 seconds
TestRunner_sco-tester         PASS      29.02 seconds
TestRunner_ioctl-tester       PASS      9.50 seconds
TestRunner_mesh-tester        FAIL      8.16 seconds
TestRunner_smp-tester         PASS      7.12 seconds
TestRunner_userchan-tester    PASS      5.50 seconds
IncrementalBuild              PENDING   0.70 seconds

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
net/bluetooth/hci_event.c: note: in included file (through include/net/bluetooth/hci_core.h):
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 490, Passed: 485 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
LL Privacy - Set Flags 3 (2 Devices to RL)           Failed       0.171 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
BUG: KASAN: slab-use-after-free in run_timer_softirq+0x76f/0x7d0
WARNING: CPU: 0 PID: 66 at kernel/workqueue.c:2257 __queue_work+0x93e/0xba0
Total: 10, Passed: 9 (90.0%), Failed: 1, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Failed       0.100 seconds
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



---
Regards,
Linux Bluetooth


--===============5996942061022168302==--
