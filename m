Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C50B5C433ED
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Apr 2021 06:39:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 876C061445
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Apr 2021 06:39:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230141AbhDWGj4 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Apr 2021 02:39:56 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:50840 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbhDWGjz (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Apr 2021 02:39:55 -0400
Received: by mail-il1-f199.google.com with SMTP id d2-20020a056e020c02b029013731419ee1so20733573ile.17
        for <linux-bluetooth@vger.kernel.org>; Thu, 22 Apr 2021 23:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=mz6YscuvZogBNVtCM3+B/kPlahbgXIU6kxtAJ38URss=;
        b=qE2JMSSDhCUW9wuVHJJmPh1bIsq23q9nPYKjdkIPhSl6bGIrZtlGWDm3LpggEOcn4q
         RYpTcOF7nlTDOT6G8UiMugDJsRe6pSIEcOpZQC/V5AfomE6qXhLaJ1NAllBPwt7I/GwI
         SDMDRXNNiN2bi4XPsT1sqRFgWr95Ivj5rd6NcZxr+Jvu8ndA2vVOWVBbZS8r1JQO01h5
         zoaB2qK+aBCvJINQnGZeWn555469IcWnVxKdIG0JXXGzUm4KokTCCM3RV2Hz9PA+KDv5
         NNEn/7stkdOHlvxL/XwryEwtGH7PKGUfHfQGV+5PkBV4XHj2+gC9w37089PA8+daTgKG
         jSIg==
X-Gm-Message-State: AOAM5301iBx+SVykZs3c5vUHbtab2PJFIPb6Sh3O4vTn4JnJu4yat7b5
        KnAsIQgPlYvtYYAC56L95m4F8yZLfjmvnjoOxlcjoqkOdMu2
X-Google-Smtp-Source: ABdhPJx5rVdBAWR6yLoY6VS2F6GSO1mNHqq/d0GsQrzl6UBCH65Jgfp7PUakW2CmpeMeqZ/hWaLTDe13ZTnq27h8fMBEuNQ02WIa
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154d:: with SMTP id j13mr1694340ilu.46.1619159959603;
 Thu, 22 Apr 2021 23:39:19 -0700 (PDT)
Date:   Thu, 22 Apr 2021 23:39:19 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003a11a005c09e0e6e@google.com>
Subject: [syzbot] general protection fault in qca_power_shutdown
From:   syzbot <syzbot+adafc67b05ed63665d5e@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    c98ff1d0 Merge tag 'scsi-fixes' of git://git.kernel.org/pu..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16d44341d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=339c2ecce8fdd1d0
dashboard link: https://syzkaller.appspot.com/bug?extid=adafc67b05ed63665d5e

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+adafc67b05ed63665d5e@syzkaller.appspotmail.com

Bluetooth: hci7: Reading QCA version information failed (-110)
Bluetooth: hci7: Retry BT power ON:0
general protection fault, probably for non-canonical address 0xdffffc000000000f: 0000 [#1] PREEMPT SMP KASAN
KASAN: null-ptr-deref in range [0x0000000000000078-0x000000000000007f]
CPU: 1 PID: 6293 Comm: kworker/u5:5 Not tainted 5.12.0-rc7-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: hci7 hci_power_on
RIP: 0010:dev_get_drvdata include/linux/device.h:666 [inline]
RIP: 0010:serdev_device_get_drvdata include/linux/serdev.h:117 [inline]
RIP: 0010:qca_soc_type drivers/bluetooth/hci_qca.c:240 [inline]
RIP: 0010:qca_power_shutdown+0x77/0x3b0 drivers/bluetooth/hci_qca.c:1821
Code: 4c 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 e8 02 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 75 08 49 8d 7e 78 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 ae 02 00 00 4d 85 f6 4d 8b 6e 78 41 bc 01 00 00
RSP: 0018:ffffc9000193f978 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff888024c82000 RCX: 0000000000000000
RDX: 000000000000000f RSI: ffffffff864835a6 RDI: 0000000000000078
RBP: ffff88802818b800 R08: 0000000000000024 R09: 0000000000000000
R10: ffffffff815bdabe R11: 0000000000000000 R12: dffffc0000000000
R13: ffff88802818b800 R14: 0000000000000000 R15: ffff88802818b808
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004e4a61 CR3: 000000007172f000 CR4: 00000000001526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 qca_setup+0x912/0x2070 drivers/bluetooth/hci_qca.c:1740
 hci_uart_setup+0x1b1/0x480 drivers/bluetooth/hci_ldisc.c:423
 hci_dev_do_open+0x3e1/0x1a00 net/bluetooth/hci_core.c:1499
 hci_power_on+0x133/0x650 net/bluetooth/hci_core.c:2247
 process_one_work+0x98d/0x1600 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294
Modules linked in:
---[ end trace d4921a9b71de1581 ]---
RIP: 0010:dev_get_drvdata include/linux/device.h:666 [inline]
RIP: 0010:serdev_device_get_drvdata include/linux/serdev.h:117 [inline]
RIP: 0010:qca_soc_type drivers/bluetooth/hci_qca.c:240 [inline]
RIP: 0010:qca_power_shutdown+0x77/0x3b0 drivers/bluetooth/hci_qca.c:1821
Code: 4c 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 e8 02 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 75 08 49 8d 7e 78 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 ae 02 00 00 4d 85 f6 4d 8b 6e 78 41 bc 01 00 00
RSP: 0018:ffffc9000193f978 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: ffff888024c82000 RCX: 0000000000000000
RDX: 000000000000000f RSI: ffffffff864835a6 RDI: 0000000000000078
RBP: ffff88802818b800 R08: 0000000000000024 R09: 0000000000000000
R10: ffffffff815bdabe R11: 0000000000000000 R12: dffffc0000000000
R13: ffff88802818b800 R14: 0000000000000000 R15: ffff88802818b808
FS:  0000000000000000(0000) GS:ffff8880b9d00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004e4a61 CR3: 000000007172f000 CR4: 00000000001526e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
