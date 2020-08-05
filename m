Return-Path: <SRS0=twEk=BP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECBD3C433E3
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Aug 2020 20:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6B8822B42
	for <linux-bluetooth@archiver.kernel.org>; Wed,  5 Aug 2020 20:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729586AbgHEUOp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 5 Aug 2020 16:14:45 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:48158 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726764AbgHEQX0 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 5 Aug 2020 12:23:26 -0400
Received: by mail-il1-f200.google.com with SMTP id x4so1918959ilk.15
        for <linux-bluetooth@vger.kernel.org>; Wed, 05 Aug 2020 09:22:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=gf59HPMENV3tGrAXq5hE5QTaFPtfjI08GkK5Z/pVw18=;
        b=MjuqQJn+f9EWfaCts4O27lNzwI97ivjbFtq2KMF1LmRu9woaI0yUXhiMrvLTYCRBug
         wPXX4MhYqY2Q5boegvamFBkF/HdCkSFIfp8AVV8S0a5NnRLSuO5cDLdKkcgZP8I5yU5M
         qSofgeGnZJma8VgEBw40atPkg7vlwPZq31nhpXhoywCOWldw6RGoKOkun4BmCv1oLyGl
         K7vWF40fLTgEFeNe0uICSL8JgTBqxdm4FAeOX5yTm6Wyb4w/bX30O6nW4kMvcC37V4ho
         MVWEYHPp00NTxo3kNF0ZCiiVaQ/xzfNGKKU2DBZTxOXHrRBI5vnn64rKZlPk14Cprriz
         wsjA==
X-Gm-Message-State: AOAM531HIPphqtAzuI2KrjM34wLDAh3h1JeMgIjr+DON6HALqvI5OoQp
        5RuMGxEnBSAwh/WbrXUPHQ/+aqQ3tqPiNnKON8EH8CZQwg4V
X-Google-Smtp-Source: ABdhPJxl0BPdl6oM/s7HLtGwzvDPhEYlmelG5KgJF5rbDcL7n1B3Q6UoxJACGDSfOLK8hC/Y8LQyi/I8pkm2k0uNJ6e3zo992gYj
MIME-Version: 1.0
X-Received: by 2002:a5d:9a86:: with SMTP id c6mr4183230iom.27.1596643761561;
 Wed, 05 Aug 2020 09:09:21 -0700 (PDT)
Date:   Wed, 05 Aug 2020 09:09:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003da5f105ac239832@google.com>
Subject: general protection fault in bt_accept_unlink
From:   syzbot <syzbot+a9c8613ce9eafbd86441@syzkaller.appspotmail.com>
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

HEAD commit:    ac3a0c84 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=1639b284900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0cfcf935bcc94d2
dashboard link: https://syzkaller.appspot.com/bug?extid=a9c8613ce9eafbd86441
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a9c8613ce9eafbd86441@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xf777682000003777: 0000 [#1] PREEMPT SMP KASAN
KASAN: maybe wild-memory-access in range [0xbbbb61000001bbb8-0xbbbb61000001bbbf]
CPU: 0 PID: 9028 Comm: kworker/0:6 Not tainted 5.8.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events l2cap_chan_timeout
RIP: 0010:__list_del_entry_valid+0x81/0xef lib/list_debug.c:51
Code: 0f 84 df 00 00 00 48 b8 22 01 00 00 00 00 ad de 49 39 c4 0f 84 e0 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 75 51 49 8b 14 24 48 39 ea 0f 85 97 00 00 00 49 8d 7d
RSP: 0018:ffffc900091afb18 EFLAGS: 00010a06
RAX: dffffc0000000000 RBX: ffff8880a71664b8 RCX: ffffffff8724984f
RDX: 17776c2000003777 RSI: ffffffff8717d437 RDI: ffff8880a71664c0
RBP: ffff8880a71664b8 R08: 0000000000000001 R09: ffff8880a7166067
R10: 0000000000000009 R11: 00000000000ccae8 R12: bbbb61000001bbbb
R13: bb60000000bbbbbb R14: 00000060000000bb R15: 0000000000000005
FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000ca8660 CR3: 000000009115f000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __list_del_entry include/linux/list.h:132 [inline]
 list_del_init include/linux/list.h:204 [inline]
 bt_accept_unlink+0x26/0x280 net/bluetooth/af_bluetooth.c:187
 l2cap_sock_teardown_cb+0x197/0x400 net/bluetooth/l2cap_sock.c:1544
 l2cap_chan_del+0xad/0x1300 net/bluetooth/l2cap_core.c:618
 l2cap_chan_close+0x118/0xb10 net/bluetooth/l2cap_core.c:824
 l2cap_chan_timeout+0x173/0x450 net/bluetooth/l2cap_core.c:436
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:291
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
Modules linked in:
---[ end trace 89227449b8393688 ]---
RIP: 0010:__list_del_entry_valid+0x81/0xef lib/list_debug.c:51
Code: 0f 84 df 00 00 00 48 b8 22 01 00 00 00 00 ad de 49 39 c4 0f 84 e0 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 75 51 49 8b 14 24 48 39 ea 0f 85 97 00 00 00 49 8d 7d
RSP: 0018:ffffc900091afb18 EFLAGS: 00010a06
RAX: dffffc0000000000 RBX: ffff8880a71664b8 RCX: ffffffff8724984f
RDX: 17776c2000003777 RSI: ffffffff8717d437 RDI: ffff8880a71664c0
RBP: ffff8880a71664b8 R08: 0000000000000001 R09: ffff8880a7166067
R10: 0000000000000009 R11: 00000000000ccae8 R12: bbbb61000001bbbb
R13: bb60000000bbbbbb R14: 00000060000000bb R15: 0000000000000005
FS:  0000000000000000(0000) GS:ffff8880ae600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000ca8660 CR3: 000000009d89f000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
