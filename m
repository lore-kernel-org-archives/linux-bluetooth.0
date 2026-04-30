Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3A140DFD7
	for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 07:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777535380; cv=none; b=W4hye+T3/+1iisE2XkWbaeJNeZa2CbNmQp8m3KyqyDm+pxdDRJotrzxkdpykYqhQxQcP2/2pYKKjtSGBKaLJhWTJVJjvjqpIlt1+1zC2TnpzKffJf9wB/Bn1pVZQ3rjx3DqSpvCMWw+FetGEljoVfUvrqjzj+pXVqElbwxDB1Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777535380; c=relaxed/simple;
	bh=qKnWZhRDnIftml40DJ+ulkfM84ZBSbURA6PjCbViXyw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=pfLplRmIKxZ0Zwmzz5E+wem5xwOETMAtloedYLPhQFXjZqz712GeD9w0VzvMXAl7OCHPqnSh6Ta8qElM6zQlFrC0Yue+lR5+Sc0cQ4q0N1XCOkh80Ox8Rmio07a6n6HDRoPdF1ojTe334+gKuXenN+4j/k7fUoYbbU0ii8l0pWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kziUCNQj; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kziUCNQj"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2ed0a45e970so712748eec.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 30 Apr 2026 00:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777535377; x=1778140177; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qFlc7hEdGKGDBu2RmQA8cJWVMuMPW7Y8p9MS0Adc9JE=;
        b=kziUCNQjjj1fC8NvzkjeLVr+ZxP0PYdZ4KRMlY1O4A/DWMVZvEJ2x2SM/AAgFZoCf/
         O6exBBjjd1B2Y0neQjgF99CjT1N8Oa6FUjT2e8fWTln2WbFKV7i56OHiNrxJs01PW1Uc
         ZUuNCH0lcdX5ZPJ5tqy/sbu0T26moNhfTrHNCQIQKAZ2OKK6gT30b4C4uCBtYTE373tH
         3vXb+GOOECER7cgbCrby6ADQ9nIDVGbKEh/8OoZNPeDYfaI0yrKQgCGQgwALyvLkdS8n
         FzQbML4zlfdmcOEXKZ+fH/tlYmgmDGtp3BuokDwH93ofOUYDV9Epnvkf5JsWWoMFUYJx
         shFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777535377; x=1778140177;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFlc7hEdGKGDBu2RmQA8cJWVMuMPW7Y8p9MS0Adc9JE=;
        b=kMXXS0EhrIC40ZMMeJI6mMUyvRb+5wr7zkEj/jS8YQPgrL3eDZQ/ZluU4QsJm0lvIU
         zyGHHKYprQiLDLMgJw+HPAicQ2Kh9soSoyMMl1E+GqY8nCf8orH+Oe6+aKvhDb1tkrB8
         dkkTGh6s4UKTzrEYWX/JppmeuOUtnUPTKHqmtw3Ztg6xu1BTcMxI5RqEPaegqPDZpHTZ
         RqEUrMdaTGKlkE0EnE0uevq+Y3n39TcrBVc/4y8Ksc4tTSlSpFGoYzXbvQx67QcBNAVm
         Kz5LOXczoignMpFDUt/f1IoBotxnI4KseeraUNJBjbZ477WqZH3M2/DKRn1hg5hgbijf
         qlaA==
X-Gm-Message-State: AOJu0YwDq0K6e2h+x2Qako7csHAAfrOe7gMayFxJxCTlPqXGRnExXKlw
	qZaYRG9Owu6+DPtFKHAVX1QuNxehNgmzZH6ClagNHl3G4gBTg1Q/qwtn67ZV4g==
X-Gm-Gg: AeBDiev+xKBD749qbuvEPeWAH6M8zIT6a2bLi8BV1zZvaqp+mcj6n0FVX3miwoS4gyM
	ekWWVrneDM08Z8mukedjJl3r1NtfvU8t4EURWQkKDR8RmdbAFQsqr3LGFKAaiT87swxqOecPfX7
	HdgF+cSvo2POcEfnrsCeZL+TUiwGm5uannKbRjtu1KTSptBTg4s4mFSyBd5hOxisYCxN/oV/Wue
	slglaXmE4YoFmGH9dSjPx+hFuyVcBMrE+fFUurQi1HiHclM/y8o4ovFCtKjDFT/v/CYgU96sHYz
	t5SzkCUcCLzfdMJg8IZbls+G90bOnXenZx+m+By93XhnHsIa1fLnSdBhZh+NdQ0pN6armp25+TJ
	jVhMCai3yem2s7TPmVh4evge+ZZD0A08yB3su1bpu2HO26hxQMXFOy53AK0SGPeP0n3OV/b7/RI
	gMoTaE5+dmXUtRgpNGxKZUERHDL1OGeQp0gsCA1HcjKw==
