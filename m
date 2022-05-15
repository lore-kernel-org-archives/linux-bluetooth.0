Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C697DC433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun, 15 May 2022 03:20:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234621AbiEODUZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 14 May 2022 23:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234122AbiEODUW (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 14 May 2022 23:20:22 -0400
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691B81903B
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 May 2022 20:20:21 -0700 (PDT)
Received: by mail-io1-f70.google.com with SMTP id k2-20020a0566022d8200b0065ad142f8c1so7895242iow.12
        for <linux-bluetooth@vger.kernel.org>; Sat, 14 May 2022 20:20:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=0iFkMPMfwtUvdfgO7HetlV9FOdp8ilcyh1fDrc+XrFI=;
        b=tTpyzDrRjYTKVGHvFhzBlJwXIKDDCmnqDzjBQF9KVmON15mr0BGSGZ7BSnL3JxJtFL
         jqZ7mO4/DtJND4CXbz310Vu+seNxtLWYEFegJ7J8bqQ92yZkkdMKI1XwIKqpGeGTbN6z
         ap3CLB6hZH44RZ/KVsX16HUluqV4HBO9RCBm0qoi1MW9O3nGU8ANV4w36AMfIJ6Njn8K
         4lkpu2+fkS5qmA/DCuYv2fkUkMlLc4425d6ba6ZF0H+CCdz4sX7ATCzYVu6cGhFD+yrg
         KY1hEJOh6hA7eRhYwNO0GYt2FKMjdHJ9hqigCZZokBJvK+4ovPC3yQueQ8Y1aOidPnGl
         3lNg==
X-Gm-Message-State: AOAM532tlwkYD/42nVEeE6KEvFXwiBQQqrwgFRfhtsuv/Vn33EtGAGTH
        2be77J1V6MOwHmssWSZMQm3Uf3VJmvzDw5w8Pwa4AHMYfBLj
X-Google-Smtp-Source: ABdhPJyMpwXvhmeQ3UHx8TuwOeyun2S2t6PLtqBuxGQY4+oOABfNzMZE8ue/c5PhZLdww9OppRiC+1DzYQceXCOqTpr8ApiVqsmb
MIME-Version: 1.0
X-Received: by 2002:a6b:3ec6:0:b0:65a:4973:6c87 with SMTP id
 l189-20020a6b3ec6000000b0065a49736c87mr5497953ioa.161.1652584820765; Sat, 14
 May 2022 20:20:20 -0700 (PDT)
Date:   Sat, 14 May 2022 20:20:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000033f9f905df0463c4@google.com>
Subject: [syzbot] WARNING: refcount bug in l2cap_chan_hold
From:   syzbot <syzbot+fd86a41b17a416a37a75@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, johan.hedberg@gmail.com,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    9be9ed2612b5 Merge tag 'platform-drivers-x86-v5.18-4' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=164544f1f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3afe599903e2c6b6
dashboard link: https://syzkaller.appspot.com/bug?extid=fd86a41b17a416a37a75
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17285deaf00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15bd5d3ef00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fd86a41b17a416a37a75@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: addition on 0; use-after-free.
WARNING: CPU: 2 PID: 3674 at lib/refcount.c:25 refcount_warn_saturate+0x169/0x1e0 lib/refcount.c:25
Modules linked in:
CPU: 2 PID: 3674 Comm: kworker/u19:1 Not tainted 5.18.0-rc6-syzkaller-00007-g9be9ed2612b5 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Workqueue: hci0 hci_rx_work
RIP: 0010:refcount_warn_saturate+0x169/0x1e0 lib/refcount.c:25
Code: 09 31 ff 89 de e8 97 44 81 fd 84 db 0f 85 36 ff ff ff e8 aa 40 81 fd 48 c7 c7 80 61 26 8a c6 05 0f 00 ad 09 01 e8 e7 f5 30 05 <0f> 0b e9 17 ff ff ff e8 8b 40 81 fd 0f b6 1d f4 ff ac 09 31 ff 89
RSP: 0018:ffffc90002e17960 EFLAGS: 00010282
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: ffff8880187b2180 RSI: ffffffff815f4a18 RDI: fffff520005c2f1e
RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff815ef3ee R11: 0000000000000000 R12: ffff88801c4a1000
R13: 0000000000000001 R14: 0000000000000000 R15: 0000000000000003
FS:  0000000000000000(0000) GS:ffff88802cc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555556dd1608 CR3: 00000000234d6000 CR4: 0000000000150ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __refcount_add include/linux/refcount.h:199 [inline]
 __refcount_inc include/linux/refcount.h:250 [inline]
 refcount_inc include/linux/refcount.h:267 [inline]
 kref_get include/linux/kref.h:45 [inline]
 l2cap_chan_hold+0xff/0x120 net/bluetooth/l2cap_core.c:497
 l2cap_global_chan_by_psm+0x3b1/0x4a0 net/bluetooth/l2cap_core.c:1986
 l2cap_conless_channel net/bluetooth/l2cap_core.c:7611 [inline]
 l2cap_recv_frame+0x68d/0x8e60 net/bluetooth/l2cap_core.c:7681
 l2cap_recv_acldata+0xa96/0xc10 net/bluetooth/l2cap_core.c:8394
 hci_acldata_packet net/bluetooth/hci_core.c:3633 [inline]
 hci_rx_work+0x4d5/0xd60 net/bluetooth/hci_core.c:3824
 process_one_work+0x996/0x1610 kernel/workqueue.c:2289
 worker_thread+0x665/0x1080 kernel/workqueue.c:2436
 kthread+0x2e9/0x3a0 kernel/kthread.c:376
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:298
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
