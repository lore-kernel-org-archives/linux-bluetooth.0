Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8C21F91D6
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 20:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775764861; cv=none; b=fCpZO8BXLiX8yQHKMIuoHgFz1KJ3ZkOctNWXAPd5/IDz3Dgsd2hGoBgz8GWdkEGNQsJOKT8j8T/VyTMIB9S/Ww72yBaPm0pO6afj9TIOA+chyR0mJWCk69uZXV8HeKYvekU0mVOpRfOz7HtFk8pnvIaRWErhZVHchm4A2mvGEU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775764861; c=relaxed/simple;
	bh=IdIquhUet61y2afsLOQM4sifGfKeNqfA6DhYTlPw5eY=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=VixnlNRvEUFoGhgFJVFjQVL1ORjk9DCUjYfdf+cGIxYEC2cj4NE1FHWhWBzUPDWblC1IThEWM4fGwcdAyBjt0+Bz20NloRlsIhMLiqhxA/rf8OdAhYx9bGZZyO0V71FTI9NNUnNgOQBcH3yeXpw/Q3n9vS3t+p74LcUmsGPBDic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uh5QuIoc; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uh5QuIoc"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50d9436f2adso14476851cf.3
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2026 13:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775764859; x=1776369659; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Osy9jL2h2kaajkVlSYY230D1JVR02574ylBl0Z0JVyk=;
        b=Uh5QuIocyDDnHdQI5mX+osLEDmFLChViMN+WLIRCSVSGqiV18FyqH8EiA/8LmSEIGR
         +nFsIjBeyvB0MJMLSdmJwFB8Tt7H0VGItVOApVqJWVjM6A2x7iD4fJNvJmXJksDALRzP
         D3lPtaspBlOjUAnJZTveFYT8f2IiP7pdett1FC2Y9lkW9F/EdmHIZcWNBd/qwMiafuaa
         eUP1m04r0N8gH5Pmaqci6KCd0j50RNrLKUn1b6DVCuiVmXMICyMtoYzsokLL7FH6gLE9
         ZV8bePanRhwE1WVyLiFkq0WKQ0y8Lr9GWNqbLMVSNLyedTlG0LLJ1gg8C1v5zJQji2PG
         onQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775764859; x=1776369659;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Osy9jL2h2kaajkVlSYY230D1JVR02574ylBl0Z0JVyk=;
        b=PCTcZk7nwbz5AtXn2WU28kbOkrC5YZ5WE62piboyDrF0Kj+nouazO7xmPJPvXfo9Pv
         vjgHVnutBoLPCYmjwOQ+F8yzrm9oqZTy1BTGlS5wuad8NsO6UV5Pc2KbrFeXHS1UDQ7H
         F1L45pVNgs47y+/Ls6MF8GM5yIjBa44fE8MDnEqI+4084x0rZsImwv886P6OS7BjVZ6p
         ZQVdh4GPDTdjPwfaQRX8eJyFgl5P8q7IpYSk9JOgITqPjXe3EX4KzGTppcHNMd/wNnJI
         mAe5ZUVMC8gjduq02JazUHlmec7MOdA+oHk2brv8ZLTC6TUQbFD7xrtNbk6Ha99pchvc
         4bvQ==
X-Gm-Message-State: AOJu0YwCyI+dFlPrHOCOqxBfUfr/X9WqjEYNpeHTU49f/MXG3OTtH/NF
	oAB3Vukwtnjql3c090zT7UV9DoZtf0R7Q8+d9jQsbVXzskcXT4ucFiuk/dL94w==
X-Gm-Gg: AeBDieu7tu8EwGCMCbrXvzma3ev6Thht17nK/RD821eJuSiWDS3TMqPG1DJ1BXqozSu
	bh05f7QSJz1VA5KtQTo7lRQ4MMG2nC0PHKXbl9KusdJ/HFdfRLI52vQleWgECFsMwndl9NU2VjG
	dRaO1PzXeObgNaA5tDpZw1UIYxE1F024ufgvnAb2WdAx8ra8w6nG/c6UbuTbSw9wtSW6WCLx3vv
	VMtY/ZO8l+VJfFqg7OpAlCiw7VxMgHyAQvs2H+oqNYKO/CX49XDa69jdQ2nDaTp9hjNLRoQldDN
	1ZVQFujoygX4gD08Qwn2BUI5oL1ap4VKK7aWz2Va0iAxtmOl5IEGNh4XaEKLQOAIGwv0+bt78Ou
	U7VhBvmbjLI8VurK8Eb+IFBTCBdJls2Ajl8CHcAf6/cicHJABYH6knCm2/Flep5mqjzcDmbvuI/
	Luf/jPO5bPlWoUvX6H0DdMDqdJICrA
X-Received: by 2002:ac8:590a:0:b0:50d:9073:f8e with SMTP id d75a77b69052e-50dd5b3f2f9mr9926501cf.26.1775764858748;
        Thu, 09 Apr 2026 13:00:58 -0700 (PDT)
Received: from [172.17.0.2] ([20.83.174.55])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd539c981sm4300941cf.4.2026.04.09.13.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 13:00:58 -0700 (PDT)
Message-ID: <69d8057a.050a0220.151edf.0e5a@mx.google.com>
Date: Thu, 09 Apr 2026 13:00:58 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============6052545033883143393=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, shuai.zhang@oss.qualcomm.com
Subject: RE: [v1] arm64: dts: qcom: hamoa-iot-evk: support Bluetooth over both USB and UART
In-Reply-To: <20260311090921.1892191-1-shuai.zhang@oss.qualcomm.com>
References: <20260311090921.1892191-1-shuai.zhang@oss.qualcomm.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============6052545033883143393==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1064914

---Test result---

Test Summary:
CheckPatch                    PENDING   0.32 seconds
GitLint                       PENDING   0.36 seconds
SubjectPrefix                 FAIL      0.38 seconds
BuildKernel                   PASS      25.87 seconds
CheckAllWarning               PASS      28.19 seconds
CheckSparse                   PASS      26.80 seconds
BuildKernel32                 PASS      24.79 seconds
TestRunnerSetup               PASS      526.67 seconds
TestRunner_l2cap-tester       PASS      27.53 seconds
TestRunner_iso-tester         PASS      35.37 seconds
TestRunner_bnep-tester        PASS      6.31 seconds
TestRunner_mgmt-tester        FAIL      112.96 seconds
TestRunner_rfcomm-tester      PASS      9.38 seconds
TestRunner_sco-tester         FAIL      14.19 seconds
TestRunner_ioctl-tester       PASS      10.09 seconds
TestRunner_mesh-tester        FAIL      11.80 seconds
TestRunner_smp-tester         PASS      8.61 seconds
TestRunner_userchan-tester    PASS      8.19 seconds
TestRunner_6lowpan-tester     FAIL      8.78 seconds
IncrementalBuild              PENDING   0.30 seconds

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
Read Exp Feature - Success                           Failed       0.107 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-gd4d8afd052d3 #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888001946240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff88800215de20 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-gd4d8afd052d3 #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    2.112 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-gd4d8afd052d3 #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff888002760140 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffff98c4d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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
##############################
Test: IncrementalBuild - PENDING
Desc: Incremental build with the patches in the series
Output:



https://github.com/bluez/bluetooth-next/pull/19/checks

---
Regards,
Linux Bluetooth


--===============6052545033883143393==--
