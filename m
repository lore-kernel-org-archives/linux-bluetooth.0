Return-Path: <SRS0=twEk=BP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0C5C433DF
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Aug 2020 06:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FC3C22B40
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Aug 2020 06:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727867AbgHEGRY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Aug 2020 02:17:24 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:49965 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725920AbgHEGRX (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Aug 2020 02:17:23 -0400
Received: by mail-il1-f198.google.com with SMTP id v12so22189784iln.16
        for <linux-bluetooth@vger.kernel.org>; Tue, 04 Aug 2020 23:17:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=6PDC0ZVEJqL6K1HxTwRQQLH2RS/QaggDpUtN9JPJU64=;
        b=G40f4zmKNmsFoqz5tLfqsR3zgPI6J2fN7lsUi7SWZPazz44/jwktg7xXJYRir5dWLh
         LKPIegThEQTuVKk80a8927kFLsj6oiA37dlfZ+XUF9F62xx6XweowYixYTMmfhdJAJoj
         csFUfZShAcx0+b0T7jmnBZ/wdde2afvwkp3dMyMGhCC3BUgbpUR8dolAvb/e7/cYiERz
         AD/Kz+VBebs+Ref7I0zhsMy7gUIEiE2gFbe5rq6F+gEepXpQiZH88OzHPh+ZTKBrW3qe
         KY7xljYcPJEq5Hvl9lSIbSXm9HXjFLKsV4xdlfvGf2xacMZBKZ9H8uDcC36kbPURd+ZQ
         Ea8A==
X-Gm-Message-State: AOAM531AX78DYQBktQp/TfoarI7R8XJTUsq1JeTBue9wQrXVmC2qmGao
        tsANOq5jCM1rb7804zMu4qSX+sDsNaj7gCk90hdG74zYA6Tt
X-Google-Smtp-Source: ABdhPJxAm7AKtMYNvwony85dtePeDXVrt4L3/rrzInP8PLHq8OPLMBeeKIdDJBPgT0guK5HrMi08lmHeMR7qRZ4nh/zIQlGyvqif
MIME-Version: 1.0
X-Received: by 2002:a92:c52e:: with SMTP id m14mr2448392ili.205.1596608242510;
 Tue, 04 Aug 2020 23:17:22 -0700 (PDT)
Date:   Tue, 04 Aug 2020 23:17:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000023efa305ac1b5309@google.com>
Subject: WARNING: refcount bug in l2cap_global_chan_by_psm
From:   syzbot <syzbot+39ad9f042519082fcec9@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c0842fbc random32: move the pseudo-random 32-bit definitio..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=142980c2900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=76cacb0fe58c4a1e
dashboard link: https://syzkaller.appspot.com/bug?extid=39ad9f042519082fcec9
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1100fc58900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13a9d662900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+39ad9f042519082fcec9@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: addition on 0; use-after-free.
WARNING: CPU: 1 PID: 6830 at lib/refcount.c:25 refcount_warn_saturate+0x13d/0x1a0 lib/refcount.c:25
Kernel panic - not syncing: panic_on_warn set ...
CPU: 1 PID: 6830 Comm: kworker/u5:2 Not tainted 5.8.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: hci0 hci_rx_work
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1f0/0x31e lib/dump_stack.c:118
 panic+0x264/0x7a0 kernel/panic.c:231
 __warn+0x227/0x250 kernel/panic.c:600
 report_bug+0x1b1/0x2e0 lib/bug.c:198
 handle_bug+0x42/0x80 arch/x86/kernel/traps.c:235
 exc_invalid_op+0x16/0x40 arch/x86/kernel/traps.c:255
 asm_exc_invalid_op+0x12/0x20 arch/x86/include/asm/idtentry.h:547
RIP: 0010:refcount_warn_saturate+0x13d/0x1a0 lib/refcount.c:25
Code: c7 c3 ca 14 89 31 c0 e8 41 c0 a9 fd 0f 0b eb a3 e8 f8 0a d8 fd c6 05 38 a8 ec 05 01 48 c7 c7 fa ca 14 89 31 c0 e8 23 c0 a9 fd <0f> 0b eb 85 e8 da 0a d8 fd c6 05 1b a8 ec 05 01 48 c7 c7 26 cb 14
RSP: 0018:ffffc90001607a70 EFLAGS: 00010246
RAX: 94a8124281310300 RBX: 0000000000000002 RCX: ffff888092562280
RDX: 0000000000000000 RSI: 0000000080000001 RDI: 0000000000000000
RBP: 0000000000000002 R08: ffffffff815e07c9 R09: ffffed1015d262c0
R10: ffffed1015d262c0 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000000 R14: ffff8880a948e018 R15: 0000000000000001
 refcount_add include/linux/refcount.h:206 [inline]
 refcount_inc include/linux/refcount.h:241 [inline]
 kref_get include/linux/kref.h:45 [inline]
 l2cap_chan_hold net/bluetooth/l2cap_core.c:495 [inline]
 l2cap_global_chan_by_psm+0x4aa/0x4e0 net/bluetooth/l2cap_core.c:1978
 l2cap_conless_channel net/bluetooth/l2cap_core.c:7596 [inline]
 l2cap_recv_frame+0x530/0x8f10 net/bluetooth/l2cap_core.c:7666
 hci_acldata_packet net/bluetooth/hci_core.c:4520 [inline]
 hci_rx_work+0x7d7/0x9c0 net/bluetooth/hci_core.c:4710
 process_one_work+0x789/0xfc0 kernel/workqueue.c:2269
 worker_thread+0xaa4/0x1460 kernel/workqueue.c:2415
 kthread+0x37e/0x3a0 drivers/block/aoe/aoecmd.c:1234
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
Kernel Offset: disabled
Rebooting in 86400 seconds..


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
