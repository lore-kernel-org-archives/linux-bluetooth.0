Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E07325D216
	for <linux-bluetooth@vger.kernel.org>; Mon, 15 Dec 2025 11:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765799851; cv=none; b=FKHz9JgsdktFP898BwSDuIUIN5UOEucvootz7P83ZMkdUnjR7s5TsB8gZsAinSOogT8dUdRht2OaBhNb/9GQ6OAIiXXF68nQLqNc6MmLfKUhdKAtcCmtzIV1NBunkm6OCJ+pEL8AvP8XYEEW+Kaagm5tLYasPQHrX9ucxuWCt+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765799851; c=relaxed/simple;
	bh=PNF2UoouZX4/uGoLfZf8sOPts43sQ/ChQRv7Y6T6wSk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=coG0Lj2gn8dN2fxMQLl8n7vIakA4b067+J1kJgZA+AA01CYmsSBWSfOeEDZqDpLMAnY4GQQiArZPAVrnMfihIcjHIxrgY3BsrJ/l1hWEyPFrUJSjVGlcPE8XYYJ6L8mGzjSAT9Se9CvQgQqULkaUdoydirou2HodOOysoD/Dt5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7caf4cdfa28so2099068a34.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 15 Dec 2025 03:57:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765799849; x=1766404649;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U3NbYe/lsAGOjlreI6KtV8k5E3zEBQWntonlBsjgs5A=;
        b=SOgJPiSIC9jcgZwD/7yUOW321JcpYi7kJqCWsisV0ea0PgEkFVNMsPNDL+qM5oHLVB
         waZn8XJ5+SdLetCzK0/PTArOqqzI1YullLIgcbRrAOBtSKsj2r5+hb1OkNd9Ty9CUrTG
         dxm5oPCFH8tTlbuQ1W6OJnQTmP0i5TxzOIS4M8QCUILBysy34QYLcMK/Z9lgEE0ybAQ0
         zeo+gSMNhHwsy6T2Xe79dRqmrwe1FojmUoQ2rIYxysL7X/04nZYnAk+yLSdjdYUCSXs6
         9plalYmIHs3UGJf3Yd9Erz1q4AWCh+6WckFRWacLp+p1MZWF/EH2QrWSqXCRk1GGT1Yb
         tXhg==
X-Forwarded-Encrypted: i=1; AJvYcCVOHjgwku3Yuf54DWuFPGJKCSbzJylyKv1PkhtT/+o9Q6prkKbcYf0GhHivSbkwwaIXVJ7Hm31L8MzFY/ik+og=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOkLk6SL1XaG4jOW5+OKRSmIY2i1v4BTVL6+E+NPcbppFW9mZb
	y51nmYFBGyIZ8j/fUUyKuDN7WxbbJOyjH7oEf+grEoIA+NBreiLj6TQnIZjuPo2swdvP8CXUX6l
	4O9k2CNk+J/HNeebTT/3v2wn6v7HvVdjeakqYhGOj3Z2RT2djjzVp4V1921k=
X-Google-Smtp-Source: AGHT+IFm348+liCy3eHy+ZYap9H5sK07cmM+7Ly7ngeWgnk2IDBRv6DQLVZ9YMiEfahOBqu5zls9jm2uJ2un5fRIKd93RQp5EXK4
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:81e:b0:657:71fa:5f6d with SMTP id
 006d021491bc7-65b450e7ecdmr4778324eaf.6.1765799849411; Mon, 15 Dec 2025
 03:57:29 -0800 (PST)
Date: Mon, 15 Dec 2025 03:57:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <693ff7a9.a70a0220.33cd7b.00fb.GAE@google.com>
Subject: [syzbot] [bluetooth?] WARNING in hci_send_cmd (3)
From: syzbot <syzbot+de67f74f87a8fd41bd70@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5ce74bc1b7cb Add linux-next specific files for 20251211
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=14b0261a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a94030c847137a18
dashboard link: https://syzkaller.appspot.com/bug?extid=de67f74f87a8fd41bd70
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e1660176a50f/disk-5ce74bc1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/616ede012bbd/vmlinux-5ce74bc1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7c0c5bc40fd8/bzImage-5ce74bc1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+de67f74f87a8fd41bd70@syzkaller.appspotmail.com

