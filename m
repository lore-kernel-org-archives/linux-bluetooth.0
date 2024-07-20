Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C73C146A74
	for <linux-bluetooth@vger.kernel.org>; Sat, 20 Jul 2024 22:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721515827; cv=none; b=oUKr+yiFlG7OiSJr4p/q4Gs9gi4vGmqk2vBUF6gRRYLgSpUYSLGgWpzoJJONG0URITiYdfENP2MliuIgKAnuyDAoD1RznHbtrhFihYEnAAZ2ftn24Kh0tQkTvGcIo+skwoSl/+JXMnJUSA8PRtdPcfFIkn/oP+VcJds+CBYlEnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721515827; c=relaxed/simple;
	bh=6KDEKAZxaaedn3DthDnvLDB9BLKZ5vLPXc3BKVo8Yt0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=a6tekiXT/PwFdLJRwn0hZ+Rzx+pMv92M85wkBjPGFg43QMBmr7L4pooZwxqz/MJeeO0gWjy8HWvVC77ih/JDaod/eTVh5goVkpjwFj8+3TQ8xY9vFqwmbcu4GRD3q8j3n4NFxMLsRWJpfU2U09lr7YhYIooHpKZQ8RI2a2z6dl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-804888d4610so524294939f.1
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Jul 2024 15:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721515823; x=1722120623;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h1ZlSIo7L/KcAi7yI9hJz8UA/MAu2rn5teJC55aiBZY=;
        b=J24H/X/GTeEeG8Pgz2Hvxv1LaWXTGqFrtn0c0SknpzxlJp+VuY6/iMda4q+saGMe78
         kXUGduksOPYKsZO862Er2JTzo8/hHSG00JIwAwCgj9OycNPYDTPIgIQZ9sBlc2px7rKI
         u9oJo+CtTWvpuKEh18XGTj/PCTPPOso1ca11QdfodTILarPz5rRS0dSp0vN/MwqiuHHv
         3KGAJVfrmqAFdJWDaF0AQdbh1KAGNB0zCTNNvveUhIxEnEX94oFfcCW8Lq7s7BUia6GW
         AE0PQECZKLXEZMQf3t2tjlzP6aCDwpMfSQhVZLA0eEoeV1QJyS4WKhRMUxdF3U5lBwXY
         HtRA==
X-Forwarded-Encrypted: i=1; AJvYcCXsW9XkqxtFg+EXW5ENQlK+12J+Ru+/4pbTvQG1XtzK7xQkg5tzloD+m8TTO5vAKvvxp2kmZuNaXlB1UfVDh1HJ9vXOMTD1NH1UBrG1J1d3
X-Gm-Message-State: AOJu0YxlG3pEzYAcya6mfHQ39BJWbIoGibor/G2Su5XVxa8aObT3HnxK
	PsTckO7Di998a/kuYjk1HyuXKsXZIvHAkel+8P3dl/M1zqxhthNXo279RIOTdTUTtor35TqNyV6
	Fnfl+FZZ1iDCkzZvd8Zz3xFdhXQ0S6JdshatrZ7bdEp9EkRY5gPG2Byg=
X-Google-Smtp-Source: AGHT+IEQjRYrMRzq8zPxk5Qeu12+ssGh0qMUNf9TtmGYJMfKR8ZXW6etJmVdJ4zwR9ZSbRyK7tUlPLVEh1hav9QOsX1JtsL8FwZc
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1383:b0:395:fa9a:3187 with SMTP id
 e9e14a558f8ab-398ee03ea4bmr2572875ab.3.1721515823474; Sat, 20 Jul 2024
 15:50:23 -0700 (PDT)
