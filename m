Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B615D3E6385
	for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 09:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776937677; cv=none; b=Fd0c3/8Tp0rYAKHPCowN8qDEyh2lBwT72FC7WIhiKXzTkQU8CV5a0+N7spzkS83tubkzCVlJalZGn7NOG4wfeAPRUdvFncDcvZ5qoV8LVynxUjxJ3DaoacQHiVpRTPZgA9dXgc4yCGGUO60J+YICHOkU6Ph8zGUZl0cVo3pZvwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776937677; c=relaxed/simple;
	bh=Hg/IAaLLMNWaE+YOzjOm+uCO6p8LMxPRv+Ye8Ftd/Fs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XQGjPclAVQIyueOBg1aoL94uO+3vbAlYM6kEESa9OhsRITuV0i3reCPEbFjYG85QdSfWv1oQq0b6NlClB3OU4pJyy6IXkMbXFe+oip0tL8KxYm2s+aTD/XWT82O9RCNqQDXUBZHb/fYiqqVap3GA1MV2t4U8uOxkiaulkfj01A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMuLT1eB; arc=none smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMuLT1eB"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-12c565476d7so15929842c88.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 23 Apr 2026 02:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776937672; x=1777542472; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=volEzn6t23D5XoEdFuWZrrqTLOGYQQtdE/t750VBd4o=;
        b=UMuLT1eBKLZc2Z7QlLwqp/lqcWCnQ6qf2AYApuyrcHuhF5jFcldj5d7LJGMQjlWuS6
         D3/3U94Q6MGWrLIfnZfXkuU8PaiUsdkWySfKftjwS1FjNqOH4UQxFPa1tY7vWF9+5igi
         OKXPZ4GlA1PhnalTe+DXCJ6LZ+dPXXTu8c7+tdLwZR/yo3uF/0cVgEA4d6dneF6lq60h
         ypeToYIOg9zu48JqYMji4weoLY5pgWcoNrTIDbVTgXMYaCu/YSE2LtO8N/MoAUJFFzFO
         IkQotEmkHL3b7f5AiGWvH4soiQn9U+eyBRbsN9sIZCjHF0CRTUqQaQN+0YhNEm5GtYR5
         6FDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776937672; x=1777542472;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=volEzn6t23D5XoEdFuWZrrqTLOGYQQtdE/t750VBd4o=;
        b=GNL6tXxDT8/tTOOMrA+tM1yxsARgmZZUUddTN3K/Yb/CRfoYGUbva7lzi4cQ/ieP6y
         8gnXov0nnmx60qsYYPEtCVk1TNPRs8W8pNrKRfMkopQp0fUfB7vPY6gPZo8APsTJmS/7
         fWhCP4oVNg0lAKUt0BldWWVkv5QyBpiL6C0fz3Zv6OASXKEvouLIhhyCd6RFjywi4PqN
         fEd+TSV59mUZpwswtMdlQbpmDrKwrTAX94K+LJYLkvp9QtFpOH0cTOr0txYgZYvssd3C
         VjRBGE7S/FUwVIhhDMcQp/XVRbOUgUrNjrxyy232zefGldLN0aSfEGVcZ2YsYuO+dBER
         1U0w==
X-Gm-Message-State: AOJu0Yy/ZxUcWiScYthYjpJ59ecVCMSqjPSMdxLZRBgzkouzVmk8G0yD
	bvrrxtUsNwnllM/UqldswXOxAOMeygpEwbGnVnZYk3wbH6FvAfg1BW+fyE2F3A==
X-Gm-Gg: AeBDiesD0lbTZrmfAU/cwsqjQU1O9Uy9KinqH3YvS9m8OWlA13k65Wx8c2N/UyHOfQi
	C1vOCPXuHnJxm9QGlSOP+TJHCI1f8EDJwe3hOk7IH8NMjpkmKQ53atUOF2tudOTbCUgN5Sv8+wR
	YGKtfRuf3CofnwgLJQE+oN0yuzvN4AQW89iGx7p5IiFt73Mp5l/eo65XlY5VoPNfHywFammD/oX
	3LPz7kF/cEm0X2AbLBzUnBAspDd4OnBpnNaYukC5LIJEyH4NmAb79tNsDlF6NEjIFNXu+Xi/0Pv
	bNYBNw1Zykdk9b8tkGPs6tsMUh6cRQQJs+jdJfALTsEsa+Tqn8oBx3BUmSNI9BHz92a9VBcjFu9
	Cn5dfRTLYGWfN1AISdqmvZWMvWyEIMF0/T+E8/QIyyzIdmajdpProeakg4DT6F75Bkd5BDeSOO4
	8N91NL+USUDkHhu9TlHuDORl9HJEEjK1CkjpI2NxG7gdIU9FKWZF3/BQ==
X-Received: by 2002:a05:7022:513:b0:12a:b3c4:c3b6 with SMTP id a92af1059eb24-12c73f998b1mr14143148c88.21.1776937672384;
        Thu, 23 Apr 2026 02:47:52 -0700 (PDT)
Received: from [172.17.0.2] ([172.208.158.211])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12db8684f90sm8281618c88.13.2026.04.23.02.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 02:47:51 -0700 (PDT)
Message-ID: <69e9eac7.050a0220.1ec926.4eb6@mx.google.com>
Date: Thu, 23 Apr 2026 02:47:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============8168401366507592257=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, dmantipov@yandex.ru
Subject: RE: [RFC] net: skb: on zero-copy formatted output to skb
In-Reply-To: <20260423073638.778334-1-dmantipov@yandex.ru>
References: <20260423073638.778334-1-dmantipov@yandex.ru>
Reply-To: linux-bluetooth@vger.kernel.org

--===============8168401366507592257==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1084557

---Test result---

Test Summary:
CheckPatch                    PASS      0.82 seconds
GitLint                       PASS      0.24 seconds
SubjectPrefix                 FAIL      0.09 seconds
BuildKernel                   PASS      26.07 seconds
CheckAllWarning               PASS      33.93 seconds
CheckSparse                   PASS      27.78 seconds
BuildKernel32                 PASS      26.43 seconds
TestRunnerSetup               PASS      578.11 seconds
TestRunner_l2cap-tester       PASS      28.36 seconds
TestRunner_iso-tester         PASS      46.37 seconds
TestRunner_bnep-tester        PASS      6.63 seconds
TestRunner_mgmt-tester        FAIL      115.81 seconds
TestRunner_rfcomm-tester      PASS      9.54 seconds
TestRunner_sco-tester         PASS      14.67 seconds
TestRunner_ioctl-tester       PASS      10.66 seconds
TestRunner_mesh-tester        FAIL      12.30 seconds
TestRunner_smp-tester         PASS      8.84 seconds
TestRunner_userchan-tester    PASS      7.13 seconds
TestRunner_6lowpan-tester     FAIL      8.54 seconds
IncrementalBuild              PASS      25.21 seconds

Details
##############################
Test: SubjectPrefix - FAIL
Desc: Check subject contains "Bluetooth" prefix
Output:
"Bluetooth: " prefix is not specified in the subject
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.115 seconds
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.732 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc7-g9a5a979a67e1 #1 Not tainted
------------------------------------------------------
kworker/0:1/13 is trying to acquire lock:
ffff88800233f140 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffff9264faa0 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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


https://github.com/bluez/bluetooth-next/pull/117

---
Regards,
Linux Bluetooth


--===============8168401366507592257==--
