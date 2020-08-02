Return-Path: <SRS0=6lUD=BM=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A58C433DF
	for <linux-bluetooth@archiver.kernel.org>; Sun,  2 Aug 2020 20:45:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACF3120759
	for <linux-bluetooth@archiver.kernel.org>; Sun,  2 Aug 2020 20:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgHBUpl (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 2 Aug 2020 16:45:41 -0400
Received: from mail-io1-f71.google.com ([209.85.166.71]:37178 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgHBUpU (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 2 Aug 2020 16:45:20 -0400
Received: by mail-io1-f71.google.com with SMTP id f6so10892609ioa.4
        for <linux-bluetooth@vger.kernel.org>; Sun, 02 Aug 2020 13:45:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=WCj8CYMMQAWzJ6MWSBeZcNE1cIR+npprASii5Yv7VV0=;
        b=ue383sXVJ9ptUWrdHxbUeVJJTxa5/0U3SvqGQGeC23l7rwNrXdMU9Er1IH5SX5qPuG
         zpsavTq6SX+5jLwySl9Z5vupqFzuHuQD57T55Ha0q6cseW4FWau/74ZSO7yBf/1CHh6M
         hsGsaUdZZvRc0+LrhCFNRUrbh8+BAsphHaKyc+gKXX1uK9o0MHSBKfy+3op50gs4u0Dq
         y5L8JsVTjVSAmexhhh8HvaN6yGnXozrwd3SL5yU3u1S9zpEZBpRD+WOi3LIwmyhzyh52
         YWzlhA00TzshVsrhxiKW1dzBV6/jV8yI87WhPHeE++kHtKigyCMDjc7yxqTNMne2m15E
         I+NQ==
X-Gm-Message-State: AOAM532DED7ilpVhEDEcU2s/C3a5aOuVjVQW0w7AaqeygKlbJ0x/Ke2G
        y7ATOvXEK92e9SZs8V6F1KTMwPRLDTWnncYncHFzVwoQNKxH
X-Google-Smtp-Source: ABdhPJxrDcWd2SstCuCwqW3Wn8G3wdsFFZ9beZO0KN/EJRcm6ZJcbbq9Ex6Ya2FXgRS/n7yrwTIrUDsDwpzrGLwErE+N+CulYzQO
MIME-Version: 1.0
X-Received: by 2002:a05:6638:348:: with SMTP id x8mr16357883jap.62.1596401119369;
 Sun, 02 Aug 2020 13:45:19 -0700 (PDT)
Date:   Sun, 02 Aug 2020 13:45:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a39e4905abeb193f@google.com>
Subject: general protection fault in hci_phy_link_complete_evt
From:   syzbot <syzbot+18e38290a2a263b31aa0@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    ac3a0c84 Merge git://git.kernel.org/pub/scm/linux/kernel/g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15ab47ca900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c0cfcf935bcc94d2
dashboard link: https://syzkaller.appspot.com/bug?extid=18e38290a2a263b31aa0
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f3dd0c900000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1032a642900000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+18e38290a2a263b31aa0@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000002: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
CPU: 1 PID: 6861 Comm: kworker/u5:1 Not tainted 5.8.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: hci0 hci_rx_work
RIP: 0010:hci_phy_link_complete_evt.isra.0+0x23e/0x790 net/bluetooth/hci_event.c:4926
Code: 48 c1 ea 03 80 3c 02 00 0f 85 3e 05 00 00 48 8b 9d 30 09 00 00 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 10 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 da 04 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b
RSP: 0018:ffffc90001897a38 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff871af0e3
RDX: 0000000000000002 RSI: ffffffff871af0f0 RDI: 0000000000000010
RBP: ffff88808f25e000 R08: 0000000000000001 R09: ffff8880a1cf6a88
R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff8880877f1110 R14: ffff8880926b480b R15: 00000000000000c8
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000000 CR3: 00000000a7ccc000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 hci_event_packet+0x481a/0x86f5 net/bluetooth/hci_event.c:6180
 hci_rx_work+0x22e/0xb10 net/bluetooth/hci_core.c:4705
 process_one_work+0x94c/0x1670 kernel/workqueue.c:2269
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2415
 kthread+0x3b5/0x4a0 kernel/kthread.c:291
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:293
Modules linked in:
---[ end trace 905ef6786a414f06 ]---
RIP: 0010:hci_phy_link_complete_evt.isra.0+0x23e/0x790 net/bluetooth/hci_event.c:4926
Code: 48 c1 ea 03 80 3c 02 00 0f 85 3e 05 00 00 48 8b 9d 30 09 00 00 48 b8 00 00 00 00 00 fc ff df 48 8d 7b 10 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 da 04 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b
RSP: 0018:ffffc90001897a38 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff871af0e3
RDX: 0000000000000002 RSI: ffffffff871af0f0 RDI: 0000000000000010
RBP: ffff88808f25e000 R08: 0000000000000001 R09: ffff8880a1cf6a88
R10: 0000000000000000 R11: 0000000000000000 R12: dffffc0000000000
R13: ffff8880877f1110 R14: ffff8880926b480b R15: 00000000000000c8
FS:  0000000000000000(0000) GS:ffff8880ae700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fff77d3f7a7 CR3: 000000009291e000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
