Received: from mail-oa1-f77.google.com (mail-oa1-f77.google.com [209.85.160.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302FC46AED7
	for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 12:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778846723; cv=none; b=a8BOH5udCjPYbCNo16XP8bDRrd8RiGyqPp177PMTTkcDWI8JfImWo3EeUzJwEhHP5xvVqp/7uN80G0Y5qQ8OKaYVobFT5+MrD6aSyRHfLvHS9if0Nabx11co0TnGnBYggvC89ruThVl5+tTszwrwY1BQIo1Z6qtqvEwE9EHWcpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778846723; c=relaxed/simple;
	bh=Jer2BC/va0AeVuOM6s5SCldIYf3dZe0BsgnG0Yn7dkU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uJGWrj0j4TGT5HusjZ/hKkUWhOhQrNojBxFypoKkq4KgtdbYvERJMQjS64W4He2Fe6Jozo2dfMb5EXUMfkcMMfw7MK36024Aahc7wyrSnauAn7W7hAw03QVCEkVwA1X+Nrx3oCjGaNUkRyZZCXW0QUjupbQUyNh57PIEuVEwIlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f77.google.com with SMTP id 586e51a60fabf-439ba95ef42so3071583fac.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 15 May 2026 05:05:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778846721; x=1779451521;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xG79SxzP85bk+Ef+HUcBRKzjUlic/7Ew2qFuPNNcY8k=;
        b=K/SMRO9nB+cmKDwq0EozgDlGpwRoZ6dKxvaLNjAsrKITr1SWhNVe3lS6UrSv3DumT5
         xK1GsFPGJhzbkgqbAHe/Q4imiDP+LMAIibvsKeUt+hFSKfMfCH5UURjD1xSad6w6DMJr
         kHuwQdE5rSVhv3S+MJqQC2B2nAPg8/rbBrgQsIn0hBAYFlcKBhkJqTbLnanJBbFNaK7A
         dRwGdkwFlcb5LQ00gdqTHJf1Cq+GFscun74gUpGxpwwcQiIRBdhIXePQTD8EGWOpdLHu
         Bs/o9in5QQK7K4QAZQVWTHTeoh+dkkGUvz8fdZCouMCT/zjnAIB4RkEves35Ojzmq7S/
         loxw==
X-Gm-Message-State: AOJu0Yz/skkjfbc+1GXrircgYhAUez95vx5gf3tf3CsjEzdN/FyYHAAw
	Rr8VD5i4N3/aPakFILAXpYIkgNGzSatBocUQK24iICnIIQPA9H6O1d70l+Jd3tQqoUQqhkD7EiS
	YlC1Pd3UlpQ86MUeAmp/6CMDtztw1BsUucZv7eDj4R6TuhslZt3LGVEA6G5w4lQ==
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1746:b0:688:2480:7fa8 with SMTP id
 006d021491bc7-69c942dac4dmr2292738eaf.21.1778846721159; Fri, 15 May 2026
 05:05:21 -0700 (PDT)
Date: Fri, 15 May 2026 05:05:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a070c01.050a0220.358c9.0001.GAE@google.com>
Subject: [syzbot] [bluetooth?] WARNING in hci_conn_drop (4)
From: syzbot <syzbot+195b4c12c5b8c9a8eb8b@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5cbb61bf4168 arm64/fpsimd: ptrace: zero target's fpsimd_st..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=13f0ebce580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a834c6344141a58b
dashboard link: https://syzkaller.appspot.com/bug?extid=195b4c12c5b8c9a8eb8b
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/04156ec16593/disk-5cbb61bf.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6bfa041e2c79/vmlinux-5cbb61bf.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a92d82d8a79e/Image-5cbb61bf.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+195b4c12c5b8c9a8eb8b@syzkaller.appspotmail.com

------------[ cut here ]------------
workqueue: cannot queue hci_conn_timeout on wq hci4
WARNING: kernel/workqueue.c:2298 at __queue_work+0xf6c/0x12f8 kernel/workqueue.c:2296, CPU#0: kworker/0:5/4769
Modules linked in:
CPU: 0 UID: 0 PID: 4769 Comm: kworker/0:5 Tainted: G             L      syzkaller #0 PREEMPT 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
Workqueue: events l2cap_chan_timeout
pstate: 634000c5 (nZCv daIF +PAN -UAO +TCO +DIT -SSBS BTYPE=--)
pc : __queue_work+0xf6c/0x12f8 kernel/workqueue.c:2296
lr : __queue_work+0xf6c/0x12f8 kernel/workqueue.c:2296
sp : ffff800092887810
x29: ffff800092887850 x28: ffff700012510f78 x27: ffff0000d64aba88
x26: ffff0000d629f800 x25: 0000000000000008 x24: ffff0000d629f9c0
x23: dfff800000000000 x22: ffff0000de09572c x21: 0000000004208060
x20: ffff800089f06000 x19: ffff0000c5968a58 x18: 1fffe00035c20e20
x17: ffff8000888db000 x16: ffff80008898cfc0 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000001 x12: 0000000000000000
x11: 0000000000000000 x10: 0000000000ff0100 x9 : 2aca8fde2d60a500
x8 : 2aca8fde2d60a500 x7 : ffff8000804886d0 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000000 x3 : ffff8000802f13b0
x2 : 0000000100000000 x1 : ffff0000de095700 x0 : 0000000000000000
Call trace:
 __queue_work+0xf6c/0x12f8 kernel/workqueue.c:2296 (P)
 __queue_delayed_work+0xf4/0x2b4 kernel/workqueue.c:2548
 queue_delayed_work_on+0xcc/0x140 kernel/workqueue.c:2600
 queue_delayed_work include/linux/workqueue.h:711 [inline]
 hci_conn_drop+0x174/0x29c include/net/bluetooth/hci_core.h:1712
 l2cap_chan_del+0x220/0x48c net/bluetooth/l2cap_core.c:672
 l2cap_chan_close+0x3e4/0x5ac net/bluetooth/l2cap_core.c:-1
 l2cap_chan_timeout+0x120/0x29c net/bluetooth/l2cap_core.c:431
 process_one_work+0x78c/0x173c kernel/workqueue.c:3302
 process_scheduled_works+0xdc/0x13c kernel/workqueue.c:3385
 worker_thread+0x770/0xbd0 kernel/workqueue.c:3466
 kthread+0x2f0/0x3c0 kernel/kthread.c:436
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:842
irq event stamp: 81246
hardirqs last  enabled at (81245): [<ffff800080351f60>] __cancel_work+0xf4/0x1a4 kernel/workqueue.c:4454
hardirqs last disabled at (81246): [<ffff80008034e144>] queue_delayed_work_on+0x54/0x140 kernel/workqueue.c:2596
softirqs last  enabled at (81238): [<ffff800084aa1108>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (81238): [<ffff800084aa1108>] release_sock+0x150/0x228 net/core/sock.c:3825
softirqs last disabled at (81234): [<ffff800084aa0fec>] spin_lock_bh include/linux/spinlock.h:348 [inline]
softirqs last disabled at (81234): [<ffff800084aa0fec>] release_sock+0x34/0x228 net/core/sock.c:3812
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
