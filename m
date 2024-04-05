Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40BC286BF
	for <linux-bluetooth@vger.kernel.org>; Fri,  5 Apr 2024 06:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712300127; cv=none; b=UJ/JaidILDcbmgAhl7XhhAT4FaK+V93n7MuoB0ALvx0IdpKDtu8SAYRaidkMUjUPVytCWLqrYYlwvDK0mp0Fc0XlzVeH4DCfg2Sni9A/hGjBcKyyWvovK6jmqq1e/+IJK+HSrc9AamILZpDyAubkd6kDxuMOCJAa3lwaT5bST4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712300127; c=relaxed/simple;
	bh=XOc0GZE6xSbBj3uMgtiG/IOXJO210bdlW1/wtND0An8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=WVcTHb1jXyn58RREdshh6as8w+ghEVMFJFn36C5yw6Dl4lckovUv5lnSI6lPSZ2W8K1tHfBftmAU39nER1xkOtdYUYMcILecPhk7Z+smtSFKu6gfxqNYE/qIhc29mBB5c8Pi1+z5YOIJI/+cgZBzuPhqCX3AznJFLHW3eTDm+ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cbf0ebfda8so182866939f.0
        for <linux-bluetooth@vger.kernel.org>; Thu, 04 Apr 2024 23:55:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712300125; x=1712904925;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=khkEduHW43nTegnqZNUcsWmoRA68GOeB0hjhS93+MRM=;
        b=ejjdoxde33hCa1rpzjL6R2gR6CzAZU4gurMp61rS2jtVMpd9mtnoz6BrE80JfEyqPU
         9sptgT8JoALEdfR8vJldNASie939K88BLQlxsCmyz814H6EnZNuHno//BWLPZ48Jwycc
         oR1An0z9tZ3r90TNywHBrb4L4fsZS/WPLhM2YwRRIp0bAAMBKz4zHVzxKFuZiQAvKyYL
         fkjMjAtwfkp8k+NjTTAGwUXFG3ad12BEgN/+EU5uJs0tQ4UBAkjB9QM8BZm+x1qEaa0H
         A1W+xHfKBcZ4nSO7dYOujBKOXmB3ONn3yrI5ZrWA1krBuJgLLlAmpSfxMA6dW++dTuMY
         BMKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgK9jvOa0bsea8IaESS8ZyN6OtuCRorW8y5lPwfpa2FYkAeSleFLxKfpNUvLuql4Dz3ucISCJwLiPl2K+EF0c9jYCZ7BNCaONUQsphsyu2
X-Gm-Message-State: AOJu0YwxHhVkLrGphAjvncM6KQYlaSrQUg+55AZfwNiIPkk2N7nPgVaE
	Ug71vSHK429uszyAw3taRiFRDHHP2l8gJsA8QxMSn4wXCk3grhg3o0FIC3lBsIP0lFf9ORFobnF
	0oqGE3jpIe1gW1P14a6fn6RwYggtR7qnrWvLWqroFu8RJ/iR1ACQBJdU=
X-Google-Smtp-Source: AGHT+IFUTL+AW/fa/iqHhrhzDp74hPpE61jgKmly9P+dYG/s0T5RWhkkQ+w7PtjsvuD+UxEIC/wUQFyQHxh1d6YLBgGH2T2xmKL2
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d95:b0:7d0:3aa9:94db with SMTP id
 k21-20020a0566022d9500b007d03aa994dbmr34215iow.3.1712300125093; Thu, 04 Apr
 2024 23:55:25 -0700 (PDT)
