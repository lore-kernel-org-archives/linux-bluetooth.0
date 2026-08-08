Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com [209.85.161.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF79388E74
	for <linux-bluetooth@vger.kernel.org>; Sat,  8 Aug 2026 16:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786208323; cv=none; b=YHa8zlXdpZwtNDIzTawAI4CVfbk6GGQRxsanIXUETLsXxxH/GCLdxyW9cIVVcWk9V4RI7M9G+LMGeH7eBsBXXuG9vuPpjRIOyfKIxF9gSf5kf/VOceeHc3kzz19n1oBbABoRUOboLCbjVW0gkUgfllMAnxEgh9FNl2YQm9uVAbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786208323; c=relaxed/simple;
	bh=MdYKW8YUFoyBPzx0IsyJ30rCUJCNAr0GjHG2aIzViOM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oMA4q9ERHndI7fIaf48sVcMJjbIpKo1RAeKw/DxmkK0G1qoTdVmbCIfU3BRnH0uFlzauO5iduZB0ADnudpdhJIfpNEmEowud4HfaGnAZZs5HVA++qGsXzgfePCRni/4wMU0PqlcJTwY6eaZRMnqfjDZB7TodVA2NTiM66HjKztc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f69.google.com with SMTP id 006d021491bc7-6ab0def53fcso448003eaf.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 08 Aug 2026 09:58:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786208309; x=1786813109;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9AK6R4A1Nmo1ZUJQ16tyl12coBHtDUUngFLpJE61V14=;
        b=G3LYQaS42DD04tqcDu0YRZzPC2gHWaA7XBf9R7s77uq7YMLOCmxtp9pc8YgGJZVPU7
         E/JLKNjwsNwK2jcE68vtEZmZed2RSC2DbLv+isjpqpl5328r9xeKOqxO7RImFx7xTDxi
         WwlAfA2FgJ0y5Jpj0ZY/knDwqa8yLNpr2NP6J2MHxNgj9fgvcyNRDTgkKLlzEfFOcM1V
         8GvFkZHJ5VhaPaua4G9S08oWrUnJu1yYAJ2xhydmc+5HnUJXw8mHSAv55aDz9BRA8OWl
         Fdnf9ctnDMWuWKBalpoa9W4XcHdYJgc+5eCno9n4fmZNwCNE09BR9mJwzCiFIWeiOQz3
         HbHg==
X-Forwarded-Encrypted: i=1; AHgh+RqL5NEUMhT/1vqUkVtpV0Yr/rhmLKGe4prOp7P9qwUGVB4cWJ0w2OS9nvs5AYSIZPV448IyCRUjv+CbuVyPlsc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxumTNe/dOR/R7llGCZ2f4OGU124FrYE33aoiRLkpUy5T9RW9QL
	qXm0tQ7GocmTiSsP7Z9x0TEUqSNN6MJjz0MIyZ0I/+WxKlnGL81ILyP0M1VoFT6BtmI1/BZSkbn
	uXasoahZgGJyG2PMJ60wc/G7ysHAqLA0x7/hlChdMcrrPpAx5YpSl9sNQxbI=
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:4cc2:b0:6ac:a539:bc41 with SMTP id
 006d021491bc7-6b041f59187mr4805815eaf.12.1786208309144; Sat, 08 Aug 2026
 09:58:29 -0700 (PDT)
Date: Sat, 08 Aug 2026 09:58:29 -0700
In-Reply-To: <0000000000004e50e40616038e72@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a776035.01d0871a.3a0d52.0063.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] WARNING in l2cap_chan_send
From: syzbot <syzbot+b6919040d9958e2fc1ae@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    a7c7074b58d2 Merge tag 'fbdev-for-7.2-rc7' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=171c0149580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b924ab49cf8bae2a
dashboard link: https://syzkaller.appspot.com/bug?extid=b6919040d9958e2fc1ae
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=109c0149580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b6919040d9958e2fc1ae@syzkaller.appspotmail.com

