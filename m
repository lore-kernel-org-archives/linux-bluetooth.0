Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8823AC0C4
	for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 09:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776073249; cv=none; b=BbrvbU5WGrff9tBlAaEBVv5u4Kmeu6eeIarS00dIe+wyhtxbs41pLEv4SQ3Hu37DAWeUy3/7B5Q65jpLtG3x4pG03DLKPM93u4hajyny8N1Y/es6VcUr7y2B0AEmc0QBbSFX2Bv6eLgMZfGeEoFSx0FJrCttYlFn3LB92ldA+n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776073249; c=relaxed/simple;
	bh=c0pfFkBS0nZFCxXeUFFrvwI6rLafj9+6XqQisTkUiRw=;
	h=Message-ID:Date:Content-Type:MIME-Version:From:To:Subject:
	 In-Reply-To:References; b=K3XMt/UDJ6Viwfr5txmh2z9NZwkFEWLXFD0XeILKRFfnPY658qI8HrGqAocp91PAYwZo6yqdpUUyDESVaUOC2yySf5b7hTKSUD976+hW4QRcZ314761Adxi/3uyn0E4sWg2PrC8Yn01xNek5q0TVhaMgRkoIYv2CqHjGxq8C9wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sJ5MdKLj; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJ5MdKLj"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8aca0469204so13733316d6.2
        for <linux-bluetooth@vger.kernel.org>; Mon, 13 Apr 2026 02:40:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776073247; x=1776678047; darn=vger.kernel.org;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lKDVqUpAuvzt3Y82+e7w4+EY3LrGNLFXmdHHPaOg4Xc=;
        b=sJ5MdKLjyK4GDsE6QlS+M8jdebjXxZsT0grauFvu5lbO+YuHMekJz6zD0GiCEUpVqL
         IlMGKV0IDU4H3alABEpe5hrbsmH2Jb7Vucup26UQ6IFY8mbBkwjwBgt7hyvN77I+mm3V
         NAkCh3BA73DKltW28plmlC02OBt/uGqMenGG/Ebz1jEHtoZsl+fs1ovJcCj7tozVZOso
         Vm9PZ3SmfxIdRQlalNy5ReEyry9iF62S14G+nNJFqAnBi+lAN1SAkvX7ht9Y5+8Z/Cl8
         uRyfkgna+c/x2PjOw6PqN2cPNgTTXqC4a1nPygLDuLIjYBkFI3JYE+jCL883B1/06BL/
         dt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776073247; x=1776678047;
        h=reply-to:references:in-reply-to:subject:to:from:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lKDVqUpAuvzt3Y82+e7w4+EY3LrGNLFXmdHHPaOg4Xc=;
        b=IkgkqUSICtDxaAnzBjEQ+4ZS5KQeIWT4OoG0O81JNMrXv7AS3KBlYZqfTIhKJOiGfo
         qdH3LF5PyBIYN9xw3Oc6gtBi30yHhggkpjkgBO7NOGJ5x0LZQU74vBFDabjusw6h6EKl
         cOxSk7EfQc5VhYZVzb8mhBN6YKf/Zh/iTiU3MpOo24cLpu5Wgllo3Vvx7f4AcqySsVVH
         zf6U0oBZ6k5C+0gqUpVGejjs+UPuy7s2RZO52hPSiD/vazSYBWWEaVQoWHxk9CQ2Dzl1
         uP2vDLAgIuy6GOxCUGtwyLKGpKsUfEe1e7NjbQea5YIn1oQw5nymB5pi25Mk2ACYNJb5
         UFqg==
X-Gm-Message-State: AOJu0YzMlBTTjKeH2lq8c2TQNIU8+XPwAamKLNcfhBaO7cgeQne0m3v5
	4ZgEnUwZwUSypY1lASkMhqb7BQ+RDtqG7Gmk6RSPmNpSLZEk+qGMJLW/L4VtVw==
X-Gm-Gg: AeBDieswYIETQtr1oMBFD4+Jn0Knr7l2jrAk0fzdRBc2ZLzFt761GADZUxICQmZ/fHu
	HIgSdyOKunHEWJgKED6un0NVZxQ3eFfJvwbx4YG+aBcPE3Tf3mgFhGEPS7wsVh0ZM9PC1cWc+h9
	ORRQHlLYT6n6CyWbw+a61NfCNPVEWTaJW6RA1zeBqT6L8FDBPTToj6YFpprx9LQNv65++ZV5Q8a
	FeeUOArAk+bvIsBNBxgn/XD3WFsp2IqXHF6zFIS9ZrFoz1uLmRtAvSLmz2bKjUHdsydZuZgwpgd
	Q/Qu2fnJm2iPVdIzlwxvWXcuJBZlAU/z8HnmSJ0NXakKYuuOZ/HIp8RV8WI/MVoUkL/z453UZdQ
	/dDJ8BRgNuJzp1JWWYPbjx2br5qPEFsNFIclDcocrAKpVQlh6iGK+zxIj+/kd8u+P6UEqzfMc3e
	Icr+Ol5DdGivfeG1TsGOMDupM2RJ9yw9E=
X-Received: by 2002:a05:6214:2683:b0:89c:5110:751a with SMTP id 6a1803df08f44-8ac862992afmr206522546d6.44.1776073246866;
        Mon, 13 Apr 2026 02:40:46 -0700 (PDT)
Received: from [172.17.0.2] ([172.183.131.17])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ac8aea242fsm80619026d6.34.2026.04.13.02.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 02:40:46 -0700 (PDT)
Message-ID: <69dcba1e.050a0220.2b8943.e4be@mx.google.com>
Date: Mon, 13 Apr 2026 02:40:46 -0700 (PDT)
Content-Type: multipart/mixed; boundary="===============7267046906098462511=="
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: bluez.test.bot@gmail.com
To: linux-bluetooth@vger.kernel.org, phx0fer@gmail.com
Subject: RE: Bluetooth: hci_conn: Use disable_delayed_work_sync for le_conn_timeout
In-Reply-To: <20260413085455.74585-1-phx0fer@gmail.com>
References: <20260413085455.74585-1-phx0fer@gmail.com>
Reply-To: linux-bluetooth@vger.kernel.org

--===============7267046906098462511==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

This is automated email and please do not reply to this email!

Dear submitter,

Thank you for submitting the patches to the linux bluetooth mailing list.
This is a CI test results with your patch series:
PW Link:https://patchwork.kernel.org/project/bluetooth/list/?series=1080586

---Test result---

Test Summary:
CheckPatch                    PENDING   0.35 seconds
GitLint                       PENDING   0.28 seconds
SubjectPrefix                 PASS      0.11 seconds
BuildKernel                   PASS      27.69 seconds
CheckAllWarning               PASS      30.82 seconds
CheckSparse                   PASS      26.17 seconds
BuildKernel32                 PASS      23.95 seconds
TestRunnerSetup               PASS      530.21 seconds
TestRunner_l2cap-tester       FAIL      28.10 seconds
TestRunner_iso-tester         PASS      35.75 seconds
TestRunner_bnep-tester        PASS      6.44 seconds
TestRunner_mgmt-tester        FAIL      114.59 seconds
TestRunner_rfcomm-tester      PASS      9.45 seconds
TestRunner_sco-tester         FAIL      14.38 seconds
TestRunner_ioctl-tester       PASS      10.23 seconds
TestRunner_mesh-tester        FAIL      12.53 seconds
TestRunner_smp-tester         PASS      8.65 seconds
TestRunner_userchan-tester    PASS      6.68 seconds
TestRunner_6lowpan-tester     FAIL      9.17 seconds
IncrementalBuild              PENDING   0.34 seconds

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
Test: TestRunner_l2cap-tester - FAIL
Desc: Run l2cap-tester with test-runner
Output:
Total: 96, Passed: 95 (99.0%), Failed: 1, Not Run: 0

Failed Test Cases
L2CAP LE Server - Set PHY Coded                      Failed       0.141 seconds
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
7.0.0-rc2-g666e7bacebcb #1 Not tainted
------------------------------------------------------
kworker/u5:2/117 is trying to acquire lock:
ffff888001e19240 (sk_lock-AF_BLUETOOTH-BTPROTO_SCO){+.+.}-{0:0}, at: sco_connect_cfm+0x358/0x8d0

but task is already holding lock:
ffff888002141c20 (&conn->lock){+.+.}-{3:3}, at: sco_connect_cfm+0x22d/0x8d0

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
CPU: 0 UID: 0 PID: 117 Comm: kworker/u5:2 Not tainted 7.0.0-rc2-g666e7bacebcb #1 PREEMPT(lazy) 
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
Mesh - Send cancel - 1                               Timed out    2.729 seconds
Mesh - Send cancel - 2                               Timed out    1.996 seconds
##############################
Test: TestRunner_6lowpan-tester - FAIL
Desc: Run 6lowpan-tester with test-runner
Output:
WARNING: possible circular locking dependency detected
7.0.0-rc2-g666e7bacebcb #1 Not tainted
------------------------------------------------------
kworker/0:1/11 is trying to acquire lock:
ffff888002454140 ((wq_completion)hci0#2){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x75/0x180

but task is already holding lock:
ffffffff9f64d720 (rtnl_mutex){+.+.}-{4:4}, at: lowpan_unregister_netdev+0xd/0x30

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



https://github.com/bluez/bluetooth-next/pull/77

---
Regards,
Linux Bluetooth


--===============7267046906098462511==--
