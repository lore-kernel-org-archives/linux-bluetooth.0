Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D6C4C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sat, 12 Feb 2022 09:25:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233015AbiBLJZX (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 12 Feb 2022 04:25:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbiBLJZW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 12 Feb 2022 04:25:22 -0500
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5F82656E
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Feb 2022 01:25:20 -0800 (PST)
Received: by mail-il1-f199.google.com with SMTP id g14-20020a056e021e0e00b002a26cb56bd4so7496852ila.14
        for <linux-bluetooth@vger.kernel.org>; Sat, 12 Feb 2022 01:25:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ZtL5i1t9klk+YLV1HnkewFTh9taQxRMyB5UUQJAQ2zM=;
        b=Te2afLXfUifDHlANlh9rPDtYpgZgKuahpxfo6K8gX0fkkg0X1ZeqttlKNnCZfE+OBS
         0jILUZa6/iU2VvZX+tOvgNNcj6LNlDA2QdP8N9HQphGLbhw2T3p1s/lgN02VBcbf/fbK
         N3aQvHcVq+sdmALjNJeXlSDt52tTRMZ3PSyQJrt+ZJ5BfL0XKUh3zcWlkYjzNDKahJII
         oXGhVPEbAqq1wgUeg4BF3ogAHTAF6QTj+Wj6pwR1/LHANOp4ggvUdJfQQ9ifHVZmHegZ
         uQF/IUlL/3iCIvbjvUQUULIfstM4nAfCDwlLejPXey1ng2e56pCWHtTfAok3oJywNrCu
         GIgA==
X-Gm-Message-State: AOAM530ZP73fUpoLL1HsizMDhKXg3ijxr+Jo7vl6LGdSjH9skNlptcvx
        lSUC0H2k7225IuhQGG+BOLbywK0xmVF3xVHhirOh+XJEoeyM
X-Google-Smtp-Source: ABdhPJx8ow+/awsXjC1xOnCUNufZuulCq8reGoQuVmsW8S+jHNRrZXiNyWPyUuWPW8OEUsUcJ4vvBdL9aXl0aE6yVyAtlHnpvlBw
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a46:: with SMTP id u6mr2938187ilv.245.1644657919465;
 Sat, 12 Feb 2022 01:25:19 -0800 (PST)
Date:   Sat, 12 Feb 2022 01:25:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000111f7f05d7cec3bd@google.com>
Subject: [syzbot] WARNING: ODEBUG bug in hci_dev_close_sync
From:   syzbot <syzbot+45bff639f729e5f15653@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.dentz@gmail.com, marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    555f3d7be91a Merge tag '5.17-rc3-ksmbd-server-fixes' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16e61b78700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5707221760c00a20
dashboard link: https://syzkaller.appspot.com/bug?extid=45bff639f729e5f15653
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+45bff639f729e5f15653@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: assert_init not available (active state 0) object type: timer_list hint: 0x0
WARNING: CPU: 1 PID: 15929 at lib/debugobjects.c:505 debug_print_object+0x16e/0x250 lib/debugobjects.c:505
Modules linked in:
CPU: 1 PID: 15929 Comm: syz-executor.5 Not tainted 5.17.0-rc3-syzkaller-00020-g555f3d7be91a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:debug_print_object+0x16e/0x250 lib/debugobjects.c:505
Code: ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 af 00 00 00 48 8b 14 dd 40 d4 05 8a 4c 89 ee 48 c7 c7 40 c8 05 8a e8 a4 34 24 05 <0f> 0b 83 05 35 4a b1 09 01 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e c3
RSP: 0018:ffffc90002c37938 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 0000000000000000
RDX: ffff88805689c200 RSI: ffffffff815ee378 RDI: fffff52000586f19
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff815e80de R11: 0000000000000000 R12: ffffffff89ae3aa0
R13: ffffffff8a05cec0 R14: ffffffff81660040 R15: 1ffff92000586f32
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 000000005c7e8000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 debug_object_assert_init lib/debugobjects.c:895 [inline]
 debug_object_assert_init+0x1f4/0x2e0 lib/debugobjects.c:866
 debug_timer_assert_init kernel/time/timer.c:739 [inline]
 debug_assert_init kernel/time/timer.c:784 [inline]
 del_timer+0x6d/0x110 kernel/time/timer.c:1204
 try_to_grab_pending+0x6d/0xd0 kernel/workqueue.c:1285
 __cancel_work_timer+0xa6/0x570 kernel/workqueue.c:3139
 hci_dev_close_sync+0xb01/0x1120 net/bluetooth/hci_sync.c:4084
 hci_dev_do_close+0x32/0x70 net/bluetooth/hci_core.c:553
 hci_unregister_dev+0x1d0/0x550 net/bluetooth/hci_core.c:2686
 vhci_release+0x7c/0xf0 drivers/bluetooth/hci_vhci.c:568
 __fput+0x286/0x9f0 fs/file_table.c:311
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 exit_task_work include/linux/task_work.h:32 [inline]
 do_exit+0xb29/0x2a30 kernel/exit.c:806
 do_group_exit+0xd2/0x2f0 kernel/exit.c:935
 __do_sys_exit_group kernel/exit.c:946 [inline]
 __se_sys_exit_group kernel/exit.c:944 [inline]
 __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:944
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7fe461979059
Code: Unable to access opcode bytes at RIP 0x7fe46197902f.
RSP: 002b:00007ffe7d025b08 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000064 RCX: 00007fe461979059
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 00007fe4619d225c R08: 000000000000000c R09: 000055555596c3b8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000016
R13: 00007ffe7d026de0 R14: 000055555596c3b8 R15: 00007ffe7d027ee0
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
