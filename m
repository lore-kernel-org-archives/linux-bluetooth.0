Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 639FAC47082
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 May 2021 07:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AB4E61186
	for <linux-bluetooth@archiver.kernel.org>; Mon, 31 May 2021 07:19:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhEaHVA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 31 May 2021 03:21:00 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:54119 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbhEaHU4 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 31 May 2021 03:20:56 -0400
Received: by mail-io1-f69.google.com with SMTP id u15-20020a6b490f0000b0290447d9583f14so6668535iob.20
        for <linux-bluetooth@vger.kernel.org>; Mon, 31 May 2021 00:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ArOpMdbFDDmKZECmacnd2/wE83IcJjiqARCZQPnaa3A=;
        b=qffMCySN2bHgcFzdurdDsVHqEbjXevkzZDV/cWD+pQDRCddBVS7KVMeuOGLEa3gjWI
         zkDbLPR8jCYf9LPCkpUY92v5PQckNMkVtA3LB01eODsPL5MTa1y4+Ag+mzZfoEcLX5mF
         gQ9YtIz2p2hWPzKJlfc/Yvrk4IgjqcI1ANCAvAD72n3Uc62VbiX7f9pPLcvOVi75SL6S
         GBndj4BSjuP84MzrUCZOhj//Nl6U5z0r4n7FFY+KxqXCwbsYZiDwINm5doOGN3q5JGGO
         dLuOJ5bGUAoocnwPN9V6r9v7ITgN7iX4nDJFNVPenL1MZp25XMYIzdeB4864vYXRLBBz
         c+XQ==
X-Gm-Message-State: AOAM531B2CQymk/dVqspdAJajHOBihZclh+ioW5G2ki4twr8bQcHw3Q1
        YCEjKUlClhrXUzqTjnzI8UPHfXxkl01VgYW9HugWY9AjHzzS
X-Google-Smtp-Source: ABdhPJzEztdJ0o/G3hEuPu3fGtsj6Vswr0Ea06NfZCEV1dhAjKIhKjuRFPOkORDHPIMrp2/d/6pxBrq3IQ63xtm26c+MvOs0S4fg
MIME-Version: 1.0
X-Received: by 2002:a05:6602:29cf:: with SMTP id z15mr16147286ioq.176.1622445557367;
 Mon, 31 May 2021 00:19:17 -0700 (PDT)
Date:   Mon, 31 May 2021 00:19:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001d4a3005c39b0b40@google.com>
Subject: [syzbot] general protection fault in l2cap_chan_timeout (2)
From:   syzbot <syzbot+008cdbf7a9044c2c2f99@syzkaller.appspotmail.com>
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

HEAD commit:    ad9f25d3 Merge tag 'netfs-lib-fixes-20200525' of git://git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=173d383dd00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=266cda122a0b56c
dashboard link: https://syzkaller.appspot.com/bug?extid=008cdbf7a9044c2c2f99

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+008cdbf7a9044c2c2f99@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc000000005a: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x00000000000002d0-0x00000000000002d7]
CPU: 0 PID: 8 Comm: kworker/0:2 Not tainted 5.13.0-rc3-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events l2cap_chan_timeout
RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:941 [inline]
RIP: 0010:__mutex_lock+0xf6/0x10c0 kernel/locking/mutex.c:1104
Code: d0 7c 08 84 d2 0f 85 cc 0c 00 00 8b 15 e3 55 5f 07 85 d2 75 29 48 8d 7d 60 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 db 0e 00 00 48 3b 6d 60 0f 85 5a 0a 00 00 bf 01
RSP: 0018:ffffc90000cd7b78 EFLAGS: 00010216
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 000000000000005a RSI: 0000000000000000 RDI: 00000000000002d0
RBP: 0000000000000270 R08: ffffffff880a40d9 R09: 0000000000000000
R10: ffffffff814b4be0 R11: 0000000000000000 R12: 0000000000000000
R13: dffffc0000000000 R14: ffff888072e47020 R15: ffff8880b9c34a40
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcac15f1d58 CR3: 00000000628fa000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
Call Trace:
 l2cap_chan_timeout+0x69/0x2f0 net/bluetooth/l2cap_core.c:422
 process_one_work+0x98d/0x1600 kernel/workqueue.c:2276
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2422
 kthread+0x3b1/0x4a0 kernel/kthread.c:313
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Modules linked in:
---[ end trace d3dc393d48928266 ]---
RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:941 [inline]
RIP: 0010:__mutex_lock+0xf6/0x10c0 kernel/locking/mutex.c:1104
Code: d0 7c 08 84 d2 0f 85 cc 0c 00 00 8b 15 e3 55 5f 07 85 d2 75 29 48 8d 7d 60 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 db 0e 00 00 48 3b 6d 60 0f 85 5a 0a 00 00 bf 01
RSP: 0018:ffffc90000cd7b78 EFLAGS: 00010216
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 000000000000005a RSI: 0000000000000000 RDI: 00000000000002d0
RBP: 0000000000000270 R08: ffffffff880a40d9 R09: 0000000000000000
R10: ffffffff814b4be0 R11: 0000000000000000 R12: 0000000000000000
R13: dffffc0000000000 R14: ffff888072e47020 R15: ffff8880b9c34a40
FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b33621000 CR3: 00000000628fa000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
