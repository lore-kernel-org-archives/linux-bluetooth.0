Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4173398A
	for <linux-bluetooth@vger.kernel.org>; Sun,  5 Jan 2025 07:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736061260; cv=none; b=ejAbRYX4n3icMcMS9kneO+em1WITrhJhMd3+2FL0esvPGMG+LZGOZJyOzy3f4ZWjOICtCwlKDGpJD2sKzjM9gC90FMRqITmtt9RWFhse5m4SSnHImF/M8n8O/XCSDwvm4uRBn0lKJdJupRu0Gk+GrYiYeln1zbntALTxtKVimdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736061260; c=relaxed/simple;
	bh=LQCWgS7Qc+bkoXZM1UsiYmVDhAhWcfy+V4VgCmCeRhk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WUemwaVhim9vvGSOSkHYpoAGkKwliGv925B3e1HuXw1IC2xUaQ440xhzlNjYFggdjI5ztAtJALYulCLKhSCxD9bX7ZzLShGyA07u/fPresoJ6eH6+6TveE9yN+Nb2DLtCVoXN8SCYDJROkHOER03NM04i7YlQ9QVj4xmilkEhI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a91a13f63fso118548275ab.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 04 Jan 2025 23:14:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736061258; x=1736666058;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gpscDy3VHv8Px7e7gmFp5GQktlm+oqpMqCbdVhnRoqM=;
        b=dRAIxrSwJsrbZ1SG8hr/HSVOD75I3u+qdm+KDWp54vrhfzyt4odLggK0YWYOAPFZuE
         O1h1A7VnmbL5FO/PhUJfs73ZQencOAgJmVCmS2Bfq/CuD4pyhg1Yn6lVwa4jsOSfzUPW
         IsJIWBaWwT6mCNdoypYaGB6VQao4AHIe/tLEMOT33r/9N+tuXDOZDjLa8OQwah8n1HBo
         v24qK9oO7CMPQHrLP0yfkz3YzhLXh/bJozJhzoJzkw+ckI+wSWHTIfGY/5RZjOcTE81K
         Ml9UZLEU06NctUSd0/RGGw83PYqzMRtsX8jjamxwzDSfnbMOYy4EhMdi6ktGNjFXSNO5
         GsbA==
X-Forwarded-Encrypted: i=1; AJvYcCWW/lqXJz2+VmKiWw5c28oJ++gRk2+Zp83hcnhWnQg/IEqlKKdWFb0iw+6xqGfz+6CoTt+fku6i5K1Ee7mVXtY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrilkkX9tLTsXrsOFfnwxhciIdGhHt5b8dhTTlbFbeUmc98+tL
	evnHHrijQMoww4jQKkAL3ikTJ1K9cTEjW+XlDR5JTomgot+0BTRea+u/uGdJm1zidDubRGhgkzh
	pbHr0wjEvxIYT7GHEbeN99n4axY3P6XfLtQJtGU46ehrq7e1opTTuLWo=
X-Google-Smtp-Source: AGHT+IEZl0xuRI6kYROVHfxtCrQSGusEqWZkXPnVBpyjdtS4uxPn8ofo4x5Fer8iAyqLjbwAcZKaAjhJlTspt5Oyxh49SEKx0vqq
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3201:b0:3a7:be5e:e22d with SMTP id
 e9e14a558f8ab-3c2d1aa3e86mr396733085ab.2.1736061258217; Sat, 04 Jan 2025
 23:14:18 -0800 (PST)
Date: Sat, 04 Jan 2025 23:14:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <677a314a.050a0220.380ff0.000b.GAE@google.com>
Subject: [syzbot] [bluetooth?] WARNING in hci_devcd_register
From: syzbot <syzbot+7540c87aab2f3a5cef91@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ccb98ccef0e5 Merge tag 'platform-drivers-x86-v6.13-4' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13255af8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=86dd15278dbfe19f
dashboard link: https://syzkaller.appspot.com/bug?extid=7540c87aab2f3a5cef91
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d24eb225cff7/disk-ccb98cce.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dd81532f8240/vmlinux-ccb98cce.xz
kernel image: https://storage.googleapis.com/syzbot-assets/18b08e4bbf40/bzImage-ccb98cce.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7540c87aab2f3a5cef91@syzkaller.appspotmail.com

------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(lock->magic != lock)
WARNING: CPU: 1 PID: 10888 at kernel/locking/mutex.c:564 __mutex_lock_common kernel/locking/mutex.c:564 [inline]
WARNING: CPU: 1 PID: 10888 at kernel/locking/mutex.c:564 __mutex_lock+0x369/0xa60 kernel/locking/mutex.c:735
Modules linked in:
CPU: 1 UID: 0 PID: 10888 Comm: syz.7.1098 Not tainted 6.13.0-rc5-syzkaller-00004-gccb98ccef0e5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:564 [inline]
RIP: 0010:__mutex_lock+0x369/0xa60 kernel/locking/mutex.c:735
Code: d0 7c 08 84 d2 0f 85 6d 06 00 00 8b 0d 50 4f 01 05 85 c9 75 19 90 48 c7 c6 60 be 4c 8b 48 c7 c7 c0 bc 4c 8b e8 d8 4c 3e f6 90 <0f> 0b 90 90 90 e9 f2 fd ff ff 4c 8d b5 60 ff ff ff 48 89 df 4c 89
RSP: 0018:ffffc900180cfa80 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff8880120c7098 RCX: ffffffff815a1789
RDX: ffff88803156bc00 RSI: ffffffff815a1796 RDI: 0000000000000001
RBP: ffffc900180cfbc0 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: dffffc0000000000
R13: 0000000000000002 R14: 0000000000000000 R15: ffffc900180cfb00
FS:  00007fa2501526c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3285ffff CR3: 000000003f326000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 hci_devcd_register+0x47/0x170 net/bluetooth/coredump.c:415
 force_devcd_write+0x175/0x350 drivers/bluetooth/hci_vhci.c:346
 full_proxy_write+0xfb/0x1b0 fs/debugfs/file.c:356
 vfs_write+0x24c/0x1150 fs/read_write.c:677
 ksys_write+0x12b/0x250 fs/read_write.c:731
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa24f385d29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa250152038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fa24f575fa0 RCX: 00007fa24f385d29
RDX: 000000000000000e RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007fa24f401b08 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fa24f575fa0 R15: 00007fff481bce58
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
