Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04F82F0C46
	for <linux-bluetooth@vger.kernel.org>; Fri,  2 Oct 2026 05:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790919150; cv=none; b=b/rE8wcqJzeLdbeJCcDEoanuCsZMUog87tRQRIRP3KYRtqPap1knZF+C/tAlVxrwh3v3A7tHnKDU4eAqFurL8NbWAm2850i/qHmVdJSaw9xmEgDnKx/TLIMmo4qH/sO8m5Tx2QS2qIVQO2V8aXCIznklsAvnPM15Haa+UVEybbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790919150; c=relaxed/simple;
	bh=2pSnaHR0dLqqhKvGwe1MH9NgzMKRsufCm8qL9qOs+Ew=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=p+Fwi2gairuq+UcnB6k2dI/1OGhDtzj7mBULDNV9ueDUr12gFSkKbmeIbTj7u+v077ZfiKGU/1f4rDranBZddGsD8n4ey0xI92gaHLZfIvzF3ZsxXwbs7dFHwwkLNJndnyy9Ft4/UE5wF6f2vIdwbUBjrKxVs/TmkVRxMYiJO8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-4db3db8687fso2611447b6e.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 22:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790919148; x=1791523948;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8fhLhuAHVPy61Xa+qU8I+dMZ+S9hoNa+YZFJU+sQNQE=;
        b=jqALezqarYCJhGdbgF/Ry1sfn6yGgtkiGMp3zguSdq2lHINCUQvr+Nuyki+WzFREkQ
         ZuKe8HQUzpc06YKBBXbwlpq7khb2E5lbOhFjNMNZdlTnSVvrmay/xhjOA3gzvqneK2GA
         UnI5RV39BXUfR26So0Vfc3I07We9zZ5a0LvnL2dDWwj74/rWpOH56VXDGxFNbzWwF8+D
         5qEUag/XESXg7xpEjur54dhLSLtP5Jso0WzLldYXPz/OiUcRWlniSdv6nSiFyQkUFxnm
         ktmdKLmpLVit0zS2rlewrCpKSc4ELAVwKGu2yMAopPrRzPNXu25toe3ilqzs81WYCWJ5
         YQ6A==
X-Gm-Message-State: AFuF++lpskeCj1wNHw2scxrB4b1gOezRpOeU9oPUprtMP4QqmRE2reY4
	YGzh6/x4BRBIOwYGqEPg6TDu+tnxwbqgHhOND1pPmZB0ksIXKjnMzuKT0xhv84ThuZnSYqu8LTD
	T1KT4v7sQeXUHLdP6ArsFggaaiFW4gX+M9JPyvQNf1MoqWDzFuPebtMkfCvE=
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:c169:b0:4f4:724e:34d7 with SMTP id
 5614622812f47-4f529c2b58cmr1178960b6e.28.1790919147837; Thu, 01 Oct 2026
 22:32:27 -0700 (PDT)
