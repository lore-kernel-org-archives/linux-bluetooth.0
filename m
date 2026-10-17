Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDEF3812F4
	for <linux-bluetooth@vger.kernel.org>; Sat, 17 Oct 2026 14:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792245695; cv=none; b=Jg1dSrX8644UL3hMO4QZroRxhXgoqAtWUsxLqXr4h2Jz+RF3ZzifPLJVp3uG4XwSQgsG3b6ryzYNNlzkNNxna0zl4knhCRhxOhDrtaj3ymfuF4XrsBjp/tRGhvn4qSXFzHxbchlPj1Mq5Qj+M8OVtory2ysKhcK7tM0IPVoRQjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792245695; c=relaxed/simple;
	bh=vmnQysLevHaWbb1uF/c8zt50f7JJc7Yo9JL3FxVJ1cc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dt3yQwgsCYnKLpYWPGnNdR+0VHr6nQzbcO8e2iGFPnHc+jLFA7GZWg3xYpGsZDjkYwkY8+yGGh6UnmtmSIrv2unCO9ozD2ICNyrcGNGJ8Ohc6NAoiiG2NvTsJznmLbB+j8nMapygpyPwDGWwIC/EzepKT15wT06eE2047KJ/rjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-4a41f46d629so1604019b6e.3
        for <linux-bluetooth@vger.kernel.org>; Sat, 17 Oct 2026 07:01:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792245693; x=1792850493;
        h=content-type:to:from:subject:message-id:in-reply-to:date
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lP3DxBlZYuFDM6MPkaVS1x4uAxYo3Wn91Igqh/JWa1A=;
        b=Cxwag0/IYWgRGdbnqB8ONS/5UdoT70vGs+QUBwneFcSMDGiW1BQg+RDrjMqmeAtsCO
         oDO+EsihB7Vp/X109Pfoog2/Rc6NEW/tuyCisdRFIgZkfh4G9TnTl7kkZpfKamrQxrtv
         5TcC3uLRlYEoHYWIe4CXBL6Q+GnEPIJaNLnT5WQBo8EXFaxwNS025NwcakOQNKYjpwG1
         5Q+IUXTEli23sVZGeiN9wyh3Epkc5zjZgNouNB1vpJfRl4DSif0YhQSrtYe4P3w/a9HO
         F0FFp882Mpjg6wTROrsk3EgfT4vGp+U6LZYkyESRu57f1NPKICxezihC6qbxU8NnCBEt
         CNlA==
X-Forwarded-Encrypted: i=1; AKwUvBwB6TNCpICDkgdkfDyv/k6VLewe0L/Xi7LQv48seiv+Dy2gZ3qPVHuX8MOiQcqZf5DDrP+u5txhEVRb3/6lzxA=@vger.kernel.org
X-Gm-Message-State: AFq9FYIKxdTxO7XzF2zIoKHdQrep6GUxRD0o22AZMQWYMlyqx0fBlr+E
	dyaZ+HusKxFmy0bwvJ8IdFi4Zgq1OoixFnGBbp7pTIsB0KYVf4X+v/Scc4ubE/Sg4d1e4FGAwFx
	YgajZvSwH1g5EHmPq0QPFIOV4TSX+jFQn8akzDzDYOGGF5759kSvseygM/cg=
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1904:b0:4d6:92f4:d684 with SMTP id
 5614622812f47-53cd2f31129mr2013438b6e.63.1792245692842; Sat, 17 Oct 2026
 07:01:32 -0700 (PDT)
Date: Sat, 17 Oct 2026 07:01:32 -0700
In-Reply-To: <694c9ee9.050a0220.35954c.0030.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ad37fbc.6814cce4.34c49f.0073.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] WARNING in hci_connect_sco
From: syzbot <syzbot+5897b3c764f5989ea942@syzkaller.appspotmail.com>
To: deaner92@yahoo.com, gservice341@gmail.com, hdanton@sina.com, 
	johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    58161ead29e5 Merge tag 'drm-fixes-2026-10-17' of https://g..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=101f34e1580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4ccb65e03706547e
dashboard link: https://syzkaller.appspot.com/bug?extid=5897b3c764f5989ea942
compiler:       Debian clang version 22.1.8 (1~deb13u4), Debian LLD 22.1.8
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17ac9031580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5897b3c764f5989ea942@syzkaller.appspotmail.com

------------[ cut here ]------------
workqueue: cannot queue hci_conn_timeout on wq hci0
WARNING: kernel/workqueue.c:2353 at __queue_work+0xd93/0x10e0 kernel/workqueue.c:2352, CPU#0: syz-executor112/5621
Modules linked in:
CPU: 0 UID: 0 PID: 5621 Comm: syz-executor112 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:__queue_work+0xdaf/0x10e0 kernel/workqueue.c:2352
Code: 49 81 c7 70 01 00 00 4c 8d 35 dd 07 ef 0f 48 89 f8 48 c1 e8 03 80 3c 18 00 74 05 e8 8b 37 ac 00 49 8b 75 18 4c 89 f7 4c 89 fa <67> 48 0f b9 3a 4c 89 e8 48 c1 e8 03 80 3c 18 00 74 08 4c 89 ef e8
RSP: 0018:ffffc900030a7af8 EFLAGS: 00010046
RAX: 1ffff1100a7cc94d RBX: dffffc0000000000 RCX: ffff888040b12580
RDX: ffff888013a00170 RSI: ffffffff8add09c0 RDI: ffffffff917d6ea0
RBP: 0000000000000000 R08: ffff888053e64a57 R09: 1ffff1100a7cc94a
R10: dffffc0000000000 R11: ffffed100a7cc94b R12: 0000000000000008
R13: ffff888053e64a50 R14: ffffffff917d6ea0 R15: ffff888013a00170
FS:  00007f0105e7e6c0(0000) GS:ffff88808b0b4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555905b7708 CR3: 0000000034424000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 queue_delayed_work_on+0x11a/0x1e0 kernel/workqueue.c:2669
 hci_connect_sco+0xe9/0x390 net/bluetooth/hci_conn.c:1881
 sco_connect net/bluetooth/sco.c:375 [inline]
 sco_sock_connect+0x45e/0xb10 net/bluetooth/sco.c:764
 connect_socket net/socket.c:2141 [inline]
 __sys_connect_file net/socket.c:2166 [inline]
 __sys_connect+0x316/0x450 net/socket.c:2183
 __do_sys_connect net/socket.c:2189 [inline]
 __se_sys_connect net/socket.c:2186 [inline]
 __x64_sys_connect+0x7a/0x90 net/socket.c:2186
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f01096e299e
Code: 08 0f 85 f5 e2 ff ff 49 89 fb 48 89 f0 48 89 d7 48 89 ce 4c 89 c2 4d 89 ca 4c 8b 44 24 08 4c 8b 4c 24 10 4c 89 5c 24 08 0f 05 <c3> 90 41 57 41 56 4d 89 c6 41 55 4d 89 cd 41 54 55 53 48 83 ec 08
RSP: 002b:00007f0105e7e0e8 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007f0105e7e6c0 RCX: 00007f01096e299e
RDX: 0000000000000008 RSI: 00007f0105e7e160 RDI: 0000000000000008
RBP: 000000000001e435 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000008
R13: 000000000001e438 R14: 00007f0105e7e160 R15: 00007f0105e7e158
 </TASK>
----------------
Code disassembly (best guess):
   0:	49 81 c7 70 01 00 00 	add    $0x170,%r15
   7:	4c 8d 35 dd 07 ef 0f 	lea    0xfef07dd(%rip),%r14        # 0xfef07eb
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
