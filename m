Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C692038BA
	for <linux-bluetooth@vger.kernel.org>; Tue, 12 Nov 2024 03:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731383191; cv=none; b=lLwywdmu1c7yb/SZDNSXBXEHFA88LeMKV4i3SB/izpYxuDEavZ8Oy3GKzaycexhfGy/oStP5DfAYEbiPEES5n8z3JixKVHkIaCxIXimzZRQzzj1DnTNm/4C90Bl3NSLvrhvgGfBJuYJNNekUvIHEtZmzwoacPHbOSauasXkG+go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731383191; c=relaxed/simple;
	bh=MdF0vQAzDkjzPCpTxKOBblHlGzTL1baHSFNggrEk/FQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cPUSvQP5ZVmQQE/SU2gxRDrxSoOgMPO5zgwmTjHWPbhThVGq/47y9f69F5GSX/1N1QBT1VlTWXkBkJqgySVvaEHGqPVtI6As8k/XYVnRLaAo2nWFN+HHjEyJCix/csmKweJKvSIkayuhEUPXfgCJ2g3t7Etrf4ulVNZf4EfN9rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a6c355b3f5so59778695ab.3
        for <linux-bluetooth@vger.kernel.org>; Mon, 11 Nov 2024 19:46:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731383189; x=1731987989;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gTlS1My+IX6vUSKJh4vEvVCjOuHSbZWEzCPaUoxSiP0=;
        b=J6NTQj61i7hWB98y+ZcUr3zUct1hEbe6ax29cQnjNxhqjEUU8ED8OaQw2xUERoJk5m
         aUfdT0Py3ft7Qh7U5J/kZI/bb/2FsfzpaA+PdUqMo1byyjQTck2U5ghi5S/enThDOpk7
         bcee3/10gWnh3ooZnmJfPxOAhXgcR2lI9O2bsDRAqBobUez6R3p55AgDZ/dBCFDll1Fy
         al9SAewWA+H4LA5ONOB+28IcW3vpqiZgWkrKs/4UMV+KIfYXtEiitg0tYGy2svzYArRQ
         HqfpUK4L8p2B1+jlEacNCAxKk/e+JurHO/LwWhnD1vhiAehqt2Pw3czJuCqZHoe/ODTV
         4WNA==
X-Forwarded-Encrypted: i=1; AJvYcCWzl8HY8f4E6l6VdhCTFbTzZ0yuj5fiyry5AODGFxZ6/L2txH5AhcxL/RDbEsXH0SL/p1T97JXjiKEMcUYMXuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YylnFzSHHUuQ8bEuf9PHhNzSmz+U75Q1JTV/+DNoW5O0MOjk5Hu
	Z2KF/SHZ7wEBxCFgFe3yZl1Jua4DGsJwA88taYooquBvMmlhPJrvzesJwRhRcqrXFlv0LaM0VJT
	9tIPdlgCj/cxIWnrRA9Q7chrJ54/Gq8t2Dv/6SWJg2InY2x53B8YeD1s=
X-Google-Smtp-Source: AGHT+IG3ufhXQPfWoo/ORV9DkMtBnk/0diPUmflaxDDBBQ/UNSgc7NBkjFs68zErC0fsRRuARu/bX+P3GgrIsquVZiyX2HrALGLv
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1f08:b0:3a6:b0a3:5402 with SMTP id
 e9e14a558f8ab-3a6f1a21dcdmr159700115ab.17.1731383188700; Mon, 11 Nov 2024
 19:46:28 -0800 (PST)
Date: Mon, 11 Nov 2024 19:46:28 -0800
In-Reply-To: <0000000000009d5daa05ed9815fa@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6732cf94.050a0220.5088e.0003.GAE@google.com>
Subject: Re: [syzbot] [bluetooth] WARNING in call_timer_fn
From: syzbot <syzbot+6fb78d577e89e69602f9@syzkaller.appspotmail.com>
To: ben-linux@fluff.org, bp@alien8.de, daniel.sneddon@linux.intel.com, 
	dave.hansen@linux.intel.com, gregkh@linuxfoundation.org, hdanton@sina.com, 
	hpa@zytor.com, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	mingo@redhat.com, netdev@vger.kernel.org, pbonzini@redhat.com, 
	penguin-kernel@I-love.SAKURA.ne.jp, penguin-kernel@i-love.sakura.ne.jp, 
	rafael@kernel.org, rosted@goodmis.org, 
	sathyanarayanan.kuppuswamy@linux.intel.com, syzkaller-bugs@googlegroups.com, 
	tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    de9df030ccb5 usb: typec: ucsi: glink: be more precise on o..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=15637ea7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=358c1689354aeef3
