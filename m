Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794717991;
	b=f7yopR/aybEREOfGKK03eaLBKGLlRQtZ3ks4R4t3ssF+6MpuUFf/vQkJVxkebBn58fvK
	 HTm1FtrtSB7Wh9OKO9mTxESXVIPEkyoIORmhVqJNtrRKFH1B71VkadANH/D4977JBwCLa
	 ko8QWC9l8aatx1SmRwBIG/ncDLoh5Cf9CcxX1eFCg4MZAmo7xifmA/DqI0DGCx5fcjn4V
	 6W/hQTxBThe++W/jKqfajYsHDCuO5/xVaq7PFCtGllSLXIAs9Vdsi1P3ZoOQTpL412YD8
	 0gda2PNFbENAHi/Q5EH44OKRoFQgKHlyvgeqlPuVW4MwuyBV2uzyZPHvEgR/dlH3sPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794717991;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 MIME-Version:X-Received:Date:In-Reply-To:X-Google-Appengine-App-Id:
	 X-Google-Appengine-App-Id-Alias:Message-ID:Subject:From:To:
	 Content-Type;
	bh=vXetaywFPW1Yinuw2ycsyGtH55hrBzKpFTa6lRlcTRQ=;
	b=pJlg1EfgyjVfNAwQR0YtVdUGc4W8+fkvRG5zBuoA1jUQZu+Bam6+IpvseOcy+EcD1FcM
	 hVmBLuo918AaMCBXc1WUfUJ4adC0T1Yg4IGK1y/QP+g7BtafXZ4aBI1yT7+Iu0kre5P1G
	 da4C7Es8BBoGEYxZG1q77VnhJPCOIbhzQ2K8vb4QMe9lPumK5X/raALwJVBQSuVjvENlQ
	 LM3DkFcYuaitxDBS48RlKkxRivhVRMJ8D/hnRlXhW3jH62F0gEudT6s5ggecQ+Hs29Da0
	 azOc6Sh0tfcrIGreY4XPU3Ndsgppg9FpIk/BPg10E6GnpXBGuceYg6KprUWGGYmWwLw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.210.70
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC888606A329
	for <linux-bluetooth@vger.kernel.org>; Sun, 15 Nov 2026 04:46:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BC888606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-847e2926d94so5225982a34.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 Nov 2026 20:46:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794717990; x=1795322790;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=vXetaywFPW1Yinuw2ycsyGtH55hrBzKpFTa6lRlcTRQ=;
        b=yZcaDJfTkz9xfaSOYvcBnFg/BmtsEwaq9wVgwutYOuyZh9Quy6Axa2TwJ4tm8VdkQG
         cF5kjV8w0Og9+608/XRJrIuFyXCUiLZfVohgwiUT4BAn9VUZtwPOaGOYFw7uMtPd4eNY
         PRvoXubsyLJtdjCM6JxfCP75+8ODrXfPLpcZwIJvZqWpM/WtH1BIdtyRhhmDU+2YHj+C
         3TyVnyYp/EdANUlu7xx+yuO1gDfkdEjFCWwv3Y2cG/J2D6pqDb5vmCmVD6tFiBNses1p
         HkjI7zx3LqKbYOPk8XE+/xzbnQwIhAjWsNRan7YI4aoeubimCQF6mxTrJlFwShlJUDYp
         WCtw==
X-Gm-Message-State: APuU4Z8D3GNVz/TzwLQUNYPgYhmysJT3YuULpCUP13Xz++ce6Qdz5jNR
	cdACqinOl6ecXQPWjvEbcLvPx20lKxVSz+7kklLRiG4OHCOXirP2U3U+bapuxegs2MRJLvLLbVp
	QlzBWjQc3fxUzbt53CKoP5Q2gCfZUzN0sX1QaaDCpxF/F+bF2/DvRcwTVHdo=
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1790:b0:4d6:90f4:48b7 with SMTP id
 5614622812f47-56e6542e6d8mr7132893b6e.57.1794717989883; Sat, 14 Nov 2026
 20:46:29 -0800 (PST)
Date: Sat, 14 Nov 2026 20:46:29 -0800
In-Reply-To: <6af79f77.98e60839.1e023a.00d6.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6af93925.aa201734.33d248.000a.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] WARNING in l2cap_chan_le_send_credits
From: syzbot <syzbot+9dc8780713b11155dd74@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    ad3fc05c7e65 arm64: suspend: Only track cpuidle context fo..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=108eebfd580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e8e6c1701ad8af2
dashboard link: https://syzkaller.appspot.com/bug?extid=9dc8780713b11155dd74
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
userspace arch: arm64
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a329ad580000

AI-generated root cause summary:
In net/bluetooth/l2cap_core.c, l2cap_chan_le_send_credits() allocates an L2CAP
transaction identifier via l2cap_get_ident() and unconditionally calls
ida_free(&conn->tx_ida, ident) after transmission under the assumption that
L2CAP_LE_CREDITS never expects a response. However, if the remote peer rejects
the packet with L2CAP_COMMAND_REJ or sends a signaling response bearing that
identifier, the asynchronous RX signaling handler l2cap_put_ident() sees the ID
as currently allocated and frees it first. When l2cap_chan_le_send_credits()
then executes ida_free() on the already-released identifier, ida_free() detects
that the ID is not allocated and triggers the warning in lib/idr.c.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=9dc8780713b11155dd74

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9dc8780713b11155dd74@syzkaller.appspotmail.com