Date: Sat, 20 Jul 2024 15:50:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000224117061db5a39c@google.com>
Subject: [syzbot] [bluetooth?] WARNING in hci_send_acl (3)
From: syzbot <syzbot+f32bdeda1c9146004da8@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c912bf709078 Merge remote-tracking branches 'origin/arm64-..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=171be3a5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79a49b0b9ffd6585
dashboard link: https://syzkaller.appspot.com/bug?extid=f32bdeda1c9146004da8
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fea69a9d153c/disk-c912bf70.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/be06762a72ef/vmlinux-c912bf70.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6c8e58b4215d/Image-c912bf70.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f32bdeda1c9146004da8@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 7434 at kernel/workqueue.c:2282 current_wq_worker kernel/workqueue_internal.h:69 [inline]
WARNING: CPU: 1 PID: 7434 at kernel/workqueue.c:2282 is_chained_work kernel/workqueue.c:2224 [inline]
WARNING: CPU: 1 PID: 7434 at kernel/workqueue.c:2282 __queue_work+0xe0c/0x12ac kernel/workqueue.c:2281
Modules linked in:
CPU: 1 PID: 7434 Comm: syz.2.363 Not tainted 6.10.0-rc7-syzkaller-gc912bf709078 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
pstate: 604000c5 (nZCv daIF +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __queue_work+0xe0c/0x12ac kernel/workqueue_internal.h:69
lr : current_wq_worker kernel/workqueue_internal.h:69 [inline]
lr : is_chained_work kernel/workqueue.c:2224 [inline]
lr : __queue_work+0xe0c/0x12ac kernel/workqueue.c:2281
sp : ffff8000a0aa7240
x29: ffff8000a0aa7290 x28: 1fffe000196d0e41 x27: 0000000000000004
x26: dfff800000000000 x25: ffff0000d17ae800 x24: 0000000000000008
x23: 1fffe0001af1e3c9 x22: ffff0000d17ae9c0 x21: 0000000000400140
x20: ffff0000d78f1e40 x19: ffff0000d8678b18 x18: ffff8000a0aa72e0
x17: ffff80008f0fd000 x16: ffff800082f8f174 x15: 0000000000000001
x14: 1fffe0001b0cf163 x13: 0000000000000000 x12: 0000000000000000
x11: 0000000000040000 x10: 000000000003ffff x9 : ffff8000a1f1f000
x8 : 0000000000040000 x7 : ffff800089145000 x6 : 0000000000000000
x5 : 0000000000000001 x4 : 0000000000000001 x3 : ffff80008022dbe8
x2 : ffff0000d8678b18 x1 : 0000000000000000 x0 : 0000000000000000
Call trace:
 current_wq_worker kernel/workqueue_internal.h:69 [inline]
 is_chained_work kernel/workqueue.c:2224 [inline]
 __queue_work+0xe0c/0x12ac kernel/workqueue.c:2281
 queue_work_on+0xe0/0x1a0 kernel/workqueue.c:2411
 queue_work include/linux/workqueue.h:621 [inline]
 hci_send_acl+0x768/0xa50 net/bluetooth/hci_core.c:3250
 l2cap_do_send+0x188/0x288 net/bluetooth/l2cap_core.c:996
 l2cap_chan_send+0x13dc/0x211c net/bluetooth/l2cap_core.c:2577
 l2cap_sock_sendmsg+0x184/0x2a8 net/bluetooth/l2cap_sock.c:1128
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x4d8/0x77c net/socket.c:2585
 ___sys_sendmsg net/socket.c:2639 [inline]
 __sys_sendmmsg+0x30c/0x6b0 net/socket.c:2725
 __do_sys_sendmmsg net/socket.c:2754 [inline]
 __se_sys_sendmmsg net/socket.c:2751 [inline]
 __arm64_sys_sendmmsg+0xa0/0xbc net/socket.c:2751
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:131
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:150
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
irq event stamp: 13644
hardirqs last  enabled at (13643): [<ffff80008afc3e68>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:85 [inline]
hardirqs last  enabled at (13643): [<ffff80008afc3e68>] exit_to_kernel_mode+0xdc/0x10c arch/arm64/kernel/entry-common.c:95
hardirqs last disabled at (13644): [<ffff80008022dbd4>] queue_work_on+0x50/0x1a0 kernel/workqueue.c:2407
softirqs last  enabled at (13586): [<ffff800089111350>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (13586): [<ffff800089111350>] release_sock+0x154/0x1b8 net/core/sock.c:3558
softirqs last disabled at (13584): [<ffff800089111238>] spin_lock_bh include/linux/spinlock.h:356 [inline]
softirqs last disabled at (13584): [<ffff800089111238>] release_sock+0x3c/0x1b8 net/core/sock.c:3547
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
