Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A92D9E71D21
	for <linux-bluetooth@archiver.kernel.org>; Fri, 29 Sep 2023 13:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbjI2NIk (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 29 Sep 2023 09:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbjI2NIj (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 29 Sep 2023 09:08:39 -0400
Received: from mail-oi1-f207.google.com (mail-oi1-f207.google.com [209.85.167.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDAD1AB
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Sep 2023 06:08:37 -0700 (PDT)
Received: by mail-oi1-f207.google.com with SMTP id 5614622812f47-3ae5ee6624dso13104708b6e.1
        for <linux-bluetooth@vger.kernel.org>; Fri, 29 Sep 2023 06:08:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695992916; x=1696597716;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ax7MLLiro/+/TuuyfIdn0rQK/ZQI/GFLoQjenylmzgU=;
        b=eAaOk+8+JhJ9MWIqjpr54QEm49MEy5LfzaHsC+pped7GqxaetFSoUVdyJK9IbdldPu
         7GuTan4wUVk/BPKGLrptzitnaxmYDvt0z3ehPpLkgFX/JNTXYSiWGSIRYLHjr9X8YsXG
         gQ+6o0huLhWoe9NT33I3P8yL6LerGrh91z5zj5FEO41e8DCcedQh5652kM4D5YTB7M8e
         GQoq8WHdcklWteRe2JkMjuO/elpjJZ50iIfWskdnPTIXh+RApv75tr/gGpG11aZeWtYd
         wO+VbKR6JeJlHuCBhr0mfG5Xn3KKCDxnMZBB3+zOXw5QDjT3XdcZZUNw4cdJrsiLqxMo
         kXKA==
X-Gm-Message-State: AOJu0YxaBU6SREIf1jp/uXtzZvuUP/byFxVaDYypfcuL105ajTShGEcH
        lMePKx6chvTvHSI1Ix6IFcz36YMA2Q/RQ9VHySSsEfWg2qsq
X-Google-Smtp-Source: AGHT+IEUC6rRpapXNwI25OyExv+6naQlqSFXaxVdWcB1CLibM+DiEGVNaKPWY9kHa0Rd1+Ta5qUT7XYZTcAmbbVFM1cPBdKuyff7
MIME-Version: 1.0
X-Received: by 2002:a05:6808:238f:b0:3a3:7087:bbfb with SMTP id
 bp15-20020a056808238f00b003a37087bbfbmr1932590oib.6.1695992916735; Fri, 29
 Sep 2023 06:08:36 -0700 (PDT)
Date:   Fri, 29 Sep 2023 06:08:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000057faf606067f1f32@google.com>
Subject: [syzbot] [bluetooth?] memory leak in prepare_creds (4)
From:   syzbot <syzbot+2a478080bd86d36bb5ea@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    6465e260f487 Linux 6.6-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11b402cc680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aa96152f5a3192e3
dashboard link: https://syzkaller.appspot.com/bug?extid=2a478080bd86d36bb5ea
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11d97bd4680000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8d4a973843e8/disk-6465e260.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7d5718938500/vmlinux-6465e260.xz
kernel image: https://storage.googleapis.com/syzbot-assets/409606a5d458/bzImage-6465e260.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2a478080bd86d36bb5ea@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888120320240 (size 192):
  comm "syz-executor.1", pid 5087, jiffies 4294976980 (age 8.630s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff812deb3b>] prepare_creds+0x2b/0x460 kernel/cred.c:263
    [<ffffffff812df934>] copy_creds+0x44/0x2c0 kernel/cred.c:368
    [<ffffffff81290f0a>] copy_process+0x6aa/0x2570 kernel/fork.c:2361
    [<ffffffff81292f7b>] kernel_clone+0x11b/0x690 kernel/fork.c:2909
    [<ffffffff8129356c>] __do_sys_clone+0x7c/0xb0 kernel/fork.c:3052
    [<ffffffff84b32fc8>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84b32fc8>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff8881009e7dc0 (size 16):
  comm "syz-executor.1", pid 5087, jiffies 4294976980 (age 8.630s)
  hex dump (first 16 bytes):
    00 00 00 00 00 00 00 00 a8 dd 07 00 81 88 ff ff  ................
  backtrace:
    [<ffffffff815748bb>] __do_kmalloc_node mm/slab_common.c:1022 [inline]
    [<ffffffff815748bb>] __kmalloc+0x4b/0x150 mm/slab_common.c:1036
    [<ffffffff82349a61>] kmalloc include/linux/slab.h:603 [inline]
    [<ffffffff82349a61>] kzalloc include/linux/slab.h:720 [inline]
    [<ffffffff82349a61>] lsm_cred_alloc security/security.c:577 [inline]
    [<ffffffff82349a61>] security_prepare_creds+0x121/0x140 security/security.c:2950
    [<ffffffff812dedec>] prepare_creds+0x2dc/0x460 kernel/cred.c:294
    [<ffffffff812df934>] copy_creds+0x44/0x2c0 kernel/cred.c:368
    [<ffffffff81290f0a>] copy_process+0x6aa/0x2570 kernel/fork.c:2361
    [<ffffffff81292f7b>] kernel_clone+0x11b/0x690 kernel/fork.c:2909
    [<ffffffff8129356c>] __do_sys_clone+0x7c/0xb0 kernel/fork.c:3052
    [<ffffffff84b32fc8>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff84b32fc8>] do_syscall_64+0x38/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84c0008b>] entry_SYSCALL_64_after_hwframe+0x63/0xcd

BUG: memory leak
unreferenced object 0xffff88812014a7e0 (size 96):
  comm "kworker/0:5", pid 5153, jiffies 4294977028 (age 8.150s)
  hex dump (first 32 bytes):
    fa 50 25 82 2e 06 06 00 00 00 00 00 00 00 00 00  .P%.............
    00 00 00 00 00 00 00 00 28 00 00 00 01 00 06 10  ........(.......
  backtrace:
    [<ffffffff815748bb>] __do_kmalloc_node mm/slab_common.c:1022 [inline]
    [<ffffffff815748bb>] __kmalloc+0x4b/0x150 mm/slab_common.c:1036
    [<ffffffff8474bca8>] kmalloc include/linux/slab.h:603 [inline]
    [<ffffffff8474bca8>] kzalloc include/linux/slab.h:720 [inline]
    [<ffffffff8474bca8>] cfg80211_inform_single_bss_frame_data+0x198/0x8d0 net/wireless/scan.c:2852
    [<ffffffff8474e2fd>] cfg80211_inform_bss_frame_data+0x6d/0x140 net/wireless/scan.c:2912
    [<ffffffff84801ec7>] ieee80211_bss_info_update+0x177/0x320 net/mac80211/scan.c:211
    [<ffffffff848110c4>] ieee80211_rx_bss_info net/mac80211/ibss.c:1124 [inline]
    [<ffffffff848110c4>] ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1613 [inline]
    [<ffffffff848110c4>] ieee80211_ibss_rx_queued_mgmt+0x894/0x1210 net/mac80211/ibss.c:1642
    [<ffffffff84813c81>] ieee80211_iface_process_skb net/mac80211/iface.c:1604 [inline]
    [<ffffffff84813c81>] ieee80211_iface_work+0x601/0x790 net/mac80211/iface.c:1658
    [<ffffffff84731458>] cfg80211_wiphy_work+0xf8/0x110 net/wireless/core.c:435
    [<ffffffff812c8d9d>] process_one_work+0x23d/0x530 kernel/workqueue.c:2630
    [<ffffffff812c9947>] process_scheduled_works kernel/workqueue.c:2703 [inline]
    [<ffffffff812c9947>] worker_thread+0x327/0x590 kernel/workqueue.c:2784
    [<ffffffff812d6e1b>] kthread+0x12b/0x170 kernel/kthread.c:388
    [<ffffffff81149f25>] ret_from_fork+0x45/0x50 arch/x86/kernel/process.c:147
    [<ffffffff81002be1>] ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304

BUG: memory leak
unreferenced object 0xffff88812014a780 (size 96):
  comm "kworker/0:5", pid 5153, jiffies 4294977028 (age 8.150s)
  hex dump (first 32 bytes):
    5c 51 25 82 2e 06 06 00 00 00 00 00 00 00 00 00  \Q%.............
    00 00 00 00 00 00 00 00 28 00 00 00 01 00 06 10  ........(.......
  backtrace:
    [<ffffffff815748bb>] __do_kmalloc_node mm/slab_common.c:1022 [inline]
    [<ffffffff815748bb>] __kmalloc+0x4b/0x150 mm/slab_common.c:1036
    [<ffffffff8474bca8>] kmalloc include/linux/slab.h:603 [inline]
    [<ffffffff8474bca8>] kzalloc include/linux/slab.h:720 [inline]
    [<ffffffff8474bca8>] cfg80211_inform_single_bss_frame_data+0x198/0x8d0 net/wireless/scan.c:2852
    [<ffffffff8474e2fd>] cfg80211_inform_bss_frame_data+0x6d/0x140 net/wireless/scan.c:2912
    [<ffffffff84801ec7>] ieee80211_bss_info_update+0x177/0x320 net/mac80211/scan.c:211
    [<ffffffff848110c4>] ieee80211_rx_bss_info net/mac80211/ibss.c:1124 [inline]
    [<ffffffff848110c4>] ieee80211_rx_mgmt_probe_beacon net/mac80211/ibss.c:1613 [inline]
    [<ffffffff848110c4>] ieee80211_ibss_rx_queued_mgmt+0x894/0x1210 net/mac80211/ibss.c:1642
    [<ffffffff84813c81>] ieee80211_iface_process_skb net/mac80211/iface.c:1604 [inline]
    [<ffffffff84813c81>] ieee80211_iface_work+0x601/0x790 net/mac80211/iface.c:1658
    [<ffffffff84731458>] cfg80211_wiphy_work+0xf8/0x110 net/wireless/core.c:435
    [<ffffffff812c8d9d>] process_one_work+0x23d/0x530 kernel/workqueue.c:2630
    [<ffffffff812c9947>] process_scheduled_works kernel/workqueue.c:2703 [inline]
    [<ffffffff812c9947>] worker_thread+0x327/0x590 kernel/workqueue.c:2784
    [<ffffffff812d6e1b>] kthread+0x12b/0x170 kernel/kthread.c:388
    [<ffffffff81149f25>] ret_from_fork+0x45/0x50 arch/x86/kernel/process.c:147
    [<ffffffff81002be1>] ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the bug is already fixed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite bug's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the bug is a duplicate of another bug, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup
