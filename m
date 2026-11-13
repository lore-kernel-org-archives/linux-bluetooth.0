Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.199
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794613112;
	b=xZQEmY1p97I+pwjJaLA6BObgZQkBAlTq8G1AftVb1o+N5Naz1iI2sFChUbpfNOeUBe7B
	 V9GC13Qm8/LX3wdBYkzywq5tclAaLad6tzP6TkC0fMA6DYkDFC3q/bJa77RGuV7afDjiZ
	 7n4h92sPddoeWAzFstx5+WrT/0iwoC+oAAgNs72zSTxhbWw8mblBVvVr6TTX7nxkENIli
	 8hnDh0zSLnoxUJKFvCt9qj6l0LH0GUEvToLKAl+QoLLMBbWnJGAulW+ulJb1FvB8qrqXV
	 WeGKc5zQLEsgdwF2SXwBfTJVn9x/+O0JyGrkA1xLyhCB5pJTj5V0gGw+iLnvA7OtXpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794613112;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 MIME-Version:X-Received:Date:X-Google-Appengine-App-Id:
	 X-Google-Appengine-App-Id-Alias:Message-ID:Subject:From:To:
	 Content-Type;
	bh=IXMzMwEfsS4+/hshQyxBdyRvMuv05vJvUOLr/48g+rU=;
	b=rcWQt24yWWOxQCAEx4SMEFqrHc9hIDzlPoq4lQDnvpg4cfVvnUl3hfwdxbJ2MoO8K+gl
	 wHDniwoJKxRd5Xs37bLbGRp44FlobrRhB296gZQ6D/Bdn17jLzJGElB7Ijq28XEKx+3Ps
	 tN3MPoYgXAOw6P7iAG1gk5n8c2JlxTTN1ExGvm/rf6AU54sfOAa7iKzDGwTNSPDsAWfqA
	 GfAW4kDH8ETMYsBgJfvN4uxvlihYu8k0YBzS31FW3l3vqV6aIByjruxSjG3udekMshcRc
	 o01LF352sKNXAmMwwX3hVb4spyp8lAOVlSgmIbBUPcypFGwBYz9kTX9uJ9DyBwvmi3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=syzkaller.appspotmail.com;
	spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com;
	arc=none smtp.remote-ip=209.85.167.199
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F20D606A333
	for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 23:38:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F20D606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4dab94dc3e7so3248030b6e.0
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 Nov 2026 15:38:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794613111; x=1795217911;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IXMzMwEfsS4+/hshQyxBdyRvMuv05vJvUOLr/48g+rU=;
        b=OdY1ehg+TmUZUQUd99SfR9ShQIAzsnyHT4dpbLeI0W8zmOx0Ws0w9nMP2RooCbFRt9
         9N8fpAtERO3Eb30t3Ej6EyVrUDiJ6NE48ITKQhJGIvZ+TkK7+D84qD/9tp46oxY6iTPp
         ZWkgaLtXJP5VjHiyg0CkqkqVEdveWcdChLe3Y77BX+wcFF0IjMG9H3MMGoQrE+fW/DDG
         wli265p2H+1KYv0FWFoD0LclrZpD8JWqxG/5NN/Poy4JfPe+0sso8c4OvMRLDME+kIsT
         1vNFxmLYtliv8Xy4HN+tGhh25P5KFt6P7y0KAkejwSm7Q8nYLYeach+xcWyCkTtG2uQ6
         6Uhg==
X-Gm-Message-State: APuU4Z8Q1oFOmYrGuq/XROWjJkT7iFSzGO91+BYzz0Si3oW60gm8rLiQ
	qDx6IgbEc0oKLIqIcgxY1BbKkzzzQ5McvlnElymoM1x2yInU8/dvZkCJ9u1XOn5Cp5bzvRk/6w9
	GEuiHvvWXf25FAA3Sq4SWyOllDyQiZEm2+rba/ckBCywI1uKRyZn4ELaPLH0=
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
List-Help: <mailto:linux-bluetooth+help@vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-bluetooth+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-Received: by 2002:a05:6808:309d:b0:533:87ee:d131 with SMTP id
 5614622812f47-56e64effd43mr3820536b6e.25.1794613111223; Fri, 13 Nov 2026
 15:38:31 -0800 (PST)
Date: Fri, 13 Nov 2026 15:38:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6af79f77.98e60839.1e023a.00d6.GAE@google.com>
Subject: [syzbot] [bluetooth?] WARNING in l2cap_chan_le_send_credits
From: syzbot <syzbot+9dc8780713b11155dd74@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    18f2d01bfce9 arm64: kexec_file: Do not use CMA for images ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=11e3a44d580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4e8e6c1701ad8af2
dashboard link: https://syzkaller.appspot.com/bug?extid=9dc8780713b11155dd74
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8bc8f56b5c77/disk-18f2d01b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0964f39ade28/vmlinux-18f2d01b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/03ec4e4b937f/Image-18f2d01b.gz.xz

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
ida_free called for id=2 which is not allocated.
WARNING: lib/idr.c:594 at ida_free+0x24c/0x2d4 lib/idr.c:594, CPU#0: syz.4.2428/12785
Modules linked in:
CPU: 0 UID: 0 PID: 12785 Comm: syz.4.2428 Tainted: G             L      syzkaller #0 PREEMPT 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/06/2026
pstate: 63400005 (nZCv daif +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : ida_free+0x24c/0x2d4 lib/idr.c:594
lr : ida_free+0x24c/0x2d4 lib/idr.c:594
sp : ffff800094d27880
x29: ffff800094d27910 x28: 00000000000000cc x27: 1fffe0001fc18211
x26: 0000000000000002 x25: dfff800000000000 x24: ffff800094d27880
x23: ffff7000129a4f10 x22: 00000000000000ca x21: 0000000000000000
x20: 0000000000000002 x19: 0000000000000000 x18: 00000000ffffffff
x17: 0000000000000000 x16: 0000000000000000 x15: ffff80008b586000
x14: 0000000000001f42 x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000080000 x9 : 8f9eb4c3589ac800
x8 : 8f9eb4c3589ac800 x7 : 756372735f656c6f x6 : 5f656c6f736e6f63
x5 : ffff0000e4be4ffc x4 : 0000000000000000 x3 : ffff80008030d4c8
x2 : 0000000100000000 x1 : ffff0000dc3b0000 x0 : 0000000000000001
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
irq event stamp: 584
hardirqs last  enabled at (583): [<ffff8000804a47b4>] vprintk_store+0x924/0xb94 kernel/printk/printk.c:2385
hardirqs last disabled at (584): [<ffff800086954058>] el1_brk64+0x20/0x54 arch/arm64/kernel/entry-common.c:484
softirqs last  enabled at (552): [<ffff8000800204f4>] __do_softirq+0x14/0x20 kernel/softirq.c:703
softirqs last disabled at (547): [<ffff8000800204f4>] __do_softirq+0x14/0x20 kernel/softirq.c:703
---[ end trace 0000000000000000 ]---


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
