Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD7F17A2EA
	for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 22:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776291287; cv=none; b=qqaO2pDL0kkMEGix/mQqztTNhtcJGGuPuY14YSq8zHJNprtzxKbnpgA/6KB3lvfmeOqtHynBtMEJ5W37sbwfcOYbg5pj+TZjDEmaSEE4RJEUm3KU6k4y2EjCHU1Xrh5Zym30y8+RFiUXglaHPk5GHFDp4GmV6GDDiIJnnrYY5w8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776291287; c=relaxed/simple;
	bh=equ+E/Q5QXPDuBONsEpY3JmWiIsloISnIaGtKfLJtQs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=XT5elgJUwLUYcMjNDX1yS1sbkcVdE4xFTeHAtlGZOJYdIFNcikNrw/6RWpoE1HicwW99pBKRO9hcI49evCdfrs1zP6hwHye2KC8MXSrbH/kKCiscZGoPOHQ8MdbythZ8mUFTKAMLSzow7LoPvuaOizI3meYGDFo72idGmLFJCGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gpcm4Dtl; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gpcm4Dtl"
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-8a05c18d3e2so221886d6.1
        for <linux-bluetooth@vger.kernel.org>; Wed, 15 Apr 2026 15:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776291285; x=1776896085; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Qk2CKtnyoTYayjDQoFw77WcxYiu7tHAWM/FPDQCIXck=;
        b=gpcm4DtlQ8iWAXUwaTc7Q8S/CU32FgTNrVBDad+k4wJ3VYLpK9z/DEw+UNl/pfHK5W
         FWgkHUJi4RG61VPnYS2SIOVBeCiYXdeMwPE3miYgp5lWZYVr8gAtg9k9stWmyz57Z8dx
         yj44fB3hPEPqdHnNiWGptLWVd+aLXlnEb40+/vOusUS3iGcC+cy7VlVMpZ5WxnBcgT07
         BcvWdrbbsHY1XRTx7yEVMCxNnnbXRRUN+ULR9bWaZMsmjV3w9q9Rl0LCXmrFkHmUBgFM
         yhJymnP/21Z25zzQf+WUga+RapIwJEVYsQlRLU+MitSgyGoaExX43f5rp3DQNUDLIlOt
         PDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776291285; x=1776896085;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qk2CKtnyoTYayjDQoFw77WcxYiu7tHAWM/FPDQCIXck=;
        b=otC5iQLlBA6XT1+kw0+KH1UxsKP00+T1E7uhNrDP8pEANx779TmNA/xJHB/iRV7S+q
         1UKMz45yMJpjB19Z17BaWltsmpQvyT/rZHjre1oY/yrF6J5gkJzSDRfa0KggUWvT6lv/
         NwdaNetFLwq83QenZEzBe4504eOwRAu5vAbr3CmbsUHyygceQ36OA7X7q18l21BfC1f/
         f1Ot6+f0QNmfhtLqHRrm4bDx9BH9yy+8C0EAMWl4bPGDGG1oYOp6W1NbvpcLm3H6Sd/P
         G2x1H5tlD0OG3MKZJ62ttnahiNsVrwUljADfbFtPkAe5hgY1MdIkoUIp57z+mRPDRIwT
         7c2Q==
X-Gm-Message-State: AOJu0Yy2yXRIfLYD7hrKXHOOFLTCLPdPQ/sigFhAkrO3lhczU/qiDepv
	v2fPHNmtURa+nqOZhUJSC1r4/qgKfPkzgZaIg8nPZz4LZkdEEQK/uEfae7eQnw==
X-Gm-Gg: AeBDietlDv7jarXicL7/r1Vb4/nPAE+2Zh5Vin5H9H0jAh6ngtcQ/eaFqFBMaLnnclq
	fTVIlLIFxg0cDqfjQyl+m8tufki81Vihl28dD42uxa5XBIFF5DGA/9SHAJCINSH23Vb7jmV6xxu
	NSLOJUHEwdHPgjSdq5rTaCg0GGZ9IeffYEylpCo2TjPMPQM0Vw6hBNndLLBJKjxPPsuYIwQMLVU
	10VcUWbrcCuvIwna9dbrbvXmoZX6X2XPh23zdsGFivViFeR7lWWllGKNFQNkwVUbt1jYZe09ltI
	QVCHm0XZIJRyXJoLMUupun1OFEXrOAySkbYCiN3avZC7ZTyKuqF8gM1SFiPbbEfSiwBJqWHZg78
	TMLfwXFnodVa9U+V6mu4juNq9xyuPlsjN7Wp+aOemaY8PmsyIw0gaTFXyEfqY/eWVAs+mjX8zYb
	PAHpXtEIIDvHZEbKJ/TM6bav8ejF/3dM5jBABMF2Hqng==
X-Received: by 2002:a05:6214:f2b:b0:89c:4b37:7106 with SMTP id 6a1803df08f44-8ae7605ebddmr21387606d6.34.1776291284930;
        Wed, 15 Apr 2026 15:14:44 -0700 (PDT)
Received: from [172.17.0.2] ([20.228.220.113])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ae6c993a3asm21685766d6.22.2026.04.15.15.14.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 15:14:44 -0700 (PDT)
Message-ID: <69e00dd4.050a0220.153b60.c880@mx.google.com>
Date: Wed, 15 Apr 2026 15:14:44 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3981507281170314087=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, oss@fourdim.xyz
Subject: RE: [v3] Bluetooth: L2CAP: Fix null-ptr-deref in l2cap_sock_get_sndtimeo_cb()
In-Reply-To: <20260415205344.2368172-1-oss@fourdim.xyz>
References: <20260415205344.2368172-1-oss@fourdim.xyz>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3981507281170314087==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1081744

