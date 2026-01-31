Received: from mail-oa1-f79.google.com (mail-oa1-f79.google.com [209.85.160.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC53F17BCA
	for <linux-bluetooth@vger.kernel.org>; Sat, 31 Jan 2026 13:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769867431; cv=none; b=e/rs2WphzkA+2CD4sHL7KuhEBb/ntOIt5x0wRREAVDV5nSEi+VRzE+bs9Sra5dmo6bKYkybqePw2INLMQlUUgSTJ9zU38Sv1RkcwxyCs+aMohOsKMcWfrqDQoEYlqc/dG7eAYMZzg7YvpTXayfOU5TT1zxzsdiIUMVuMWPP6fr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769867431; c=relaxed/simple;
	bh=PG7kemAgOo1QKjFuEjPsRf64oLSFXhZeDUEYPblwInQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GHyQMMdNBw8AZ+2eurA4VBaOwaSYfTWR3hWnSNIraPPCmqs+Jn9FAGiX1LO3YbLDO6cGuRO8sJNkATm3zGMkMAPI1jXL8gGzsOVqrGbBaN7APF/ceAqUzqbiY617fpzWn+4X8DTw3TAWlaz6P4J7yNxtOPRUST4vPcsT0W168rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f79.google.com with SMTP id 586e51a60fabf-4099ea02dfdso7725455fac.2
        for <linux-bluetooth@vger.kernel.org>; Sat, 31 Jan 2026 05:50:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769867429; x=1770472229;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sEiqMtKpUh7bHm2i5eUrSLTvPryl68FR0myfDjieKEk=;
        b=ejClF8a5PEXxJRmZm/WkeHcau8UU0UOMje1Zcr2/cL/l4ujpPsePeQscF7GhuXIDMy
         uiJSWQrKOz8Z4j1x3zcZ9AJhOlV5O4e2FZ53m8gagFCwWZgtMCl0bb1W7QvCfaGmYWOx
         eH2NBcUO6tAYWEyp2r1bfrvCkiVZ0vhF6roi0HLK1EKBv2tgeiYD6gRG5Hq+ikmNRl5N
         c49orqeggwjDNFU88h10Bs6QohkeNBBH604XISb8xrJQ6bLv6ccnUTWjEr3DcIlMG48D
         +7JSBcv4zNmidxGorbqv5qL3Ap26335vbTtW+5RKHQklpwu5M8B17E8mCR3ZqbmSGgdd
         RXhw==
X-Forwarded-Encrypted: i=1; AJvYcCWA+DRQeRg2puzXOzX2kB17iBsladRHIp2FDACEI5CJxBfl0of5WF5BPsorEHLbj2n7i4SRVdQQBKuldsIaa4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzQa4vhAXnLIA4U3D/tKHC3ySTt1QXF8rzkX8h9bHpReMNLhpA
	eWWZ/xrVseAuJBdFHLg0X++FghmtFiTRpHYoAfsWGz7Ms3TGZwQdzf6Y7l43zOxEoE1fUHfYa03
	EIeTpmR+bNXdbXdeieIPusfOCNTKqLbzUnw+wjXhDRwwRyZmB81lRFXVaDzU=
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:820:b0:662:c5c5:4fac with SMTP id
 006d021491bc7-6630f3c4dbcmr2516793eaf.79.1769867428833; Sat, 31 Jan 2026
 05:50:28 -0800 (PST)
Date: Sat, 31 Jan 2026 05:50:28 -0800
In-Reply-To: <694c9ee9.050a0220.35954c.0030.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <697e08a4.050a0220.16b13.0092.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] WARNING in hci_connect_sco
From: syzbot <syzbot+5897b3c764f5989ea942@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    ad9a728a3388 Merge tag 'for-linus-iommufd' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15513c5a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f1fac0919970b671
dashboard link: https://syzkaller.appspot.com/bug?extid=5897b3c764f5989ea942
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17b45322580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-ad9a728a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bad71633ff53/vmlinux-ad9a728a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7cac661e37c7/bzImage-ad9a728a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5897b3c764f5989ea942@syzkaller.appspotmail.com

------------[ cut here ]------------
workqueue: cannot queue hci_conn_timeout on wq hci1
WARNING: kernel/workqueue.c:2251 at __queue_work+0xcbb/0x10f0 kernel/workqueue.c:2250, CPU#1: syz.0.8416/24058
Modules linked in:
CPU: 1 UID: 0 PID: 24058 Comm: syz.0.8416 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:__queue_work+0xcbf/0x10f0 kernel/workqueue.c:2250
Code: 00 00 00 fc ff df 49 8d 94 24 78 01 00 00 48 89 f9 48 c1 e9 03 80 3c 01 00 0f 85 15 04 00 00 48 8d 3d 95 f5 eb 0e 48 8b 75 18 <67> 48 0f b9 3a e9 77 f7 ff ff e8 a2 b0 38 00 90 0f 0b 90 e9 ff f5
RSP: 0018:ffffc90005f2fbf8 EFLAGS: 00010046
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 1ffff11006ee094b
RDX: ffff888027001178 RSI: ffffffff8a71b840 RDI: ffffffff90ba4040
RBP: ffff888037704a40 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: ffff888027001000
R13: ffff888048858000 R14: ffff888037704a88 R15: ffff888037704a48
FS:  00007fa16e9826c0(0000) GS:ffff8880d66d9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002000000000c0 CR3: 00000000523e6000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 __queue_delayed_work+0x365/0x470 kernel/workqueue.c:2503
 queue_delayed_work_on+0x180/0x1e0 kernel/workqueue.c:2555
 queue_delayed_work include/linux/workqueue.h:684 [inline]
 hci_conn_drop include/net/bluetooth/hci_core.h:1710 [inline]
 hci_conn_drop include/net/bluetooth/hci_core.h:1684 [inline]
 hci_connect_sco+0x4d2/0xef0 net/bluetooth/hci_conn.c:1767
 sco_connect net/bluetooth/sco.c:339 [inline]
 sco_sock_connect+0x303/0xcb0 net/bluetooth/sco.c:665
 __sys_connect_file+0x141/0x1a0 net/socket.c:2089
 __sys_connect+0x141/0x170 net/socket.c:2108
 __do_sys_connect net/socket.c:2114 [inline]
 __se_sys_connect net/socket.c:2111 [inline]
 __x64_sys_connect+0x72/0xb0 net/socket.c:2111
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xc9/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa16db9aeb9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa16e982028 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: ffffffffffffffda RBX: 00007fa16de15fa0 RCX: 00007fa16db9aeb9
RDX: 0000000000000008 RSI: 00002000000000c0 RDI: 0000000000000004
RBP: 00007fa16dc08c1f R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fa16de16038 R14: 00007fa16de15fa0 R15: 00007ffcb1740998
 </TASK>
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	00 fc                	add    %bh,%ah
   4:	ff                   	lcall  (bad)
   5:	df 49 8d             	fisttps -0x73(%rcx)
   8:	94                   	xchg   %eax,%esp
   9:	24 78                	and    $0x78,%al
   b:	01 00                	add    %eax,(%rax)
   d:	00 48 89             	add    %cl,-0x77(%rax)
  10:	f9                   	stc
  11:	48 c1 e9 03          	shr    $0x3,%rcx
  15:	80 3c 01 00          	cmpb   $0x0,(%rcx,%rax,1)
  19:	0f 85 15 04 00 00    	jne    0x434
  1f:	48 8d 3d 95 f5 eb 0e 	lea    0xeebf595(%rip),%rdi        # 0xeebf5bb
  26:	48 8b 75 18          	mov    0x18(%rbp),%rsi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	e9 77 f7 ff ff       	jmp    0xfffff7ab
  34:	e8 a2 b0 38 00       	call   0x38b0db
  39:	90                   	nop
  3a:	0f 0b                	ud2
  3c:	90                   	nop
  3d:	e9                   	.byte 0xe9
  3e:	ff f5                	push   %rbp


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