Bluetooth: MGMT ver 1.23
------------[ cut here ]------------
workqueue: cannot queue hci_cmd_work on wq hci0
WARNING: kernel/workqueue.c:2271 at __queue_work+0xd20/0xf90 kernel/workqueue.c:2269, CPU#1: syz.6.1277/11092
Modules linked in:
CPU: 1 UID: 0 PID: 11092 Comm: syz.6.1277 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:__queue_work+0xd4b/0xf90 kernel/workqueue.c:2269
Code: 83 c5 18 4c 89 e8 48 c1 e8 03 42 80 3c 20 00 74 08 4c 89 ef e8 e6 68 9d 00 49 8b 75 00 49 81 c7 78 01 00 00 4c 89 f7 4c 89 fa <67> 48 0f b9 3a 48 83 c4 58 5b 41 5c 41 5d 41 5e 41 5f 5d e9 3d 2a
RSP: 0018:ffffc900030d76d0 EFLAGS: 00010086
RAX: 1ffff1100afba184 RBX: 0000000000000008 RCX: 0000000000080000
RDX: ffff88807d99d178 RSI: ffffffff8a5590f0 RDI: ffffffff8f851310
RBP: 0000000000000000 R08: ffff888057dd0c0f R09: 1ffff1100afba181
R10: dffffc0000000000 R11: ffffed100afba182 R12: dffffc0000000000
R13: ffff888057dd0c20 R14: ffffffff8f851310 R15: ffff88807d99d178
FS:  00007fefeae826c0(0000) GS:ffff888125f32000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fefeae60f98 CR3: 0000000066f94000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 queue_work_on+0x181/0x270 kernel/workqueue.c:2405
 queue_work include/linux/workqueue.h:669 [inline]
 hci_send_cmd+0xb7/0x1b0 net/bluetooth/hci_core.c:3110
 set_link_security+0x588/0x740 net/bluetooth/mgmt.c:1934
 hci_mgmt_cmd+0xa14/0xfa0 net/bluetooth/hci_sock.c:1721
 hci_sock_sendmsg+0x6d7/0xf30 net/bluetooth/hci_sock.c:1841
 sock_sendmsg_nosec+0x18f/0x1d0 net/socket.c:737
 __sock_sendmsg net/socket.c:752 [inline]
 sock_write_iter+0x2d9/0x3d0 net/socket.c:1210
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5c9/0xb30 fs/read_write.c:686
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fefe9f8f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fefeae82038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fefea1e5fa0 RCX: 00007fefe9f8f749
RDX: 0000000000000007 RSI: 0000200000000000 RDI: 0000000000000007
RBP: 00007fefea013f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fefea1e6038 R14: 00007fefea1e5fa0 R15: 00007fff2736b578
 </TASK>
----------------
Code disassembly (best guess):
   0:	83 c5 18             	add    $0x18,%ebp
   3:	4c 89 e8             	mov    %r13,%rax
   6:	48 c1 e8 03          	shr    $0x3,%rax
   a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1)
   f:	74 08                	je     0x19
  11:	4c 89 ef             	mov    %r13,%rdi
  14:	e8 e6 68 9d 00       	call   0x9d68ff
  19:	49 8b 75 00          	mov    0x0(%r13),%rsi
  1d:	49 81 c7 78 01 00 00 	add    $0x178,%r15
  24:	4c 89 f7             	mov    %r14,%rdi
  27:	4c 89 fa             	mov    %r15,%rdx
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	48 83 c4 58          	add    $0x58,%rsp
  33:	5b                   	pop    %rbx
  34:	41 5c                	pop    %r12
  36:	41 5d                	pop    %r13
  38:	41 5e                	pop    %r14
  3a:	41 5f                	pop    %r15
  3c:	5d                   	pop    %rbp
  3d:	e9                   	.byte 0xe9
  3e:	3d                   	.byte 0x3d
  3f:	2a                   	.byte 0x2a


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
