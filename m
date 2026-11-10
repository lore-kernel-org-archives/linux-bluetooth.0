Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794299020;
	b=06EPMQljPOCRXP8GpjEDtkmZoGrq5GBehzCTugNBtyEyvpsQscvmebqiTYGXvsrS1RXy
	 axgsXDGuFtdEE69Hh6ejzGx1cv48pEjswr46/aFJ1Z8n0BHNQxVrwPdFOKfZlbFepidpO
	 FtLEEpld8oAbh+OdF1Jt5ocUGo+47azBTf3onkFM9Uro+FuN5nUlGHK2b2lHEL3RBUfm0
	 1pyCgd6DFuObgy5QW1SJeiF4rSOc+tpRUH1p9ywiku1s/uv9I/AzGC25uiNAoHHMBC8Zz
	 RKI5UOENVxcAlmEu2RAoW0DPChLyUz5/mC5j3FHEE9MjQkew47mz4aUEFQJdaQdSo5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794299020;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 MIME-Version:X-Received:Date:X-Google-Appengine-App-Id:
	 X-Google-Appengine-App-Id-Alias:Message-ID:Subject:From:To:
	 Content-Type;
	bh=C+lLx34DtFR+icpIrkFESZORb4whxR56bE4IISsmaT0=;
	b=WJ0idFFgb4BnzNH9/M8gey8CiwxPtCmLIKl4UWeEkpvdpJ4DN/WI1Kp0f1WYRI4H+4uP
	 fV7Gt/L/3iPV+/diRl4LQpYUlZhCf484pfZ/fUzxqmJ4makcIkEO2lJqGKG0IQGojQQoE
	 8SNYdJ5SfdrykNitntnk0VC97uNJCAo1mh6z7EFOf1v3ZgORV1k74xnkIuxjJ07Yi7TMG
	 Z0zcn8IQRLT6m9UG3YPVUw+69kpUHs0RbznJKhEIU4TYCLCDpfvPVQnHoBUCydj5aW6qR
	 zR1zZEmd0N8J3H5Tt1EfEy2Sc4Kyz9grZFGtTW5TzPhucC1KQv89B272jcPaNMaCBGw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563A7606A321
	for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 08:23:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 563A7606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4ab260600easo2707715b6e.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Nov 2026 00:23:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794299019; x=1794903819;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=C+lLx34DtFR+icpIrkFESZORb4whxR56bE4IISsmaT0=;
        b=o11qDU30RSWm4Wjbl7ob1TSAVf7k0JJas0jnH5BoIf639QWBdk79JoTqT4kItHoWQF
         0n6mKSjMj2rKpvwP2ex5BK8V5Qu9rvBgECgAOw6Joyi/RGgOPVO0qbwT2zfYZu5a7TKx
         UVjudfLKHWX1kEcl7AYAWvF7CmQn2fvvxb8DsirH5ElxKaRsPyhfD+Dh9hMGF+SItfSs
         PUIwz5SoTS2A7HTJ/rYD7EayehUEkYXtVprRBEMynDvWlXxX2oP59uCd5UnFezKhDHl8
         G9ku3IPqJkFM99pVvhdpGx1tUjpLOR94jRYX4/xPKOvVU6ZHmHykCgjwXNAPiCb9MWpY
         u4Qg==
X-Gm-Message-State: APuU4Z9aueat+HnPUQSizDimGo2Rqaof0nht57fn4wBFr7g1ttxxsNGl
	xvLvV49/nAx+SII30SVSI1haXuKKYibwNRDT5Y3tYAZzQxMZBg/uib6ILfpaADm6+frjVlMTcHv
	pJdOTXxRRWCZs8tnJFU2UcOos673NF5GyXVcmZ3OSh0KwqIJZDyF+n91WC3M=
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c1fc:b0:4d6:9133:cfeb with SMTP id
 5614622812f47-568813b3f76mr846681b6e.48.1794299019256; Tue, 10 Nov 2026
 00:23:39 -0800 (PST)
Date: Tue, 10 Nov 2026 00:23:39 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6af2d48b.4dd4714a.f8d02.0024.GAE@google.com>
Subject: [syzbot] [bluetooth?] WARNING in disable_delayed_work_sync
From: syzbot <syzbot+b1146b58a9d6d90e0eb4@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    58c1eb84e977 arm64: sdei: Preserve the interrupted context..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=1070f24e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a58b6b4d667e7a61
dashboard link: https://syzkaller.appspot.com/bug?extid=b1146b58a9d6d90e0eb4
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12869155580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b1ec47537e12/disk-58c1eb84.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3bca0c2b1169/vmlinux-58c1eb84.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0a7c49594d5a/Image-58c1eb84.gz.xz

