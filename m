Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A19C4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 12:03:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC3F060FC3
	for <linux-bluetooth@archiver.kernel.org>; Tue, 17 Aug 2021 12:03:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239871AbhHQMEC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 17 Aug 2021 08:04:02 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:38829 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239813AbhHQMEA (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 17 Aug 2021 08:04:00 -0400
Received: by mail-io1-f69.google.com with SMTP id g5-20020a05660203c5b02905867ea91fc6so11129550iov.5
        for <linux-bluetooth@vger.kernel.org>; Tue, 17 Aug 2021 05:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=wTF2xTI7fvG7lsoldA2r9rUQ0Wgqa9ZZw5QPGbNw+cY=;
        b=uXeM0B3PC+DKlK1XzSXiE0AaK3PnHeldoqkrdOF0FVAcUjITw6bC6v7Q/XyCz40aVJ
         ep5dSwBplM7e1xWpcSCHqAPZ60XFEDp5E3sTjXE1AoOA7ZDgSVM5oNgx7xwJT4dFJl8O
         QZKZpYoNvj8YEMF6pJ1P5gU/Idi6XhWI2BTIkc4FhvuYokit2RduSvAL1846C/KXUDGg
         vN+HS3lzvyaoHR7mNZGu2ZsNn5D9kRAe4RxNxlm98mqN6xvrPgGDYTL4Og0mD9Q+ArBe
         7gMue7K0C29MwhyAOBiMa1dkkpHnpt7b4n4Dm2sFuskqII6DJEMnpap3TiwBjZCpjZu9
         0eww==
X-Gm-Message-State: AOAM5312U+R0fZ2ET5Ky6f4OgUZfRSkrjo2vAKJeP6LtOiRH4PYzEQ4C
        uPP9qAOZHlNOKpJZlPz0QzyUIv3KdifJvFTTPbRXTHuy4qoV
X-Google-Smtp-Source: ABdhPJw+aEEQchlMQ1rz+6/yFeqAWlm2069r7R3XD7+am+eXUMyZxHD/pxuYcxmHs5+UK/Wo7/n+AI/5KBug+iC+2kYjzjTDMmd/
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:cc3:: with SMTP id c3mr2204223ilj.207.1629201806520;
 Tue, 17 Aug 2021 05:03:26 -0700 (PDT)
Date:   Tue, 17 Aug 2021 05:03:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f1f68705c9c01ab7@google.com>
Subject: [syzbot] INFO: task hung in rfcomm_run
From:   syzbot <syzbot+bd221c9eb2a95e43c20f@syzkaller.appspotmail.com>
To:     davem@davemloft.net, desmondcheongzx@gmail.com,
        johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, luiz.von.dentz@intel.com,
        marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    8ca403f3e7a2 Add linux-next specific files for 20210811
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=12b0745e300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1151ef35b04cc3a
dashboard link: https://syzkaller.appspot.com/bug?extid=bd221c9eb2a95e43c20f
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119f42a1300000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1707e231300000

The issue was bisected to:

commit b7ce436a5d798bc59e71797952566608a4b4626b
Author: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Date:   Tue Aug 10 04:14:09 2021 +0000

    Bluetooth: switch to lock_sock in RFCOMM

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12e68b26300000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11e68b26300000
console output: https://syzkaller.appspot.com/x/log.txt?x=16e68b26300000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bd221c9eb2a95e43c20f@syzkaller.appspotmail.com
Fixes: b7ce436a5d79 ("Bluetooth: switch to lock_sock in RFCOMM")

INFO: task krfcommd:2895 blocked for more than 143 seconds.
      Not tainted 5.14.0-rc5-next-20210811-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:krfcommd        state:D stack:29640 pid: 2895 ppid:     2 flags:0x00004000
Call Trace:
 context_switch kernel/sched/core.c:4698 [inline]
 __schedule+0x93a/0x26f0 kernel/sched/core.c:5955
 schedule+0xd3/0x270 kernel/sched/core.c:6034
 schedule_preempt_disabled+0xf/0x20 kernel/sched/core.c:6093
 __mutex_lock_common kernel/locking/mutex.c:1036 [inline]
 __mutex_lock+0xa46/0x1300 kernel/locking/mutex.c:1096
 rfcomm_process_sessions net/bluetooth/rfcomm/core.c:1979 [inline]
 rfcomm_run+0x2ed/0x4a20 net/bluetooth/rfcomm/core.c:2086
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
INFO: task syz-executor247:6597 blocked for more than 143 seconds.
      Not tainted 5.14.0-rc5-next-20210811-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor247 state:D stack:27600 pid: 6597 ppid:  6565 flags:0x00004006
Call Trace:
 context_switch kernel/sched/core.c:4698 [inline]
 __schedule+0x93a/0x26f0 kernel/sched/core.c:5955
 schedule+0xd3/0x270 kernel/sched/core.c:6034
 __lock_sock+0x13d/0x260 net/core/sock.c:2645
 lock_sock_nested+0xf6/0x120 net/core/sock.c:3178
 lock_sock include/net/sock.h:1612 [inline]
 rfcomm_sk_state_change+0xb4/0x390 net/bluetooth/rfcomm/sock.c:73
 __rfcomm_dlc_close+0x1b6/0x8a0 net/bluetooth/rfcomm/core.c:489
 rfcomm_dlc_close+0x1ea/0x240 net/bluetooth/rfcomm/core.c:520
 __rfcomm_sock_close+0xac/0x260 net/bluetooth/rfcomm/sock.c:220
 rfcomm_sock_shutdown+0xe9/0x210 net/bluetooth/rfcomm/sock.c:931
 rfcomm_sock_release+0x5f/0x140 net/bluetooth/rfcomm/sock.c:951
 __sock_release+0xcd/0x280 net/socket.c:649
 sock_close+0x18/0x20 net/socket.c:1311
 __fput+0x288/0x920 fs/file_table.c:280
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 exit_task_work include/linux/task_work.h:32 [inline]
 do_exit+0xbd4/0x2a60 kernel/exit.c:825
 do_group_exit+0x125/0x310 kernel/exit.c:922
 get_signal+0x47f/0x2160 kernel/signal.c:2831
 arch_do_signal_or_restart+0x2a9/0x1c40 arch/x86/kernel/signal.c:865
 handle_signal_work kernel/entry/common.c:148 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
 exit_to_user_mode_prepare+0x17d/0x290 kernel/entry/common.c:209
 __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:302
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x446009
RSP: 002b:00007ffda734ed78 EFLAGS: 00000246 ORIG_RAX: 000000000000002a
RAX: fffffffffffffffc RBX: 0000000000000003 RCX: 0000000000446009
RDX: 0000000000000080 RSI: 0000000020000000 RDI: 0000000000000004
RBP: 0000000000000003 R08: 000000ff00000001 R09: 000000ff00000001
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000001dee2b8
R13: 0000000000000072 R14: 00007ffda734edd0 R15: 0000000000000003
INFO: lockdep is turned off.
NMI backtrace for cpu 0
CPU: 0 PID: 27 Comm: khungtaskd Not tainted 5.14.0-rc5-next-20210811-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 nmi_cpu_backtrace.cold+0x47/0x144 lib/nmi_backtrace.c:105
 nmi_trigger_cpumask_backtrace+0x1ae/0x220 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:146 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:254 [inline]
 watchdog+0xcb7/0xed0 kernel/hung_task.c:339
 kthread+0x3e5/0x4d0 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1 skipped: idling at native_safe_halt arch/x86/include/asm/irqflags.h:51 [inline]
NMI backtrace for cpu 1 skipped: idling at arch_safe_halt arch/x86/include/asm/irqflags.h:89 [inline]
NMI backtrace for cpu 1 skipped: idling at acpi_safe_halt drivers/acpi/processor_idle.c:109 [inline]
NMI backtrace for cpu 1 skipped: idling at acpi_idle_do_entry+0x1c6/0x250 drivers/acpi/processor_idle.c:553


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
