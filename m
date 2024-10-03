Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB2F819F13A
	for <linux-bluetooth@vger.kernel.org>; Thu,  3 Oct 2024 14:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727966707; cv=none; b=QOH1OXQqCKB2Jet65XA6RlzazSAOlWfDU5WidT3QuoNKeiqtI4gV3hSWA0xpVdLheGxWg5qSlZ7vf05dLkFkVoE4XQPibtjES+p2KIc6XHgmxMnHhyQVe3j7TBXrzRkfylA5FQE4iFrYrR49cqsSEdmGs9wYVi3kcxxOXGaND5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727966707; c=relaxed/simple;
	bh=WCOvTCUhC24KvaPygSWeHD7vLDuO8jmYAzkaBhVaWuQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=l79LUG+LCNFzxIQP//rL0VnLzzoUCQwo3JzAeAQHv0aLEc3YnX/6dOgGbPT1qSxn6F8uhLK9Zq/7t8VuyilQoFRICegdB35pyNW6nqxR4WcGBUcHcScqjG2/j1pckeBctc8kxySVF/74DG3RvNTVBuIF9Kw9GdOUEfExs6cm3ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a19534ac2fso12935995ab.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 03 Oct 2024 07:45:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727966705; x=1728571505;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YqgwiSIyyjXVtpe/wlPz1udWGxl36h0kXXb71vZI94Q=;
        b=aA61S6xOfXcusB2Xx+vKc6VabuXgExXjfK22jQZUjOqcsYntxPqnnPK5pCMS9iYdjf
         REJpN5NOx/e4gUju21wcFxyHXPg21K6oymeBZpPUL98U8xfAtjcXA9wy77KG5iOtA3Iy
         A0Oo3MgDZ0JLr2AhRJUr0pobuf6wscxpsiJAU8GYxbbab6b34l6bA5fxwk70p1JvW3hK
         OL+Hn3kaDjUzcHiahKjetlzIFRy852AzvNBj7nSYBIiS3jDf96FT9O747TNUAL68CuAx
         rRXfITXSyq0dONbJ5pGkTJklR+FT3SkH+1J+03t6yluaT5ol9LYr4MrgwXWdp71itG3u
         C+xw==
X-Forwarded-Encrypted: i=1; AJvYcCWBILKojfd/9htAmARLE24nv57aui0uwLlxR0uj0x+2GI6ZALihJeTFLDYG03zvIBMMvvr6UucaOa/32f4/z8A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9xEgMZbqVtb4FaoT4RVMqULNEYZZ1gHrLq31jDjSp9nTbz/Lh
	+OSdYoJvCfaU5lacBG52RatpJQAg3pHmn9gmAbYTmws7A1XNATI2hCHXK+9PmNflWS4g04QSn/y
	dSSczBthnKHi6vWVikrKTdF5iI7Dh0BAiAr4VIVjH0A6NPF89xNwmvd8=
X-Google-Smtp-Source: AGHT+IGDz3EgWb4beh65cBoiqxln1oApbaK9ID8OfgKoSvEaX9TpBjDA56BS/GnL/YrNVN3t3Lny5/TrLqzwr66ReXV/e8Fq3Tx9
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1544:b0:3a3:35f0:4c11 with SMTP id
 e9e14a558f8ab-3a36592cb1bmr75740435ab.15.1727966705024; Thu, 03 Oct 2024
 07:45:05 -0700 (PDT)
Date: Thu, 03 Oct 2024 07:45:04 -0700
In-Reply-To: <Zv6qDfzdXMrSjGkE@fedora>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66feadf0.050a0220.9ec68.0042.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in set_powered_sync
From: syzbot <syzbot+03d6270b6425df1605bf@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	qianqiang.liu@163.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
possible deadlock in hci_dev_close_sync

============================================
WARNING: possible recursive locking detected
6.11.0-syzkaller-11519-gc30a3f54e661-dirty #0 Not tainted
--------------------------------------------
syz.0.15/6089 is trying to acquire lock:
ffff88802cd3cd80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_dev_close_sync+0x66e/0x11b0 net/bluetooth/hci_sync.c:5191

but task is already holding lock:
ffff88802cd3cd80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_dev_do_close net/bluetooth/hci_core.c:481 [inline]
ffff88802cd3cd80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_dev_close+0x10a/0x210 net/bluetooth/hci_core.c:508

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&hdev->req_lock);
  lock(&hdev->req_lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by syz.0.15/6089:
 #0: ffff88802cd3cd80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_dev_do_close net/bluetooth/hci_core.c:481 [inline]
 #0: ffff88802cd3cd80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_dev_close+0x10a/0x210 net/bluetooth/hci_core.c:508
 #1: ffff88802cd3c078 (&hdev->lock){+.+.}-{3:3}, at: hci_dev_close_sync+0x572/0x11b0 net/bluetooth/hci_sync.c:5183

stack backtrace:
CPU: 1 UID: 0 PID: 6089 Comm: syz.0.15 Not tainted 6.11.0-syzkaller-11519-gc30a3f54e661-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_deadlock_bug+0x483/0x620 kernel/locking/lockdep.c:3034
 check_deadlock kernel/locking/lockdep.c:3086 [inline]
 validate_chain+0x15e2/0x5920 kernel/locking/lockdep.c:3888
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5199
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 hci_dev_close_sync+0x66e/0x11b0 net/bluetooth/hci_sync.c:5191
 hci_dev_do_close net/bluetooth/hci_core.c:483 [inline]
 hci_dev_close+0x112/0x210 net/bluetooth/hci_core.c:508
 sock_do_ioctl+0x158/0x460 net/socket.c:1228
 sock_ioctl+0x626/0x8e0 net/socket.c:1347
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe0fa37cef9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe0fb0e2038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fe0fa536058 RCX: 00007fe0fa37cef9
RDX: 0000000000000000 RSI: 00000000400448ca RDI: 0000000000000008
RBP: 00007fe0fa3ef046 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fe0fa536058 R15: 00007fff1e0b61e8
 </TASK>


Tested on:

commit:         c30a3f54 net: mana: Add get_link and get_link_ksetting..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=13ea7580580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b2d4fdf18a83ec0b
dashboard link: https://syzkaller.appspot.com/bug?extid=03d6270b6425df1605bf
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16806307980000