Date: Thu, 04 Apr 2024 23:55:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b48cb0061553f087@google.com>
Subject: [syzbot] [bluetooth?] KASAN: slab-out-of-bounds Read in l2cap_sock_setsockopt
From: syzbot <syzbot+8a1d152fba6b41f760ae@syzkaller.appspotmail.com>
To: johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    707081b61156 Merge branch 'for-next/core', remote-tracking..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=14a081d3180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=caeac3f3565b057a
dashboard link: https://syzkaller.appspot.com/bug?extid=8a1d152fba6b41f760ae
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a2a955180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c6098d180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6cad68bf7532/disk-707081b6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1a27e5400778/vmlinux-707081b6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/67dfc53755d0/Image-707081b6.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8a1d152fba6b41f760ae@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: slab-out-of-bounds in copy_from_sockptr_offset include/linux/sockptr.h:49 [inline]
BUG: KASAN: slab-out-of-bounds in copy_from_sockptr include/linux/sockptr.h:55 [inline]
BUG: KASAN: slab-out-of-bounds in l2cap_sock_setsockopt+0x2070/0x2934 net/bluetooth/l2cap_sock.c:962
Read of size 4 at addr ffff0000cbfa73c3 by task syz-executor258/6168

CPU: 1 PID: 6168 Comm: syz-executor258 Not tainted 6.8.0-rc7-syzkaller-g707081b61156 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:291
 show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:298
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x178/0x518 mm/kasan/report.c:488
 kasan_report+0xd8/0x138 mm/kasan/report.c:601
 __asan_report_load_n_noabort+0x1c/0x28 mm/kasan/report_generic.c:391
 copy_from_sockptr_offset include/linux/sockptr.h:49 [inline]
 copy_from_sockptr include/linux/sockptr.h:55 [inline]
 l2cap_sock_setsockopt+0x2070/0x2934 net/bluetooth/l2cap_sock.c:962
 do_sock_setsockopt+0x2a0/0x4e0 net/socket.c:2311
 __sys_setsockopt+0x128/0x1a8 net/socket.c:2334
 __do_sys_setsockopt net/socket.c:2343 [inline]
 __se_sys_setsockopt net/socket.c:2340 [inline]
 __arm64_sys_setsockopt+0xb8/0xd4 net/socket.c:2340
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

Allocated by task 6168:
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x40/0x78 mm/kasan/common.c:68
 kasan_save_alloc_info+0x40/0x50 mm/kasan/generic.c:575
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0xac/0xc4 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __do_kmalloc_node mm/slub.c:3981 [inline]
 __kmalloc+0x2bc/0x5d4 mm/slub.c:3994
 kmalloc include/linux/slab.h:594 [inline]
 __cgroup_bpf_run_filter_setsockopt+0xa94/0xd1c kernel/bpf/cgroup.c:1872
 do_sock_setsockopt+0x498/0x4e0 net/socket.c:2293
 __sys_setsockopt+0x128/0x1a8 net/socket.c:2334
 __do_sys_setsockopt net/socket.c:2343 [inline]
 __se_sys_setsockopt net/socket.c:2340 [inline]
 __arm64_sys_setsockopt+0xb8/0xd4 net/socket.c:2340
 __invoke_syscall arch/arm64/kernel/syscall.c:34 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:48
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:133
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:152
 el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

The buggy address belongs to the object at ffff0000cbfa73c0
 which belongs to the cache kmalloc-8 of size 8
The buggy address is located 1 bytes to the right of
 allocated 2-byte region [ffff0000cbfa73c0, ffff0000cbfa73c2)

The buggy address belongs to the physical page:
page:00000000512b024c refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x10bfa7
anon flags: 0x5ffc00000000800(slab|node=0|zone=2|lastcpupid=0x7ff)
page_type: 0xffffffff()
raw: 05ffc00000000800 ffff0000c0001280 0000000000000000 dead000000000001
raw: 0000000000000000 0000000080800080 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
 ffff0000cbfa7280: 05 fc fc fc 00 fc fc fc 00 fc fc fc 00 fc fc fc
 ffff0000cbfa7300: 05 fc fc fc 05 fc fc fc 05 fc fc fc fa fc fc fc
>ffff0000cbfa7380: fa fc fc fc 00 fc fc fc 02 fc fc fc 05 fc fc fc
                                           ^
 ffff0000cbfa7400: 00 fc fc fc 00 fc fc fc 00 fc fc fc 05 fc fc fc
 ffff0000cbfa7480: 05 fc fc fc 05 fc fc fc 05 fc fc fc fa fc fc fc
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
