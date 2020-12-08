Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2DDAC433FE
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 07:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7970D23A3C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Dec 2020 07:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgLHHl6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Dec 2020 02:41:58 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:41441 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbgLHHl6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Dec 2020 02:41:58 -0500
Received: by mail-il1-f199.google.com with SMTP id f19so15263291ilk.8
        for <linux-bluetooth@vger.kernel.org>; Mon, 07 Dec 2020 23:41:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=RUspfPnjch4mUyKGLxOiRP5+mo2m76pTBBo3OySsIYo=;
        b=dWm/5v7+vQGjvWHXsJn7aJIx1pLrfUUCgdlMtvVREjse9BRHg8eCRgdi7Ed6p5AJ+N
         xGusOSoLOx8a8n8O2h+O2x1NL3fPqTZzXkaCzcZm9WvaO97IaK7xhz8VakPu8xzl0aGY
         iroNxch9X0sZ6UA0txJ/9fOw1qBo2nrFHoLmGd5p3hVg9XcvQV59JiY27CFLBUcziFgL
         9v2HHBXbjUE8WqXkszj01nWcgJRl31oJAsEzg9xlyeJ+O5rYaOhHBoHICIyHw+k8XyaW
         5OuHhLE/bVDAz005qDYdW8HUOQo6WVUIBtdCo1/YKG39l+1JLTkSEMYvi2TyYumborFV
         Zb9w==
X-Gm-Message-State: AOAM532eEpmQLAgfZ7MywuJqcajCuSnATwl0UKwmzknJUqt61nSkusFM
        swLQsE2wztuVhFJF6L6kIFX3WrZtWRI1CJ6OTGOI+ksAq6OY
X-Google-Smtp-Source: ABdhPJwgG/2deafYUvxDNV8ROdSjs4LsO5PX+s8Z0IB2FBHLScSTHmtTWjS4OcYpsLW8VChpEQEWWxzloq8n/LHM2lYC0wbgcqJz
MIME-Version: 1.0
X-Received: by 2002:a5d:8791:: with SMTP id f17mr23789417ion.80.1607413271163;
 Mon, 07 Dec 2020 23:41:11 -0800 (PST)
Date:   Mon, 07 Dec 2020 23:41:11 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000008f84205b5ef1170@google.com>
Subject: general protection fault in hci_chan_del
From:   syzbot <syzbot+4c574753a325a601326c@syzkaller.appspotmail.com>
To:     davem@davemloft.net, johan.hedberg@gmail.com, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    b3298500 Merge tag 'for-5.10/dm-fixes' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=144f0bf7500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e49433cfed49b7d9
dashboard link: https://syzkaller.appspot.com/bug?extid=4c574753a325a601326c
compiler:       gcc (GCC) 10.1.0-syz 20200507

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4c574753a325a601326c@syzkaller.appspotmail.com

general protection fault, probably for non-canonical address 0xdffffc0000000b00: 0000 [#1] PREEMPT SMP KASAN
KASAN: probably user-memory-access in range [0x0000000000005800-0x0000000000005807]
CPU: 1 PID: 30846 Comm: syz-executor.1 Not tainted 5.10.0-rc6-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:__list_del_entry_valid+0x81/0xf0 lib/list_debug.c:51
Code: 0f 84 d3 c0 fb 04 48 b8 22 01 00 00 00 00 ad de 49 39 c4 0f 84 d4 c0 fb 04 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 75 51 49 8b 14 24 48 39 ea 0f 85 8b c0 fb 04 49 8d 7d
RSP: 0018:ffffc9001653fb50 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000054 RCX: ffffc9000aab6000
RDX: 0000000000000b00 RSI: ffffffff87df1892 RDI: ffff888014569f08
RBP: ffff888014569f00 R08: 0000000000000001 R09: ffff88801a734a77
R10: ffffed10034e694e R11: 0000000000000001 R12: 0000000000005800
R13: 3000004010000000 R14: fffffbfff19608c8 R15: 0000000000000067
FS:  00007f7eae8b2700(0000) GS:ffff8880b9f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055c3b4ac8030 CR3: 0000000025fa7000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 __list_del_entry include/linux/list.h:132 [inline]
 list_del_rcu include/linux/rculist.h:166 [inline]
 hci_chan_del+0x4e/0x200 net/bluetooth/hci_conn.c:1733
 l2cap_conn_del+0x478/0x7b0 net/bluetooth/l2cap_core.c:1900
 l2cap_disconn_cfm net/bluetooth/l2cap_core.c:8161 [inline]
 l2cap_disconn_cfm+0x98/0xd0 net/bluetooth/l2cap_core.c:8154
 hci_disconn_cfm include/net/bluetooth/hci_core.h:1441 [inline]
 hci_conn_hash_flush+0x127/0x260 net/bluetooth/hci_conn.c:1557
 hci_dev_do_close+0x569/0x1110 net/bluetooth/hci_core.c:1770
 hci_rfkill_set_block+0x19c/0x1d0 net/bluetooth/hci_core.c:2209
 rfkill_set_block+0x1f9/0x540 net/rfkill/core.c:341
 rfkill_fop_write+0x267/0x500 net/rfkill/core.c:1240
 vfs_write+0x28e/0xa30 fs/read_write.c:603
 ksys_write+0x1ee/0x250 fs/read_write.c:658
 do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x45de79
Code: 0d b4 fb ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 0f 83 db b3 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f7eae8b1c68 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 000000000045de79
RDX: 0000000000000008 RSI: 0000000020000000 RDI: 0000000000000003
RBP: 000000000118bf60 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000118bf2c
R13: 000000000169fb7f R14: 00007f7eae8b29c0 R15: 000000000118bf2c
Modules linked in:
---[ end trace 8aa7b596113f27d8 ]---
RIP: 0010:__list_del_entry_valid+0x81/0xf0 lib/list_debug.c:51
Code: 0f 84 d3 c0 fb 04 48 b8 22 01 00 00 00 00 ad de 49 39 c4 0f 84 d4 c0 fb 04 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 75 51 49 8b 14 24 48 39 ea 0f 85 8b c0 fb 04 49 8d 7d
RSP: 0018:ffffc9001653fb50 EFLAGS: 00010206
RAX: dffffc0000000000 RBX: 0000000000000054 RCX: ffffc9000aab6000
RDX: 0000000000000b00 RSI: ffffffff87df1892 RDI: ffff888014569f08
RBP: ffff888014569f00 R08: 0000000000000001 R09: ffff88801a734a77
R10: ffffed10034e694e R11: 0000000000000001 R12: 0000000000005800
R13: 3000004010000000 R14: fffffbfff19608c8 R15: 0000000000000067
FS:  00007f7eae8b2700(0000) GS:ffff8880b9f00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000001590004 CR3: 0000000025fa7000 CR4: 00000000001506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
