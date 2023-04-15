Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C939C77B71
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Apr 2023 11:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjDOLyp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 15 Apr 2023 07:54:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229853AbjDOLyo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 15 Apr 2023 07:54:44 -0400
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 050EA4C26
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Apr 2023 04:54:43 -0700 (PDT)
Received: by mail-il1-f206.google.com with SMTP id e2-20020a056e0204a200b0032a995cacf5so1639908ils.21
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Apr 2023 04:54:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681559682; x=1684151682;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gw1ZDETNNEoLC8bozAtBwMlkLf8dC7i6XTm43c0ZuwI=;
        b=UEifUnI795TVChafcg5nBGAXyeMpxuOu5Ua3q+9Mm/BFNFsp7LwWFdzS6LzNfqHhvL
         ZOELqpmWvTWet/YLlPjvwLRRvg6dT7UXxTB2ogqrks0lWy8OH7D+GLSt4MZ9FM6/qOyV
         XKXRY11R+HwmCe3WOMBIsnLCrXl+p38gEQMWGhw75QJc3bol3CKUWlZMTAQKm/EpPcW5
         2AZi4hWywl8SFjv7H6+fiLyDBY5BZP3rIGnHaQDIQdMtBDDIdq89PWEvja6sGrYMNom2
         LP0diT40aTqeZ8wKJYP8tZLCjxluNkMLy8Agk2HUKUzWjzrakobmaO0eIAxtNY/073qJ
         hjKw==
X-Gm-Message-State: AAQBX9fBwt/A0QQ6GI3wS6/p38i2IXaPWrofalT82Sd68WWag3YR8saY
        n3pFQ7XsQ4wQpPepH2PEfDsra7EsNLoWjFmjYRafG2U//epz
X-Google-Smtp-Source: AKy350bDbTzx/11Az3isJV5odN7J+8AgnBvwtk/Sc0eb8+pAxMc9dIycTpADWvO2W6g1M//8RdgkPIPHaMJqWi4rLvOLO07tCA7f
MIME-Version: 1.0
X-Received: by 2002:a02:856f:0:b0:40b:c412:70a9 with SMTP id
 g102-20020a02856f000000b0040bc41270a9mr3337698jai.4.1681559682368; Sat, 15
 Apr 2023 04:54:42 -0700 (PDT)
Date:   Sat, 15 Apr 2023 04:54:42 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000894f5f05f95e9f4d@google.com>
Subject: [syzbot] [bluetooth?] WARNING: bad unlock balance in l2cap_recv_frame
From:   syzbot <syzbot+9519d6b5b79cf7787cf3@syzkaller.appspotmail.com>
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

HEAD commit:    95abc817ab3a Merge tag 'acpi-6.3-rc7' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13c85123c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c21559e740385326
dashboard link: https://syzkaller.appspot.com/bug?extid=9519d6b5b79cf7787cf3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/87e400f90ed9/disk-95abc817.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cf7aa6546e50/vmlinux-95abc817.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a44d83ac79a7/bzImage-95abc817.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9519d6b5b79cf7787cf3@syzkaller.appspotmail.com

=====================================
WARNING: bad unlock balance detected!
6.3.0-rc6-syzkaller-00168-g95abc817ab3a #0 Not tainted
-------------------------------------
kworker/u5:7/5124 is trying to release lock (&conn->chan_lock) at:
[<ffffffff89148e14>] l2cap_disconnect_rsp net/bluetooth/l2cap_core.c:4697 [inline]
[<ffffffff89148e14>] l2cap_le_sig_cmd net/bluetooth/l2cap_core.c:6426 [inline]
[<ffffffff89148e14>] l2cap_le_sig_channel net/bluetooth/l2cap_core.c:6464 [inline]
[<ffffffff89148e14>] l2cap_recv_frame+0x85a4/0x9390 net/bluetooth/l2cap_core.c:7796
but there are no more locks to release!

other info that might help us debug this:
2 locks held by kworker/u5:7/5124:
 #0: ffff88801ecca938 ((wq_completion)hci1#2){+.+.}-{0:0}, at: arch_atomic64_set arch/x86/include/asm/atomic64_64.h:34 [inline]
 #0: ffff88801ecca938 ((wq_completion)hci1#2){+.+.}-{0:0}, at: arch_atomic_long_set include/linux/atomic/atomic-long.h:41 [inline]
 #0: ffff88801ecca938 ((wq_completion)hci1#2){+.+.}-{0:0}, at: atomic_long_set include/linux/atomic/atomic-instrumented.h:1280 [inline]
 #0: ffff88801ecca938 ((wq_completion)hci1#2){+.+.}-{0:0}, at: set_work_data kernel/workqueue.c:639 [inline]
 #0: ffff88801ecca938 ((wq_completion)hci1#2){+.+.}-{0:0}, at: set_work_pool_and_clear_pending kernel/workqueue.c:666 [inline]
 #0: ffff88801ecca938 ((wq_completion)hci1#2){+.+.}-{0:0}, at: process_one_work+0x87a/0x15c0 kernel/workqueue.c:2361
 #1: ffffc9000468fda8 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_one_work+0x8ae/0x15c0 kernel/workqueue.c:2365

stack backtrace:
CPU: 1 PID: 5124 Comm: kworker/u5:7 Not tainted 6.3.0-rc6-syzkaller-00168-g95abc817ab3a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
Workqueue: hci1 hci_rx_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd9/0x150 lib/dump_stack.c:106
 __lock_release kernel/locking/lockdep.c:5346 [inline]
 lock_release+0x4f1/0x670 kernel/locking/lockdep.c:5689
 __mutex_unlock_slowpath+0x99/0x5e0 kernel/locking/mutex.c:907
 l2cap_disconnect_rsp net/bluetooth/l2cap_core.c:4697 [inline]
 l2cap_le_sig_cmd net/bluetooth/l2cap_core.c:6426 [inline]
 l2cap_le_sig_channel net/bluetooth/l2cap_core.c:6464 [inline]
 l2cap_recv_frame+0x85a4/0x9390 net/bluetooth/l2cap_core.c:7796
 l2cap_recv_acldata+0xa80/0xbf0 net/bluetooth/l2cap_core.c:8504
 hci_acldata_packet net/bluetooth/hci_core.c:3828 [inline]
 hci_rx_work+0x709/0x1340 net/bluetooth/hci_core.c:4063
 process_one_work+0x991/0x15c0 kernel/workqueue.c:2390
 worker_thread+0x669/0x1090 kernel/workqueue.c:2537
 kthread+0x2e8/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:308
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
