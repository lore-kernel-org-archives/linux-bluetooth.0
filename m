Return-Path: <SRS0=Lvhs=W2=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3345C3A5A6
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Aug 2019 19:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E38F21897
	for <linux-bluetooth@archiver.kernel.org>; Fri, 30 Aug 2019 19:28:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728058AbfH3T2P (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Aug 2019 15:28:15 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:53103 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728111AbfH3T2J (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Aug 2019 15:28:09 -0400
Received: by mail-io1-f69.google.com with SMTP id q5so9661957iof.19
        for <linux-bluetooth@vger.kernel.org>; Fri, 30 Aug 2019 12:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=WuWiZb77BzJY+J1MNhFVvKgsGXna89Mt8XyNjZyvad8=;
        b=lUPCSu8aC9RBVvtKExaeRShpaQf2UKupQKtjSqhUfci8akjFmbULLocutt8vA+Y/x3
         OMfSx4wFG1ED/NFB9AfG0B9EbuD1At0fEpgVHc9/VJ+ApdoeJQQroJc9qBIatIQGhcT2
         ym6OgHbM7rIA/hDfiURhMvXe17Q8VjsBHjHC76gFUQqSgpEYzWzqRLmX0ORNdPvrf/Ao
         eMK/q2QnOPzi6IUPdoMLtxaTCWH9DinZfONlnhcjaltcygrZkHOHEYCI4VGRQveovqWo
         XOh8M6AVQyJuuChqklsYpsUOyH+HSngG6NbG4nK3/EIDuxluyezDFtxGgPPjC1cfcggP
         WC6Q==
X-Gm-Message-State: APjAAAXpexVMB3477a0nPsnwa47BDX8+Okkzfie4azYP8smjxH2ZIwPs
        utbfn319x5AMrtYIMd1HTJBUf7DOpNvxQZd4gw2w2zH6t2vR
X-Google-Smtp-Source: APXvYqziyMc7Qv/sf941HnJFhTpfPdQBt8JTF/X8VpcabVdQqFN0rG+p/2LEls5l385vlNZfFEt/WJoxnYN1vvkifTfa/61+jl/G
MIME-Version: 1.0
X-Received: by 2002:a5d:9696:: with SMTP id m22mr1153125ion.14.1567193288485;
 Fri, 30 Aug 2019 12:28:08 -0700 (PDT)
Date:   Fri, 30 Aug 2019 12:28:08 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004132be05915a9f7c@google.com>
Subject: memory leak in hci_inquiry_cache_update
From:   syzbot <syzbot+82e5dfb66f1a36c0ffbb@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    6525771f Merge tag 'arc-5.3-rc7' of git://git.kernel.org/p..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11ce405c600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e6131eafb9408877
dashboard link: https://syzkaller.appspot.com/bug?extid=82e5dfb66f1a36c0ffbb
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16ef5ade600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+82e5dfb66f1a36c0ffbb@syzkaller.appspotmail.com

2019/08/30 10:10:13 executed programs: 1
2019/08/30 10:10:24 executed programs: 2
2019/08/30 10:10:39 executed programs: 3
2019/08/30 10:10:49 executed programs: 4
BUG: memory leak
unreferenced object 0xffff8881227b8ac0 (size 64):
   comm "kworker/u5:0", pid 1543, jiffies 4294990660 (age 28.050s)
   hex dump (first 32 bytes):
     70 2a b0 2a 81 88 ff ff c0 7e c6 1a 81 88 ff ff  p*.*.....~......
     80 2a b0 2a 81 88 ff ff d0 7e c6 1a 81 88 ff ff  .*.*.....~......
   backtrace:
     [<0000000003c40121>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000003c40121>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<0000000003c40121>] slab_alloc mm/slab.c:3319 [inline]
     [<0000000003c40121>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<00000000bdd76485>] kmalloc include/linux/slab.h:552 [inline]
     [<00000000bdd76485>] kzalloc include/linux/slab.h:748 [inline]
     [<00000000bdd76485>] hci_inquiry_cache_update+0x138/0x2b0  
net/bluetooth/hci_core.c:1183
     [<000000000fa97823>] hci_inquiry_result_with_rssi_evt  
net/bluetooth/hci_event.c:4079 [inline]
     [<000000000fa97823>] hci_event_packet+0x1224/0x3453  
net/bluetooth/hci_event.c:5952
     [<0000000021923028>] hci_rx_work+0x1b6/0x2f0  
net/bluetooth/hci_core.c:4462
     [<00000000eb63bebf>] process_one_work+0x210/0x490  
kernel/workqueue.c:2269
     [<00000000873e1703>] worker_thread+0x56/0x4c0 kernel/workqueue.c:2415
     [<00000000a3c26b57>] kthread+0x13e/0x160 kernel/kthread.c:255
     [<00000000c66acc55>] ret_from_fork+0x1f/0x30  
arch/x86/entry/entry_64.S:352

BUG: memory leak
unreferenced object 0xffff88811ac67ec0 (size 64):
   comm "kworker/u5:0", pid 1543, jiffies 4294990660 (age 28.050s)
   hex dump (first 32 bytes):
     c0 8a 7b 22 81 88 ff ff 80 7e c6 1a 81 88 ff ff  ..{".....~......
     d0 8a 7b 22 81 88 ff ff 90 7e c6 1a 81 88 ff ff  ..{".....~......
   backtrace:
     [<0000000003c40121>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000003c40121>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<0000000003c40121>] slab_alloc mm/slab.c:3319 [inline]
     [<0000000003c40121>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<00000000bdd76485>] kmalloc include/linux/slab.h:552 [inline]
     [<00000000bdd76485>] kzalloc include/linux/slab.h:748 [inline]
     [<00000000bdd76485>] hci_inquiry_cache_update+0x138/0x2b0  
net/bluetooth/hci_core.c:1183
     [<000000000fa97823>] hci_inquiry_result_with_rssi_evt  
net/bluetooth/hci_event.c:4079 [inline]
     [<000000000fa97823>] hci_event_packet+0x1224/0x3453  
net/bluetooth/hci_event.c:5952
     [<0000000021923028>] hci_rx_work+0x1b6/0x2f0  
net/bluetooth/hci_core.c:4462
     [<00000000eb63bebf>] process_one_work+0x210/0x490  
kernel/workqueue.c:2269
     [<00000000873e1703>] worker_thread+0x56/0x4c0 kernel/workqueue.c:2415
     [<00000000a3c26b57>] kthread+0x13e/0x160 kernel/kthread.c:255
     [<00000000c66acc55>] ret_from_fork+0x1f/0x30  
arch/x86/entry/entry_64.S:352

BUG: memory leak
unreferenced object 0xffff88811ac67e80 (size 64):
   comm "kworker/u5:0", pid 1543, jiffies 4294990660 (age 28.050s)
   hex dump (first 32 bytes):
     c0 7e c6 1a 81 88 ff ff 40 7e c6 1a 81 88 ff ff  .~......@~......
     d0 7e c6 1a 81 88 ff ff 50 7e c6 1a 81 88 ff ff  .~......P~......
   backtrace:
     [<0000000003c40121>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000003c40121>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<0000000003c40121>] slab_alloc mm/slab.c:3319 [inline]
     [<0000000003c40121>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<00000000bdd76485>] kmalloc include/linux/slab.h:552 [inline]
     [<00000000bdd76485>] kzalloc include/linux/slab.h:748 [inline]
     [<00000000bdd76485>] hci_inquiry_cache_update+0x138/0x2b0  
net/bluetooth/hci_core.c:1183
     [<000000000fa97823>] hci_inquiry_result_with_rssi_evt  
net/bluetooth/hci_event.c:4079 [inline]
     [<000000000fa97823>] hci_event_packet+0x1224/0x3453  
net/bluetooth/hci_event.c:5952
     [<0000000021923028>] hci_rx_work+0x1b6/0x2f0  
net/bluetooth/hci_core.c:4462
     [<00000000eb63bebf>] process_one_work+0x210/0x490  
kernel/workqueue.c:2269
     [<00000000873e1703>] worker_thread+0x56/0x4c0 kernel/workqueue.c:2415
     [<00000000a3c26b57>] kthread+0x13e/0x160 kernel/kthread.c:255
     [<00000000c66acc55>] ret_from_fork+0x1f/0x30  
arch/x86/entry/entry_64.S:352

BUG: memory leak
unreferenced object 0xffff88811ac67e40 (size 64):
   comm "kworker/u5:0", pid 1543, jiffies 4294990660 (age 28.050s)
   hex dump (first 32 bytes):
     80 7e c6 1a 81 88 ff ff 00 7e c6 1a 81 88 ff ff  .~.......~......
     90 7e c6 1a 81 88 ff ff 10 7e c6 1a 81 88 ff ff  .~.......~......
   backtrace:
     [<0000000003c40121>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000003c40121>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<0000000003c40121>] slab_alloc mm/slab.c:3319 [inline]
     [<0000000003c40121>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<00000000bdd76485>] kmalloc include/linux/slab.h:552 [inline]
     [<00000000bdd76485>] kzalloc include/linux/slab.h:748 [inline]
     [<00000000bdd76485>] hci_inquiry_cache_update+0x138/0x2b0  
net/bluetooth/hci_core.c:1183
     [<000000000fa97823>] hci_inquiry_result_with_rssi_evt  
net/bluetooth/hci_event.c:4079 [inline]
     [<000000000fa97823>] hci_event_packet+0x1224/0x3453  
net/bluetooth/hci_event.c:5952
     [<0000000021923028>] hci_rx_work+0x1b6/0x2f0  
net/bluetooth/hci_core.c:4462
     [<00000000eb63bebf>] process_one_work+0x210/0x490  
kernel/workqueue.c:2269
     [<00000000873e1703>] worker_thread+0x56/0x4c0 kernel/workqueue.c:2415
     [<00000000a3c26b57>] kthread+0x13e/0x160 kernel/kthread.c:255
     [<00000000c66acc55>] ret_from_fork+0x1f/0x30  
arch/x86/entry/entry_64.S:352

BUG: memory leak
unreferenced object 0xffff88811ac67e00 (size 64):
   comm "kworker/u5:0", pid 1543, jiffies 4294990660 (age 28.050s)
   hex dump (first 32 bytes):
     40 7e c6 1a 81 88 ff ff c0 7d c6 1a 81 88 ff ff  @~.......}......
     50 7e c6 1a 81 88 ff ff d0 7d c6 1a 81 88 ff ff  P~.......}......
   backtrace:
     [<0000000003c40121>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000003c40121>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<0000000003c40121>] slab_alloc mm/slab.c:3319 [inline]
     [<0000000003c40121>] kmem_cache_alloc_trace+0x145/0x2c0 mm/slab.c:3548
     [<00000000bdd76485>] kmalloc include/linux/slab.h:552 [inline]
     [<00000000bdd76485>] kzalloc include/linux/slab.h:748 [inline]
     [<00000000bdd76485>] hci_inquiry_cache_update+0x138/0x2b0  
net/bluetooth/hci_core.c:1183
     [<000000000fa97823>] hci_inquiry_result_with_rssi_evt  
net/bluetooth/hci_event.c:4079 [inline]
     [<000000000fa97823>] hci_event_packet+0x1224/0x3453  
net/bluetooth/hci_event.c:5952
     [<0000000021923028>] hci_rx_work+0x1b6/0x2f0  
net/bluetooth/hci_core.c:4462
     [<00000000eb63bebf>] process_one_work+0x210/0x490  
kernel/workqueue.c:2269
     [<00000000873e1703>] worker_thread+0x56/0x4c0 kernel/workqueue.c:2415
     [<00000000a3c26b57>] kthread+0x13e/0x160 kernel/kthread.c:255
     [<00000000c66acc55>] ret_from_fork+0x1f/0x30  
arch/x86/entry/entry_64.S:352



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
