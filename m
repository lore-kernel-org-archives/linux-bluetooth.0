Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167F01C36
	for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 08:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729500516; cv=none; b=lZUYbh7yCxMJ07I4ADgvtFN7nFpPB74JMLheOHp0vyJyb4Yt6TMr3epak0L4e4OXJw58zv8wOVKSHrzQPu2CvA4pDbS0jlsb9YOGs4HxWYoVxJZ1v4/LOSjUdHoUtNiiGviUxlg4YNdCa9l5jZ5TKlCaWuTlgCq4CWQ/ZH4np2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729500516; c=relaxed/simple;
	bh=Llcqrxslonyl4B/Nz/uXlanIENTNmHbzg5BrvPUFZoE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GKqu7Q5slMPoNl2kAmMWTiuUHo8tsZtps/tUNUHLIlxkxZhXW/VJSsdbgm9L50CQ9JUPQYkmw26+kkbBUq3hnbC9EB4+rfli2VvhiVYR61gQ412J2chVjhfYTcvip/8rx3vjq7Tm66kSLv5VTX6+GH276bVy8HDlOShQTclL0MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a39631593aso36454525ab.1
        for <linux-bluetooth@vger.kernel.org>; Mon, 21 Oct 2024 01:48:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729500513; x=1730105313;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wKRMGoOLPHIY4A2n8q2ekK8jXs7bqBdpQW03gebrnM8=;
        b=NH6xNLTsVmZFQnxRVj5r4POhymTR8WZwJ21Xi6x0Jdnx5gAqMEI8ffyHxsd0nUWeap
         emLwZVQEkmqcXtapOiTaLzkQZTIPv4pFDnuJkp4Xefchk0iqa8CcccpaTHQFpKCl3oAy
         U1KGYf9RZRBWez0SWkeOtxwMw0Yw9gyiTS/rkFdQfzqWjyRe6UJSnfY/HJpYA0GBJqH0
         VPVTnvmI6TliHxJmtrx48YG0NH/SRfEzj2ebAoV+hzImbxKxCEN6TjH/dsMliq1CqnQu
         JMSKzUAPSiNEkkLVt4HKxs5gLaQbhMDSuys1Mn1ZfcrxWZ2/E8S3S5QDMOOTpNx7WYWM
         PAJw==
X-Forwarded-Encrypted: i=1; AJvYcCXhHV0dJ5FJJxSGObZGFCFtCZpDPGFyK1XUmEs4jwnW/+vmYfSUUtVHpvAUIMHi5JfNDeneD1F1CaV1+bD7YFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQToTNf0cKVfMmKz6V+gU/5TTUCOMgI8+Jgy5UdQqK/SfbF11+
	TKncBUGDborCeBTX7tRvl9u4Jh3iEazvv2J3hNBak7RnPLczxb9bpl32nws38RVrvcHOPA4WoLC
	jjLZZDkG2AL/48traq02YR1tMhfcEfjgPh+kCeQ/i/KpTWamgHWYLvh4=
X-Google-Smtp-Source: AGHT+IE1XNxrOBIr+QkpwQPQjH+ffOF3u2QJ3aaYNiHtgWCdKLo3A/S9ezoGmTN8f70bI3ob663AQQDSLXSTBYmXFRIHHRfvF03U
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219e:b0:395:e85e:f2fa with SMTP id
 e9e14a558f8ab-3a3f4177956mr61457805ab.1.1729500513080; Mon, 21 Oct 2024
 01:48:33 -0700 (PDT)
Date: Mon, 21 Oct 2024 01:48:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67161561.050a0220.10f4f4.0042.GAE@google.com>
Subject: [syzbot] [bluetooth?] BUG: corrupted list in hci_cmd_sync_dequeue_once
From: syzbot <syzbot+5250d87dea2afdb718a5@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b311c1b497e5 Merge tag '6.11-rc4-server-fixes' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10492dd3980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4fc2afd52fd008bb
dashboard link: https://syzkaller.appspot.com/bug?extid=5250d87dea2afdb718a5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d6f4c238ef76/disk-b311c1b4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/41d5a1c1c348/vmlinux-b311c1b4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/86f62e4350b3/bzImage-b311c1b4.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5250d87dea2afdb718a5@syzkaller.appspotmail.com

list_del corruption, ffff8880295c1780->next is LIST_POISON1 (dead000000000100)
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:58!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 UID: 0 PID: 54 Comm: kworker/u9:0 Not tainted 6.11.0-rc4-syzkaller-00019-gb311c1b497e5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: hci1 hci_conn_timeout
RIP: 0010:__list_del_entry_valid_or_report+0xf4/0x140 lib/list_debug.c:56
Code: e8 d1 20 fb 06 90 0f 0b 48 c7 c7 00 9d 3f 8c 4c 89 fe e8 bf 20 fb 06 90 0f 0b 48 c7 c7 60 9d 3f 8c 4c 89 fe e8 ad 20 fb 06 90 <0f> 0b 48 c7 c7 c0 9d 3f 8c 4c 89 fe e8 9b 20 fb 06 90 0f 0b 48 c7
RSP: 0018:ffffc90000be7ad0 EFLAGS: 00010246
RAX: 000000000000004e RBX: dead000000000122 RCX: d39b9f85a0f3fd00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffff8880295c17a0 R08: ffffffff817402dc R09: 1ffff9200017cef8
R10: dffffc0000000000 R11: fffff5200017cef9 R12: dffffc0000000000
R13: ffff8880295c1780 R14: dead000000000100 R15: ffff8880295c1780
FS:  0000000000000000(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001400 CR3: 0000000058c36000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del include/linux/list.h:229 [inline]
 _hci_cmd_sync_cancel_entry net/bluetooth/hci_sync.c:643 [inline]
 hci_cmd_sync_cancel_entry net/bluetooth/hci_sync.c:809 [inline]
 hci_cmd_sync_dequeue_once+0x262/0x360 net/bluetooth/hci_sync.c:828
 hci_cancel_connect_sync+0xc3/0x120
 hci_abort_conn+0x194/0x330 net/bluetooth/hci_conn.c:2951
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0xf4/0x140 lib/list_debug.c:56
Code: e8 d1 20 fb 06 90 0f 0b 48 c7 c7 00 9d 3f 8c 4c 89 fe e8 bf 20 fb 06 90 0f 0b 48 c7 c7 60 9d 3f 8c 4c 89 fe e8 ad 20 fb 06 90 <0f> 0b 48 c7 c7 c0 9d 3f 8c 4c 89 fe e8 9b 20 fb 06 90 0f 0b 48 c7
RSP: 0018:ffffc90000be7ad0 EFLAGS: 00010246
RAX: 000000000000004e RBX: dead000000000122 RCX: d39b9f85a0f3fd00
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffff8880295c17a0 R08: ffffffff817402dc R09: 1ffff9200017cef8
R10: dffffc0000000000 R11: fffff5200017cef9 R12: dffffc0000000000
R13: ffff8880295c1780 R14: dead000000000100 R15: ffff8880295c1780
FS:  0000000000000000(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001400 CR3: 0000000058c36000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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
