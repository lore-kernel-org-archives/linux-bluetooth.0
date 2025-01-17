Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B47D530
	for <linux-bluetooth@vger.kernel.org>; Fri, 17 Jan 2025 01:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737077046; cv=none; b=riPf7TNUX3H2wVjv8k9XnrDGtXhzbNOcfRo1SC9l9HWPk2RI4Ui+MUOUy4vpTQCqVihpe8Ci66kFGRHFbTO7OrwU1JDj2hH+j0dmFxaUQBhGFJ8xIHK28JFoOsSoui4gs/R+yNfl+7DiYWbXCPjO3G5ccE7leaiclgXv0nN7y2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737077046; c=relaxed/simple;
	bh=CVCwr8GdktVXf79q8KXeeME4f6aASUqReBlA4VfytRA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=n/Z2A61m41FPtKzMR6mGSBjPyY7/7Hcrk77ZbrLjNAElepcA9J9iR6wHDXbGlhcJ3JlBxekRE7LLZT0UB9+vQCj1rqSvEOvPEkyJIuejTaS48VahAqb9Mk6LYRFcx/kAKkJGgEvcihBdo+97CoVb2BFFhUHkWX1NcIscDZ7T/BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a7e0d5899bso26672615ab.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 16 Jan 2025 17:24:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737077044; x=1737681844;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2iQV63u731mTCIWmL3VgeGo2lOvzybrMiK3VobLJXkg=;
        b=u/XmqVAaYVxDbfXR5+OQahvLIWaJZFoE2voiLYaykXiQ2qfJYiG6cRwBLXW8vmTaI4
         nkMZJvYL88WkDrErDKz2MuwMxsloc828Wz2yxamiBp5Ver97E/gcYR4vFWz8wpC4Q+LO
         PsxTtidawuvnkB9pEn8EveiATMm+9WJh4+6CwA5BWHF+GgAoCnYoVyHlwqU8i/FfvUiH
         l4vakzO0WzBoSSw9lNEp8U50y/tBloMf9m1vdropNN4XUeAf2JbAt5EWGcFRF7zoFDp3
         m922ckR3Z+7N9ASFkifDVB2gYG2CQ7PwelMKqNLT70Yp8rAwCInAIqG8ctYWmfiOWzi3
         csnA==
X-Gm-Message-State: AOJu0Yx5YxRK32TBAH4DaGf8Epyaa8pqyqWWt1jYRDSzz/p540Y3wlBU
	x1gPTCEzBEsKH0qEKTgehJuzdDf3zbInQpM/eyQLYQd8L2h9Yyp8B4Z7LwER5/H0zGGkKDieiLi
	JdfDZy019dMIbL47yVXQ053ETdBEbXCQpQOxRR1VOys0rX3EDDOEFqmU=
X-Google-Smtp-Source: AGHT+IFlxpd0ZmtfEnGBReLGaExi+GhwvQwkhurU2H4b39y4imqn4Y6Ak/zuojiHuEnvWi3hD3ottNP3L1m7mnS3uDWicxIV3l8Y
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3f03:b0:3ce:87e3:c26c with SMTP id
 e9e14a558f8ab-3cf743df88amr8866975ab.5.1737077043848; Thu, 16 Jan 2025
 17:24:03 -0800 (PST)
Date: Thu, 16 Jan 2025 17:24:03 -0800
In-Reply-To: <CABBYNZJYDW+k+RMZiLGxK094UB8bMcXeqqqMzDv7zkStRPTyTA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6789b133.050a0220.20d369.004c.GAE@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Read in l2cap_send_cmd
From: syzbot <syzbot+31c2f641b850a348a734@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in hci_send_acl

