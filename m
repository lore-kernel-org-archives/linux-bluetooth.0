Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69A4FC25B08
	for <linux-bluetooth@archiver.kernel.org>; Sat, 20 Aug 2022 11:58:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345941AbiHTL6g (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 20 Aug 2022 07:58:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241030AbiHTL6e (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 20 Aug 2022 07:58:34 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32742C135
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Aug 2022 04:58:33 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id h8-20020a92c268000000b002e95299cff0so2162193ild.23
        for <linux-bluetooth@vger.kernel.org>; Sat, 20 Aug 2022 04:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=vy3gLv5pvPQlLz2bjwfmQURwI/ANJztqCqsTatb7lPc=;
        b=5/JuCW/k+kpx++R20QIS/xSwPIizJS7woME3W1NXpD609AGqEx1CQNg5EU+YAzIU0D
         WNuy8qS+SF1malkC8cGyBPIsiAsl1qT9P/t1gJueOfaAlDh1QhtOYfr41G0lBiyehSXW
         ajdNzzTAMAFAoNwsvKFbPW4kSyMFJYEmvxB4CHkeVGGmeqKBymMC+qe6LV+NUv6G1zQ/
         qgn0YquxLuejPJ+RrzNtcuyg4A1BCZ57hRCPSfrEXpKvM8v8cSrH7bqX/RA4yDajrXuY
         0e9s+L3KWRUHqHm4izClJ/oaw7NhuVJt+SVgKhH/qEb/5TqW/IppR+lWYrENi581j2Xt
         rSdA==
X-Gm-Message-State: ACgBeo0jrdwwJK+DZOJk5pKWnqhLktW6bnSSYhRIZK0GsA43y2+qiVtu
        KFZCBdsj+D+l65XdOfkEwPKg+0ultktPVSelYvbIZMC7i9XC
X-Google-Smtp-Source: AA6agR42s0Q0/ClM39KKuAgSZ1cZ949PdC2kNOjk+fj2W/VpQvCJ6SFgRvV4AKLjivqd5ZqOQ3G3ZG2+U4IPcuN0qZnCCyqt7jZr
MIME-Version: 1.0
X-Received: by 2002:a05:6602:14c5:b0:689:5640:5b0f with SMTP id
 b5-20020a05660214c500b0068956405b0fmr3941282iow.70.1660996712989; Sat, 20 Aug
 2022 04:58:32 -0700 (PDT)
Date:   Sat, 20 Aug 2022 04:58:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000d0b1905e6aaef64@google.com>
Subject: [syzbot] memory leak in vhci_write
From:   syzbot <syzbot+8f819e36e01022991cfa@syzkaller.appspotmail.com>
To:     johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    7ebfc85e2cd7 Merge tag 'net-6.0-rc1' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1206e2d3080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6e4b25d26c713a1b
dashboard link: https://syzkaller.appspot.com/bug?extid=8f819e36e01022991cfa
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11e8bd97080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=143c9fc3080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8f819e36e01022991cfa@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88810d81ac00 (size 240):
  comm "syz-executor219", pid 3615, jiffies 4294947117 (age 12.320s)
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<ffffffff838733d9>] __alloc_skb+0x1f9/0x270 net/core/skbuff.c:418
    [<ffffffff833f742f>] alloc_skb include/linux/skbuff.h:1257 [inline]
    [<ffffffff833f742f>] bt_skb_alloc include/net/bluetooth/bluetooth.h:469 [inline]
    [<ffffffff833f742f>] vhci_get_user drivers/bluetooth/hci_vhci.c:391 [inline]
    [<ffffffff833f742f>] vhci_write+0x5f/0x230 drivers/bluetooth/hci_vhci.c:511
    [<ffffffff815e398d>] call_write_iter include/linux/fs.h:2192 [inline]
    [<ffffffff815e398d>] new_sync_write fs/read_write.c:491 [inline]
    [<ffffffff815e398d>] vfs_write+0x42d/0x540 fs/read_write.c:578
    [<ffffffff815e3cdd>] ksys_write+0x9d/0x160 fs/read_write.c:631
    [<ffffffff845e0645>] do_syscall_x64 arch/x86/entry/common.c:50 [inline]
    [<ffffffff845e0645>] do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
    [<ffffffff84600087>] entry_SYSCALL_64_after_hwframe+0x63/0xcd



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
