Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61E9518AE0
	for <linux-bluetooth@vger.kernel.org>; Tue,  2 Apr 2024 06:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712038476; cv=none; b=e6Krqpf+m3z9KOtTnZrKXs7qf+/O6NKxFQvB/mrziLsH/AgsU3hfDuK+RcK5U5ls0fk2MxfjT00ft6ZBFJFDc/H3pAdOnKA94kELXIzZ688tdiLPxx1DValCm+8UEOcp/Pj6QxJfxBAFkeq38kGe7Pcz0x/tKbjI6okxGZm+Ccs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712038476; c=relaxed/simple;
	bh=NCvnPQZsQ2LIrWhPlXEsj1uo2wstL8bsmWxXSIgVrtw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=OhxdCCz13QI2GMRDzHmfoFhtCJNxt4kJdydAsO0zVnd9vHCc5ADCYSVlHEA8RrpXC5Zg0a5+As0SF0IvLmpoAURz3s4YZ5ivQtB9H3+IiUki+J3j4/N+5ScgA4cnbqPE43ETTxSdwCYG4/t6sdGH1eIeLr4xbS8aJW35bY6EfEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c88a694b46so431622639f.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 01 Apr 2024 23:14:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712038474; x=1712643274;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XkbJM6qpjB4KLi/PZYGEwg1QOXEt+REEpWayoWOCnho=;
        b=EIPGa8oqiup7mkkXK2PnyIEZVAsw8Z/qwsw9xLAaR5nbOHOauFQnjBWedZvFkK4JGb
         WEb5Tqd6aXcUgcJZUM1y7tBYrnyTkMJo10He2hFmpgzv1EdWKVLHvzXIqZT2UAPxjq2K
         WhSaB2W8DbKp9d45yUKe++fkeupcenLxgCDmzcxV+LlBlILqR24QgvlwlFiUJfoNG4tT
         oHcdCRncDIpYM5iJ3JvZGgyWcvKFSV+svhewSgHNwkMOBMWs3sbXuCOEajcmlB1fWkzt
         3/UO7vT8HnJaBSRuRMtED78cISSOedSzn6GIR1zu6CWpIC9ek+q12QXlPIwD3+9Ul5fL
         tWYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXYrmTCdmWS4Yd6do+7+2ivbqIvK3kiwp+Ilh/HUVU+xooeFD9tzOCPIcSep3FxsuxoAUsyTDhvXTh7G0cvY2YkDS0dfTuKPbo0bAIagnMZ
X-Gm-Message-State: AOJu0Yw3bO2oDLjMJMXSIN5XZSSCUtjqmIdlqaUOjMXY6LJgCe9CgjxU
	HTG9m+F0SEV/Wk3gDBVPztGahKost7C6Px3+WBu5tLUvQvVVTfW8eaqPSnyEBePfe6RBSm26C01
	q0rjespV1clwBP/5Ww/2Qj9It3Q8ZxcKg1lNSF1bRYO4oC+jIyQTtx98=
X-Google-Smtp-Source: AGHT+IFB66KTv346kke83xb1m2RxUjAJsI5h7wHdGFE8XJ/VfEZtALh7bRAil4uLjrBzoOTmYnevBO4cTLnxltDGIfOGt0QIxygM
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6c05:b0:7cc:ce74:4280 with SMTP id
 ik5-20020a0566026c0500b007ccce744280mr148271iob.1.1712038474506; Mon, 01 Apr
 2024 23:14:34 -0700 (PDT)
Date: Mon, 01 Apr 2024 23:14:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001d76070615170543@google.com>
Subject: [syzbot] [bluetooth?] WARNING in msft_do_close
From: syzbot <syzbot+bb31c235295febed08db@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1254ae29180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe78468a74fdc3b7
dashboard link: https://syzkaller.appspot.com/bug?extid=bb31c235295febed08db
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0f7abe4afac7/disk-fe46a7dd.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/82598d09246c/vmlinux-fe46a7dd.xz
kernel image: https://storage.googleapis.com/syzbot-assets/efa23788c875/bzImage-fe46a7dd.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bb31c235295febed08db@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 1 PID: 4465 at kernel/locking/mutex.c:587 __mutex_lock_common kernel/locking/mutex.c:587 [inline]
WARNING: CPU: 1 PID: 4465 at kernel/locking/mutex.c:587 __mutex_lock+0xc3b/0xd70 kernel/locking/mutex.c:752
Modules linked in:
CPU: 1 PID: 4465 Comm: kworker/u9:1 Not tainted 6.8.0-syzkaller-08951-gfe46a7dd189e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: hci6 hci_power_on
RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:587 [inline]
RIP: 0010:__mutex_lock+0xc3b/0xd70 kernel/locking/mutex.c:752
Code: 0f b6 04 20 84 c0 0f 85 18 01 00 00 83 3d 0c 81 09 04 00 75 19 90 48 c7 c7 e0 ac aa 8b 48 c7 c6 80 ad aa 8b e8 d6 dc d9 f5 90 <0f> 0b 90 90 90 e9 c3 f4 ff ff 90 0f 0b 90 e9 d2 f8 ff ff 90 0f 0b
RSP: 0018:ffffc9000ce6f8a0 EFLAGS: 00010246
RAX: ad875c4e249db200 RBX: 0000000000000000 RCX: ffff88802eca9e00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc9000ce6f9f8 R08: ffffffff8157cc12 R09: fffffbfff1bf9650
R10: dffffc0000000000 R11: fffffbfff1bf9650 R12: dffffc0000000000
R13: ffff888063019040 R14: 0000000000000000 R15: ffff888063019040
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5a5bf7e1f8 CR3: 000000007ece8000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 msft_do_close+0x2e9/0x790 net/bluetooth/msft.c:694
 hci_dev_close_sync+0xa1d/0x1050 net/bluetooth/hci_sync.c:5162
 hci_dev_do_close net/bluetooth/hci_core.c:554 [inline]
 hci_power_on+0x328/0x700 net/bluetooth/hci_core.c:1033
 process_one_work kernel/workqueue.c:3254 [inline]
 process_scheduled_works+0xa02/0x1770 kernel/workqueue.c:3335
 worker_thread+0x86d/0xd70 kernel/workqueue.c:3416
 kthread+0x2f2/0x390 kernel/kthread.c:388
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:243
 </TASK>


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
