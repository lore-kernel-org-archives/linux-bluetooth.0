Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA58C433DB
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Feb 2021 08:37:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B52264FCA
	for <linux-bluetooth@archiver.kernel.org>; Sat,  6 Feb 2021 08:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbhBFIg6 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 6 Feb 2021 03:36:58 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:53057 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbhBFIg5 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 6 Feb 2021 03:36:57 -0500
Received: by mail-io1-f72.google.com with SMTP id x17so8278920iov.19
        for <linux-bluetooth@vger.kernel.org>; Sat, 06 Feb 2021 00:36:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=Vjllui7uaJPc8hueRFxPXFS2fUrnK2hwtttKy49Se7c=;
        b=eFPcz7HVl6ob7PT6YGbsYpxf0ieBpK1oHkrv94tf2ltHQHJlRRCUmqApnOqqDXeJSk
         x3KDkWOrBjp9dlH8VSosEphkCop0xPIj4gmbXLuAsu75W7dfAuQuaqSgoBEPFP6+QDjO
         tvqXR4KGstRHVixkj7XAwSDZ6yuc2nAMWxK1sKrgClFU5bSGWE3OyL6Dsq7twlYciMmO
         Zqo6C4sWWcdGT5MGx+hj7ykIL/c38ne4CPsZiGcUsOVAcroGiWZMU8DfkxhRhLX0vm0X
         rVK1gnJ7h8l41nWpepr5H27FJsL7VYwFBmbe9anQmtod7Kl8JddAnBN23YcP6nIZhRkA
         sBig==
X-Gm-Message-State: AOAM5319LoaSeBYx6kYYl7qwBK5BrEWLjUhL0463aEJTVEcg4JAZm7st
        RXyPnJYyWOZsqwS24nYm5q3eyKTD3grfvzhk9cEngl9kLmwg
X-Google-Smtp-Source: ABdhPJxdYczRveQpCPBHDtTkJB7uRbqfviBPRd7k0i4Q1KOsXvzGLGjVkTTmxVFUU3t6/hf80LeKtMR7PaCztG8NUy+cBum5e6ty
MIME-Version: 1.0
X-Received: by 2002:a6b:fb0f:: with SMTP id h15mr7682245iog.27.1612600573798;
 Sat, 06 Feb 2021 00:36:13 -0800 (PST)
Date:   Sat, 06 Feb 2021 00:36:13 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005dacd805baa6d46e@google.com>
Subject: KASAN: wild-memory-access Write in l2cap_chan_put
From:   syzbot <syzbot+a384548b03ddcbbaf619@syzkaller.appspotmail.com>
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

HEAD commit:    88bb507a Merge tag 'media/v5.11-3' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=112bab6f500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6e95b9873f64b36c
dashboard link: https://syzkaller.appspot.com/bug?extid=a384548b03ddcbbaf619
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a384548b03ddcbbaf619@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: wild-memory-access in instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
BUG: KASAN: wild-memory-access in atomic_fetch_sub_release include/asm-generic/atomic-instrumented.h:220 [inline]
BUG: KASAN: wild-memory-access in __refcount_sub_and_test include/linux/refcount.h:272 [inline]
BUG: KASAN: wild-memory-access in __refcount_dec_and_test include/linux/refcount.h:315 [inline]
BUG: KASAN: wild-memory-access in refcount_dec_and_test include/linux/refcount.h:333 [inline]
BUG: KASAN: wild-memory-access in kref_put include/linux/kref.h:64 [inline]
BUG: KASAN: wild-memory-access in l2cap_chan_put+0x35/0x2e0 net/bluetooth/l2cap_core.c:502
Write of size 4 at addr aaaa00aaaaaaaac2 by task kworker/2:22/10838

CPU: 2 PID: 10838 Comm: kworker/2:22 Not tainted 5.11.0-rc6-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Workqueue: events l2cap_chan_timeout
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 __kasan_report mm/kasan/report.c:400 [inline]
 kasan_report.cold+0x5f/0xd5 mm/kasan/report.c:413
 check_memory_region_inline mm/kasan/generic.c:179 [inline]
 check_memory_region+0x13d/0x180 mm/kasan/generic.c:185
 instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
 atomic_fetch_sub_release include/asm-generic/atomic-instrumented.h:220 [inline]
 __refcount_sub_and_test include/linux/refcount.h:272 [inline]
 __refcount_dec_and_test include/linux/refcount.h:315 [inline]
 refcount_dec_and_test include/linux/refcount.h:333 [inline]
 kref_put include/linux/kref.h:64 [inline]
 l2cap_chan_put+0x35/0x2e0 net/bluetooth/l2cap_core.c:502
 l2cap_sock_kill+0xd0/0x240 net/bluetooth/l2cap_sock.c:1217
 l2cap_chan_timeout+0x1cc/0x2f0 net/bluetooth/l2cap_core.c:438
 process_one_work+0x98d/0x15f0 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
==================================================================
Kernel panic - not syncing: panic_on_warn set ...
CPU: 2 PID: 10838 Comm: kworker/2:22 Tainted: G    B             5.11.0-rc6-syzkaller #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
Workqueue: events l2cap_chan_timeout
Call Trace:
 __dump_stack lib/dump_stack.c:79 [inline]
 dump_stack+0x107/0x163 lib/dump_stack.c:120
 panic+0x306/0x73d kernel/panic.c:231
 end_report+0x58/0x5e mm/kasan/report.c:100
 __kasan_report mm/kasan/report.c:403 [inline]
 kasan_report.cold+0x67/0xd5 mm/kasan/report.c:413
 check_memory_region_inline mm/kasan/generic.c:179 [inline]
 check_memory_region+0x13d/0x180 mm/kasan/generic.c:185
 instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
 atomic_fetch_sub_release include/asm-generic/atomic-instrumented.h:220 [inline]
 __refcount_sub_and_test include/linux/refcount.h:272 [inline]
 __refcount_dec_and_test include/linux/refcount.h:315 [inline]
 refcount_dec_and_test include/linux/refcount.h:333 [inline]
 kref_put include/linux/kref.h:64 [inline]
 l2cap_chan_put+0x35/0x2e0 net/bluetooth/l2cap_core.c:502
 l2cap_sock_kill+0xd0/0x240 net/bluetooth/l2cap_sock.c:1217
 l2cap_chan_timeout+0x1cc/0x2f0 net/bluetooth/l2cap_core.c:438
 process_one_work+0x98d/0x15f0 kernel/workqueue.c:2275
 worker_thread+0x64c/0x1120 kernel/workqueue.c:2421
 kthread+0x3b1/0x4a0 kernel/kthread.c:292
 ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:296
Dumping ftrace buffer:
   (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 1 seconds..
ACPI MEMORY or I/O RESET_REG.


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