---Test result---

Test Summary:
CheckPatch                    PASS      0.74 seconds
GitLint                       PASS      0.34 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      26.16 seconds
CheckAllWarning               PASS      28.46 seconds
CheckSparse                   PASS      27.50 seconds
BuildKernel32                 PASS      25.27 seconds
TestRunnerSetup               PASS      567.62 seconds
TestRunner_l2cap-tester       PASS      28.21 seconds
TestRunner_iso-tester         PASS      36.11 seconds
TestRunner_bnep-tester        PASS      6.63 seconds
TestRunner_mgmt-tester        FAIL      114.19 seconds
TestRunner_rfcomm-tester      PASS      9.73 seconds
TestRunner_sco-tester         FAIL      14.29 seconds
TestRunner_ioctl-tester       PASS      10.49 seconds
TestRunner_mesh-tester        FAIL      12.35 seconds
TestRunner_smp-tester         PASS      8.77 seconds
TestRunner_userchan-tester    PASS      6.84 seconds
TestRunner_6lowpan-tester     FAIL      10.86 seconds
IncrementalBuild              PASS      24.60 seconds

Details
##############################
Test: TestRunner_mgmt-tester - FAIL
Desc: Run mgmt-tester with test-runner
Output:
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.111 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-ga05988142481 #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888001946240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff888002094c20 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&conn->lock){+.+.}-{3:3}:
       lock_acquire+0xf7/0x2c0
       _raw_spin_lock+0x2a/0x40
       sco_sock_connect+0x4d7/0x1280
       __sys_connect+0x1a3/0x260
       __x64_sys_connect+0x6e/0xb0
       do_syscall_64+0xa0/0x570
       entry_SYSCALL_64_after_hwframe+0x74/0x7c

-> #0 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}:
       check_prev_add+0xe9/0xc70
       __lock_acquire+0x1457/0x1df0
       lock_acquire+0xf7/0x2c0
       lock_sock_nested+0x36/0xd0
       sco_connect_cfm+0x358/0x8d0
       hci_sync_conn_complete_evt+0x3d3/0x8e0
       hci_event_packet+0x74f/0xb10
       hci_rx_work+0x398/0xd00
       process_scheduled_works+0xb16/0x1ac0
       worker_thread+0x4ff/0xba0
       kthread+0x368/0x490
       ret_from_fork+0x498/0x7e0
       ret_from_fork_asm+0x19/0x30

other info that might help us debug this:

...
BUG: sleeping function called from invalid context at net/core/sock.c:3782
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 117, name: kworker/u5:2
preempt_count: 1, expected: 0
RCU nest depth: 0, expected: 0
INFO: lockdep is turned off.
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-ga05988142481 #1 PREEMPT(lazy) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.13.0-1ubuntu1.1 04/01/2014
Workqueue: hci0 hci_rx_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x49/0x60
 __might_resched+0x2ea/0x500
 lock_sock_nested+0x47/0xd0
 ? sco_connect_cfm+0x358/0x8d0
 sco_connect_cfm+0x358/0x8d0
 ? hci_debugfs_create_conn+0x190/0x210
 ? __pfx_sco_connect_cfm+0x10/0x10
 hci_sync_conn_complete_evt+0x3d3/0x8e0
 hci_event_packet+0x74f/0xb10
 ? __pfx_hci_sync_conn_complete_evt+0x10/0x10
 ? __pfx_hci_event_packet+0x10/0x10
 ? mark_held_locks+0x49/0x80
 ? lockdep_hardirqs_on_prepare+0xd4/0x180
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 hci_rx_work+0x398/0xd00
 process_scheduled_works+0xb16/0x1ac0
 ? __pfx_process_scheduled_works+0x10/0x10
 ? lock_acquire+0xf7/0x2c0
 ? lock_is_held_type+0x9b/0x110
 ? __pfx_hci_rx_work+0x10/0x10
 worker_thread+0x4ff/0xba0
 ? _raw_spin_unlock_irqrestore+0x2c/0x50
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x368/0x490
 ? _raw_spin_unlock_irq+0x23/0x40
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x498/0x7e0
 ? __pfx_ret_from_fork+0x10/0x10
 ? __switch_to+0x9e4/0xe50
 ? __switch_to_asm+0x32/0x60
...
Total: 30, Passed: 30 (100.0%), Failed: 0, Not Run: 0
##############################
Test: TestRunner_mesh-tester - FAIL
Desc: Run mesh-tester with test-runner
Output:
Total: 10, Passed: 8 (80.0%), Failed: 2, Not Run: 0

Failed Test Cases
Mesh - Send cancel - 1                               Timed out    2.783 seconds
Mesh - Send cancel - 2                               Timed out    1.994 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-ga05988142481 #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff8880026e9140 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffff94a4d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #4 (rtnl_mutex){+.+.}-{4:4}:
       lock_acquire+0xf7/0x2c0
       __mutex_lock+0x16b/0x1fc0
       lowpan_register_netdev+0x11/0x30
       chan_ready_cb+0x836/0xd00
       l2cap_recv_frame+0x6a06/0x8920
       l2cap_recv_acldata+0x790/0xdf0
       hci_rx_work+0x500/0xd00
       process_scheduled_works+0xb16/0x1ac0
       worker_thread+0x4ff/0xba0
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


https://github.com/bluez/bluetooth-next/pull/91

---
Regards,
Linux Bluetooth


--===============3981507281170314087==--
