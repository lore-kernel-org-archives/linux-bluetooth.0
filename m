Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B5B3C4B79
	for <linux-bluetooth@vger.kernel.org>; Sun, 18 Oct 2026 07:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792307973; cv=none; b=pM1glXWrN320SNa0rVHPEJZw+qJEVIq2/E1V8nt4R/7QheriDX8lJfIaIGZICPBtu+g8PMxn/6ucJn36eMeqhGR+OI0peyC8G8+5hIhiEsQD3PJ0bwC21PaqObnxdg/+ylAzsPwNuTSg/xNch18KpmGzr/HIKobMzPJmRPmIk/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792307973; c=relaxed/simple;
	bh=4V8pFwPzztzfNKUmID/Y810/S4uDAWZb9BkU/MT59LI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=B9e8SPgupyR6srJfZhJ+Qb0mA+l+WXKdc4K/o1yZ/pgqIMxqlv/xmrW5bvtr5GOHmLlVG4w27UUmQ+GGrJ2TbJN3O4mI98JoxOIHU6Tz78oYfGgl8qCnDr83nIU5KLOhw/PhGK7+Y7EQb15P3oydgHGTSRb8Z6w2sMnYvMhZKwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-4e937c5bd4fso1533019b6e.2
        for <linux-bluetooth@vger.kernel.org>; Sun, 18 Oct 2026 00:19:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792307971; x=1792912771;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kG+0vS79neUY8AgmkmNQZZtNTJjATrvCUw5SiLwyRXE=;
        b=zE5RdwvjdsBEAr/5YQY/jHXsqPENiUcsoz9pBa311XQ/jqNxWXfrk25Kfnn66XMra/
         nuxoiZToRSCXfv7rVpyfHRcOrFBPiovXJlKNRJCPGNEvJkog3Xd68f6Jj9DIXRNPvE/m
         cVrNODrD5epUCZdnDHS/JEUg43LvUJFLxwniTs28JZzzYMUFxSO9SkUI0+rFsCSSKrbz
         vJ7zwv8RRxheSNTDVahiU1wErLmeaKPyQbDO71jEnLyWXzQCbqakW/GQp3u9016wG4RS
         xy+saUH9ORjY5sSTuhrkzpPzViO4ChiL9runI0ttuDzJxbdAZW8wllIlMh4yXu7c6n4P
         MIYQ==
X-Gm-Message-State: AFq9FYJqC0J0FKmwERrHVRC4iaMcEPZli/0Ln2ELVylJQEfVDKumlJNJ
	qlPaPCJZF9VWjNqjXsQOK7JYRV+dCwBpV9mNazBHOYlJR3QYccF7B11hzvTj0zARwAh0M3WhYaL
	/y6zQe4ceJvI1bYlRn6GM2plBkzndwZ04ptceA8RmHHzlEjLXe/Jkr7XXQlI=
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3c49:b0:53c:7298:35a9 with SMTP id
 5614622812f47-53cc3e3c8bbmr3405895b6e.8.1792307971593; Sun, 18 Oct 2026
 00:19:31 -0700 (PDT)
Date: Sun, 18 Oct 2026 00:19:31 -0700
In-Reply-To: <6ac5d1ad.353c8d8e.177895.000d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ad47303.a6d1a155.34a93f.0086.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] WARNING in hci_recv_frame (2)
From: syzbot <syzbot+2344fb8002f3ef5b1712@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    32c52ec87d62 x86/insn-eval: Fix shadowed segment index in ..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10999621580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ccb65e03706547e
dashboard link: https://syzkaller.appspot.com/bug?extid=2344fb8002f3ef5b1712
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17870f01580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2344fb8002f3ef5b1712@syzkaller.appspotmail.com

------------[ cut here ]------------
workqueue: cannot queue hci_rx_work on wq hci0
WARNING: kernel/workqueue.c:2353 at __queue_work+0xd93/0x10e0 kernel/workqueue.c:2352, CPU#0: syz-executor360/5620
Modules linked in:
CPU: 0 UID: 0 PID: 5620 Comm: syz-executor360 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:__queue_work+0xdaf/0x10e0 kernel/workqueue.c:2352
Code: 49 81 c7 70 01 00 00 4c 8d 35 dd 08 ef 0f 48 89 f8 48 c1 e8 03 80 3c 18 00 74 05 e8 8b 37 ac 00 49 8b 75 18 4c 89 f7 4c 89 fa <67> 48 0f b9 3a 4c 89 e8 48 c1 e8 03 80 3c 18 00 74 08 4c 89 ef e8
RSP: 0018:ffffc90002bc7af8 EFLAGS: 00010046
RAX: 1ffff1100266f978 RBX: dffffc0000000000 RCX: ffff888035d04b00
RDX: ffff888013890970 RSI: ffffffff8adabbd0 RDI: ffffffff917d6fa0
RBP: 0000000000000000 R08: ffff88801337cbaf R09: 1ffff1100266f975
R10: dffffc0000000000 R11: ffffed100266f976 R12: 0000000000000008
R13: ffff88801337cba8 R14: ffffffff917d6fa0 R15: ffff888013890970
FS:  00007f02356e36c0(0000) GS:ffff88808b0b4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056507f781b68 CR3: 000000001468d000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 queue_work_on+0x106/0x1d0 kernel/workqueue.c:2501
 queue_work include/linux/workqueue.h:700 [inline]
 hci_recv_frame+0x61e/0x7c0 net/bluetooth/hci_core.c:2946
 vhci_get_user drivers/bluetooth/hci_vhci.c:530 [inline]
 vhci_write+0x35d/0x4a0 drivers/bluetooth/hci_vhci.c:626
 new_sync_write fs/read_write.c:595 [inline]
 vfs_write+0x612/0xba0 fs/read_write.c:687
 ksys_write+0x150/0x270 fs/read_write.c:739
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f023773e24e
Code: 08 0f 85 05 e3 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 90 41 57 41 56 4d 89 c6 41 55 4d 89 cd 41 54 55 53 48 83 ec 08
RSP: 002b:00007f02356e3198 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f02356e36c0 RCX: 00007f023773e24e
RDX: 0000000000000007 RSI: 00007f0237789050 RDI: 0000000000000003
RBP: 00007f0237789050 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f0237789057
R13: 0000000000000000 R14: 00007ffc8187e190 R15: 00007ffc8187e278
 </TASK>
----------------
Code disassembly (best guess):
   0:	49 81 c7 70 01 00 00 	add    $0x170,%r15
   7:	4c 8d 35 dd 08 ef 0f 	lea    0xfef08dd(%rip),%r14        # 0xfef08eb
   e:	48 89 f8             	mov    %rdi,%rax
  11:	48 c1 e8 03          	shr    $0x3,%rax
  15:	80 3c 18 00          	cmpb   $0x0,(%rax,%rbx,1)
  19:	74 05                	je     0x20
  1b:	e8 8b 37 ac 00       	call   0xac37ab
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
