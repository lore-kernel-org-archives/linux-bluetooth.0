Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC42537B01E
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 Apr 2026 07:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775720542; cv=none; b=Yfgp5u1c9xgMPa+uffAV8AfoyJRhOmHqAfrNvhmfgcxM+EozegvNshmwEynpm5CqfuVzfe7xHeNDHtlM3FGzc1CiSHenf9Q1zk+NnrbctsjEPX1LcyU3qOhhPqNeO6FYu3fut9hLzlO9ymssKaaW+byrWmrQgW+c0BCYRIeGAtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775720542; c=relaxed/simple;
	bh=DP0MaN12chIdKtctde1hPZNgioqVVK73fqKxEgc9Ikk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Ycaf+3D8gtx1SYf/MO0Or4GVp49bQ1N0pV+RxUM+y+uwihaM9MIPZIRpiaq0gd5rzhwnoLhq82/6Zi3jUBr8DrM8Rki4nqREfwrSG5ftlx5KJjbTHDcU9ebLP8GU8xn/hP/LQ3BoK0GUgPGgDKD+pc8Ef8NzZDiArhXpGjR62sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-67a1e063795so1128628eaf.1
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 Apr 2026 00:42:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775720540; x=1776325340;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gygayrJGgMwZqbWBI6JiR+DhqkU8Ra5y3i3FEQwb3Xk=;
        b=SE/wcuH94Vy46PhxMFZepHQLuHWqgOy2Zv+u/Iq7wo5twpID/m0TjFdOUR+JNjtGZm
         Ugta5FVw5o6X8eMOLh/YGIANH5JZMTnEpOqJKM6wt4EPmo66HRPn/shV0Sw81KIPS58Q
         qDLnUIhXWuBEllMJ0GAaSjzJ+3fJNaVLPX8RuTKtkpJmVyOYxBm0bDjxsaG5upGeY/AH
         7uteciwcqPLIp1R+FDc6UG1SX9Plq8ebajjqWkmUVesabWAjJ6CPIvuwimN5Wlbh6Lnh
         c7NYil0BIggkujnd5gYdmqm8FHa4qjsLrLU00ekmlAXn8+jlewQzpiLTMP4moYb/0nlE
         3uLw==
X-Gm-Message-State: AOJu0YzmQsgHlBzyxMJu6qFa7MIt6KOvC9uW/PFlYa9zLRUYzz5M0vSb
	QasgMzFoyT14RaYPsSc1lchyauQapg1RPEuyn0kc4huzaEFCmlzJXchBtzdTd8sdO/uHap/SgdV
	KQrJ1VNj69GVWwMqJw57WpT9ps7gc8ffOU5eWPRLhakcI0uub7Pfbk0gqIsARnQ==
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:c441:0:b0:682:1c53:89fc with SMTP id
 006d021491bc7-68a682b1503mr888315eaf.8.1775720540016; Thu, 09 Apr 2026
 00:42:20 -0700 (PDT)
Date: Thu, 09 Apr 2026 00:42:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69d7585b.050a0220.3030df.0011.GAE@google.com>
Subject: [syzbot] [bluetooth?] general protection fault in h4_recv
From: syzbot <syzbot+ff30eeab8e07b37d524e@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3aae9383f42f Merge tag 'input-for-v7.0-rc6' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17814e06580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a3e5e8c17cc174e
dashboard link: https://syzkaller.appspot.com/bug?extid=ff30eeab8e07b37d524e
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=108c0bd6580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11015d02580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/46384525f287/disk-3aae9383.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bcd9d5c20ab7/vmlinux-3aae9383.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e4353e5e60e2/bzImage-3aae9383.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ff30eeab8e07b37d524e@syzkaller.appspotmail.com

RBP: 00007ffeca659d70 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fd7d4415fac R14: 00007fd7d4415fa0 R15: 00007fd7d4415fa0
 </TASK>
Bluetooth: Can't register HCI device
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 UID: 0 PID: 5964 Comm: syz.0.18 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/18/2026
RIP: 0010:h4_recv+0x52/0x1c0 drivers/bluetooth/hci_h4.c:112
Code: df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 3c 01 00 00 4c 8b a3 b8 01 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f 85 31 01 00 00 49 8b 34 24 48 89 ea 41 b9 04 00 00
RSP: 0018:ffffc900037afca8 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff888033b48400 RCX: ffffffff887767b0
RDX: 0000000000000000 RSI: ffffffff8877b6a8 RDI: ffff888033b485b8
RBP: ffffc900037afd68 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000001 R14: ffff888033b484c0 R15: ffffffff8cc1b1c0
FS:  000055556677d500(0000) GS:ffff888124339000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd7d4072140 CR3: 00000000747cb000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 hci_uart_tty_receive+0x259/0x7e0 drivers/bluetooth/hci_ldisc.c:627
 tiocsti drivers/tty/tty_io.c:2290 [inline]
 tty_ioctl+0x909/0x1690 drivers/tty/tty_io.c:2706
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl fs/ioctl.c:583 [inline]
 __x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0x106/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd7d419c819
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffeca659d08 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fd7d4415fa0 RCX: 00007fd7d419c819
RDX: 0000200000000100 RSI: 0000000000005412 RDI: 0000000000000003
RBP: 00007fd7d4232c91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fd7d4415fac R14: 00007fd7d4415fa0 R15: 00007fd7d4415fa0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:h4_recv+0x52/0x1c0 drivers/bluetooth/hci_h4.c:112
Code: df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 3c 01 00 00 4c 8b a3 b8 01 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f 85 31 01 00 00 49 8b 34 24 48 89 ea 41 b9 04 00 00
RSP: 0018:ffffc900037afca8 EFLAGS: 00010246
RAX: dffffc0000000000 RBX: ffff888033b48400 RCX: ffffffff887767b0
RDX: 0000000000000000 RSI: ffffffff8877b6a8 RDI: ffff888033b485b8
RBP: ffffc900037afd68 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000001 R14: ffff888033b484c0 R15: ffffffff8cc1b1c0
FS:  000055556677d500(0000) GS:ffff888124339000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd7d4072140 CR3: 00000000747cb000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	df 48 89             	fisttps -0x77(%rax)
   3:	fa                   	cli
   4:	48 c1 ea 03          	shr    $0x3,%rdx
   8:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   c:	0f 85 3c 01 00 00    	jne    0x14e
  12:	4c 8b a3 b8 01 00 00 	mov    0x1b8(%rbx),%r12
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	4c 89 e2             	mov    %r12,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 31 01 00 00    	jne    0x165
  34:	49 8b 34 24          	mov    (%r12),%rsi
  38:	48 89 ea             	mov    %rbp,%rdx
  3b:	41                   	rex.B
  3c:	b9                   	.byte 0xb9
  3d:	04 00                	add    $0x0,%al


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
