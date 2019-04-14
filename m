Return-Path: <SRS0=d7gb=SQ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADCADC10F14
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Apr 2019 00:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8470E2084D
	for <linux-bluetooth@archiver.kernel.org>; Sun, 14 Apr 2019 00:16:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbfDNAQK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 13 Apr 2019 20:16:10 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:50846 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbfDNAQK (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 13 Apr 2019 20:16:10 -0400
Received: by mail-it1-f200.google.com with SMTP id k8so13050256itd.0
        for <linux-bluetooth@vger.kernel.org>; Sat, 13 Apr 2019 17:16:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=xXuzSWyv+sKnNZGQm/vy9xDa4HZxZ8HxM06OLjDe5dQ=;
        b=rumTIGcw8CI5yKHGc7kOcyQeTY9kZ38HHemYnWnPo+LRZXlHkY+ZdislXipBCEFiIA
         1agGyIDywk0MqkWq4dQ//cSb8iOoSHmjOF5yunqW6gHTozJDLdZZZGFCiX7N4Y8N2U5n
         Pt47TyOuKMM64VWuYQgKMBl7eBFIMorDGqPKZY0Wr9fcFwa1GMCG7KDBOQbmO7xrmYa6
         FokBv99j/mvSQG68AVHf/gO+9df7JnK4TqigP1k6c3DgzXrcRko52DtD1SNuoQxeT4/b
         KfLDs9AmpVV3ehvSzlJxd3D4fGZ7SA4ZEukOCSn5fowPUsAvm8p8e15crYhddmcLJgfl
         EIvQ==
X-Gm-Message-State: APjAAAUSDqCt0shhSC+hHgJqTw5ezS3iRBBqkIGnEL4yhGA0xKuKxzGb
        pAiWU1iRhcOvMKWmnf1frH2g4z7MFXsx2nbFoJfEQiNM8LQG
X-Google-Smtp-Source: APXvYqwUGnz4QR3rq23u0Tb5EQnl3SZDYcLL/lu5WB5Yds4ZRRkQnmGQ90dvx2ZX/4tZ5pAZL9g3c+Y5aZeNFf1MGCfm6GE8G6Wk
MIME-Version: 1.0
X-Received: by 2002:a6b:8f01:: with SMTP id r1mr3846361iod.27.1555200969779;
 Sat, 13 Apr 2019 17:16:09 -0700 (PDT)
Date:   Sat, 13 Apr 2019 17:16:09 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005bb0ae05867271c1@google.com>
Subject: KMSAN: uninit-value in hci_event_packet
From:   syzbot <syzbot+4918ee47ac82d51de00d@syzkaller.appspotmail.com>
To:     davem@davemloft.net, glider@google.com, johan.hedberg@gmail.com,
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

HEAD commit:    c10a026b kmsan: use __free_pages() in kmsan_iounmap_page_r..
git tree:       kmsan
console output: https://syzkaller.appspot.com/x/log.txt?x=11c903a3200000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a5675814e8eae69e
dashboard link: https://syzkaller.appspot.com/bug?extid=4918ee47ac82d51de00d
compiler:       clang version 8.0.0 (trunk 350509)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13b4634d200000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=150657ef200000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4918ee47ac82d51de00d@syzkaller.appspotmail.com

IPVS: ftp: loaded support on port[0] = 21
==================================================================
BUG: KMSAN: uninit-value in hci_conn_complete_evt  
net/bluetooth/hci_event.c:2440 [inline]
BUG: KMSAN: uninit-value in hci_event_packet+0x126e8/0x35290  
net/bluetooth/hci_event.c:5781
CPU: 1 PID: 10735 Comm: kworker/u5:1 Not tainted 5.0.0+ #16
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: hci0 hci_rx_work
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x173/0x1d0 lib/dump_stack.c:113
  kmsan_report+0x131/0x2a0 mm/kmsan/kmsan.c:636
  __msan_warning+0x7a/0xf0 mm/kmsan/kmsan_instr.c:310
  hci_conn_complete_evt net/bluetooth/hci_event.c:2440 [inline]
  hci_event_packet+0x126e8/0x35290 net/bluetooth/hci_event.c:5781
  hci_rx_work+0x478/0xcc0 net/bluetooth/hci_core.c:4412
  process_one_work+0x1607/0x2010 kernel/workqueue.c:2173
  worker_thread+0x111c/0x2460 kernel/workqueue.c:2319
  kthread+0x4a1/0x4e0 kernel/kthread.c:247
  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355

Uninit was created at:
  kmsan_save_stack_with_flags mm/kmsan/kmsan.c:205 [inline]
  kmsan_internal_poison_shadow+0x92/0x150 mm/kmsan/kmsan.c:159
  kmsan_kmalloc+0xa6/0x130 mm/kmsan/kmsan_hooks.c:173
  kmsan_slab_alloc+0xe/0x10 mm/kmsan/kmsan_hooks.c:182
  slab_post_alloc_hook mm/slab.h:445 [inline]
  slab_alloc_node mm/slub.c:2773 [inline]
  __kmalloc_node_track_caller+0xe9e/0xff0 mm/slub.c:4398
  __kmalloc_reserve net/core/skbuff.c:140 [inline]
  __alloc_skb+0x309/0xa20 net/core/skbuff.c:208
  alloc_skb include/linux/skbuff.h:1012 [inline]
  bt_skb_alloc include/net/bluetooth/bluetooth.h:339 [inline]
  bcsp_recv+0x1437/0x2050 drivers/bluetooth/hci_bcsp.c:685
  hci_uart_tty_receive+0x35c/0x5d0 drivers/bluetooth/hci_ldisc.c:607
  tty_ldisc_receive_buf+0x2ea/0x350 drivers/tty/tty_buffer.c:465
  tty_port_default_receive_buf+0x14f/0x1e0 drivers/tty/tty_port.c:38
  receive_buf drivers/tty/tty_buffer.c:481 [inline]
  flush_to_ldisc+0x30c/0x7f0 drivers/tty/tty_buffer.c:533
  process_one_work+0x1607/0x2010 kernel/workqueue.c:2173
  worker_thread+0x111c/0x2460 kernel/workqueue.c:2319
  kthread+0x4a1/0x4e0 kernel/kthread.c:247
  ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:355
==================================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