AI-generated root cause summary:
When shutting down a Bluetooth HCI device (e.g., via vhci_release() during
process exit), hci_dev_close_sync() calls hci_conn_hash_flush() to iterate and
delete all active connections on hdev->conn_hash.list via hci_conn_del(). In
hci_conn_del(), disable_delayed_work_sync(&conn->disc_work) invokes
__flush_work(), which triggers WARN_ON(!work->func) because
conn->disc_work.work.func is NULL. This occurs because the connection entry on
conn_hash.list either suffered an in-place memory corruption overwriting
disc_work or remained linked after an unbalanced hci_conn_put() dropped its
refcount to zero without deleting it from the connection hash table.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=b1146b58a9d6d90e0eb4

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b1146b58a9d6d90e0eb4@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: kernel/workqueue.c:4570 at __flush_work+0x988/0xa90 kernel/workqueue.c:-1, CPU#0: syz-executor/4881
Modules linked in:
CPU: 0 UID: 0 PID: 4881 Comm: syz-executor Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
pstate: 83400005 (Nzcv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : __flush_work+0x988/0xa90 kernel/workqueue.c:-1
lr : __flush_work+0x984/0xa90 kernel/workqueue.c:4570
sp : ffff80009c5c7540
x29: ffff80009c5c76b0 x28: ffff7000138b8eac x27: 1fffe0001913694d
x26: ffff0000c89b4a68 x25: 0000000000000001 x24: dfff800000000000
x23: 0000000000000040 x22: dfff800000000000 x21: dfff800000000000
x20: ffff0000c89b4a50 x19: ffff80009c5c7580 x18: 00000000ffffffff
x17: 0000000000000003 x16: ffff8000898b7000 x15: ffff80008b586000
x14: 0000000000000000 x13: 0000000000000005 x12: 0000000000000000
x11: ffff7000138b8ec5 x10: 0000000000000000 x9 : 0000000000000000
x8 : 0000000000000000 x7 : 0000000000000000 x6 : 000000000000003f
x5 : 0000000000000040 x4 : 0000000000000000 x3 : 0000000000000020
x2 : 0000000000000008 x1 : ffff0000c8350000 x0 : 0000000000000000
Call trace:
 __flush_work+0x988/0xa90 kernel/workqueue.c:-1 (P)
 __cancel_work_sync+0xc8/0x144 kernel/workqueue.c:4729
 disable_delayed_work_sync+0x24/0x38 kernel/workqueue.c:4892
 hci_conn_del+0x6c/0xfcc net/bluetooth/hci_conn.c:1300
 hci_conn_hash_flush+0x17c/0x238 net/bluetooth/hci_conn.c:2814
 hci_dev_close_sync+0x5d4/0xd00 net/bluetooth/hci_sync.c:5681
 hci_dev_do_close+0x34/0xbc net/bluetooth/hci_core.c:502
 hci_unregister_dev+0x204/0x4c4 net/bluetooth/hci_core.c:2694
 vhci_release+0x12c/0x17c drivers/bluetooth/hci_vhci.c:704
 __fput+0x338/0x74c fs/file_table.c:512
 fput_close_sync+0x10c/0x278 fs/file_table.c:618
 filp_close_sync+0x7c/0xb4 fs/open.c:1573
 close_files fs/file.c:572 [inline]
 put_files_struct+0x1a4/0x2e8 fs/file.c:584
 switch_files_struct+0x60/0x74 fs/file.c:598
 exit_files+0x50/0x68 fs/file.c:604
 do_exit+0x55c/0x1a64 kernel/exit.c:977
 do_group_exit+0x198/0x238 kernel/exit.c:1123
 __do_sys_exit_group kernel/exit.c:1134 [inline]
 __se_sys_exit_group kernel/exit.c:1132 [inline]
 pid_child_should_wake+0x0/0x104 kernel/exit.c:1132
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x60/0x1d8 arch/arm64/kernel/entry-common.c:797
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:816
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:606
irq event stamp: 175128
hardirqs last  enabled at (175127): [<ffff80008036fa20>] __cancel_work+0xf4/0x1a4 kernel/workqueue.c:4709
hardirqs last disabled at (175128): [<ffff800086953878>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:484
softirqs last  enabled at (173918): [<ffff8000800204f4>] __do_softirq+0x14/0x20 kernel/softirq.c:703


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