------------[ cut here ]------------
ida_free called for id=3 which is not allocated.
WARNING: lib/idr.c:594 at ida_free+0x24c/0x2d4 lib/idr.c:594, CPU#0: syz-executor357/5073
Modules linked in:
CPU: 0 UID: 0 PID: 5073 Comm: syz-executor357 Not tainted syzkaller #0 PREEMPT 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : ida_free+0x24c/0x2d4 lib/idr.c:594
lr : ida_free+0x24c/0x2d4 lib/idr.c:594
sp : ffff800094f27880
x29: ffff800094f27910 x28: 00000000000000cc x27: 1fffe0001aec2a11
x26: 0000000000000003 x25: dfff800000000000 x24: ffff800094f27880
x23: ffff7000129e4f10 x22: 0000000000000001 x21: 0000000000000000
x20: 0000000000000003 x19: 0000000000000000 x18: 00000000ffffffff
x17: 0000000000000003 x16: ffff8000898b7000 x15: ffff80008b586000
x14: 000000000000067b x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: ffff70001135360e x9 : b56adb3a1390ea00
x8 : b56adb3a1390ea00 x7 : ffff8000804a121c x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff80008030d4c8
x2 : 0000000100000000 x1 : ffff0000d8109d80 x0 : 0000000000000000
Call trace:
 ida_free+0x24c/0x2d4 lib/idr.c:594 (P)
 l2cap_chan_le_send_credits+0x17c/0x29c net/bluetooth/l2cap_core.c:7113
 l2cap_chan_rx_avail+0xb4/0x134 net/bluetooth/l2cap_core.c:7126
 l2cap_publish_rx_avail+0x110/0x168 net/bluetooth/l2cap_sock.c:-1
 l2cap_sock_recvmsg+0x280/0x7b8 net/bluetooth/l2cap_sock.c:1317
 sock_recvmsg_nosec net/socket.c:1154 [inline]
 sock_recvmsg+0xd4/0x170 net/socket.c:1176
 __sys_recvfrom+0x1ec/0x31c net/socket.c:2333
 __do_sys_recvfrom net/socket.c:2348 [inline]
 __se_sys_recvfrom net/socket.c:2344 [inline]
 __arm64_sys_recvfrom+0xec/0x10c net/socket.c:2344
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x60/0x1d8 arch/arm64/kernel/entry-common.c:797
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:816
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:606
irq event stamp: 8486
hardirqs last  enabled at (8485): [<ffff8000804a47b4>] vprintk_store+0x924/0xb94 kernel/printk/printk.c:2385
hardirqs last disabled at (8486): [<ffff800086954060>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:484
softirqs last  enabled at (8478): [<ffff8000800204f4>] __do_softirq+0x14/0x20 kernel/softirq.c:703
softirqs last disabled at (8455): [<ffff8000800204f4>] __do_softirq+0x14/0x20 kernel/softirq.c:703
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ida_free called for id=5 which is not allocated.
WARNING: lib/idr.c:594 at ida_free+0x24c/0x2d4 lib/idr.c:594, CPU#0: syz-executor357/5073
Modules linked in:
CPU: 0 UID: 0 PID: 5073 Comm: syz-executor357 Tainted: G        W           syzkaller #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : ida_free+0x24c/0x2d4 lib/idr.c:594
lr : ida_free+0x24c/0x2d4 lib/idr.c:594
sp : ffff800094f27880
x29: ffff800094f27910 x28: 00000000000000cc x27: 1fffe0001aec2a11
x26: 0000000000000005 x25: dfff800000000000 x24: ffff800094f27880
x23: ffff7000129e4f10 x22: 0000000000000001 x21: 0000000000000000
x20: 0000000000000005 x19: 0000000000000000 x18: 1fffe000359cf228
x17: 0000000000000003 x16: ffff8000898b7000 x15: ffff80008b586000
x14: 00000000000006c5 x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: ffff70001135360e x9 : b56adb3a1390ea00
x8 : b56adb3a1390ea00 x7 : ffff8000804a121c x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff80008030d4c8
x2 : 0000000100000000 x1 : ffff0000d8109d80 x0 : 0000000000000000
Call trace:
 ida_free+0x24c/0x2d4 lib/idr.c:594 (P)
 l2cap_chan_le_send_credits+0x17c/0x29c net/bluetooth/l2cap_core.c:7113
 l2cap_chan_rx_avail+0xb4/0x134 net/bluetooth/l2cap_core.c:7126
 l2cap_publish_rx_avail+0x110/0x168 net/bluetooth/l2cap_sock.c:-1
 l2cap_sock_recvmsg+0x280/0x7b8 net/bluetooth/l2cap_sock.c:1317
 sock_recvmsg_nosec net/socket.c:1154 [inline]
 sock_recvmsg+0xd4/0x170 net/socket.c:1176
 __sys_recvfrom+0x1ec/0x31c net/socket.c:2333
 __do_sys_recvfrom net/socket.c:2348 [inline]
 __se_sys_recvfrom net/socket.c:2344 [inline]
 __arm64_sys_recvfrom+0xec/0x10c net/socket.c:2344
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x60/0x1d8 arch/arm64/kernel/entry-common.c:797
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:816
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:606
irq event stamp: 8834
hardirqs last  enabled at (8833): [<ffff8000804a47b4>] vprintk_store+0x924/0xb94 kernel/printk/printk.c:2385
hardirqs last disabled at (8834): [<ffff800086954060>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:484
softirqs last  enabled at (8818): [<ffff800084c8f174>] __alloc_skb+0x1c0/0x610 net/core/skbuff.c:699
softirqs last disabled at (8816): [<ffff800084c8f15c>] local_bh_disable include/linux/bottom_half.h:20 [inline]
softirqs last disabled at (8816): [<ffff800084c8f15c>] __alloc_skb+0x1a8/0x610 net/core/skbuff.c:698
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ida_free called for id=8 which is not allocated.
WARNING: lib/idr.c:594 at ida_free+0x24c/0x2d4 lib/idr.c:594, CPU#0: syz-executor357/5073
Modules linked in:
CPU: 0 UID: 0 PID: 5073 Comm: syz-executor357 Tainted: G        W           syzkaller #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : ida_free+0x24c/0x2d4 lib/idr.c:594
lr : ida_free+0x24c/0x2d4 lib/idr.c:594
sp : ffff800094f27880
x29: ffff800094f27910 x28: 00000000000000cc x27: 1fffe0001aec2a11
x26: 0000000000000008 x25: dfff800000000000 x24: ffff800094f27880
x23: ffff7000129e4f10 x22: 0000000000000001 x21: 0000000000000000
x20: 0000000000000008 x19: 0000000000000000 x18: 1fffe000359cf228
x17: ffff800123625000 x16: ffff80008f910000 x15: 0000000000000001
x14: 000000000042ed3e x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: ffff7000129e4eb8 x9 : b56adb3a1390ea00
x8 : b56adb3a1390ea00 x7 : 0000000000000000 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000008 x3 : ffff8000803cfd0c
x2 : 0000000000000001 x1 : ffff0000d8109d80 x0 : 0000000000000001
Call trace:
 ida_free+0x24c/0x2d4 lib/idr.c:594 (P)
 l2cap_chan_le_send_credits+0x17c/0x29c net/bluetooth/l2cap_core.c:7113
 l2cap_chan_rx_avail+0xb4/0x134 net/bluetooth/l2cap_core.c:7126
 l2cap_publish_rx_avail+0x110/0x168 net/bluetooth/l2cap_sock.c:-1
 l2cap_sock_recvmsg+0x280/0x7b8 net/bluetooth/l2cap_sock.c:1317
 sock_recvmsg_nosec net/socket.c:1154 [inline]
 sock_recvmsg+0xd4/0x170 net/socket.c:1176
 __sys_recvfrom+0x1ec/0x31c net/socket.c:2333
 __do_sys_recvfrom net/socket.c:2348 [inline]
 __se_sys_recvfrom net/socket.c:2344 [inline]
 __arm64_sys_recvfrom+0xec/0x10c net/socket.c:2344
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x60/0x1d8 arch/arm64/kernel/entry-common.c:797
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:816
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:606
irq event stamp: 9170
hardirqs last  enabled at (9169): [<ffff8000803cfcbc>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1719 [inline]
hardirqs last  enabled at (9169): [<ffff8000803cfcbc>] finish_lock_switch kernel/sched/core.c:5314 [inline]
hardirqs last  enabled at (9169): [<ffff8000803cfcbc>] finish_task_switch+0x234/0x858 kernel/sched/core.c:5432
hardirqs last disabled at (9170): [<ffff800086954060>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:484
softirqs last  enabled at (9150): [<ffff800084c8f174>] __alloc_skb+0x1c0/0x610 net/core/skbuff.c:699
softirqs last disabled at (9148): [<ffff800084c8f15c>] local_bh_disable include/linux/bottom_half.h:20 [inline]
softirqs last disabled at (9148): [<ffff800084c8f15c>] __alloc_skb+0x1a8/0x610 net/core/skbuff.c:698
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ida_free called for id=10 which is not allocated.
WARNING: lib/idr.c:594 at ida_free+0x24c/0x2d4 lib/idr.c:594, CPU#0: syz-executor357/5073
Modules linked in:
CPU: 0 UID: 0 PID: 5073 Comm: syz-executor357 Tainted: G        W           syzkaller #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : ida_free+0x24c/0x2d4 lib/idr.c:594
lr : ida_free+0x24c/0x2d4 lib/idr.c:594
sp : ffff800094f27880
x29: ffff800094f27910 x28: 00000000000000cc x27: 1fffe0001aec2a11
x26: 000000000000000a x25: dfff800000000000 x24: ffff800094f27880
x23: ffff7000129e4f10 x22: 0000000000000001 x21: 0000000000000000
x20: 000000000000000a x19: 0000000000000000 x18: 1fffe000359cf228
x17: 0000000000000003 x16: ffff8000898b7000 x15: ffff80008996b3e0
x14: 0000000000000760 x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: ffff70001135360e x9 : b56adb3a1390ea00
x8 : b56adb3a1390ea00 x7 : ffff8000804a121c x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff80008030d4c8
x2 : 0000000100000000 x1 : ffff0000d8109d80 x0 : 0000000000000000
Call trace:
 ida_free+0x24c/0x2d4 lib/idr.c:594 (P)
 l2cap_chan_le_send_credits+0x17c/0x29c net/bluetooth/l2cap_core.c:7113
 l2cap_chan_rx_avail+0xb4/0x134 net/bluetooth/l2cap_core.c:7126
 l2cap_publish_rx_avail+0x110/0x168 net/bluetooth/l2cap_sock.c:-1
 l2cap_sock_recvmsg+0x280/0x7b8 net/bluetooth/l2cap_sock.c:1317
 sock_recvmsg_nosec net/socket.c:1154 [inline]
 sock_recvmsg+0xd4/0x170 net/socket.c:1176
 __sys_recvfrom+0x1ec/0x31c net/socket.c:2333
 __do_sys_recvfrom net/socket.c:2348 [inline]
 __se_sys_recvfrom net/socket.c:2344 [inline]
 __arm64_sys_recvfrom+0xec/0x10c net/socket.c:2344
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x60/0x1d8 arch/arm64/kernel/entry-common.c:797
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:816
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:606
irq event stamp: 9406
hardirqs last  enabled at (9405): [<ffff8000804a47b4>] vprintk_store+0x924/0xb94 kernel/printk/printk.c:2385
hardirqs last disabled at (9406): [<ffff800086954060>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:484
softirqs last  enabled at (9390): [<ffff800084c8f174>] __alloc_skb+0x1c0/0x610 net/core/skbuff.c:699
softirqs last disabled at (9388): [<ffff800084c8f15c>] local_bh_disable include/linux/bottom_half.h:20 [inline]
softirqs last disabled at (9388): [<ffff800084c8f15c>] __alloc_skb+0x1a8/0x610 net/core/skbuff.c:698
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ida_free called for id=12 which is not allocated.
WARNING: lib/idr.c:594 at ida_free+0x24c/0x2d4 lib/idr.c:594, CPU#0: syz-executor357/5073
Modules linked in:
CPU: 0 UID: 0 PID: 5073 Comm: syz-executor357 Tainted: G        W           syzkaller #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : ida_free+0x24c/0x2d4 lib/idr.c:594
lr : ida_free+0x24c/0x2d4 lib/idr.c:594
sp : ffff800094f27880
x29: ffff800094f27910 x28: 00000000000000cc x27: 1fffe0001aec2a11
x26: 000000000000000c x25: dfff800000000000 x24: ffff800094f27880
x23: ffff7000129e4f10 x22: 0000000000000001 x21: 0000000000000000
x20: 000000000000000c x19: 0000000000000000 x18: 1fffe000359cf228
x17: 0000000000000003 x16: ffff8000898b7000 x15: ffff80008996b3e0
x14: 00000000000007af x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: ffff70001135360e x9 : b56adb3a1390ea00
x8 : b56adb3a1390ea00 x7 : ffff8000804a121c x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff80008030d4c8
x2 : 0000000100000000 x1 : ffff0000d8109d80 x0 : 0000000000000000
Call trace:
 ida_free+0x24c/0x2d4 lib/idr.c:594 (P)
 l2cap_chan_le_send_credits+0x17c/0x29c net/bluetooth/l2cap_core.c:7113
 l2cap_chan_rx_avail+0xb4/0x134 net/bluetooth/l2cap_core.c:7126
 l2cap_publish_rx_avail+0x110/0x168 net/bluetooth/l2cap_sock.c:-1
 l2cap_sock_recvmsg+0x280/0x7b8 net/bluetooth/l2cap_sock.c:1317
 sock_recvmsg_nosec net/socket.c:1154 [inline]
 sock_recvmsg+0xd4/0x170 net/socket.c:1176
 __sys_recvfrom+0x1ec/0x31c net/socket.c:2333
 __do_sys_recvfrom net/socket.c:2348 [inline]
 __se_sys_recvfrom net/socket.c:2344 [inline]
 __arm64_sys_recvfrom+0xec/0x10c net/socket.c:2344
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x60/0x1d8 arch/arm64/kernel/entry-common.c:797
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:816
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:606
irq event stamp: 9622
hardirqs last  enabled at (9621): [<ffff8000804a47b4>] vprintk_store+0x924/0xb94 kernel/printk/printk.c:2385
hardirqs last disabled at (9622): [<ffff800086954060>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:484
softirqs last  enabled at (9606): [<ffff800084c8f174>] __alloc_skb+0x1c0/0x610 net/core/skbuff.c:699
softirqs last disabled at (9604): [<ffff800084c8f15c>] local_bh_disable include/linux/bottom_half.h:20 [inline]
softirqs last disabled at (9604): [<ffff800084c8f15c>] __alloc_skb+0x1a8/0x610 net/core/skbuff.c:698
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ida_free called for id=156 which is not allocated.
WARNING: lib/idr.c:594 at ida_free+0x24c/0x2d4 lib/idr.c:594, CPU#0: syz-executor357/5073
Modules linked in:
CPU: 0 UID: 0 PID: 5073 Comm: syz-executor357 Tainted: G        W           syzkaller #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : ida_free+0x24c/0x2d4 lib/idr.c:594
lr : ida_free+0x24c/0x2d4 lib/idr.c:594
sp : ffff800094f27880
x29: ffff800094f27910 x28: 00000000000000cc x27: 1fffe0001aec2a11
x26: 000000000000009c x25: dfff800000000000 x24: ffff800094f27880
x23: ffff7000129e4f10 x22: 0000000000000001 x21: 0000000000000000
x20: 000000000000009c x19: 0000000000000000 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000001
x14: 00000000000007fa x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: ffff70001135360e x9 : b56adb3a1390ea00
x8 : b56adb3a1390ea00 x7 : ffff8000804a121c x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff80008030d4c8
x2 : 0000000100000000 x1 : ffff0000d8109d80 x0 : 0000000000000000
Call trace:
 ida_free+0x24c/0x2d4 lib/idr.c:594 (P)
 l2cap_chan_le_send_credits+0x17c/0x29c net/bluetooth/l2cap_core.c:7113
 l2cap_chan_rx_avail+0xb4/0x134 net/bluetooth/l2cap_core.c:7126
 l2cap_publish_rx_avail+0x110/0x168 net/bluetooth/l2cap_sock.c:-1
 l2cap_sock_recvmsg+0x280/0x7b8 net/bluetooth/l2cap_sock.c:1317
 sock_recvmsg_nosec net/socket.c:1154 [inline]
 sock_recvmsg+0xd4/0x170 net/socket.c:1176
 __sys_recvfrom+0x1ec/0x31c net/socket.c:2333
 __do_sys_recvfrom net/socket.c:2348 [inline]
 __se_sys_recvfrom net/socket.c:2344 [inline]
 __arm64_sys_recvfrom+0xec/0x10c net/socket.c:2344
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x60/0x1d8 arch/arm64/kernel/entry-common.c:797
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:816
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:606
irq event stamp: 24500
hardirqs last  enabled at (24499): [<ffff8000804a47b4>] vprintk_store+0x924/0xb94 kernel/printk/printk.c:2385
hardirqs last disabled at (24500): [<ffff800086954060>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:484
softirqs last  enabled at (24488): [<ffff800084c8f174>] __alloc_skb+0x1c0/0x610 net/core/skbuff.c:699
softirqs last disabled at (24486): [<ffff800084c8f15c>] local_bh_disable include/linux/bottom_half.h:20 [inline]
softirqs last disabled at (24486): [<ffff800084c8f15c>] __alloc_skb+0x1a8/0x610 net/core/skbuff.c:698
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ida_free called for id=220 which is not allocated.
WARNING: lib/idr.c:594 at ida_free+0x24c/0x2d4 lib/idr.c:594, CPU#0: syz-executor357/5073
Modules linked in:
CPU: 0 UID: 0 PID: 5073 Comm: syz-executor357 Tainted: G        W           syzkaller #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : ida_free+0x24c/0x2d4 lib/idr.c:594
lr : ida_free+0x24c/0x2d4 lib/idr.c:594
sp : ffff800094f27880
x29: ffff800094f27910 x28: 00000000000000cc x27: 1fffe0001aec2a11
x26: 00000000000000dc x25: dfff800000000000 x24: ffff800094f27880
x23: ffff7000129e4f10 x22: 0000000000000001 x21: 0000000000000000
x20: 00000000000000dc x19: 0000000000000000 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000001
x14: 0000000000000845 x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: ffff70001135360e x9 : b56adb3a1390ea00
x8 : b56adb3a1390ea00 x7 : ffff8000804a121c x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff80008030d4c8
x2 : 0000000100000000 x1 : ffff0000d8109d80 x0 : 0000000000000000
Call trace:
 ida_free+0x24c/0x2d4 lib/idr.c:594 (P)
 l2cap_chan_le_send_credits+0x17c/0x29c net/bluetooth/l2cap_core.c:7113
 l2cap_chan_rx_avail+0xb4/0x134 net/bluetooth/l2cap_core.c:7126
 l2cap_publish_rx_avail+0x110/0x168 net/bluetooth/l2cap_sock.c:-1
 l2cap_sock_recvmsg+0x280/0x7b8 net/bluetooth/l2cap_sock.c:1317
 sock_recvmsg_nosec net/socket.c:1154 [inline]
 sock_recvmsg+0xd4/0x170 net/socket.c:1176
 __sys_recvfrom+0x1ec/0x31c net/socket.c:2333
 __do_sys_recvfrom net/socket.c:2348 [inline]
 __se_sys_recvfrom net/socket.c:2344 [inline]
 __arm64_sys_recvfrom+0xec/0x10c net/socket.c:2344
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x60/0x1d8 arch/arm64/kernel/entry-common.c:797
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:816
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:606
irq event stamp: 31398
hardirqs last  enabled at (31397): [<ffff8000804a47b4>] vprintk_store+0x924/0xb94 kernel/printk/printk.c:2385
hardirqs last disabled at (31398): [<ffff800086954060>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:484
softirqs last  enabled at (31386): [<ffff800084c8f174>] __alloc_skb+0x1c0/0x610 net/core/skbuff.c:699
softirqs last disabled at (31384): [<ffff800084c8f15c>] local_bh_disable include/linux/bottom_half.h:20 [inline]
softirqs last disabled at (31384): [<ffff800084c8f15c>] __alloc_skb+0x1a8/0x610 net/core/skbuff.c:698
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ida_free called for id=235 which is not allocated.
WARNING: lib/idr.c:594 at ida_free+0x24c/0x2d4 lib/idr.c:594, CPU#0: syz-executor357/5073
Modules linked in:
CPU: 0 UID: 0 PID: 5073 Comm: syz-executor357 Tainted: G        W           syzkaller #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : ida_free+0x24c/0x2d4 lib/idr.c:594
lr : ida_free+0x24c/0x2d4 lib/idr.c:594
sp : ffff800094f27880
x29: ffff800094f27910 x28: 00000000000000cc x27: 1fffe0001aec2a11
x26: 00000000000000eb x25: dfff800000000000 x24: ffff800094f27880
x23: ffff7000129e4f10 x22: 0000000000000001 x21: 0000000000000000
x20: 00000000000000eb x19: 0000000000000000 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000001
x14: 0000000000000890 x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: ffff70001135360e x9 : b56adb3a1390ea00
x8 : b56adb3a1390ea00 x7 : ffff8000804a121c x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff80008030d4c8
x2 : 0000000100000000 x1 : ffff0000d8109d80 x0 : 0000000000000000
Call trace:
 ida_free+0x24c/0x2d4 lib/idr.c:594 (P)
 l2cap_chan_le_send_credits+0x17c/0x29c net/bluetooth/l2cap_core.c:7113
 l2cap_chan_rx_avail+0xb4/0x134 net/bluetooth/l2cap_core.c:7126
 l2cap_publish_rx_avail+0x110/0x168 net/bluetooth/l2cap_sock.c:-1
 l2cap_sock_recvmsg+0x280/0x7b8 net/bluetooth/l2cap_sock.c:1317
 sock_recvmsg_nosec net/socket.c:1154 [inline]
 sock_recvmsg+0xd4/0x170 net/socket.c:1176
 __sys_recvfrom+0x1ec/0x31c net/socket.c:2333
 __do_sys_recvfrom net/socket.c:2348 [inline]
 __se_sys_recvfrom net/socket.c:2344 [inline]
 __arm64_sys_recvfrom+0xec/0x10c net/socket.c:2344
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x60/0x1d8 arch/arm64/kernel/entry-common.c:797
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:816
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:606
irq event stamp: 33188
hardirqs last  enabled at (33187): [<ffff8000804a47b4>] vprintk_store+0x924/0xb94 kernel/printk/printk.c:2385
hardirqs last disabled at (33188): [<ffff800086954060>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:484
softirqs last  enabled at (33176): [<ffff800084c8f174>] __alloc_skb+0x1c0/0x610 net/core/skbuff.c:699
softirqs last disabled at (33174): [<ffff800084c8f15c>] local_bh_disable include/linux/bottom_half.h:20 [inline]
softirqs last disabled at (33174): [<ffff800084c8f15c>] __alloc_skb+0x1a8/0x610 net/core/skbuff.c:698
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ida_free called for id=237 which is not allocated.
WARNING: lib/idr.c:594 at ida_free+0x24c/0x2d4 lib/idr.c:594, CPU#0: syz-executor357/5073
Modules linked in:
CPU: 0 UID: 0 PID: 5073 Comm: syz-executor357 Tainted: G        W           syzkaller #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : ida_free+0x24c/0x2d4 lib/idr.c:594
lr : ida_free+0x24c/0x2d4 lib/idr.c:594
sp : ffff800094f27880
x29: ffff800094f27910 x28: 00000000000000cc x27: 1fffe0001aec2a11
x26: 00000000000000ed x25: dfff800000000000 x24: ffff800094f27880
x23: ffff7000129e4f10 x22: 0000000000000001 x21: 0000000000000000
x20: 00000000000000ed x19: 0000000000000000 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000001
x14: 00000000000008db x13: 0000000000000001 x12: ffff800123625000
x11: ffff0001ace79308 x10: 0000000000000001 x9 : b56adb3a1390ea00
x8 : b56adb3a1390ea00 x7 : ffff8000804a121c x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff80008030d4c8
x2 : 0000000100000000 x1 : ffff0000d8109d80 x0 : 0000000000000000
Call trace:
 ida_free+0x24c/0x2d4 lib/idr.c:594 (P)
 l2cap_chan_le_send_credits+0x17c/0x29c net/bluetooth/l2cap_core.c:7113
 l2cap_chan_rx_avail+0xb4/0x134 net/bluetooth/l2cap_core.c:7126
 l2cap_publish_rx_avail+0x110/0x168 net/bluetooth/l2cap_sock.c:-1
 l2cap_sock_recvmsg+0x280/0x7b8 net/bluetooth/l2cap_sock.c:1317
 sock_recvmsg_nosec net/socket.c:1154 [inline]
 sock_recvmsg+0xd4/0x170 net/socket.c:1176
 __sys_recvfrom+0x1ec/0x31c net/socket.c:2333
 __do_sys_recvfrom net/socket.c:2348 [inline]
 __se_sys_recvfrom net/socket.c:2344 [inline]
 __arm64_sys_recvfrom+0xec/0x10c net/socket.c:2344
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x60/0x1d8 arch/arm64/kernel/entry-common.c:797
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:816
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:606
irq event stamp: 33428
hardirqs last  enabled at (33427): [<ffff8000804a47b4>] vprintk_store+0x924/0xb94 kernel/printk/printk.c:2385
hardirqs last disabled at (33428): [<ffff800086954060>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:484
softirqs last  enabled at (33408): [<ffff800084c8f174>] __alloc_skb+0x1c0/0x610 net/core/skbuff.c:699
softirqs last disabled at (33406): [<ffff800084c8f15c>] local_bh_disable include/linux/bottom_half.h:20 [inline]
softirqs last disabled at (33406): [<ffff800084c8f15c>] __alloc_skb+0x1a8/0x610 net/core/skbuff.c:698
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ida_free called for id=166 which is not allocated.
WARNING: lib/idr.c:594 at ida_free+0x24c/0x2d4 lib/idr.c:594, CPU#0: syz-executor357/5073
Modules linked in:
CPU: 0 UID: 0 PID: 5073 Comm: syz-executor357 Tainted: G        W           syzkaller #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : ida_free+0x24c/0x2d4 lib/idr.c:594
lr : ida_free+0x24c/0x2d4 lib/idr.c:594
sp : ffff800094f27880
x29: ffff800094f27910 x28: 00000000000000cc x27: 1fffe0001aec2a11
x26: 00000000000000a6 x25: dfff800000000000 x24: ffff800094f27880
x23: ffff7000129e4f10 x22: 0000000000000001 x21: 0000000000000000
x20: 00000000000000a6 x19: 0000000000000000 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000001
x14: 0000000000000926 x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: ffff70001135360e x9 : b56adb3a1390ea00
x8 : b56adb3a1390ea00 x7 : ffff8000804a121c x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff80008030d4c8
x2 : 0000000100000000 x1 : ffff0000d8109d80 x0 : 0000000000000000
Call trace:
 ida_free+0x24c/0x2d4 lib/idr.c:594 (P)
 l2cap_chan_le_send_credits+0x17c/0x29c net/bluetooth/l2cap_core.c:7113
 l2cap_chan_rx_avail+0xb4/0x134 net/bluetooth/l2cap_core.c:7126
 l2cap_publish_rx_avail+0x110/0x168 net/bluetooth/l2cap_sock.c:-1
 l2cap_sock_recvmsg+0x280/0x7b8 net/bluetooth/l2cap_sock.c:1317
 sock_recvmsg_nosec net/socket.c:1154 [inline]
 sock_recvmsg+0xd4/0x170 net/socket.c:1176
 __sys_recvfrom+0x1ec/0x31c net/socket.c:2333
 __do_sys_recvfrom net/socket.c:2348 [inline]
 __se_sys_recvfrom net/socket.c:2344 [inline]
 __arm64_sys_recvfrom+0xec/0x10c net/socket.c:2344
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x60/0x1d8 arch/arm64/kernel/entry-common.c:797
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:816
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:606
irq event stamp: 53042
hardirqs last  enabled at (53041): [<ffff8000804a47b4>] vprintk_store+0x924/0xb94 kernel/printk/printk.c:2385
hardirqs last disabled at (53042): [<ffff800086954060>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:484
softirqs last  enabled at (53030): [<ffff800084c8f174>] __alloc_skb+0x1c0/0x610 net/core/skbuff.c:699
softirqs last disabled at (53028): [<ffff800084c8f15c>] local_bh_disable include/linux/bottom_half.h:20 [inline]
softirqs last disabled at (53028): [<ffff800084c8f15c>] __alloc_skb+0x1a8/0x610 net/core/skbuff.c:698
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ida_free called for id=172 which is not allocated.
WARNING: lib/idr.c:594 at ida_free+0x24c/0x2d4 lib/idr.c:594, CPU#0: syz-executor357/5073
Modules linked in:
CPU: 0 UID: 0 PID: 5073 Comm: syz-executor357 Tainted: G        W           syzkaller #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : ida_free+0x24c/0x2d4 lib/idr.c:594
lr : ida_free+0x24c/0x2d4 lib/idr.c:594
sp : ffff800094f27880
x29: ffff800094f27910 x28: 00000000000000cc x27: 1fffe0001aec2a11
x26: 00000000000000ac x25: dfff800000000000 x24: ffff800094f27880
x23: ffff7000129e4f10 x22: 0000000000000001 x21: 0000000000000000
x20: 00000000000000ac x19: 0000000000000000 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000001
x14: 0000000000000971 x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: ffff70001135360e x9 : b56adb3a1390ea00
x8 : b56adb3a1390ea00 x7 : ffff8000804a121c x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff80008030d4c8
x2 : 0000000100000000 x1 : ffff0000d8109d80 x0 : 0000000000000000
Call trace:
 ida_free+0x24c/0x2d4 lib/idr.c:594 (P)
 l2cap_chan_le_send_credits+0x17c/0x29c net/bluetooth/l2cap_core.c:7113
 l2cap_chan_rx_avail+0xb4/0x134 net/bluetooth/l2cap_core.c:7126
 l2cap_publish_rx_avail+0x110/0x168 net/bluetooth/l2cap_sock.c:-1
 l2cap_sock_recvmsg+0x280/0x7b8 net/bluetooth/l2cap_sock.c:1317
 sock_recvmsg_nosec net/socket.c:1154 [inline]
 sock_recvmsg+0xd4/0x170 net/socket.c:1176
 __sys_recvfrom+0x1ec/0x31c net/socket.c:2333
 __do_sys_recvfrom net/socket.c:2348 [inline]
 __se_sys_recvfrom net/socket.c:2344 [inline]
 __arm64_sys_recvfrom+0xec/0x10c net/socket.c:2344
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x60/0x1d8 arch/arm64/kernel/entry-common.c:797
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:816
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:606
irq event stamp: 53782
hardirqs last  enabled at (53781): [<ffff8000804a47b4>] vprintk_store+0x924/0xb94 kernel/printk/printk.c:2385
hardirqs last disabled at (53782): [<ffff800086954060>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:484
softirqs last  enabled at (53770): [<ffff800084c8f174>] __alloc_skb+0x1c0/0x610 net/core/skbuff.c:699
softirqs last disabled at (53768): [<ffff800084c8f15c>] local_bh_disable include/linux/bottom_half.h:20 [inline]
softirqs last disabled at (53768): [<ffff800084c8f15c>] __alloc_skb+0x1a8/0x610 net/core/skbuff.c:698
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ida_free called for id=224 which is not allocated.
WARNING: lib/idr.c:594 at ida_free+0x24c/0x2d4 lib/idr.c:594, CPU#0: syz-executor357/5073
Modules linked in:
CPU: 0 UID: 0 PID: 5073 Comm: syz-executor357 Tainted: G        W           syzkaller #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : ida_free+0x24c/0x2d4 lib/idr.c:594
lr : ida_free+0x24c/0x2d4 lib/idr.c:594
sp : ffff800094f27880
x29: ffff800094f27910 x28: 00000000000000cc x27: 1fffe0001aec2a11
x26: 00000000000000e0 x25: dfff800000000000 x24: ffff800094f27880
x23: ffff7000129e4f10 x22: 0000000000000001 x21: 0000000000000000
x20: 00000000000000e0 x19: 0000000000000000 x18: ffff800123625000
x17: ffff0001ace95387 x16: ffff0000d8109d94 x15: 0000000000000001
x14: 00000000000009bc x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: ffff70001135360e x9 : b56adb3a1390ea00
x8 : b56adb3a1390ea00 x7 : ffff8000804a121c x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff80008030d4c8
x2 : 0000000100000000 x1 : ffff0000d8109d80 x0 : 0000000000000000
Call trace:
 ida_free+0x24c/0x2d4 lib/idr.c:594 (P)
 l2cap_chan_le_send_credits+0x17c/0x29c net/bluetooth/l2cap_core.c:7113
 l2cap_chan_rx_avail+0xb4/0x134 net/bluetooth/l2cap_core.c:7126
 l2cap_publish_rx_avail+0x110/0x168 net/bluetooth/l2cap_sock.c:-1
 l2cap_sock_recvmsg+0x280/0x7b8 net/bluetooth/l2cap_sock.c:1317
 sock_recvmsg_nosec net/socket.c:1154 [inline]
 sock_recvmsg+0xd4/0x170 net/socket.c:1176
 __sys_recvfrom+0x1ec/0x31c net/socket.c:2333
 __do_sys_recvfrom net/socket.c:2348 [inline]
 __se_sys_recvfrom net/socket.c:2344 [inline]
 __arm64_sys_recvfrom+0xec/0x10c net/socket.c:2344
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x60/0x1d8 arch/arm64/kernel/entry-common.c:797
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:816
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:606
irq event stamp: 59336
hardirqs last  enabled at (59335): [<ffff8000804a47b4>] vprintk_store+0x924/0xb94 kernel/printk/printk.c:2385
hardirqs last disabled at (59336): [<ffff800086954060>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:484
softirqs last  enabled at (59316): [<ffff800084c8f174>] __alloc_skb+0x1c0/0x610 net/core/skbuff.c:699
softirqs last disabled at (59314): [<ffff800084c8f15c>] local_bh_disable include/linux/bottom_half.h:20 [inline]
softirqs last disabled at (59314): [<ffff800084c8f15c>] __alloc_skb+0x1a8/0x610 net/core/skbuff.c:698
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ida_free called for id=239 which is not allocated.
WARNING: lib/idr.c:594 at ida_free+0x24c/0x2d4 lib/idr.c:594, CPU#0: syz-executor357/5073
Modules linked in:
CPU: 0 UID: 0 PID: 5073 Comm: syz-executor357 Tainted: G        W           syzkaller #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : ida_free+0x24c/0x2d4 lib/idr.c:594
lr : ida_free+0x24c/0x2d4 lib/idr.c:594
sp : ffff800094f27880
x29: ffff800094f27910 x28: 00000000000000cc x27: 1fffe0001aec2a11
x26: 00000000000000ef x25: dfff800000000000 x24: ffff800094f27880
x23: ffff7000129e4f10 x22: 0000000000000001 x21: 0000000000000000
x20: 00000000000000ef x19: 0000000000000000 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000001
x14: 0000000000000a07 x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: ffff70001135360e x9 : b56adb3a1390ea00
x8 : b56adb3a1390ea00 x7 : ffff8000804a121c x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff80008030d4c8
x2 : 0000000100000000 x1 : ffff0000d8109d80 x0 : 0000000000000000
Call trace:
 ida_free+0x24c/0x2d4 lib/idr.c:594 (P)
 l2cap_chan_le_send_credits+0x17c/0x29c net/bluetooth/l2cap_core.c:7113
 l2cap_chan_rx_avail+0xb4/0x134 net/bluetooth/l2cap_core.c:7126
 l2cap_publish_rx_avail+0x110/0x168 net/bluetooth/l2cap_sock.c:-1
 l2cap_sock_recvmsg+0x280/0x7b8 net/bluetooth/l2cap_sock.c:1317
 sock_recvmsg_nosec net/socket.c:1154 [inline]
 sock_recvmsg+0xd4/0x170 net/socket.c:1176
 __sys_recvfrom+0x1ec/0x31c net/socket.c:2333
 __do_sys_recvfrom net/socket.c:2348 [inline]
 __se_sys_recvfrom net/socket.c:2344 [inline]
 __arm64_sys_recvfrom+0xec/0x10c net/socket.c:2344
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x60/0x1d8 arch/arm64/kernel/entry-common.c:797
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:816
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:606
irq event stamp: 60986
hardirqs last  enabled at (60985): [<ffff8000804a47b4>] vprintk_store+0x924/0xb94 kernel/printk/printk.c:2385
hardirqs last disabled at (60986): [<ffff800086954060>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:484
softirqs last  enabled at (60974): [<ffff800084c8f174>] __alloc_skb+0x1c0/0x610 net/core/skbuff.c:699
softirqs last disabled at (60972): [<ffff800084c8f15c>] local_bh_disable include/linux/bottom_half.h:20 [inline]
softirqs last disabled at (60972): [<ffff800084c8f15c>] __alloc_skb+0x1a8/0x610 net/core/skbuff.c:698
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ida_free called for id=6 which is not allocated.
WARNING: lib/idr.c:594 at ida_free+0x24c/0x2d4 lib/idr.c:594, CPU#0: syz-executor357/5073
Modules linked in:
CPU: 0 UID: 0 PID: 5073 Comm: syz-executor357 Tainted: G        W           syzkaller #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : ida_free+0x24c/0x2d4 lib/idr.c:594
lr : ida_free+0x24c/0x2d4 lib/idr.c:594
sp : ffff800094f27880
x29: ffff800094f27910 x28: 00000000000000cc x27: 1fffe0001aec2a11
x26: 0000000000000006 x25: dfff800000000000 x24: ffff800094f27880
x23: ffff7000129e4f10 x22: 0000000000000001 x21: 0000000000000000
x20: 0000000000000006 x19: 0000000000000000 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000001
x14: 0000000000000a52 x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: ffff70001135360e x9 : b56adb3a1390ea00
x8 : b56adb3a1390ea00 x7 : ffff8000804a121c x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff80008030d4c8
x2 : 0000000100000000 x1 : ffff0000d8109d80 x0 : 0000000000000000
Call trace:
 ida_free+0x24c/0x2d4 lib/idr.c:594 (P)
 l2cap_chan_le_send_credits+0x17c/0x29c net/bluetooth/l2cap_core.c:7113
 l2cap_chan_rx_avail+0xb4/0x134 net/bluetooth/l2cap_core.c:7126
 l2cap_publish_rx_avail+0x110/0x168 net/bluetooth/l2cap_sock.c:-1
 l2cap_sock_recvmsg+0x280/0x7b8 net/bluetooth/l2cap_sock.c:1317
 sock_recvmsg_nosec net/socket.c:1154 [inline]
 sock_recvmsg+0xd4/0x170 net/socket.c:1176
 __sys_recvfrom+0x1ec/0x31c net/socket.c:2333
 __do_sys_recvfrom net/socket.c:2348 [inline]
 __se_sys_recvfrom net/socket.c:2344 [inline]
 __arm64_sys_recvfrom+0xec/0x10c net/socket.c:2344
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x60/0x1d8 arch/arm64/kernel/entry-common.c:797
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:816
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:606
irq event stamp: 63392
hardirqs last  enabled at (63391): [<ffff8000804a47b4>] vprintk_store+0x924/0xb94 kernel/printk/printk.c:2385
hardirqs last disabled at (63392): [<ffff800086954060>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:484
softirqs last  enabled at (63380): [<ffff800084c8f174>] __alloc_skb+0x1c0/0x610 net/core/skbuff.c:699
softirqs last disabled at (63378): [<ffff800084c8f15c>] local_bh_disable include/linux/bottom_half.h:20 [inline]
softirqs last disabled at (63378): [<ffff800084c8f15c>] __alloc_skb+0x1a8/0x610 net/core/skbuff.c:698
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ida_free called for id=109 which is not allocated.
WARNING: lib/idr.c:594 at ida_free+0x24c/0x2d4 lib/idr.c:594, CPU#0: syz-executor357/5073
Modules linked in:
CPU: 0 UID: 0 PID: 5073 Comm: syz-executor357 Tainted: G        W           syzkaller #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : ida_free+0x24c/0x2d4 lib/idr.c:594
lr : ida_free+0x24c/0x2d4 lib/idr.c:594
sp : ffff800094f27880
x29: ffff800094f27910 x28: 00000000000000cc x27: 1fffe0001aec2a11
x26: 000000000000006d x25: dfff800000000000 x24: ffff800094f27880
x23: ffff7000129e4f10 x22: 0000000000000001 x21: 0000000000000000
x20: 000000000000006d x19: 0000000000000000 x18: 1fffe000359cf228
x17: 0000000000000003 x16: ffff8000898b7000 x15: ffff80008996b3e0
x14: 0000000000000a9d x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: ffff70001135360e x9 : b56adb3a1390ea00
x8 : b56adb3a1390ea00 x7 : ffff8000804a121c x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff80008030d4c8
x2 : 0000000100000000 x1 : ffff0000d8109d80 x0 : 0000000000000000
Call trace:
 ida_free+0x24c/0x2d4 lib/idr.c:594 (P)
 l2cap_chan_le_send_credits+0x17c/0x29c net/bluetooth/l2cap_core.c:7113
 l2cap_chan_rx_avail+0xb4/0x134 net/bluetooth/l2cap_core.c:7126
 l2cap_publish_rx_avail+0x110/0x168 net/bluetooth/l2cap_sock.c:-1
 l2cap_sock_recvmsg+0x280/0x7b8 net/bluetooth/l2cap_sock.c:1317
 sock_recvmsg_nosec net/socket.c:1154 [inline]
 sock_recvmsg+0xd4/0x170 net/socket.c:1176
 __sys_recvfrom+0x1ec/0x31c net/socket.c:2333
 __do_sys_recvfrom net/socket.c:2348 [inline]
 __se_sys_recvfrom net/socket.c:2344 [inline]
 __arm64_sys_recvfrom+0xec/0x10c net/socket.c:2344
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x60/0x1d8 arch/arm64/kernel/entry-common.c:797
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:816
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:606
irq event stamp: 74376
hardirqs last  enabled at (74375): [<ffff8000804a47b4>] vprintk_store+0x924/0xb94 kernel/printk/printk.c:2385
hardirqs last disabled at (74376): [<ffff800086954060>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:484
softirqs last  enabled at (74346): [<ffff800084c8f174>] __alloc_skb+0x1c0/0x610 net/core/skbuff.c:699
softirqs last disabled at (74344): [<ffff800084c8f15c>] local_bh_disable include/linux/bottom_half.h:20 [inline]
softirqs last disabled at (74344): [<ffff800084c8f15c>] __alloc_skb+0x1a8/0x610 net/core/skbuff.c:698
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ida_free called for id=24 which is not allocated.
WARNING: lib/idr.c:594 at ida_free+0x24c/0x2d4 lib/idr.c:594, CPU#0: syz-executor357/5073
Modules linked in:
CPU: 0 UID: 0 PID: 5073 Comm: syz-executor357 Tainted: G        W           syzkaller #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : ida_free+0x24c/0x2d4 lib/idr.c:594
lr : ida_free+0x24c/0x2d4 lib/idr.c:594
sp : ffff800094f27880
x29: ffff800094f27910 x28: 00000000000000c2 x27: 1fffe0001aec2a11
x26: 0000000000000018 x25: dfff800000000000 x24: ffff800094f27880
x23: ffff7000129e4f10 x22: 0000000000000001 x21: 0000000000000000
x20: 0000000000000018 x19: 0000000000000000 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000001
x14: 0000000000000aea x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: ffff70001135360e x9 : b56adb3a1390ea00
x8 : b56adb3a1390ea00 x7 : ffff8000804a121c x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff80008030d4c8
x2 : 0000000100000000 x1 : ffff0000d8109d80 x0 : 0000000000000000
Call trace:
 ida_free+0x24c/0x2d4 lib/idr.c:594 (P)
 l2cap_chan_le_send_credits+0x17c/0x29c net/bluetooth/l2cap_core.c:7113
 l2cap_chan_rx_avail+0xb4/0x134 net/bluetooth/l2cap_core.c:7126
 l2cap_publish_rx_avail+0x110/0x168 net/bluetooth/l2cap_sock.c:-1
 l2cap_sock_recvmsg+0x280/0x7b8 net/bluetooth/l2cap_sock.c:1317
 sock_recvmsg_nosec net/socket.c:1154 [inline]
 sock_recvmsg+0xd4/0x170 net/socket.c:1176
 __sys_recvfrom+0x1ec/0x31c net/socket.c:2333
 __do_sys_recvfrom net/socket.c:2348 [inline]
 __se_sys_recvfrom net/socket.c:2344 [inline]
 __arm64_sys_recvfrom+0xec/0x10c net/socket.c:2344
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x60/0x1d8 arch/arm64/kernel/entry-common.c:797
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:816
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:606
irq event stamp: 142656
hardirqs last  enabled at (142655): [<ffff8000804a47b4>] vprintk_store+0x924/0xb94 kernel/printk/printk.c:2385
hardirqs last disabled at (142656): [<ffff800086954060>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:484
softirqs last  enabled at (142644): [<ffff800084c8f174>] __alloc_skb+0x1c0/0x610 net/core/skbuff.c:699
softirqs last disabled at (142642): [<ffff800084c8f15c>] local_bh_disable include/linux/bottom_half.h:20 [inline]
softirqs last disabled at (142642): [<ffff800084c8f15c>] __alloc_skb+0x1a8/0x610 net/core/skbuff.c:698
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ida_free called for id=156 which is not allocated.
WARNING: lib/idr.c:594 at ida_free+0x24c/0x2d4 lib/idr.c:594, CPU#0: syz-executor357/5073
Modules linked in:
CPU: 0 UID: 0 PID: 5073 Comm: syz-executor357 Tainted: G        W           syzkaller #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : ida_free+0x24c/0x2d4 lib/idr.c:594
lr : ida_free+0x24c/0x2d4 lib/idr.c:594
sp : ffff800094f27880
x29: ffff800094f27910 x28: 00000000000000be x27: 1fffe0001aec2a11
x26: 000000000000009c x25: dfff800000000000 x24: ffff800094f27880
x23: ffff7000129e4f10 x22: 0000000000000001 x21: 0000000000000000
x20: 000000000000009c x19: 0000000000000000 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000001
x14: 0000000000000b35 x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: ffff70001135360e x9 : b56adb3a1390ea00
x8 : b56adb3a1390ea00 x7 : ffff8000804a121c x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff80008030d4c8
x2 : 0000000100000000 x1 : ffff0000d8109d80 x0 : 0000000000000000
Call trace:
 ida_free+0x24c/0x2d4 lib/idr.c:594 (P)
 l2cap_chan_le_send_credits+0x17c/0x29c net/bluetooth/l2cap_core.c:7113
 l2cap_chan_rx_avail+0xb4/0x134 net/bluetooth/l2cap_core.c:7126
 l2cap_publish_rx_avail+0x110/0x168 net/bluetooth/l2cap_sock.c:-1
 l2cap_sock_recvmsg+0x280/0x7b8 net/bluetooth/l2cap_sock.c:1317
 sock_recvmsg_nosec net/socket.c:1154 [inline]
 sock_recvmsg+0xd4/0x170 net/socket.c:1176
 __sys_recvfrom+0x1ec/0x31c net/socket.c:2333
 __do_sys_recvfrom net/socket.c:2348 [inline]
 __se_sys_recvfrom net/socket.c:2344 [inline]
 __arm64_sys_recvfrom+0xec/0x10c net/socket.c:2344
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x60/0x1d8 arch/arm64/kernel/entry-common.c:797
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:816
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:606
irq event stamp: 158266
hardirqs last  enabled at (158265): [<ffff8000804a47b4>] vprintk_store+0x924/0xb94 kernel/printk/printk.c:2385
hardirqs last disabled at (158266): [<ffff800086954060>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:484
softirqs last  enabled at (158254): [<ffff800084c8f174>] __alloc_skb+0x1c0/0x610 net/core/skbuff.c:699
softirqs last disabled at (158252): [<ffff800084c8f15c>] local_bh_disable include/linux/bottom_half.h:20 [inline]
softirqs last disabled at (158252): [<ffff800084c8f15c>] __alloc_skb+0x1a8/0x610 net/core/skbuff.c:698
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ida_free called for id=180 which is not allocated.
WARNING: lib/idr.c:594 at ida_free+0x24c/0x2d4 lib/idr.c:594, CPU#0: syz-executor357/5073
Modules linked in:
CPU: 0 UID: 0 PID: 5073 Comm: syz-executor357 Tainted: G        W           syzkaller #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : ida_free+0x24c/0x2d4 lib/idr.c:594
lr : ida_free+0x24c/0x2d4 lib/idr.c:594
sp : ffff800094f27880
x29: ffff800094f27910 x28: 00000000000000b9 x27: 1fffe0001aec2a11
x26: 00000000000000b4 x25: dfff800000000000 x24: ffff800094f27880
x23: ffff7000129e4f10 x22: 0000000000000001 x21: 0000000000000000
x20: 00000000000000b4 x19: 0000000000000000 x18: 1fffe000359cf228
x17: 0000000000000003 x16: ffff8000898b7000 x15: ffff80008996b3e0
x14: 0000000000000b80 x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: ffff70001135360e x9 : b56adb3a1390ea00
x8 : b56adb3a1390ea00 x7 : ffff8000804a121c x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff80008030d4c8
x2 : 0000000100000000 x1 : ffff0000d8109d80 x0 : 0000000000000000
Call trace:
 ida_free+0x24c/0x2d4 lib/idr.c:594 (P)
 l2cap_chan_le_send_credits+0x17c/0x29c net/bluetooth/l2cap_core.c:7113
 l2cap_chan_rx_avail+0xb4/0x134 net/bluetooth/l2cap_core.c:7126
 l2cap_publish_rx_avail+0x110/0x168 net/bluetooth/l2cap_sock.c:-1
 l2cap_sock_recvmsg+0x280/0x7b8 net/bluetooth/l2cap_sock.c:1317
 sock_recvmsg_nosec net/socket.c:1154 [inline]
 sock_recvmsg+0xd4/0x170 net/socket.c:1176
 __sys_recvfrom+0x1ec/0x31c net/socket.c:2333
 __do_sys_recvfrom net/socket.c:2348 [inline]
 __se_sys_recvfrom net/socket.c:2344 [inline]
 __arm64_sys_recvfrom+0xec/0x10c net/socket.c:2344
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x60/0x1d8 arch/arm64/kernel/entry-common.c:797
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:816
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:606
irq event stamp: 161840
hardirqs last  enabled at (161839): [<ffff8000804a47b4>] vprintk_store+0x924/0xb94 kernel/printk/printk.c:2385
hardirqs last disabled at (161840): [<ffff800086954060>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:484
softirqs last  enabled at (161824): [<ffff800084c8f174>] __alloc_skb+0x1c0/0x610 net/core/skbuff.c:699
softirqs last disabled at (161822): [<ffff800084c8f15c>] local_bh_disable include/linux/bottom_half.h:20 [inline]
softirqs last disabled at (161822): [<ffff800084c8f15c>] __alloc_skb+0x1a8/0x610 net/core/skbuff.c:698
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ida_free called for id=137 which is not allocated.
WARNING: lib/idr.c:594 at ida_free+0x24c/0x2d4 lib/idr.c:594, CPU#0: syz-executor357/5073
Modules linked in:
CPU: 0 UID: 0 PID: 5073 Comm: syz-executor357 Tainted: G        W           syzkaller #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : ida_free+0x24c/0x2d4 lib/idr.c:594
lr : ida_free+0x24c/0x2d4 lib/idr.c:594
sp : ffff800094f27880
x29: ffff800094f27910 x28: 00000000000000b9 x27: 1fffe0001aec2a11
x26: 0000000000000089 x25: dfff800000000000 x24: ffff800094f27880
x23: ffff7000129e4f10 x22: 0000000000000001 x21: 0000000000000000
x20: 0000000000000089 x19: 0000000000000000 x18: ffff800123625000
x17: ffff0001ace95387 x16: ffff0000d8109d94 x15: 0000000000000001
x14: 0000000000000bcb x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: ffff70001135360e x9 : b56adb3a1390ea00
x8 : b56adb3a1390ea00 x7 : ffff8000804a121c x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff80008030d4c8
x2 : 0000000100000000 x1 : ffff0000d8109d80 x0 : 0000000000000000
Call trace:
 ida_free+0x24c/0x2d4 lib/idr.c:594 (P)
 l2cap_chan_le_send_credits+0x17c/0x29c net/bluetooth/l2cap_core.c:7113
 l2cap_chan_rx_avail+0xb4/0x134 net/bluetooth/l2cap_core.c:7126
 l2cap_publish_rx_avail+0x110/0x168 net/bluetooth/l2cap_sock.c:-1
 l2cap_sock_recvmsg+0x280/0x7b8 net/bluetooth/l2cap_sock.c:1317
 sock_recvmsg_nosec net/socket.c:1154 [inline]
 sock_recvmsg+0xd4/0x170 net/socket.c:1176
 __sys_recvfrom+0x1ec/0x31c net/socket.c:2333
 __do_sys_recvfrom net/socket.c:2348 [inline]
 __se_sys_recvfrom net/socket.c:2344 [inline]
 __arm64_sys_recvfrom+0xec/0x10c net/socket.c:2344
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x60/0x1d8 arch/arm64/kernel/entry-common.c:797
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:816
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:606
irq event stamp: 204974
hardirqs last  enabled at (204973): [<ffff8000804a47b4>] vprintk_store+0x924/0xb94 kernel/printk/printk.c:2385
hardirqs last disabled at (204974): [<ffff800086954060>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:484
softirqs last  enabled at (204956): [<ffff800084c8f174>] __alloc_skb+0x1c0/0x610 net/core/skbuff.c:699
softirqs last disabled at (204954): [<ffff800084c8f15c>] local_bh_disable include/linux/bottom_half.h:20 [inline]
softirqs last disabled at (204954): [<ffff800084c8f15c>] __alloc_skb+0x1a8/0x610 net/core/skbuff.c:698
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ida_free called for id=132 which is not allocated.
WARNING: lib/idr.c:594 at ida_free+0x24c/0x2d4 lib/idr.c:594, CPU#0: syz-executor357/5073
Modules linked in:
CPU: 0 UID: 0 PID: 5073 Comm: syz-executor357 Tainted: G        W           syzkaller #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : ida_free+0x24c/0x2d4 lib/idr.c:594
lr : ida_free+0x24c/0x2d4 lib/idr.c:594
sp : ffff800094f27880
x29: ffff800094f27910 x28: 00000000000000b5 x27: 1fffe0001aec2a11
x26: 0000000000000084 x25: dfff800000000000 x24: ffff800094f27880
x23: ffff7000129e4f10 x22: 0000000000000001 x21: 0000000000000000
x20: 0000000000000084 x19: 0000000000000000 x18: 1fffe000359cf228
x17: 0000000000000003 x16: ffff8000898b7000 x15: 0000000000000001
x14: 0000000000000c17 x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: ffff70001135360e x9 : b56adb3a1390ea00
x8 : b56adb3a1390ea00 x7 : ffff8000804a121c x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff80008030d4c8
x2 : 0000000100000000 x1 : ffff0000d8109d80 x0 : 0000000000000000
Call trace:
 ida_free+0x24c/0x2d4 lib/idr.c:594 (P)
 l2cap_chan_le_send_credits+0x17c/0x29c net/bluetooth/l2cap_core.c:7113
 l2cap_chan_rx_avail+0xb4/0x134 net/bluetooth/l2cap_core.c:7126
 l2cap_publish_rx_avail+0x110/0x168 net/bluetooth/l2cap_sock.c:-1
 l2cap_sock_recvmsg+0x280/0x7b8 net/bluetooth/l2cap_sock.c:1317
 sock_recvmsg_nosec net/socket.c:1154 [inline]
 sock_recvmsg+0xd4/0x170 net/socket.c:1176
 __sys_recvfrom+0x1ec/0x31c net/socket.c:2333
 __do_sys_recvfrom net/socket.c:2348 [inline]
 __se_sys_recvfrom net/socket.c:2344 [inline]
 __arm64_sys_recvfrom+0xec/0x10c net/socket.c:2344
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x60/0x1d8 arch/arm64/kernel/entry-common.c:797
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:816
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:606
irq event stamp: 253844
hardirqs last  enabled at (253843): [<ffff8000804a47b4>] vprintk_store+0x924/0xb94 kernel/printk/printk.c:2385
hardirqs last disabled at (253844): [<ffff800086954060>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:484
softirqs last  enabled at (253832): [<ffff800084c8f174>] __alloc_skb+0x1c0/0x610 net/core/skbuff.c:699
softirqs last disabled at (253830): [<ffff800084c8f15c>] local_bh_disable include/linux/bottom_half.h:20 [inline]
softirqs last disabled at (253830): [<ffff800084c8f15c>] __alloc_skb+0x1a8/0x610 net/core/skbuff.c:698
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ida_free called for id=233 which is not allocated.
WARNING: lib/idr.c:594 at ida_free+0x24c/0x2d4 lib/idr.c:594, CPU#0: syz-executor357/5073
Modules linked in:
CPU: 0 UID: 0 PID: 5073 Comm: syz-executor357 Tainted: G        W           syzkaller #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : ida_free+0x24c/0x2d4 lib/idr.c:594
lr : ida_free+0x24c/0x2d4 lib/idr.c:594
sp : ffff800094f27880
x29: ffff800094f27910 x28: 00000000000000b5 x27: 1fffe0001aec2a11
x26: 00000000000000e9 x25: dfff800000000000 x24: ffff800094f27880
x23: ffff7000129e4f10 x22: 0000000000000001 x21: 0000000000000000
x20: 00000000000000e9 x19: 0000000000000000 x18: ffff800123625000
x17: ffff0001ace95387 x16: ffff0000d8109d94 x15: 0000000000000001
x14: 0000000000000c62 x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: ffff70001135360e x9 : b56adb3a1390ea00
x8 : b56adb3a1390ea00 x7 : ffff8000804a121c x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff80008030d4c8
x2 : 0000000100000000 x1 : ffff0000d8109d80 x0 : 0000000000000000
Call trace:
 ida_free+0x24c/0x2d4 lib/idr.c:594 (P)
 l2cap_chan_le_send_credits+0x17c/0x29c net/bluetooth/l2cap_core.c:7113
 l2cap_chan_rx_avail+0xb4/0x134 net/bluetooth/l2cap_core.c:7126
 l2cap_publish_rx_avail+0x110/0x168 net/bluetooth/l2cap_sock.c:-1
 l2cap_sock_recvmsg+0x280/0x7b8 net/bluetooth/l2cap_sock.c:1317
 sock_recvmsg_nosec net/socket.c:1154 [inline]
 sock_recvmsg+0xd4/0x170 net/socket.c:1176
 __sys_recvfrom+0x1ec/0x31c net/socket.c:2333
 __do_sys_recvfrom net/socket.c:2348 [inline]
 __se_sys_recvfrom net/socket.c:2344 [inline]
 __arm64_sys_recvfrom+0xec/0x10c net/socket.c:2344
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x60/0x1d8 arch/arm64/kernel/entry-common.c:797
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:816
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:606
irq event stamp: 288938
hardirqs last  enabled at (288937): [<ffff8000804a47b4>] vprintk_store+0x924/0xb94 kernel/printk/printk.c:2385
hardirqs last disabled at (288938): [<ffff800086954060>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:484
softirqs last  enabled at (288918): [<ffff800084c8f174>] __alloc_skb+0x1c0/0x610 net/core/skbuff.c:699
softirqs last disabled at (288916): [<ffff800084c8f15c>] local_bh_disable include/linux/bottom_half.h:20 [inline]
softirqs last disabled at (288916): [<ffff800084c8f15c>] __alloc_skb+0x1a8/0x610 net/core/skbuff.c:698
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ida_free called for id=24 which is not allocated.
WARNING: lib/idr.c:594 at ida_free+0x24c/0x2d4 lib/idr.c:594, CPU#0: syz-executor357/5073
Modules linked in:
CPU: 0 UID: 0 PID: 5073 Comm: syz-executor357 Tainted: G        W           syzkaller #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : ida_free+0x24c/0x2d4 lib/idr.c:594
lr : ida_free+0x24c/0x2d4 lib/idr.c:594
sp : ffff800094f27880
x29: ffff800094f27910 x28: 00000000000000b7 x27: 1fffe0001aec2a11
x26: 0000000000000018 x25: dfff800000000000 x24: ffff800094f27880
x23: ffff7000129e4f10 x22: 0000000000000001 x21: 0000000000000000
x20: 0000000000000018 x19: 0000000000000000 x18: 0000000000000000
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000001
x14: 0000000000000cad x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: ffff70001135360e x9 : b56adb3a1390ea00
x8 : b56adb3a1390ea00 x7 : ffff8000804a121c x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff80008030d4c8
x2 : 0000000100000000 x1 : ffff0000d8109d80 x0 : 0000000000000000
Call trace:
 ida_free+0x24c/0x2d4 lib/idr.c:594 (P)
 l2cap_chan_le_send_credits+0x17c/0x29c net/bluetooth/l2cap_core.c:7113
 l2cap_chan_rx_avail+0xb4/0x134 net/bluetooth/l2cap_core.c:7126
 l2cap_publish_rx_avail+0x110/0x168 net/bluetooth/l2cap_sock.c:-1
 l2cap_sock_recvmsg+0x280/0x7b8 net/bluetooth/l2cap_sock.c:1317
 sock_recvmsg_nosec net/socket.c:1154 [inline]
 sock_recvmsg+0xd4/0x170 net/socket.c:1176
 __sys_recvfrom+0x1ec/0x31c net/socket.c:2333
 __do_sys_recvfrom net/socket.c:2348 [inline]
 __se_sys_recvfrom net/socket.c:2344 [inline]
 __arm64_sys_recvfrom+0xec/0x10c net/socket.c:2344
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x60/0x1d8 arch/arm64/kernel/entry-common.c:797
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:816
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:606
irq event stamp: 293428
hardirqs last  enabled at (293427): [<ffff8000804a47b4>] vprintk_store+0x924/0xb94 kernel/printk/printk.c:2385
hardirqs last disabled at (293428): [<ffff800086954060>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:484
softirqs last  enabled at (293416): [<ffff800084c8f174>] __alloc_skb+0x1c0/0x610 net/core/skbuff.c:699
softirqs last disabled at (293414): [<ffff800084c8f15c>] local_bh_disable include/linux/bottom_half.h:20 [inline]
softirqs last disabled at (293414): [<ffff800084c8f15c>] __alloc_skb+0x1a8/0x610 net/core/skbuff.c:698
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ida_free called for id=67 which is not allocated.
WARNING: lib/idr.c:594 at ida_free+0x24c/0x2d4 lib/idr.c:594, CPU#0: syz-executor357/5073
Modules linked in:
CPU: 0 UID: 0 PID: 5073 Comm: syz-executor357 Tainted: G        W           syzkaller #0 PREEMPT 
Tainted: [W]=WARN
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : ida_free+0x24c/0x2d4 lib/idr.c:594
lr : ida_free+0x24c/0x2d4 lib/idr.c:594
sp : ffff800094f27880
x29: ffff800094f27910 x28: 00000000000000b4 x27: 1fffe0001aec2a11
x26: 0000000000000043 x25: dfff800000000000 x24: ffff800094f27880
x23: ffff7000129e4f10 x22: 0000000000000001 x21: 0000000000000000
x20: 0000000000000043 x19: 0000000000000000 x18: 1fffe000359cf228
x17: 0000000000000003 x16: ffff8000898b7000 x15: ffff80008996b3e0
x14: 0000000000000cf8 x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: ffff70001135360e x9 : b56adb3a1390ea00
x8 : b56adb3a1390ea00 x7 : ffff8000804a121c x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : ffff80008030d4c8
x2 : 0000000100000000 x1 : ffff0000d8109d80 x0 : 0000000000000000
Call trace:
 ida_free+0x24c/0x2d4 lib/idr.c:594 (P)
 l2cap_chan_le_send_credits+0x17c/0x29c net/bluetooth/l2cap_core.c:7113
 l2cap_chan_rx_avail+0xb4/0x134 net/bluetooth/l2cap_core.c:7126
 l2cap_publish_rx_avail+0x110/0x168 net/bluetooth/l2cap_sock.c:-1
 l2cap_sock_recvmsg+0x280/0x7b8 net/bluetooth/l2cap_sock.c:1317
 sock_recvmsg_nosec net/socket.c:1154 [inline]
 sock_recvmsg+0xd4/0x170 net/socket.c:1176
 __sys_recvfrom+0x1ec/0x31c net/socket.c:2333
 __do_sys_recvfrom net/socket.c:2348 [inline]
 __se_sys_recvfrom net/socket.c:2344 [inline]
 __arm64_sys_recvfrom+0xec/0x10c net/socket.c:2344
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x244 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xec/0x23c arch/arm64/kernel/syscall.c:121
 do_el0_svc+0x4c/0x5c arch/arm64/kernel/syscall.c:140
 el0_svc+0x60/0x1d8 arch/arm64/kernel/entry-common.c:797
 el0t_64_sync_handler+0x44/0x104 arch/arm64/kernel/entry-common.c:816
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:606
irq event stamp: 298612
hardirqs last  enabled at (298611): [<ffff8000804a47b4>] vprintk_store+0x924/0xb94 kernel/printk/printk.c:2385
hardirqs last disabled at (298612): [<ffff800086954060>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:484
softirqs last  enabled at (298596): [<ffff800084c8f174>] __alloc_skb+0x1c0/0x610 net/core/skbuff.c:699
softirqs last disabled at (298594): [<ffff800084c8f15c>] local_bh_disable include/linux/bottom_half.h:20 [inline]
softirqs last disabled at (298594): [<ffff800084c8f15c>] __alloc_skb+0x1a8/0x610 net/core/skbuff.c:698
---[ end trace 0000000000000000 ]---
------------[ cut here ]------------
ida_free called for id=69 which is not allocated.
WARNING: lib/idr.c:594 at ida_free+0x24c/0x2d4 lib/idr.c:594, CPU#0: syz-executor357/5073
Modules l
