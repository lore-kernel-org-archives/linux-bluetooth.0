Return-Path: <SRS0=DQXy=BZ=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F37AFC433E1
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Aug 2020 22:00:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D726D206B6
	for <linux-bluetooth@archiver.kernel.org>; Sat, 15 Aug 2020 22:00:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728116AbgHOWAK (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 15 Aug 2020 18:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbgHOVvh (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:37 -0400
Received: from mail-il1-x148.google.com (mail-il1-x148.google.com [IPv6:2607:f8b0:4864:20::148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1FAC0F26CD
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Aug 2020 10:19:25 -0700 (PDT)
Received: by mail-il1-x148.google.com with SMTP id e12so8795392ile.14
        for <linux-bluetooth@vger.kernel.org>; Sat, 15 Aug 2020 10:19:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=GpKlYOLTQ3NZOHf3k+bXCS8gLg7b2ROCnIxYzCs9K7Y=;
        b=hZZ5rjeuraBiLyXJEtf7NMqp6FrZnQM0Mq1EJ78ra384MysBAd4CkhnaI8m7CbWmEq
         R+gnsoQ60x516mRPVAusXDfoxp7otW+D8Vpvf/bS5IyMKVutJHR18rZTcLAc0UUTaU+O
         7Qb2u85LxUN2oBLQhIkEiYPwYGMXLgGhJhchxYwSC5DIs2p70q6UZBx17v2koWRxcQBc
         g2XNEwEzyE8oGfOYYBUPIA6cgHxc9ZcllU202ZrUNhGXDlCgZERctYBSvqlfvNZ0fFsN
         QMx1sbnxHlj9ua00tMvSHB72Imljofq+a6VRV0iWF7Gpz2EdEKNgxnezg/yNZoA5mcoR
         Ee7w==
X-Gm-Message-State: AOAM532H12PHFn8zdGAX1W1r08s77MW+TcjfIhF/rbJ7gDMtcUlCdblk
        boveot9JhzY9l5q3lHeFeOft9+duqPzFe4MUke84ZWdb4yhJ
X-Google-Smtp-Source: ABdhPJzgWk0fNRRV9SxWB4STKsUr+rNsP+8+REIA7cb/c2NKeIHdOl1bkAZJR4qeWpTJhROEEuaRmDE7QKSDCrP/+Du82uxCBax8
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:792:: with SMTP id q18mr7200462ils.104.1597511965051;
 Sat, 15 Aug 2020 10:19:25 -0700 (PDT)
Date:   Sat, 15 Aug 2020 10:19:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000033913705acedbd6b@google.com>
Subject: memory leak in read_adv_mon_features
From:   syzbot <syzbot+f7f6e564f4202d8601c6@syzkaller.appspotmail.com>
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

HEAD commit:    7fca4dee Merge tag 'powerpc-5.9-2' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15ea92a1900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e320bbff976a5cdc
dashboard link: https://syzkaller.appspot.com/bug?extid=f7f6e564f4202d8601c6
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1286db9a900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1143ddf6900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f7f6e564f4202d8601c6@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88812b18e6e0 (size 32):
  comm "syz-executor286", pid 6490, jiffies 4294993450 (age 13.120s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 20 00 10 00 00 00 00 00  ........ .......
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000f286b99c>] kmalloc include/linux/slab.h:559 [inline]
    [<00000000f286b99c>] read_adv_mon_features+0xa1/0x150 net/bluetooth/mgmt.c:4180
    [<00000000f0f16504>] hci_mgmt_cmd net/bluetooth/hci_sock.c:1603 [inline]
    [<00000000f0f16504>] hci_sock_sendmsg+0xb01/0xc60 net/bluetooth/hci_sock.c:1738
    [<000000001560da71>] sock_sendmsg_nosec net/socket.c:651 [inline]
    [<000000001560da71>] sock_sendmsg+0x4c/0x60 net/socket.c:671
    [<000000007d7be9f6>] sock_write_iter+0xc5/0x140 net/socket.c:998
    [<00000000e3633d41>] call_write_iter include/linux/fs.h:1882 [inline]
    [<00000000e3633d41>] new_sync_write+0x173/0x210 fs/read_write.c:503
    [<0000000021a87df2>] vfs_write+0x21d/0x280 fs/read_write.c:578
    [<0000000003f07ff6>] ksys_write+0xd8/0x120 fs/read_write.c:631
    [<0000000003a7df09>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<000000005ecd28f6>] entry_SYSCALL_64_after_hwframe+0x44/0xa9

BUG: memory leak
unreferenced object 0xffff88812b18e660 (size 32):
  comm "syz-executor286", pid 6495, jiffies 4294993998 (age 7.640s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 20 00 10 00 00 00 00 00  ........ .......
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<00000000f286b99c>] kmalloc include/linux/slab.h:559 [inline]
    [<00000000f286b99c>] read_adv_mon_features+0xa1/0x150 net/bluetooth/mgmt.c:4180
    [<00000000f0f16504>] hci_mgmt_cmd net/bluetooth/hci_sock.c:1603 [inline]
    [<00000000f0f16504>] hci_sock_sendmsg+0xb01/0xc60 net/bluetooth/hci_sock.c:1738
    [<000000001560da71>] sock_sendmsg_nosec net/socket.c:651 [inline]
    [<000000001560da71>] sock_sendmsg+0x4c/0x60 net/socket.c:671
    [<000000007d7be9f6>] sock_write_iter+0xc5/0x140 net/socket.c:998
    [<00000000e3633d41>] call_write_iter include/linux/fs.h:1882 [inline]
    [<00000000e3633d41>] new_sync_write+0x173/0x210 fs/read_write.c:503
    [<0000000021a87df2>] vfs_write+0x21d/0x280 fs/read_write.c:578
    [<0000000003f07ff6>] ksys_write+0xd8/0x120 fs/read_write.c:631
    [<0000000003a7df09>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<000000005ecd28f6>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
