Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DC921547C0
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 20:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775764889; cv=none; b=HKfP6MqKZ+hUAkhUBG7RsRlmhvVuwQiHWKD5mnGEbgk5j4Tp9lQ2Lp1Tl2UdgTOwtzpKOoXb/aJKr7M8QNM0rch+a8Bu9cKYIFPLPG5ZogFlZDEJiWhJ2ULJtODCLoFQX2ONFax0uyGX1Tl5NFQK6JwJnT9v3NSBeu3JRUrsguY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775764889; c=relaxed/simple;
	bh=R4oWYroBIKrVEy1wECn5/8mn7ajAOptddKQHv88BHcs=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=Vcgo6bbHsv3q5utlDnpfiAtniG1KHpJQgeCeQFKuWQ60Ce35GlJ5baKa1qjirWcGKxQyFxxaByxnsSgL9VjaVKpjqsQwMZy0jISfG78sfDsS8gz7LZBaHb9OWLTOPmtuyObOjcyWhSQZGgxfvXJ7xGVbVuU/F22YoWhpIy+SJ+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GCab+cus; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCab+cus"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50d6ab4476eso12800751cf.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2026 13:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775764887; x=1776369687; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qlS6AS8dECz0lFvUEyg2Zk7ZLPkkZBoj4n+N038cDAk=;
        b=GCab+cuseGVs8fbf/KbPeuBIyod0qC2gD/NUAjD/0dimkZgk925PyLCHnFVZTlaZst
         H9DQ6Ej3JJZ5iP1z0bLle4JLgJYZexHFYd+6erMt3C2la5Uy1PGdAXNSOpU7AgreEeZ4
         7Iq5DHsRfu157yb675ZerYVBUm0ObNyIabBLZDjHTiVT4RU/1r/7c+8pJXwyeZjQwg2M
         10YTwz5l2bXbu6Je3G8ALYjHRodrdB4RoxCnarBRC/bMVU+7JbFyAKbcqlon8qtLjhe7
         obnzm0qZn32hZbioeEgveQCg88ZPmPHdhtiNQ0t7x3Z6XgkYzRQU8r/5dnnmgZmSQNIb
         YqtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775764887; x=1776369687;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qlS6AS8dECz0lFvUEyg2Zk7ZLPkkZBoj4n+N038cDAk=;
        b=RzL3Ih6XFVsjop30mWJzILRAGG5f2vi6uwbHPyFOzN3WMTpr+mtuUS6AIQ/g4Xuxhk
         4sN+hS2TjIAyw+VrctCjLE3bJ96g5KHeMECiNZMdXaIFPsLqajl2MgCm0Mq/3enlhSZ0
         9TFAS17ZfkiUWR9Jc8113I62sQpsF7+pj66mgtM3GpbB0q71UwWO+1QczJe8BMMZndoA
         G4XFQfj/Me7H3l252uuuZt+ksrS6DfEh0tiMrPGBDwGmUzU+yoTlrhIm4p6XZj9452f2
         GHj92Cbv0RzaAdqVemEN4s+jfVzaX3v+e3tb89NtbO5fDY9CNRD2D9DqxQLgD/QyH8Ry
         YShw==
X-Gm-Message-State: AOJu0Yw/lOJ9cnli4iAE7TAAb+IZrYTg91SmfHZkh+VA417qyMsfrIvi
	N5+OsTC06536rAjvO18hO+aJzQk31EyPXCgQGjekXfkaRzpTjxfBKm1O5eEDoA==
X-Gm-Gg: AeBDiev19pQZuBOoDKdSc0rhDV2SBIJFnfZlgKi7qvgwK2XEKTYssuVXJt7hjsRW1Qb
	K14QvRYPT9NsXzdf/U2ptv8E+Q2yJP62DWMswtXdjLd78E8QAdhHES7i1II/GfymkUV8y4Imn7X
	0vU0lBHdzSq1+bZLYKfvtOw7FJtV7ylO7GjQXFbiWiKI7QW0NYNDNJbJruBNHsQxYPWtS3HQtHg
	RzVzEdhhDG8Ix/oc6rXLzer+r9ZezAWwfofzxS4fjtPLmrQhc+5zvoK48fBijl73AvpuIOjTm27
	HGrsvSLRoA9HcjCyR3kYDovR3QY2YxkVKV/X+G1C3Iqh/8xvoEp4ymq5m+FJ1wLh/ZkSVeDeEDu
	IM5gfkOydqaaUvLukfLNX2XTr6eF7gWlHmj4SXA1qw0bUWDd+I26uEOU2cNB0v7Jrdpn7cfGk0D
	EXR74f+yN+lMwcO8dHPhd87H9p3l0PisaXBd3ZZ04=
X-Received: by 2002:a05:622a:13c9:b0:50d:6f16:390a with SMTP id d75a77b69052e-50dd5bcdc2emr9065261cf.34.1775764886855;
        Thu, 09 Apr 2026 13:01:26 -0700 (PDT)
Received: from [172.17.0.2] ([74.235.123.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-50dd539b428sm4621891cf.1.2026.04.09.13.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 13:01:26 -0700 (PDT)
Message-ID: <69d80596.c80a0220.e5ad2.7f45@mx.google.com>
Date: Thu, 09 Apr 2026 13:01:26 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============3470308294742058841=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, imv4bel@gmail.com
Subject: RE: Bluetooth: L2CAP: Fix use-after-free in l2cap_chan_timeout()
In-Reply-To: <abwSxg_C6n8Avid3@v4bel>
References: <abwSxg_C6n8Avid3@v4bel>
Reply-To: linux-bluetooth@vger.kernel.org

--===============3470308294742058841==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1069344

---Test result---

Test Summary:
CheckPatch                    PENDING   0.73 seconds
GitLint                       PENDING   0.29 seconds
SubjectPrefix                 PASS      0.13 seconds
BuildKernel                   PASS      25.23 seconds
CheckAllWarning               PASS      27.56 seconds
CheckSparse                   PASS      26.53 seconds
BuildKernel32                 PASS      24.14 seconds
TestRunnerSetup               PASS      539.17 seconds
TestRunner_l2cap-tester       PASS      26.58 seconds
TestRunner_iso-tester         PASS      43.33 seconds
TestRunner_bnep-tester        PASS      5.97 seconds
TestRunner_mgmt-tester        FAIL      110.68 seconds
TestRunner_rfcomm-tester      PASS      9.05 seconds
TestRunner_sco-tester         FAIL      13.94 seconds
TestRunner_ioctl-tester       PASS      10.49 seconds
TestRunner_mesh-tester        FAIL      11.48 seconds
TestRunner_smp-tester         PASS      8.10 seconds
TestRunner_userchan-tester    PASS      6.29 seconds
TestRunner_6lowpan-tester     FAIL      8.29 seconds
IncrementalBuild              PENDING   0.27 seconds

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
Total: 494, Passed: 489 (99.0%), Failed: 1, Not Run: 4

Failed Test Cases
Read Exp Feature - Success                           Failed       0.101 seconds
##############################
Test: TestRunner_sco-tester - FAIL
Desc: Run sco-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g8a3d4f6c0901 #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888002416240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff8880025fc220 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-g8a3d4f6c0901 #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    2.258 seconds
Mesh - Send cancel - 2                               Timed out    1.995 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g8a3d4f6c0901 #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff8880026e0940 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffffb5c4d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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



https://github.com/bluez/bluetooth-next/pull/24/checks

---
Regards,
Linux Bluetooth


--===============3470308294742058841==--
