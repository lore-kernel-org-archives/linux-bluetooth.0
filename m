Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A23C433ED
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 May 2021 09:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BB706108B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 May 2021 09:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235868AbhEQJQJ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 17 May 2021 05:16:09 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:54813 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235908AbhEQJNe (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 17 May 2021 05:13:34 -0400
Received: by mail-il1-f199.google.com with SMTP id h1-20020a056e021d81b02901bb694b89faso5043364ila.21
        for <linux-bluetooth@vger.kernel.org>; Mon, 17 May 2021 02:12:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=mRyf9lv2g3j7nk1w/H4T1H1jAQgqzoEpGRqMuq86u2E=;
        b=PfFaEUdHRKQHtbIxnvxtJIWYVOwH/YxLJ1hGSAa4c019gWOViaqK1IZQf5p4A9rjgd
         t7bxaYRJMOokibuIwxtez2abmxehKDTHvIuKXi6d1LBRowmPN4DMpdrtjxctaV4c70hy
         hoT1EuB+WZ4JgUb4JLr3XlDHMOJLv84tP5aYbM2ECJiSf2gMgIMQjjlqjMMDrT26WA9L
         LAq5+terYcPYgliuVL7HY+fUxrpwdwqFAJLHLYUb+kSakwxwqTTwEsGuVeBnoiLpF5dc
         8hFtTUeZvIsHzSMvEsj7fw6EEDh20aYGM1F2XvyCaesIplSyVRA7CSal2zcu25X8nNK4
         9XfQ==
X-Gm-Message-State: AOAM532Ir9V5wuQ11Qxu2Ku6AKUKxtv6jfUZywughfBRPquLM7aEo3oG
        ETu/zI5n33FMAZsfVtPLaT7aKBO63QVBNPtgyyQwXfb462Sc
X-Google-Smtp-Source: ABdhPJyw89HcafgTnmnXd8Q0mhLCT8K6VI+UsYJH2lobE3ZOmBIIsPzLBSnQG2WX+XN+ZZl9SZvDwQ/xb7l6drPRY+J3+UJmZYnw
MIME-Version: 1.0
X-Received: by 2002:a5e:930d:: with SMTP id k13mr43881968iom.61.1621242736388;
 Mon, 17 May 2021 02:12:16 -0700 (PDT)
Date:   Mon, 17 May 2021 02:12:16 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000065b14e05c282fd15@google.com>
Subject: [syzbot] memory leak in mgmt_cmd_complete
From:   syzbot <syzbot+4c4ffd1e1094dae61035@syzkaller.appspotmail.com>
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

HEAD commit:    9f67672a Merge tag 'ext4_for_linus' of git://git.kernel.or..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=136256a5d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5427806e749e612b
dashboard link: https://syzkaller.appspot.com/bug?extid=4c4ffd1e1094dae61035
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17a4d5a3d00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4c4ffd1e1094dae61035@syzkaller.appspotmail.com

2021/05/01 15:27:37 executed programs: 23
BUG: memory leak
unreferenced object 0xffff8881131d9100 (size 232):
  comm "kworker/u5:7", pid 8471, jiffies 4294965136 (age 11.710s)
  hex dump (first 32 bytes):
    d0 94 18 27 81 88 ff ff d0 94 18 27 81 88 ff ff  ...'.......'....
    00 00 00 00 00 00 00 00 00 94 18 27 81 88 ff ff  ...........'....
  backtrace:
    [<ffffffff83678b3f>] __alloc_skb+0x20f/0x280 net/core/skbuff.c:413
    [<ffffffff83c9cedd>] alloc_skb include/linux/skbuff.h:1107 [inline]
    [<ffffffff83c9cedd>] mgmt_cmd_complete+0x3d/0x1a0 net/bluetooth/mgmt_util.c:146
    [<ffffffff83c5d46e>] send_settings_rsp net/bluetooth/mgmt.c:1126 [inline]
    [<ffffffff83c5d46e>] settings_rsp+0x5e/0x170 net/bluetooth/mgmt.c:1279
    [<ffffffff83c9d1c6>] mgmt_pending_foreach+0x76/0xa0 net/bluetooth/mgmt_util.c:226
    [<ffffffff83c68c3c>] __mgmt_power_off+0x5c/0x1e0 net/bluetooth/mgmt.c:8575
    [<ffffffff83c392e9>] hci_dev_do_close+0x579/0x720 net/bluetooth/hci_core.c:1776
    [<ffffffff8125d109>] process_one_work+0x2c9/0x600 kernel/workqueue.c:2275
    [<ffffffff8125d9f9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2421
    [<ffffffff81265268>] kthread+0x178/0x1b0 kernel/kthread.c:313
    [<ffffffff8100227f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

BUG: memory leak
unreferenced object 0xffff888126cdce00 (size 512):
  comm "kworker/u5:7", pid 8471, jiffies 4294965136 (age 11.710s)
  hex dump (first 32 bytes):
    01 00 00 00 07 00 05 00 00 82 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff83678a0f>] kmalloc_reserve net/core/skbuff.c:354 [inline]
    [<ffffffff83678a0f>] __alloc_skb+0xdf/0x280 net/core/skbuff.c:425
    [<ffffffff83c9cedd>] alloc_skb include/linux/skbuff.h:1107 [inline]
    [<ffffffff83c9cedd>] mgmt_cmd_complete+0x3d/0x1a0 net/bluetooth/mgmt_util.c:146
    [<ffffffff83c5d46e>] send_settings_rsp net/bluetooth/mgmt.c:1126 [inline]
    [<ffffffff83c5d46e>] settings_rsp+0x5e/0x170 net/bluetooth/mgmt.c:1279
    [<ffffffff83c9d1c6>] mgmt_pending_foreach+0x76/0xa0 net/bluetooth/mgmt_util.c:226
    [<ffffffff83c68c3c>] __mgmt_power_off+0x5c/0x1e0 net/bluetooth/mgmt.c:8575
    [<ffffffff83c392e9>] hci_dev_do_close+0x579/0x720 net/bluetooth/hci_core.c:1776
    [<ffffffff8125d109>] process_one_work+0x2c9/0x600 kernel/workqueue.c:2275
    [<ffffffff8125d9f9>] worker_thread+0x59/0x5d0 kernel/workqueue.c:2421
    [<ffffffff81265268>] kthread+0x178/0x1b0 kernel/kthread.c:313
    [<ffffffff8100227f>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
