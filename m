Received: from mail-oi1-f206.google.com (mail-oi1-f206.google.com [209.85.167.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B048130F819
	for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 23:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784591790; cv=none; b=qpkKMn3GW2UoElH/TxD1Gvg0FnZGEJlSY0SWSp7ucQP4iKhJM+yVUC/5bHE4Cs8oiSNRGXXM9RoquDSU8bsn2vWHAQY4rkI5NyNRABkLd4gRhH7l4b20n7Ev8XYIEpknUEFsSZPFYmor9Uwb6lEecfS+wHVFxLsfbNL3KgvfMDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784591790; c=relaxed/simple;
	bh=tacwk512JYcKF+5dkygCidvXwNApZeyqPObupf06z1Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JbR4LtbdXITPZvjfCYpNplh1AnEwayA3rJOP8VDQD8okYxqmlockZYm50QSVuYKgAn/3+rQ2x+UwfxcCQQ71s+b8zG+GkDza7QhpNoRa7bHLm5UM09tpsQ8fWIJiM6Et3q8qfpBE6lmLbYTMia4N8pmNB6dnRLmjLzGzimNMMks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f206.google.com with SMTP id 5614622812f47-49ce04870f8so17607066b6e.0
        for <linux-bluetooth@vger.kernel.org>; Mon, 20 Jul 2026 16:56:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784591787; x=1785196587;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U9wHbMHhd8AwxKX5crEIW9yPD+RhBzkSrhsrdb8HbHw=;
        b=SCJGQNOFxctQKd781YysY60ECgvZrkPzq0hFbBauVSYjfmJJggliyrFy1DhogZ1nSQ
         ZXLWS3ygspMUJ0aLU7oPvr9Bf9vIko4RaZww4Uayo4R/Y82MCP0qsI8l0nVCmpaGXgHf
         FpiIw7cqff3TCqBq3VboNAWUjayhenWu6mn5EerzzDrtC7u6ANNbMlehqm9GQEwiUaAk
         WU8PX1nqRxVMETmp9HWJTrcHQQOHg+TUcy4ETEQkAC4IaqW0dymj67WfUaiT+mXB7sR0
         EhkBlpAqEweatxPAD1tabI6st1IGmfUwq/F+9EUIf9DMRc5tL2TPzGNfr2EiGzliiudP
         BU3g==
X-Gm-Message-State: AOJu0YzehI9cNjVMnti9rv537SymDzLrAMpPH74oAIjfeP7HJDVIPgK5
	2D6XOa+nQtqD1GN8dlbVFCU1F9dddEIHMKBeAlpSgeq4bfq6wqi7tMvevysy8xyGSF4jtSxaEpx
	DuBHcXPv/Ka3rn6Fc2+bADuq1tYU1QEIEl6Qc+8U4+g6gwM4GmRNoyx9Zti4Xzw==
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3448:b0:4a4:c12:ee68 with SMTP id
 5614622812f47-4a4d01bb487mr8882354b6e.10.1784591787533; Mon, 20 Jul 2026
 16:56:27 -0700 (PDT)
Date: Mon, 20 Jul 2026 16:56:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a5eb5ab.42649fcc.6186.008b.GAE@google.com>
Subject: [syzbot] [bluetooth?] KASAN: null-ptr-deref Read in l2cap_chan_hold_unless_zero
From: syzbot <syzbot+e6382a2f53f5fc7453ac@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e22254e9ddd8 Merge tag 'xfs-fixes-7.2-rc4' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13d46789580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=48ef5c5c0f192153
dashboard link: https://syzkaller.appspot.com/bug?extid=e6382a2f53f5fc7453ac
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17b434b9580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17d46789580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-e22254e9.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c69a30d7d78f/vmlinux-e22254e9.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f15a346cc7e1/bzImage-e22254e9.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e6382a2f53f5fc7453ac@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: null-ptr-deref in instrument_atomic_read include/linux/instrumented.h:82 [inline]
BUG: KASAN: null-ptr-deref in atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
BUG: KASAN: null-ptr-deref in refcount_read include/linux/refcount.h:170 [inline]
BUG: KASAN: null-ptr-deref in __refcount_add_not_zero include/linux/refcount.h:176 [inline]
BUG: KASAN: null-ptr-deref in __refcount_inc_not_zero include/linux/refcount.h:317 [inline]
BUG: KASAN: null-ptr-deref in refcount_inc_not_zero include/linux/refcount.h:335 [inline]
BUG: KASAN: null-ptr-deref in kref_get_unless_zero include/linux/kref.h:133 [inline]
BUG: KASAN: null-ptr-deref in l2cap_chan_hold_unless_zero+0x80/0x290 net/bluetooth/l2cap_core.c:511
Read of size 4 at addr 0000000000000008 by task syz.0.158/6397

CPU: 2 UID: 0 PID: 6397 Comm: syz.0.158 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 kasan_report+0xdf/0x1c0 mm/kasan/report.c:595
 check_region_inline mm/kasan/generic.c:186 [inline]
 kasan_check_range+0x10f/0x1e0 mm/kasan/generic.c:200
 instrument_atomic_read include/linux/instrumented.h:82 [inline]
 atomic_read include/linux/atomic/atomic-instrumented.h:32 [inline]
 refcount_read include/linux/refcount.h:170 [inline]
 __refcount_add_not_zero include/linux/refcount.h:176 [inline]
 __refcount_inc_not_zero include/linux/refcount.h:317 [inline]
 refcount_inc_not_zero include/linux/refcount.h:335 [inline]
 kref_get_unless_zero include/linux/kref.h:133 [inline]
 l2cap_chan_hold_unless_zero+0x80/0x290 net/bluetooth/l2cap_core.c:511
 l2cap_sock_cleanup_listen+0x8a/0x4d0 net/bluetooth/l2cap_sock.c:1535
 l2cap_sock_release+0x69/0x280 net/bluetooth/l2cap_sock.c:1480
 __sock_release+0xb3/0x260 net/socket.c:710
 sock_close+0x1c/0x30 net/socket.c:1501
 __fput+0x3ff/0xb50 fs/file_table.c:512
 task_work_run+0x150/0x240 kernel/task_work.c:233
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 __exit_to_user_mode_loop kernel/entry/common.c:70 [inline]
 exit_to_user_mode_loop+0x1d8/0x6f0 kernel/entry/common.c:101
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:207 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:230 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:318 [inline]
 do_syscall_64+0x666/0x870 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3758d9de99
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff659f88f8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007f3759027da0 RCX: 00007f3758d9de99
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f3759027da0 R08: 0000000000000006 R09: 0000000000000000
R10: 00007f3759027cb0 R11: 0000000000000246 R12: 0000000000046482
R13: 00007f375902609c R14: 00000000000461ac R15: 00007f3759026090
 </TASK>
==================================================================


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
