Return-Path: <SRS0=MaJy=CS=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D036C433E2
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Sep 2020 08:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DC8F218AC
	for <linux-bluetooth@archiver.kernel.org>; Wed,  9 Sep 2020 08:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729449AbgIIItj (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 9 Sep 2020 04:49:39 -0400
Received: from mail-il1-f205.google.com ([209.85.166.205]:37449 "EHLO
        mail-il1-f205.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728647AbgIIItY (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 9 Sep 2020 04:49:24 -0400
Received: by mail-il1-f205.google.com with SMTP id z14so1511822ils.4
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Sep 2020 01:49:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Hmc2r7eesuS8hDT5sY5ndDBpeHvg0B9Mp2Q2pIVeAhQ=;
        b=uY9Qboi9N/YojYQUYLDvGE7HQAFUt/CBXX17Nyi+Kt2nT9eo9xDxIVeWOBXX2dA4GL
         d+HAkVX0SIEOnJLJ7ud+hokgJiGUYi4TWUqPHItAKh4kED/R+FW0BjS8C5r427FUYp/z
         3dCpUTiwY2mv+Lz6ZwT8pdZlqcYsmAEdhcMuaSYa9oJEZ2ubfSXo3ADjL/IhcsWOKv40
         14hRUQGirj6Fu+Ux6kxy2N4HnoYbXmzM8LNTEcLJU2JXplh2bc7ucwX/6+EOxkxY1NG2
         p3m7SjvAMv3Ru2jCQ7Hi6qxcqiPUg/V6wj9M1D7R15RCEs3TqmAHNm91+TXvW8sIUrRr
         jRAQ==
X-Gm-Message-State: AOAM531EF0dfi3PMGyzj/E5JAqHwZAioXAg7rqeAgnBmrBvAPsDuN/+l
        whC/BaYpoK1cyZlltuFPM+RYGjUPIUi6efYn1pYYEM1w+103
X-Google-Smtp-Source: ABdhPJxoMRKRTwWdxdXUfgMHZQIkaFn/xWyh4vyruirgPIBRjn9gLzghekwhJjrYO7UQ2Zc99DWXrwQldvZR/amubDmOOitKbaCk
MIME-Version: 1.0
X-Received: by 2002:a92:c002:: with SMTP id q2mr2827066ild.171.1599641363124;
 Wed, 09 Sep 2020 01:49:23 -0700 (PDT)
Date:   Wed, 09 Sep 2020 01:49:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003798d705aedd870d@google.com>
Subject: memory leak in mgmt_cmd_status
From:   syzbot <syzbot+80f5bab4eb14d14e7386@syzkaller.appspotmail.com>
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

HEAD commit:    6f6a73c8 Merge tag 'drm-fixes-2020-09-08' of git://anongit..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=152e3245900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7954285d6e960c0f
dashboard link: https://syzkaller.appspot.com/bug?extid=80f5bab4eb14d14e7386
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16877335900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+80f5bab4eb14d14e7386@syzkaller.appspotmail.com

2020/09/09 02:38:52 executed programs: 3
2020/09/09 02:38:58 executed programs: 5
2020/09/09 02:39:03 executed programs: 7
BUG: memory leak
unreferenced object 0xffff888119d41a00 (size 224):
  comm "kworker/u5:0", pid 1520, jiffies 4294954656 (age 28.430s)
  hex dump (first 32 bytes):
    d0 30 1c 2b 81 88 ff ff d0 30 1c 2b 81 88 ff ff  .0.+.....0.+....
    00 00 00 00 00 00 00 00 00 30 1c 2b 81 88 ff ff  .........0.+....
  backtrace:
    [<000000007a3b2b8a>] __alloc_skb+0x5e/0x250 net/core/skbuff.c:198
    [<000000003fe180cd>] alloc_skb include/linux/skbuff.h:1094 [inline]
    [<000000003fe180cd>] mgmt_cmd_status+0x31/0x140 net/bluetooth/mgmt_util.c:102
    [<00000000a98852de>] mgmt_set_discoverable_complete+0x18e/0x1c0 net/bluetooth/mgmt.c:1351
    [<000000000d6aa222>] discoverable_update_work+0x7a/0xa0 net/bluetooth/hci_request.c:2595
    [<00000000159838c7>] process_one_work+0x213/0x4d0 kernel/workqueue.c:2269
    [<0000000087b95ef0>] worker_thread+0x58/0x4b0 kernel/workqueue.c:2415
    [<0000000059403542>] kthread+0x164/0x190 kernel/kthread.c:292
    [<00000000d35ee226>] ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
