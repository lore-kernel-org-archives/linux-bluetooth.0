Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE853D16EC
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 12:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779366033; cv=none; b=L6ENViBlhCaYFqo+Tr2E3ltZb95/aZCssenO49jotbD+5SZXR8Oz6AkEJLx2MUH+4CiKJON1/mvxTHcYOmNCc+GIzCA3ymEMUiTIvGWrGSHvn6QX92rylLl2wizgxmDHQCG0quW3ILmfxLaf1s3eaW6nw0TFTdyl0PvC8r7b1eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779366033; c=relaxed/simple;
	bh=Gh28SfWmkzS2vkAboXXSPdN1N+6HPY3dWeqZHxOnb+o=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WodOyAfCB+pT0CZ99ERrSu3uTprfew+QYeowni/64xHQ6uzOYgA+96MFu26laQYOR+tFLXgsjkLkb21tEEO+D2wtro2/pYS1IS/fp45r+32tRnFoN7rRNgbQHYrlHWoOZLFXmQV6gQb1XFX9/OeGbmMcRkcTBZrA3AxuH+N+F2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-6948d83a548so17519319eaf.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 21 May 2026 05:20:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779366031; x=1779970831;
        h=content-transfer-encoding:to:from:subject:message-id:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x1Q8xrqYHGimh4kFYtM9Tp1zCduOr1Dac5mZvvZNvtE=;
        b=nPkzTZ+woTMB5CxMDtWRRf1zxRrZid5O433laYk1wy2N5i0NESFW70B2X+jNextMdi
         +MShzIXxOsRkCPNgyjwSNGylhCerf2Xrc/xzTh3orar/HPn77zd9sHvbSw8Sxi8rt58u
         ipLzcuMciptmQTlnbjyXUle09tkQwJCf/I+9JQJ2wx3S2FfKdHIZNTs1Q1PcQH0qevHT
         hvG/voXZuPRmY9dIZnAePMCoDaP1wglK8X4i0a1gvdl1QjHX8EWPdQlsoVCTll9Jghcm
         n9R3kE2HlQ14RK+KydeRPJa7hZ5bynabr2/m7dX2/sJ/U/0CeKjEBVWeNS0yWro+xfr8
         oMWg==
X-Gm-Message-State: AOJu0Yy6U2wfnjDTr7OMAoDzFPH/V2PSKpy29EIscCuwlP2fkOAz8xpV
	udb/Ee8b+50JCG4yb530L0Zh3mso6GUIt5SZ31uTRF3YZh7TkMxNop9U6HVwj+Iikpp6VOJXZl3
	BH/mV6CqPx2PcmEYDdmI3LVM5SlzQgi5KPq4OEap6WcFzhamHGUPRpXnuVY2jdw==
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:208c:b0:69d:6696:846a with SMTP id
 006d021491bc7-69d6ef10fcemr1072211eaf.52.1779366030756; Thu, 21 May 2026
 05:20:30 -0700 (PDT)
Date: Thu, 21 May 2026 05:20:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a0ef88e.170a0220.303405.4ce2.GAE@google.com>
Subject: [syzbot] [bluetooth?] WARNING in hci_send_acl (4)
From: syzbot <syzbot+0e3882021d9c3ae26430@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

syzbot found the following issue on:

HEAD commit:    5cbb61bf4168 arm64/fpsimd: ptrace: zero target's fpsimd_st.=
.
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.g=
it for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=3D138bd02e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3Da834c6344141a58=
b
dashboard link: https://syzkaller.appspot.com/bug?extid=3D0e3882021d9c3ae26=
430
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-=
1~exp1~20251221153213.50), Debian LLD 21.1.8
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/04156ec16593/disk-=
5cbb61bf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6bfa041e2c79/vmlinux-=
5cbb61bf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a92d82d8a79e/Ima=
ge-5cbb61bf.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit=
:
Reported-by: syzbot+0e3882021d9c3ae26430@syzkaller.appspotmail.com

------------[ cut here ]------------
workqueue: cannot queue hci_tx_work on wq hci2
WARNING: kernel/workqueue.c:2298 at __queue_work+0xf6c/0x12f8 kernel/workqu=
eue.c:2296, CPU#0: kbnepd =01/10362
Modules linked in:
CPU: 0 UID: 0 PID: 10362 Comm: kbnepd =01 Tainted: G             L      syz=
kaller #0 PREEMPT=20
Tainted: [L]=3DSOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 03/18/2026
pstate: 634000c5 (nZCv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=3D--)
pc : __queue_work+0xf6c/0x12f8 kernel/workqueue.c:2296
lr : __queue_work+0xf6c/0x12f8 kernel/workqueue.c:2296
sp : ffff8000971a7560
x29: ffff8000971a75a0 x28: ffff0000ed3e98c0 x27: ffff0000ed3e9990
x26: ffff0000ca68f800 x25: 0000000000000008 x24: ffff0000ca68f9c0
x23: dfff800000000000 x22: ffff0000d8bb002c x21: 0000000000208040
x20: ffff800089f06000 x19: ffff0000ce2d0c50 x18: 1fffe00035c20e20
x17: ffff8000888db000 x16: ffff80008898cfc0 x15: ffff0001ae10710c
x14: 0000000000000000 x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000001c1f x10: 0000000000ff0100 x9 : 2106f328601d6d00
x8 : 2106f328601d6d00 x7 : ffff8000804886d0 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000000 x3 : ffff8000802f13b0
x2 : 0000000100000000 x1 : ffff0000d8bb0000 x0 : 0000000000000000
Call trace:
 __queue_work+0xf6c/0x12f8 kernel/workqueue.c:2296 (P)
 queue_work_on+0xc0/0x130 kernel/workqueue.c:2432
 queue_work include/linux/workqueue.h:696 [inline]
 hci_send_acl+0x4a4/0x7c4 net/bluetooth/hci_core.c:3283
 l2cap_do_send+0x18c/0x2b4 net/bluetooth/l2cap_core.c:1019
 l2cap_chan_send+0x108c/0x1dc4 net/bluetooth/l2cap_core.c:-1
 l2cap_sock_sendmsg+0x284/0x428 net/bluetooth/l2cap_sock.c:1164
 sock_sendmsg_nosec net/socket.c:787 [inline]
 __sock_sendmsg+0xc8/0x138 net/socket.c:802
 sock_sendmsg+0x154/0x228 net/socket.c:825
 kernel_sendmsg+0x54/0x6c net/socket.c:849
 bnep_tx_frame net/bluetooth/bnep/core.c:466 [inline]
 bnep_session+0x1ce0/0x2298 net/bluetooth/bnep/core.c:509
 kthread+0x2f0/0x3c0 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:842
irq event stamp: 284
hardirqs last  enabled at (283): [<ffff8000803bd554>] raw_spin_rq_unlock_ir=
q kernel/sched/sched.h:1644 [inline]
hardirqs last  enabled at (283): [<ffff8000803bd554>] finish_lock_switch+0x=
160/0x204 kernel/sched/core.c:5124
hardirqs last disabled at (284): [<ffff80008034c854>] queue_work_on+0x4c/0x=
130 kernel/workqueue.c:2428
softirqs last  enabled at (236): [<ffff800084ab928c>] local_bh_enable+0x10/=
0x34 include/linux/bottom_half.h:32
softirqs last disabled at (232): [<ffff800084ab9258>] local_bh_disable+0x10=
/0x34 include/linux/bottom_half.h:19
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
