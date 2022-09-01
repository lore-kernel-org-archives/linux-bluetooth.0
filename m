Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90DAEC64991
	for <linux-bluetooth@archiver.kernel.org>; Thu,  1 Sep 2022 08:59:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbiIAI7Y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 1 Sep 2022 04:59:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234275AbiIAI64 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 1 Sep 2022 04:58:56 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBF0130A1A
        for <linux-bluetooth@vger.kernel.org>; Thu,  1 Sep 2022 01:58:25 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id q10-20020a0566022f0a00b00688d703717bso10278301iow.9
        for <linux-bluetooth@vger.kernel.org>; Thu, 01 Sep 2022 01:58:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=OWc08Czh542+n2j7Jr99E99uAYpH5Cu42kPDNtF9Coo=;
        b=O3cfXp0vySHnag2jVMfJBBRflGF1PiKFgvn8F3pl6DulGT9R6eqv1WEaLg+ElEYfWh
         V/k9EOvtH7Gz5suE1hBoznTBvcasB9wCljaBauWspuXpQJhnsIbtNHraY67XaY/b08Fs
         D0tli1kNlWcnsh33sfSjSpyN5Ye0DDw03mEezhM1SCS0B4Q/I6Qjo8iz2BgWKH8UgHYC
         9bX12C911ZzJjsWlILNWJkgXSsfmiGtVGukAYA81i0Rhz4SDcRxkBe2G5lG9XBnBc/9L
         8alXECmi9WjxjUUndKT8m2EyhdOjksroTVvEgG54p8I+flG65L5hbt6DQ5iH8y6itC4H
         4cyw==
X-Gm-Message-State: ACgBeo3sIHeeuiw42Op/ylu9nf+kSwsqBPJ+B/nkFqRF4+Zp/GDW3Paz
        oCBW2VMupu58IymVS3rZ04tjaABvxyRPEdl2CcDZ3uM4imyX
X-Google-Smtp-Source: AA6agR4Qaz3Rzpj8GH4d6W/7aDjLYxNQ7esTtqevTh9xSsx0uWhx3rAtJTM3t1pKLBonmIM4tJO2G1DhrlaeNObzw0zP1ez2APrs
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1614:b0:689:d670:be5b with SMTP id
 x20-20020a056602161400b00689d670be5bmr14058432iow.126.1662022705305; Thu, 01
 Sep 2022 01:58:25 -0700 (PDT)
Date:   Thu, 01 Sep 2022 01:58:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f5622905e799d02f@google.com>
Subject: [syzbot] WARNING: ODEBUG bug in hci_dev_close_sync (2)
From:   syzbot <syzbot+e6fb0b74cd2dab0c42ec@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, johan.hedberg@gmail.com,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    e022620b5d05 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13841183080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=312be25752c7fe30
dashboard link: https://syzkaller.appspot.com/bug?extid=e6fb0b74cd2dab0c42ec
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e6fb0b74cd2dab0c42ec@syzkaller.appspotmail.com

Bluetooth: hci1: hardware error 0x00
------------[ cut here ]------------
ODEBUG: assert_init not available (active state 0) object type: timer_list hint: 0x0
WARNING: CPU: 2 PID: 3720 at lib/debugobjects.c:502 debug_print_object+0x16e/0x250 lib/debugobjects.c:502
Modules linked in:
CPU: 2 PID: 3720 Comm: kworker/u19:8 Not tainted 6.0.0-rc2-syzkaller-00248-ge022620b5d05 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Workqueue: hci1 hci_error_reset
RIP: 0010:debug_print_object+0x16e/0x250 lib/debugobjects.c:502
Code: ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 af 00 00 00 48 8b 14 dd 60 f3 48 8a 4c 89 ee 48 c7 c7 00 e7 48 8a e8 9f 21 39 05 <0f> 0b 83 05 35 43 dd 09 01 48 83 c4 18 5b 5d 41 5c 41 5d 41 5e c3
RSP: 0018:ffffc900030af920 EFLAGS: 00010086
RAX: 0000000000000000 RBX: 0000000000000005 RCX: 0000000000000000
RDX: ffff8880767d6200 RSI: ffffffff81611ee8 RDI: fffff52000615f16
RBP: 0000000000000001 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000080000000 R11: 0000000000000000 R12: ffffffff89eeec60
R13: ffffffff8a48edc0 R14: ffffffff816a50a0 R15: 1ffff92000615f2f
FS:  0000000000000000(0000) GS:ffff88802ca00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020170000 CR3: 0000000049298000 CR4: 0000000000152ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 debug_object_assert_init lib/debugobjects.c:892 [inline]
 debug_object_assert_init+0x1f4/0x2e0 lib/debugobjects.c:863
 debug_timer_assert_init kernel/time/timer.c:792 [inline]
 debug_assert_init kernel/time/timer.c:837 [inline]
 del_timer+0x6d/0x110 kernel/time/timer.c:1257
 try_to_grab_pending+0x6d/0xd0 kernel/workqueue.c:1275
 __cancel_work_timer+0xa6/0x570 kernel/workqueue.c:3121
 hci_dev_close_sync+0xc37/0x1130 net/bluetooth/hci_sync.c:4452
 hci_dev_do_close+0x2d/0x70 net/bluetooth/hci_core.c:554
 hci_error_reset+0x96/0x130 net/bluetooth/hci_core.c:1050
 process_one_work+0x991/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e4/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
