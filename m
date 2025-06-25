Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE6825BF18
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Jun 2025 17:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750871669; cv=none; b=rQ9QVqbdCQmyyVwoxbWQK9f+gVE6HMEIpfLK44pBIFcYnQF6VhLpSrEkM5sca3IKpgEcXgos72Z8EaLimx9XexRMSb9lTf7xg6O2ZjIZZ8rp1W6oCryiQHYl7N4Lu02qMjkZZwl9xU/pXkVnQcxya2riM79J5sVsuRZ9SqZc+Oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750871669; c=relaxed/simple;
	bh=YKkvkQ+DdOVsLHQyaBRqdlrsotAQLSDlyoY+RWNqYVA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Cm+tYCuwU8DLAcL9TYhQfrG95FUSPiQnbt/wQaWCuA9zgNKrA3LJrtWDyUJVlvKqwQ3sj2hINZ64kVOxAFA3lJO5yGH1m3oPxCzaKzgpSfuigSWEdOAte0xqOzHsSWDCg3egeDXSWedkobcJZjGSF1xgG0sLjp3LZAcSI1FvxZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ddd5311fd3so840465ab.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 25 Jun 2025 10:14:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750871667; x=1751476467;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L/l8xFjBHoux/yvwL6aD3x2VUCTiy+iKK29WrV0pdFY=;
        b=UXEX+WQ2Ff3ocZhWenI7TOUuJa4gWeEp76cVue8/8ZFH9M3C5teLIlN+1VWzAJ+iPX
         /4umqGt1fh6+PUAgB5ie2UkMpKwYAavzaAO0K6k7p3SGcXjFdkENKIO9wW4Z5q4USbXl
         Pt/cQ4mVWpHJCAvN/d7DtL/aFNU573OALlGBfqQ0aKTwL9fRq9t82/fc7ffTCUFzYsDP
         fWOSdkbA0WltHIyy5W+YCy53Zc8ROgkEFaigzbiOMDw4BqAVaoo8iuVYfC53I/kNEEsQ
         /DdR6nXJCO8c//9kal+vf8IeM4VDgIPwqVrqEyzjXqAapPuh/Y8nJb4Z73YbjDsNeGd5
         p8KQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6eV4n99/bwVgeAjnPxsRUrMXDD6PXVftLmj7eq79GrS5RuXqOW4RZNdMfdey0+dCpZJIZK1De9En/YdrfGpM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9HaabFOVbg/u2QN0DDid/Y+Sl8uRBBwcBMr+bboubD5Q57Qwk
	8AGn2kSiAW0eSBr884F/KABXTuStkvcMWPuMzzM6ZK7tU1GKhMle/3Z4Ih5TYLs0v9HRlmbq36Q
	lPmxYmHf4kGZN7/X6bngVyWKyBCH6TfMKnxNVBCWgrL2as3+ifaXM4qfEaLw=
X-Google-Smtp-Source: AGHT+IF4tP1NNueFUshXhU6NYNM5uEbLto+Lt8hRij3Xfkqi9ZOuPSh5aKmlJA6qZF1oxSHP+VCuV0Smkd6mHXvR22rrt5aSAQgc
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218a:b0:3dd:b808:be59 with SMTP id
 e9e14a558f8ab-3df3297dea6mr56177245ab.21.1750871667166; Wed, 25 Jun 2025
 10:14:27 -0700 (PDT)
Date: Wed, 25 Jun 2025 10:14:27 -0700
In-Reply-To: <66f6c6e7.050a0220.38ace9.0024.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685c2e73.050a0220.2303ee.004c.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] BUG: corrupted list in _hci_cmd_sync_cancel_entry
From: syzbot <syzbot+01fdb2cc3f0b4ddcfcf1@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    7595b66ae9de Merge tag 'selinux-pr-20250624' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10ed4f0c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=641bc01f4fbdccd4
dashboard link: https://syzkaller.appspot.com/bug?extid=01fdb2cc3f0b4ddcfcf1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14bc9b70580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/86576f060f6f/disk-7595b66a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/051ad595d63b/vmlinux-7595b66a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e72740ea313a/bzImage-7595b66a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+01fdb2cc3f0b4ddcfcf1@syzkaller.appspotmail.com

Bluetooth: hci4: command 0x0406 tx timeout
 non-paged memory
list_del corruption, ffff88802932b700->next is LIST_POISON1 (dead000000000100)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:56!
Oops: invalid opcode: 0000 [#1] SMP KASAN NOPTI
CPU: 1 UID: 0 PID: 51 Comm: kworker/u9:0 Not tainted 6.16.0-rc3-syzkaller-00044-g7595b66ae9de #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: hci4 hci_conn_timeout
RIP: 0010:__list_del_entry_valid_or_report+0x121/0x200 lib/list_debug.c:56
Code: 48 c7 c7 e0 7e 15 8c e8 1d 41 b9 fc 90 0f 0b 4c 89 e7 e8 02 f3 1d fd 4c 89 e2 48 89 de 48 c7 c7 40 7f 15 8c e8 00 41 b9 fc 90 <0f> 0b 48 89 ef e8 e5 f2 1d fd 48 89 ea 48 89 de 48 c7 c7 a0 7f 15
RSP: 0018:ffffc90000bb7b78 EFLAGS: 00010282
RAX: 000000000000004e RBX: ffff88802932b700 RCX: ffffffff819b00b9
RDX: 0000000000000000 RSI: ffffffff819b7f46 RDI: 0000000000000005
RBP: dead000000000122 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: dead000000000100
R13: dffffc0000000000 R14: ffff88802f118618 R15: ffff88802932b700
FS:  0000000000000000(0000) GS:ffff888124852000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c007642020 CR3: 000000007e2b4000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del include/linux/list.h:229 [inline]
 _hci_cmd_sync_cancel_entry.constprop.0+0x80/0x1d0 net/bluetooth/hci_sync.c:647
 hci_cmd_sync_cancel_entry net/bluetooth/hci_sync.c:851 [inline]
 hci_cmd_sync_dequeue_once net/bluetooth/hci_sync.c:870 [inline]
 hci_cancel_connect_sync+0xfa/0x2b0 net/bluetooth/hci_sync.c:6903
 hci_abort_conn+0x15a/0x340 net/bluetooth/hci_conn.c:2919
 hci_conn_timeout+0x1a2/0x210 net/bluetooth/hci_conn.c:580
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0x121/0x200 lib/list_debug.c:56
Code: 48 c7 c7 e0 7e 15 8c e8 1d 41 b9 fc 90 0f 0b 4c 89 e7 e8 02 f3 1d fd 4c 89 e2 48 89 de 48 c7 c7 40 7f 15 8c e8 00 41 b9 fc 90 <0f> 0b 48 89 ef e8 e5 f2 1d fd 48 89 ea 48 89 de 48 c7 c7 a0 7f 15
RSP: 0018:ffffc90000bb7b78 EFLAGS: 00010282
RAX: 000000000000004e RBX: ffff88802932b700 RCX: ffffffff819b00b9
RDX: 0000000000000000 RSI: ffffffff819b7f46 RDI: 0000000000000005
RBP: dead000000000122 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000001 R12: dead000000000100
R13: dffffc0000000000 R14: ffff88802f118618 R15: ffff88802932b700
FS:  0000000000000000(0000) GS:ffff888124852000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd6f9b7e2d8 CR3: 000000007b2b4000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
