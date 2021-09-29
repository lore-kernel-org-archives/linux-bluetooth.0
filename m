Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4954DC433FE
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 11:36:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C81561409
	for <linux-bluetooth@archiver.kernel.org>; Wed, 29 Sep 2021 11:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245703AbhI2LiL (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 29 Sep 2021 07:38:11 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:48894 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245603AbhI2LiI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 29 Sep 2021 07:38:08 -0400
Received: by mail-io1-f71.google.com with SMTP id m19-20020a6bea13000000b005d751644a6eso2660947ioc.15
        for <linux-bluetooth@vger.kernel.org>; Wed, 29 Sep 2021 04:36:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=PKgKN2Eqt15tt78hRikEq7x2wz37kMe0a24grKmsqGc=;
        b=nbYO+DagMh6NNrcJYp+OyLP2eXbj4O3McHb+KLXeQH6IdOcwhWbFCOO+CBFTyL+toe
         /w0ZOuVwPfsVqE4W6maVG7MxjbFVF3y0rdzBdyCEs9iaE5x8RGzWrdmiN524a8/VsBWK
         1/WJy4b5hKa1TUqALsjqDA8OQ591sZtMYlrNHI5/fa1doXlc7u5c1sh6wi13X8sWWVo/
         yGOkksjGLbA55nPKUzJ9AoVuw2c9orPA3hqc1QHJQqX5xi2XvnO43W+ad0J5lipyDndM
         8Dn0Lefcc+Pq/2MKMxQYI1yhhfnpcidAZ12K2Yotj3UajzMRbxvsMzT9+P2oZ2coc4WM
         YAdA==
X-Gm-Message-State: AOAM532z8/cKyRGH+j5M7jyxVXh1ii8x4/5xQ/CQR6bRAFrWqEj3CiWH
        b+flecPPYbWe20bv2fZufJuPu2N58TEZ3M8xMKjjJkNH82tU
X-Google-Smtp-Source: ABdhPJwJZigqwhPrbwsTToPjubhdPdxpYMZTeDtSJkWxb2Ekxj2J+XcE+Cr4RKu+5qdgekb7ei8zIS8k853GY5rphaRCykV2j6gw
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1709:: with SMTP id u9mr7696896ill.202.1632915387399;
 Wed, 29 Sep 2021 04:36:27 -0700 (PDT)
Date:   Wed, 29 Sep 2021 04:36:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009d466d05cd20bdbe@google.com>
Subject: [syzbot] INFO: trying to register non-static key in sco_conn_del
From:   syzbot <syzbot+44e9ca14eedcbe453eca@syzkaller.appspotmail.com>
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

HEAD commit:    7d42e9818258 Merge tag 'gpio-fixes-for-v5.15-rc3' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=107c5ff7300000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e917f3dfc452c977
dashboard link: https://syzkaller.appspot.com/bug?extid=44e9ca14eedcbe453eca
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+44e9ca14eedcbe453eca@syzkaller.appspotmail.com

INFO: trying to register non-static key.
The code is fine but needs lockdep annotation, or maybe
you didn't initialize this object before use?
turning off the locking correctness validator.
CPU: 1 PID: 23193 Comm: syz-executor.2 Not tainted 5.15.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:106
 assign_lock_key kernel/locking/lockdep.c:939 [inline]
 register_lock_class+0xf79/0x10c0 kernel/locking/lockdep.c:1251
 __lock_acquire+0x105/0x54a0 kernel/locking/lockdep.c:4894
 lock_acquire kernel/locking/lockdep.c:5625 [inline]
 lock_acquire+0x1ab/0x510 kernel/locking/lockdep.c:5590
 lock_sock_nested+0x2f/0xf0 net/core/sock.c:3183
 lock_sock include/net/sock.h:1612 [inline]
 sco_conn_del+0x12a/0x2b0 net/bluetooth/sco.c:194
 sco_disconn_cfm+0x71/0xb0 net/bluetooth/sco.c:1205
 hci_disconn_cfm include/net/bluetooth/hci_core.h:1518 [inline]
 hci_conn_hash_flush+0x127/0x260 net/bluetooth/hci_conn.c:1608
 hci_dev_do_close+0x57d/0x1130 net/bluetooth/hci_core.c:1793
 hci_unregister_dev+0x1c0/0x5a0 net/bluetooth/hci_core.c:4029
 vhci_release+0x70/0xe0 drivers/bluetooth/hci_vhci.c:340
 __fput+0x288/0x9f0 fs/file_table.c:280
 task_work_run+0xdd/0x1a0 kernel/task_work.c:164
 exit_task_work include/linux/task_work.h:32 [inline]
 do_exit+0xbae/0x2a30 kernel/exit.c:825
 do_group_exit+0x125/0x310 kernel/exit.c:922
 get_signal+0x47f/0x2160 kernel/signal.c:2868
 arch_do_signal_or_restart+0x2a9/0x1c40 arch/x86/kernel/signal.c:865
 handle_signal_work kernel/entry/common.c:148 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
 exit_to_user_mode_prepare+0x17d/0x290 kernel/entry/common.c:207
 __syscall_exit_to_user_mode_work kernel/entry/common.c:289 [inline]
 syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:300
 do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f51377a1709
Code: Unable to access opcode bytes at RIP 0x7f51377a16df.
RSP: 002b:00007f5134d18218 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007f51378a5f68 RCX: 00007f51377a1709
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f51378a5f68
RBP: 00007f51378a5f60 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f51378a5f6c
R13: 00007fffbbb2087f R14: 00007f5134d18300 R15: 0000000000022000


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