Bluetooth: Unknown BR/EDR signaling command 0x0d
Bluetooth: Wrong link type (-22)
Bluetooth: Unknown BR/EDR signaling command 0x0f
Bluetooth: Wrong link type (-22)
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 0 UID: 0 PID: 6555 Comm: kworker/u9:3 Not tainted 6.13.0-rc7-syzkaller-00102-gce69b4019001-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Workqueue: hci3 hci_rx_work
RIP: 0010:hci_send_acl+0x3e/0xd00 net/bluetooth/hci_core.c:3232
Code: 00 89 54 24 04 49 89 f5 48 89 fb 49 bf 00 00 00 00 00 fc ff df e8 e2 91 e6 f6 48 89 5c 24 18 4c 8d 73 18 4c 89 f3 48 c1 eb 03 <42> 80 3c 3b 00 74 08 4c 89 f7 e8 03 fc 4c f7 bd f8 0f 00 00 49 03
RSP: 0018:ffffc90003627238 EFLAGS: 00010206
RAX: ffffffff8ab8f08e RBX: 0000000000000003 RCX: ffff88802f890000
RDX: 0000000000000000 RSI: ffff888029522b40 RDI: 0000000000000000
RBP: ffffc90003627a10 R08: ffffffff8ac38ee4 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed100e8028c3 R12: ffff888031548629
R13: ffff888029522b40 R14: 0000000000000018 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2c547452d8 CR3: 000000000e736000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 l2cap_sig_send_rej net/bluetooth/l2cap_core.c:5502 [inline]
 l2cap_sig_channel net/bluetooth/l2cap_core.c:5538 [inline]
 l2cap_recv_frame+0x221f/0x10db0 net/bluetooth/l2cap_core.c:6817
 l2cap_recv_acldata+0x700/0x1a50 net/bluetooth/l2cap_core.c:7524
 hci_acldata_packet net/bluetooth/hci_core.c:3797 [inline]
 hci_rx_work+0x508/0xdb0 net/bluetooth/hci_core.c:4040
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3317
 worker_thread+0x870/0xd30 kernel/workqueue.c:3398
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:hci_send_acl+0x3e/0xd00 net/bluetooth/hci_core.c:3232
Code: 00 89 54 24 04 49 89 f5 48 89 fb 49 bf 00 00 00 00 00 fc ff df e8 e2 91 e6 f6 48 89 5c 24 18 4c 8d 73 18 4c 89 f3 48 c1 eb 03 <42> 80 3c 3b 00 74 08 4c 89 f7 e8 03 fc 4c f7 bd f8 0f 00 00 49 03
RSP: 0018:ffffc90003627238 EFLAGS: 00010206
RAX: ffffffff8ab8f08e RBX: 0000000000000003 RCX: ffff88802f890000
RDX: 0000000000000000 RSI: ffff888029522b40 RDI: 0000000000000000
RBP: ffffc90003627a10 R08: ffffffff8ac38ee4 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffed100e8028c3 R12: ffff888031548629
R13: ffff888029522b40 R14: 0000000000000018 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000564e8bb3fdc8 CR3: 000000000e736000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	00 89 54 24 04 49    	add    %cl,0x49042454(%rcx)
   6:	89 f5                	mov    %esi,%ebp
   8:	48 89 fb             	mov    %rdi,%rbx
   b:	49 bf 00 00 00 00 00 	movabs $0xdffffc0000000000,%r15
  12:	fc ff df
  15:	e8 e2 91 e6 f6       	call   0xf6e691fc
  1a:	48 89 5c 24 18       	mov    %rbx,0x18(%rsp)
  1f:	4c 8d 73 18          	lea    0x18(%rbx),%r14
  23:	4c 89 f3             	mov    %r14,%rbx
  26:	48 c1 eb 03          	shr    $0x3,%rbx
* 2a:	42 80 3c 3b 00       	cmpb   $0x0,(%rbx,%r15,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 f7             	mov    %r14,%rdi
  34:	e8 03 fc 4c f7       	call   0xf74cfc3c
  39:	bd f8 0f 00 00       	mov    $0xff8,%ebp
  3e:	49                   	rex.WB
  3f:	03                   	.byte 0x3


Tested on:

commit:         ce69b401 Merge tag 'net-6.13-rc8' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10e782b0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aadf89e2f6db86cc
dashboard link: https://syzkaller.appspot.com/bug?extid=31c2f641b850a348a734
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=154721f8580000

