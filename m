Return-Path: <SRS0=loPc=XL=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,LONGWORDS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD9EC49ED7
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Sep 2019 16:09:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C710020678
	for <linux-bluetooth@archiver.kernel.org>; Mon, 16 Sep 2019 16:09:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389582AbfIPQJI (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 16 Sep 2019 12:09:08 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:41191 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732059AbfIPQJI (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 16 Sep 2019 12:09:08 -0400
Received: by mail-io1-f72.google.com with SMTP id e6so284657ios.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 16 Sep 2019 09:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=EC2s8BEqRAx9Dr0E2QNHTzJxeMHG454P6cMAn1PGkeg=;
        b=mNUTc6bU7vFfBlo6pb0OKANIldpT71OUHb35e+N18A9R16sO5Nm0zqPklN9HQSSVQx
         sichubTSS/22iJW/SgBz5jnzbTaUHtQlI7XgeT7iOQfw1t8EG2JQ/jlSESudn8OoDhk3
         MdmxD03Ma2sPqW+egudoTKr/jmZgKqWY4KiGNGR5BUFaiSdlQvQSndNhbo8pje6ETq4K
         vIso77Qit3bDhPENEFOnDSDJSVJDey8s+WsoWPuam4t42ptuRDZ1jdNxtqYNlwZAYcCL
         Lcr56358JI1WruxnSY6BTrS4FxNh9/vd9687W01lMlcgtGifoYRkavRL2hx9KbcKO7id
         u5pA==
X-Gm-Message-State: APjAAAWr5hnBAfUeeGhR+9S/E0Kk5NIbZOOmLlGz+3zlTGa4RAfoKD/1
        Jq+mKxUgyi7t4vtMxWwjK2HlN/M0h/YRMQSSK4soib9V28aH
X-Google-Smtp-Source: APXvYqxgrjyRDgUGY0231kJo3+PNXQQJKev3jLswEnQYXN+zlSCG7YyT3tkMrT/3iiQJJXuxYJgaNcDC3EKtMHA7Zgv2zXaMYWPQ
MIME-Version: 1.0
X-Received: by 2002:a6b:2c07:: with SMTP id s7mr716787ios.254.1568650147447;
 Mon, 16 Sep 2019 09:09:07 -0700 (PDT)
Date:   Mon, 16 Sep 2019 09:09:07 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d0cc780592add25d@google.com>
Subject: memory leak in h5_rx_pkt_start
From:   syzbot <syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    1609d760 Merge tag 'for-linus' of git://git.kernel.org/pub..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1494a081600000
kernel config:  https://syzkaller.appspot.com/x/.config?x=90cbcb59581ed842
dashboard link: https://syzkaller.appspot.com/bug?extid=6ce141c55b2f7aafd1c4
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12185479600000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1238c465600000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+6ce141c55b2f7aafd1c4@syzkaller.appspotmail.com

executing program
executing program
executing program
executing program
executing program
BUG: memory leak
unreferenced object 0xffff88811469e100 (size 224):
   comm "syz-executor068", pid 6860, jiffies 4294949784 (age 13.480s)
   hex dump (first 32 bytes):
     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
     00 c0 bf 20 81 88 ff ff 00 00 00 00 00 00 00 00  ... ............
   backtrace:
     [<0000000036b71133>] kmemleak_alloc_recursive  
include/linux/kmemleak.h:43 [inline]
     [<0000000036b71133>] slab_post_alloc_hook mm/slab.h:522 [inline]
     [<0000000036b71133>] slab_alloc_node mm/slab.c:3262 [inline]
     [<0000000036b71133>] kmem_cache_alloc_node+0x163/0x2f0 mm/slab.c:3574
     [<00000000c50cdaae>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:197
     [<0000000097f6a43a>] alloc_skb include/linux/skbuff.h:1055 [inline]
     [<0000000097f6a43a>] bt_skb_alloc include/net/bluetooth/bluetooth.h:339  
[inline]
     [<0000000097f6a43a>] h5_rx_pkt_start+0x57/0xd0  
drivers/bluetooth/hci_h5.c:474
     [<00000000d2c8fdbf>] h5_recv+0x13f/0x1d0 drivers/bluetooth/hci_h5.c:563
     [<00000000c4a86230>] hci_uart_tty_receive+0xba/0x200  
drivers/bluetooth/hci_ldisc.c:613
     [<0000000039786cc4>] tiocsti drivers/tty/tty_io.c:2197 [inline]
     [<0000000039786cc4>] tty_ioctl+0x81c/0xa30 drivers/tty/tty_io.c:2573
     [<00000000ba214ddb>] vfs_ioctl fs/ioctl.c:46 [inline]
     [<00000000ba214ddb>] file_ioctl fs/ioctl.c:509 [inline]
     [<00000000ba214ddb>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
     [<00000000fa2c3356>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
     [<00000000eab0a027>] __do_sys_ioctl fs/ioctl.c:720 [inline]
     [<00000000eab0a027>] __se_sys_ioctl fs/ioctl.c:718 [inline]
     [<00000000eab0a027>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
     [<00000000db7e89eb>] do_syscall_64+0x76/0x1a0  
arch/x86/entry/common.c:296
     [<000000008887ecc0>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