------------[ cut here ]------------
workqueue: cannot queue hci_tx_work on wq hci0
WARNING: kernel/workqueue.c:2306 at __queue_work+0xd4a/0x1090 kernel/workqueue.c:2305, CPU#1: syz-executor109/5985
Modules linked in:
CPU: 1 UID: 0 PID: 5985 Comm: syz-executor109 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
RIP: 0010:__queue_work+0xd66/0x1090 kernel/workqueue.c:2305
Code: 49 81 c7 70 01 00 00 4c 8d 35 86 dd 5b 0e 48 89 f8 48 c1 e8 03 80 3c 18 00 74 05 e8 a4 20 a5 00 49 8b 75 18 4c 89 f7 4c 89 fa <67> 48 0f b9 3a 4c 89 e8 48 c1 e8 03 80 3c 18 00 74 08 4c 89 ef e8
RSP: 0018:ffffc900032d7510 EFLAGS: 00010046
RAX: 1ffff11004fd798a RBX: dffffc0000000000 RCX: ffff8880308b1f00
RDX: ffff88807d1c0970 RSI: ffffffff8a85e850 RDI: ffffffff8fe7e260
RBP: 0000000000000000 R08: ffff888027ebcc3f R09: 1ffff11004fd7987
R10: dffffc0000000000 R11: ffffed1004fd7988 R12: 0000000000000008
R13: ffff888027ebcc38 R14: ffffffff8fe7e260 R15: ffff88807d1c0970
FS:  00007fed8a7926c0(0000) GS:ffff888125866000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fed8c796d58 CR3: 00000000739ba000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 queue_work_on+0x106/0x1c0 kernel/workqueue.c:2452
 l2cap_chan_send+0x168a/0x22f0 net/bluetooth/l2cap_core.c:-1
 l2cap_sock_sendmsg+0x33a/0x4d0 net/bluetooth/l2cap_sock.c:1180
 sock_sendmsg_nosec+0x13a/0x180 net/socket.c:775
 __sock_sendmsg net/socket.c:790 [inline]
 ____sys_sendmsg+0x54e/0x850 net/socket.c:2684
 ___sys_sendmsg+0x2a5/0x360 net/socket.c:2738
 __sys_sendmmsg+0x273/0x4d0 net/socket.c:2827
 __do_sys_sendmmsg net/socket.c:2854 [inline]
 __se_sys_sendmmsg net/socket.c:2851 [inline]
 __x64_sys_sendmmsg+0xa0/0xc0 net/socket.c:2851
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x15f/0x560 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fed8cfcb649
Code: c0 79 93 eb d5 48 8d 7c 1d 00 eb 99 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fed8a791f58 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00000000000001f2 RCX: 00007fed8cfcb649
RDX: 000000000000000a RSI: 00007fed8a791f80 RDI: 0000000000000006
RBP: 00007fed8a791f80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000040 R11: 0000000000000246 R12: 0000000000000006
R13: 0000000000000000 R14: 00007ffed10ed450 R15: 00007ffed10ed538
 </TASK>
----------------
Code disassembly (best guess):
   0:	49 81 c7 70 01 00 00 	add    $0x170,%r15
   7:	4c 8d 35 86 dd 5b 0e 	lea    0xe5bdd86(%rip),%r14        # 0xe5bdd94
   e:	48 89 f8             	mov    %rdi,%rax
  11:	48 c1 e8 03          	shr    $0x3,%rax
  15:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1)
  19:	74 05                	je     0x20
  1b:	e8 a4 20 a5 00       	call   0xa520c4
  20:	49 8b 75 18          	mov    0x18(%r13),%rsi
  24:	4c 89 f7             	mov    %r14,%rdi
  27:	4c 89 fa             	mov    %r15,%rdx
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	4c 89 e8             	mov    %r13,%rax
  32:	48 c1 e8 03          	shr    $0x3,%rax
  36:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1)
  3a:	74 08                	je     0x44
  3c:	4c 89 ef             	mov    %r13,%rdi
  3f:	e8                   	.byte 0xe8


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