dashboard link: https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=101db8c0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1738f4e8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fcce9dc5242d/disk-de9df030.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/420ef3e22854/vmlinux-de9df030.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a6d0ac1f944e/bzImage-de9df030.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6fb78d577e89e69602f9@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 9 at kernel/workqueue.c:2257 __queue_work+0xc3a/0x1080 kernel/workqueue.c:2256
Modules linked in:
CPU: 0 UID: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.12.0-rc6-syzkaller-00106-gde9df030ccb5 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: usb_hub_wq hub_event
RIP: 0010:__queue_work+0xc3a/0x1080 kernel/workqueue.c:2256
Code: 07 83 c0 03 38 d0 7c 09 84 d2 74 05 e8 7f 46 8b 00 8b 5b 2c 31 ff 83 e3 20 89 de e8 40 bf 32 00 85 db 75 60 e8 f7 bc 32 00 90 <0f> 0b 90 e9 f9 f7 ff ff e8 e9 bc 32 00 90 0f 0b 90 e9 a8 f7 ff ff
RSP: 0018:ffffc90000007bf0 EFLAGS: 00010046
RAX: 0000000000000000 RBX: 0000000000000100 RCX: ffffffff812335c1
RDX: ffff888101698000 RSI: ffffffff81233619 RDI: 0000000000000005
RBP: ffff88811a063780 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000100 R11: 0000000000000000 R12: 1ffff92000000f90
R13: 0000000000000001 R14: 0000000000000101 R15: ffff888106b28800
FS:  0000000000000000(0000) GS:ffff8881f5800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7cbbc0c258 CR3: 0000000116944000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 call_timer_fn+0x1a0/0x610 kernel/time/timer.c:1794
 expire_timers kernel/time/timer.c:1840 [inline]
 __run_timers+0x56a/0x930 kernel/time/timer.c:2419
 __run_timer_base kernel/time/timer.c:2430 [inline]
 __run_timer_base kernel/time/timer.c:2423 [inline]
 run_timer_base+0x111/0x190 kernel/time/timer.c:2439
 run_timer_softirq+0x1a/0x40 kernel/time/timer.c:2449
 handle_softirqs+0x206/0x8d0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xac/0x110 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:console_trylock_spinning kernel/printk/printk.c:2042 [inline]
RIP: 0010:vprintk_emit+0x621/0x6f0 kernel/printk/printk.c:2406
Code: 85 ed 0f 85 81 00 00 00 e8 0c 94 1f 00 9c 41 5c 41 81 e4 00 02 00 00 31 ff 4c 89 e6 e8 68 96 1f 00 4d 85 e4 0f 85 8d 00 00 00 <e8> ea 93 1f 00 45 31 c9 41 b8 01 00 00 00 31 c9 48 8d 05 00 00 00
RSP: 0018:ffffc9000009f6e8 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000029 RCX: ffffffff81365f9e
RDX: ffff888101698000 RSI: ffffffff81365fa8 RDI: 0000000000000007
RBP: 1ffff92000013edf R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000200 R14: ffff88810d331d40 R15: ffffc9000009f7b0
 dev_vprintk_emit drivers/base/core.c:4942 [inline]
 dev_printk_emit+0xfb/0x140 drivers/base/core.c:4953
 __dev_printk+0xf5/0x270 drivers/base/core.c:4965
 _dev_info+0xe5/0x120 drivers/base/core.c:5011
 usb_disconnect+0xec/0x920 drivers/usb/core/hub.c:2286
 hub_port_connect drivers/usb/core/hub.c:5361 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5661 [inline]
 port_event drivers/usb/core/hub.c:5821 [inline]
 hub_event+0x1bed/0x4f40 drivers/usb/core/hub.c:5903
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
----------------
Code disassembly (best guess):
   0:	85 ed                	test   %ebp,%ebp
   2:	0f 85 81 00 00 00    	jne    0x89
   8:	e8 0c 94 1f 00       	call   0x1f9419
   d:	9c                   	pushf
   e:	41 5c                	pop    %r12
  10:	41 81 e4 00 02 00 00 	and    $0x200,%r12d
  17:	31 ff                	xor    %edi,%edi
  19:	4c 89 e6             	mov    %r12,%rsi
  1c:	e8 68 96 1f 00       	call   0x1f9689
  21:	4d 85 e4             	test   %r12,%r12
  24:	0f 85 8d 00 00 00    	jne    0xb7
* 2a:	e8 ea 93 1f 00       	call   0x1f9419 <-- trapping instruction
  2f:	45 31 c9             	xor    %r9d,%r9d
  32:	41 b8 01 00 00 00    	mov    $0x1,%r8d
  38:	31 c9                	xor    %ecx,%ecx
  3a:	48                   	rex.W
  3b:	8d                   	.byte 0x8d
  3c:	05                   	.byte 0x5
  3d:	00 00                	add    %al,(%rax)


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
