Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC057C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 28 Nov 2021 09:24:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356812AbhK1J1e (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 28 Nov 2021 04:27:34 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:52885 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233127AbhK1JZd (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 28 Nov 2021 04:25:33 -0500
Received: by mail-il1-f197.google.com with SMTP id y3-20020a056e021be300b0029f6c440695so19878194ilv.19
        for <linux-bluetooth@vger.kernel.org>; Sun, 28 Nov 2021 01:22:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=/gh/RIirNb12dG3VUXwDsG22Fm8KS1ZnNB70KsKbfa8=;
        b=JoXGEW0u8panMkSexXMan6If5RsXXjRkTBp64tcS2OyuDYS1TgpnB4HPVDOWMlfI7h
         LNdJX0a3j67V8Bdszdi9LV4aPCJOQ1NKyJTzWOOZFU9rgD5m0bbjkQS/iEedr2kLCA/0
         216Eb1kxR2XnyhfSx+jXRGAzR6MYf1yTCKZPHAOOrIirYB3a/eJ5DScmUyTunxNn/rUy
         hhF5mcnpWk+rqwYMdJaSX5V3IPqkLNqCA6U3L86oOKk/JJvyhBWhzAz+R6efLmw8+rhN
         Q5AQ4KtDBq9dDneoFeuIfgqT2gjPQTK994FtbOffxTexXJisXMP0C9qkB5t7TuNOfCWf
         35Rw==
X-Gm-Message-State: AOAM530erURE4mdEanmjC4CX1v0uwk65bQkwAvvN5RJKyhBhaib/P3H5
        cnm/e0ElxeGhuoOOufU0NxEEJs/AxGqnkPxZ5NBYs0prvS1G
X-Google-Smtp-Source: ABdhPJye5Ui+qEY5l/8O444JqqbQhowZO9TRfMvoZ72SWuUt2trfxS5NlwmhUs8VBemz4qXCkJV/M6A/y+rgmfwxJT06ZJUxsouY
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:148c:: with SMTP id n12mr10574733ilk.209.1638091337453;
 Sun, 28 Nov 2021 01:22:17 -0800 (PST)
Date:   Sun, 28 Nov 2021 01:22:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000047549805d1d5dcdc@google.com>
Subject: [syzbot] KMSAN: uninit-value in hci_conn_complete_evt
From:   syzbot <syzbot+dcb7d98a388eafb85ecb@syzkaller.appspotmail.com>
To:     davem@davemloft.net, glider@google.com, johan.hedberg@gmail.com,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    a535b0caaa2f Revert "DO-NOT-SUBMIT: kmsan: suppress a repo..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=10becf06b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2d142cdf4204061
dashboard link: https://syzkaller.appspot.com/bug?extid=dcb7d98a388eafb85ecb
compiler:       clang version 14.0.0 (git@github.com:llvm/llvm-project.git 0996585c8e3b3d409494eb5f1cad714b9e1f7fb5), GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dcb7d98a388eafb85ecb@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in hci_conn_complete_evt+0x8e7/0x1de0 net/bluetooth/hci_event.c:2668
 hci_conn_complete_evt+0x8e7/0x1de0 net/bluetooth/hci_event.c:2668
 hci_event_packet+0x1670/0x22e0 net/bluetooth/hci_event.c:6311
 hci_rx_work+0x6ae/0xd10 net/bluetooth/hci_core.c:5136
 process_one_work+0xdc7/0x1760 kernel/workqueue.c:2297
 worker_thread+0x1101/0x22b0 kernel/workqueue.c:2444
 kthread+0x66b/0x780 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30

Uninit was created at:
 slab_post_alloc_hook mm/slab.h:524 [inline]
 slab_alloc_node mm/slub.c:3227 [inline]
 __kmalloc_node_track_caller+0xa3b/0x13c0 mm/slub.c:4962
 kmalloc_reserve net/core/skbuff.c:356 [inline]
 __alloc_skb+0x4db/0xe40 net/core/skbuff.c:427
 alloc_skb include/linux/skbuff.h:1116 [inline]
 bt_skb_alloc include/net/bluetooth/bluetooth.h:389 [inline]
 bcsp_recv+0x1550/0x2120 drivers/bluetooth/hci_bcsp.c:673
 hci_uart_tty_receive+0x345/0x7a0 drivers/bluetooth/hci_ldisc.c:613
 tty_ldisc_receive_buf+0x32a/0x390 drivers/tty/tty_buffer.c:475
 tty_port_default_receive_buf+0x14b/0x1e0 drivers/tty/tty_port.c:39
 receive_buf drivers/tty/tty_buffer.c:491 [inline]
 flush_to_ldisc+0x3b5/0x940 drivers/tty/tty_buffer.c:543
 process_one_work+0xdc7/0x1760 kernel/workqueue.c:2297
 worker_thread+0x1101/0x22b0 kernel/workqueue.c:2444
 kthread+0x66b/0x780 kernel/kthread.c:319
 ret_from_fork+0x1f/0x30
=====================================================


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
