Return-Path: <SRS0=SJVD=4F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8629C7619B
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Feb 2020 03:27:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6A4E20659
	for <linux-bluetooth@archiver.kernel.org>; Mon, 17 Feb 2020 03:27:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728176AbgBQD1N (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 16 Feb 2020 22:27:13 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:52422 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727668AbgBQD1M (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 16 Feb 2020 22:27:12 -0500
Received: by mail-io1-f70.google.com with SMTP id l62so10997707ioa.19
        for <linux-bluetooth@vger.kernel.org>; Sun, 16 Feb 2020 19:27:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=dEhJDZdogk/AzHtnY6lpncC9g7Pr4YtHwsSeRTNBiSA=;
        b=oE0njuU9gnn8LW+TCtatw6CF1ny+tU1sa0+su+z722ujunKak3QjM7g0kKMqGhLO1T
         Ew6rx3KGd2Ov15prw0H3TYeHR7Wgn2TPCclWzCYdrkz68w5f3qROX6achShE8ix2pgaF
         pKlJcW48StgNai4cSlBf8AQGREk+TB20I3wO/Gv/W+g62JoPRDAjQOFX/lNP4JLQKr36
         PMXTYloq8YT0cWpoEd8veia9qe465Ix5J+FLUnkIyUhgug3imXNpYZ9NH3efPcbdJE94
         G3zbEWC9HwKWDtJwJz06jmhZGoRRL7eze1yspauq1qAmKb2S8Rvlge3YwodAh/zEl2RF
         ts+w==
X-Gm-Message-State: APjAAAWAiRoMVcvga80uunUJ02hVTWzumtG6NsU/x0vT2xb1L2FAH3dR
        ZQHtCmsFhF+u9z5TGr6lkeaGLrADeAE9TjZBX16rZoYT4zxG
X-Google-Smtp-Source: APXvYqxXNI5Jk/qaZxKOHyL02SDG44ZkAdM7TaWwvHZGz4oon7FeNzBnPHZH/Tj4CwIP11FXVPI+XTQIroQ4XyIQdkSoUfIy5Rhw
MIME-Version: 1.0
X-Received: by 2002:a02:742:: with SMTP id f63mr11168517jaf.138.1581910032194;
 Sun, 16 Feb 2020 19:27:12 -0800 (PST)
Date:   Sun, 16 Feb 2020 19:27:12 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000089226a059ebd21ab@google.com>
Subject: KMSAN: uninit-value in hci_cmd_timeout
From:   syzbot <syzbot+d5eabae89ae62371887f@syzkaller.appspotmail.com>
To:     davem@davemloft.net, glider@google.com, johan.hedberg@gmail.com,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    686a4f77 kmsan: don't compile memmove
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=15b019d9e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e10654781bc1f11c
dashboard link: https://syzkaller.appspot.com/bug?extid=d5eabae89ae62371887f
compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+d5eabae89ae62371887f@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in hci_cmd_timeout+0x2bd/0x2d0 net/bluetooth/hci_core.c:2637
CPU: 0 PID: 5 Comm: kworker/0:0 Not tainted 5.5.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Workqueue: events hci_cmd_timeout
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x1c9/0x220 lib/dump_stack.c:118
 kmsan_report+0xf7/0x1e0 mm/kmsan/kmsan_report.c:118
 __msan_warning+0x58/0xa0 mm/kmsan/kmsan_instr.c:215
 hci_cmd_timeout+0x2bd/0x2d0 net/bluetooth/hci_core.c:2637
 process_one_work+0x1552/0x1ef0 kernel/workqueue.c:2264
 worker_thread+0xef6/0x2450 kernel/workqueue.c:2410
 kthread+0x4b5/0x4f0 kernel/kthread.c:256
 ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:353

Uninit was created at:
 kmsan_save_stack_with_flags mm/kmsan/kmsan.c:144 [inline]
 kmsan_internal_poison_shadow+0x66/0xd0 mm/kmsan/kmsan.c:127
 kmsan_slab_alloc+0x8a/0xe0 mm/kmsan/kmsan_hooks.c:82
 slab_alloc_node mm/slub.c:2774 [inline]
 slab_alloc mm/slub.c:2783 [inline]
 kmem_cache_alloc+0x711/0xd70 mm/slub.c:2788
 skb_clone+0x328/0x5d0 net/core/skbuff.c:1448
 hci_cmd_work+0x12f/0x4f0 net/bluetooth/hci_core.c:4527
 process_one_work+0x1552/0x1ef0 kernel/workqueue.c:2264
 worker_thread+0xef6/0x2450 kernel/workqueue.c:2410
 kthread+0x4b5/0x4f0 kernel/kthread.c:256
 ret_from_fork+0x35/0x40 arch/x86/entry/entry_64.S:353
=====================================================


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
