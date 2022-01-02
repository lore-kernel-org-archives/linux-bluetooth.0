Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D28C433EF
	for <linux-bluetooth@archiver.kernel.org>; Sun,  2 Jan 2022 22:23:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiABWXT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 2 Jan 2022 17:23:19 -0500
Received: from mail-io1-f69.google.com ([209.85.166.69]:42657 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbiABWXT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 2 Jan 2022 17:23:19 -0500
Received: by mail-io1-f69.google.com with SMTP id k125-20020a6bba83000000b005e7a312f86dso16656211iof.9
        for <linux-bluetooth@vger.kernel.org>; Sun, 02 Jan 2022 14:23:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=RZcgwQ127RRDjLwS9pjPoFiYu/8bbP+WbwniW4lbksU=;
        b=m3rUvQRpuyj39Cc08X343FAPm9JKA3zwoMiFGdeh5Ks4bS72NS3E2idbu6JPRut1fB
         dMh3u9tyYyMpqk+msdmKqX0Ei7hxuk1b8D2tC981cvyJSnwIzXVGUQxnAlRLQZUcw8MV
         i4ueOFXghkBii+AOixyly5auNA7bnSqay2yRoup0MY8fgwesPGybYhgaQYO/NzyLcSL9
         mgES7VR4AyBh4D9mBB8hPVi6EuJhzxQWebqQn7R9amtviA8tqpyW8hatU7bDoIWXaFXN
         abBTj/6M7c4mQnsUyFzjmGS5eof15Aypfw09+N6Pj9sUcMrnZwsTJqIgWZ8lvX++8x4S
         v3FQ==
X-Gm-Message-State: AOAM530FpB8KBwleGpPrwpg+S9fiPReZMVuneh8rlsVllYeb17rQgPvz
        5/e5SdG+woNJIh1LHIEDGktgQI3U4j+z6tjxWPoopixnrET2
X-Google-Smtp-Source: ABdhPJwkty2r3iKRy9Ev0KrYdlKg+iUkF3bJryENYKIu+EoHKfmvPOjd2isAbm3FYF7brT3/9lzTxBwNdg5ry4C2wjkTvPgwDcUP
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14d3:: with SMTP id b19mr19555616iow.17.1641162198638;
 Sun, 02 Jan 2022 14:23:18 -0800 (PST)
Date:   Sun, 02 Jan 2022 14:23:18 -0800
In-Reply-To: <000000000000f5dc0805cf7807a7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000de69a305d4a0d958@google.com>
Subject: Re: [syzbot] KMSAN: uninit-value in hci_conn_request_evt
From:   syzbot <syzbot+8f84cf3ec5c288e779ef@syzkaller.appspotmail.com>
To:     davem@davemloft.net, glider@google.com, johan.hedberg@gmail.com,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    81c325bbf94e kmsan: hooks: do not check memory in kmsan_in..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=103ea4c7b00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2d8b9a11641dc9aa
dashboard link: https://syzkaller.appspot.com/bug?extid=8f84cf3ec5c288e779ef
compiler:       clang version 14.0.0 (/usr/local/google/src/llvm-git-monorepo 2b554920f11c8b763cd9ed9003f4e19b919b8e1f), GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10051b67b00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12148a3bb00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8f84cf3ec5c288e779ef@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in hci_proto_connect_ind include/net/bluetooth/hci_core.h:1485 [inline]
BUG: KMSAN: uninit-value in hci_conn_request_evt+0x22b/0x13c0 net/bluetooth/hci_event.c:2827
 hci_proto_connect_ind include/net/bluetooth/hci_core.h:1485 [inline]
 hci_conn_request_evt+0x22b/0x13c0 net/bluetooth/hci_event.c:2827
 hci_event_packet+0x1452/0x23e0 net/bluetooth/hci_event.c:6360
 hci_rx_work+0x6a0/0xd00 net/bluetooth/hci_core.c:5084
 process_one_work+0xdb9/0x1820 kernel/workqueue.c:2298
 worker_thread+0x10bc/0x21f0 kernel/workqueue.c:2445
 kthread+0x721/0x850 kernel/kthread.c:327
 ret_from_fork+0x1f/0x30

Uninit was created at:
 slab_post_alloc_hook mm/slab.h:524 [inline]
 slab_alloc_node mm/slub.c:3251 [inline]
 __kmalloc_node_track_caller+0xe0c/0x1510 mm/slub.c:4974
 kmalloc_reserve net/core/skbuff.c:354 [inline]
 __alloc_skb+0x545/0xf90 net/core/skbuff.c:426
 alloc_skb include/linux/skbuff.h:1126 [inline]
 bt_skb_alloc include/net/bluetooth/bluetooth.h:413 [inline]
 vhci_get_user drivers/bluetooth/hci_vhci.c:287 [inline]
 vhci_write+0x187/0x8f0 drivers/bluetooth/hci_vhci.c:407
 call_write_iter include/linux/fs.h:2162 [inline]
 new_sync_write fs/read_write.c:503 [inline]
 vfs_write+0x1318/0x2030 fs/read_write.c:590
 ksys_write+0x28b/0x510 fs/read_write.c:643
 __do_sys_write fs/read_write.c:655 [inline]
 __se_sys_write fs/read_write.c:652 [inline]
 __x64_sys_write+0xdb/0x120 fs/read_write.c:652
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x54/0xd0 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x44/0xae

CPU: 1 PID: 43 Comm: kworker/u5:0 Not tainted 5.16.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: hci0 hci_rx_work
=====================================================