X-Received: by 2002:a05:7301:e2a:b0:2c5:60d0:702e with SMTP id 5a478bee46e88-2ed3d7b8d87mr688414eec.18.1777535377214;
        Thu, 30 Apr 2026 00:49:37 -0700 (PDT)
Received: from [172.17.0.2] ([57.151.137.145])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ed46afda3fsm2333850eec.30.2026.04.30.00.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2026 00:49:36 -0700 (PDT)
Message-ID: <69f30990.050a0220.1d833e.9dc1@mx.google.com>
Date: Thu, 30 Apr 2026 00:49:36 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============2431009763684334384=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, danilklishch@gmail.com
Subject: RE: [RFC] Bluetooth: fix Set Public Address on controller in HCI_AUTO_OFF grace period
In-Reply-To: <20260430045522.7881-1-danilklishch@gmail.com>
References: <20260430045522.7881-1-danilklishch@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============2431009763684334384==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1087873

---Test result---

Test Summary:
CheckPatch                    FAIL      0.63 seconds
GitLint                       FAIL      0.26 seconds
SubjectPrefix                 PASS      0.09 seconds
BuildKernel                   PASS      25.03 seconds
CheckAllWarning               PASS      27.56 seconds
CheckSparse                   PASS      26.39 seconds
BuildKernel32                 PASS      24.04 seconds
TestRunnerSetup               PASS      523.74 seconds
TestRunner_l2cap-tester       PASS      27.31 seconds
TestRunner_iso-tester         PASS      34.75 seconds
TestRunner_bnep-tester        PASS      6.36 seconds
TestRunner_mgmt-tester        FAIL      109.68 seconds
TestRunner_rfcomm-tester      PASS      9.47 seconds
TestRunner_sco-tester         PASS      14.20 seconds
TestRunner_ioctl-tester       PASS      9.96 seconds
TestRunner_mesh-tester        FAIL      11.22 seconds
TestRunner_smp-tester         PASS      8.64 seconds
TestRunner_userchan-tester    PASS      6.74 seconds
TestRunner_6lowpan-tester     FAIL      8.59 seconds
IncrementalBuild              PASS      23.68 seconds

Details
##############################
Test: CheckPatch - FAIL
Desc: Run checkpatch.pl script
Output:
[RFC] Bluetooth: fix Set Public Address on controller in HCI_AUTO_OFF grace period
WARNING: Non-standard signature: Assisted-by:
#148: 
Assisted-by: Claude:claude-opus-4-7

ERROR: Unrecognized email address: 'Claude:claude-opus-4-7'
#148: 
Assisted-by: Claude:claude-opus-4-7

total: 1 errors, 1 warnings, 0 checks, 14 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

/github/workspace/src/patch/14548392.patch has style problems, please review.

NOTE: Ignored message types: UNKNOWN_COMMIT_ID

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


##############################
Test: GitLint - FAIL
Desc: Run gitlint
Output:
[RFC] Bluetooth: fix Set Public Address on controller in HCI_AUTO_OFF grace period

WARNING: I3 - ignore-body-lines: gitlint will be switching from using Python regex 'match' (match beginning) to 'search' (match anywhere) semantics. Please review your ignore-body-lines.regex option accordingly. To remove this warning, set general.regex-style-search=True. More details: https://jorisroovers.github.io/gitlint/configuration/#regex-style-search
1: T1 Title exceeds max length (82>80): "[RFC] Bluetooth: fix Set Public Address on controller in HCI_AUTO_OFF grace period"
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.096 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    1.834 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc7-gb8928b8010b2 #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff888002735940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffff9c44faa0 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (rtnl_mutex){+.+.}-{4:4}:
       lock_acquire+0xf7/0x2c0
       __mutex_lock+0x16b/0x1fc0
       lowpan_register_netdev+0x11/0x30
       chan_ready_cb+0x836/0xd00
       l2cap_recv_frame+0x61bb/0x88e0
       l2cap_recv_acldata+0x790/0xdf0
       hci_rx_work+0x500/0xd00
       process_scheduled_works+0xba7/0x1a90
       worker_thread+0x514/0xbb0
       kthread+0x368/0x490
       ret_from_fork+0x498/0x7e0
       ret_from_fork_asm+0x19/0x30

-> #3 (&chan->lock#3/1){+.+.}-{4:4}:
       lock_acquire+0xf7/0x2c0
       __mutex_lock+0x16b/0x1fc0
       l2cap_chan_connect+0x74e/0x1980
       lowpan_control_write+0x523/0x660
       full_proxy_write+0x10b/0x190
       vfs_write+0x1c0/0xf60
       ksys_write+0xf1/0x1d0
       do_syscall_64+0xa0/0x570
       entry_SYSCALL_64_after_hwframe+0x74/0x7c

-> #2 (&conn->lock){+.+.}-{4:4}:
...
Total: 8, Passed: 8 (100.0%), Failed: 0, Not Run: 0


https://github.com/bluez/bluetooth-next/pull/135

---
Regards,
Linux Bluetooth


--===============2431009763684334384==--