Date: Thu, 01 Oct 2026 22:32:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6abf41eb.b50370da.302ea9.000a.GAE@google.com>
Subject: [syzbot] [bluetooth?] general protection fault in rfcomm_dev_shutdown
From: syzbot <syzbot+4a807caf7680652d53b6@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    551c722f4080 Merge tag 'rtc-7.3-fixes' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=155ee3f5580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d4242cb1c54cdf7
dashboard link: https://syzkaller.appspot.com/bug?extid=4a807caf7680652d53b6
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3e4fb9949c4f/disk-551c722f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fc47c1d4ab50/vmlinux-551c722f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d29008ae09f9/bzImage-551c722f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4a807caf7680652d53b6@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000008: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000040-0x0000000000000047]
CPU: 1 UID: 0 PID: 9467 Comm: syz.4.1031 Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/16/2026
RIP: 0010:rfcomm_dev_shutdown+0x48/0xb0 net/bluetooth/rfcomm/tty.c:131
Code: 8d b3 e0 03 00 00 4c 89 f0 48 c1 e8 03 42 80 3c 20 00 74 08 4c 89 f7 e8 26 32 48 f7 4d 8b 36 4d 8d 7e 40 4c 89 f8 48 c1 e8 03 <42> 80 3c 20 00 74 08 4c 89 ff e8 09 32 48 f7 49 83 3f 00 74 16 e8
RSP: 0018:ffffc90006937bf0 EFLAGS: 00010212
RAX: 0000000000000008 RBX: ffff8880538c2000 RCX: 0000000000080000
RDX: ffffc9000f182000 RSI: 0000000000000325 RDI: 0000000000000326
RBP: 0000000000000400 R08: ffff8880538c2237 R09: 1ffff1100a718446
R10: dffffc0000000000 R11: ffffffff8aefbc10 R12: dffffc0000000000
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000040
FS:  00007f1514ff66c0(0000) GS:ffff888124dc8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c2cbda1 CR3: 0000000038298000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 tty_port_shutdown+0x1bf/0x220 drivers/tty/tty_port.c:372
 tty_port_close+0x4e/0x150 drivers/tty/tty_port.c:705
 tty_release+0x359/0x1670 drivers/tty/tty_io.c:1718
 __fput+0x418/0xa50 fs/file_table.c:512
 task_work_run+0x1d9/0x270 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:70 [inline]
 exit_to_user_mode_loop+0x204/0x770 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:343 [inline]
 do_syscall_64+0x328/0x520 arch/x86/entry/syscall_64.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1516d9e159
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1514ff6028 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007f1517026090 RCX: 00007f1516d9e159
RDX: 0000000000000000 RSI: ffffffffffffffff RDI: 0000000000000000
RBP: 00007f1516e3506b R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f1517026128 R14: 00007f1517026090 R15: 00007fff99ef4628
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:rfcomm_dev_shutdown+0x48/0xb0 net/bluetooth/rfcomm/tty.c:131
Code: 8d b3 e0 03 00 00 4c 89 f0 48 c1 e8 03 42 80 3c 20 00 74 08 4c 89 f7 e8 26 32 48 f7 4d 8b 36 4d 8d 7e 40 4c 89 f8 48 c1 e8 03 <42> 80 3c 20 00 74 08 4c 89 ff e8 09 32 48 f7 49 83 3f 00 74 16 e8
RSP: 0018:ffffc90006937bf0 EFLAGS: 00010212
RAX: 0000000000000008 RBX: ffff8880538c2000 RCX: 0000000000080000
RDX: ffffc9000f182000 RSI: 0000000000000325 RDI: 0000000000000326
RBP: 0000000000000400 R08: ffff8880538c2237 R09: 1ffff1100a718446
R10: dffffc0000000000 R11: ffffffff8aefbc10 R12: dffffc0000000000
R13: dffffc0000000000 R14: 0000000000000000 R15: 0000000000000040
FS:  00007f1514ff66c0(0000) GS:ffff888124dc8000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f508245e000 CR3: 0000000038298000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess):
   0:	8d b3 e0 03 00 00    	lea    0x3e0(%rbx),%esi
   6:	4c 89 f0             	mov    %r14,%rax
   9:	48 c1 e8 03          	shr    $0x3,%rax
   d:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1)
  12:	74 08                	je     0x1c
  14:	4c 89 f7             	mov    %r14,%rdi
  17:	e8 26 32 48 f7       	call   0xf7483242
  1c:	4d 8b 36             	mov    (%r14),%r14
  1f:	4d 8d 7e 40          	lea    0x40(%r14),%r15
  23:	4c 89 f8             	mov    %r15,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 ff             	mov    %r15,%rdi
  34:	e8 09 32 48 f7       	call   0xf7483242
  39:	49 83 3f 00          	cmpq   $0x0,(%r15)
  3d:	74 16                	je     0x55
  3f:	e8                   	.byte 0xe8


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
