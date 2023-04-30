Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79E5AC77B60
	for <linux-bluetooth@archiver.kernel.org>; Sun, 30 Apr 2023 07:52:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229566AbjD3Hwn (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 30 Apr 2023 03:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjD3Hwm (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 30 Apr 2023 03:52:42 -0400
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EA33199A
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Apr 2023 00:52:40 -0700 (PDT)
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-769036b47a7so46142439f.0
        for <linux-bluetooth@vger.kernel.org>; Sun, 30 Apr 2023 00:52:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682841160; x=1685433160;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fDkKPNSsXxANthsudfaiuRAniodyGXR5TzlpJcW5aYk=;
        b=IAvzBTgatf55O+u2RZpYeoIgwUOnlli22Ltk5fPxGAJW8Y7zyNqnfNXIqXseB7ZVFf
         Qzy42vGzT8y8gmD/pbLSTCPYaWORjlDb2xFusAMD190ttnnDiZujFlMovSmQtXBbsLnB
         b36as5t4ipqsCyp4d1L+95jUeaIPKHYGtaQfJyzBZNZo50nEn6HVb7OnyFpvPVr1Rchv
         ScM9HPNy84/PNoVOD8fIZZUYVBwnT77zCx9uaxZiZOwv5OsEJ5d4jcBBf0e2GU7TsoFT
         bgXt0KR+8zNqbSXrUhN1J/glu4VwLuELZmRO/GPfTwjIvFhBXf8ruUL3wjMwB4kwjfeG
         tbCg==
X-Gm-Message-State: AC+VfDx/qvMTu7zokGHmqoHeG4lW7zuwo9ZI2VV14emjyIaw128fMf57
        KsnYuFO/zoWJ/Ax47FHg3IHX7T8f+YNcfYwrV7nJfJBaj2nU
X-Google-Smtp-Source: ACHHUZ7bcG1e/3bUMzc0ymc7D2jyrzRFpHg6OGgc1vjTSzYAQkzB6eb8hwkmLDkQ2x4UKlWv/MXS4mus8I2wW/dEjqwTOCIeYkg4
MIME-Version: 1.0
X-Received: by 2002:a6b:90a:0:b0:760:fab7:5bbf with SMTP id
 t10-20020a6b090a000000b00760fab75bbfmr4768392ioi.4.1682841159908; Sun, 30 Apr
 2023 00:52:39 -0700 (PDT)
Date:   Sun, 30 Apr 2023 00:52:39 -0700
In-Reply-To: <000000000000fcbbf805f9aca52b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008cc80505fa88fdfc@google.com>
Subject: Re: [syzbot] [bluetooth?] WARNING: bad unlock balance in l2cap_disconnect_rsp
From:   syzbot <syzbot+180f35f8e76c7af067d2@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, johan.hedberg@gmail.com,
        kuba@kernel.org, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, luiz.dentz@gmail.com,
        marcel@holtmann.org, netdev@vger.kernel.org, pabeni@redhat.com,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

syzbot has found a reproducer for the following issue on:

HEAD commit:    14f8db1c0f9a Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=13b18ef8280000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a837a8ba7e88bb45
dashboard link: https://syzkaller.appspot.com/bug?extid=180f35f8e76c7af067d2
compiler:       Debian clang version 15.0.7, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=167c5f2c280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1430f330280000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ad6ce516eed3/disk-14f8db1c.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1f38c2cc7667/vmlinux-14f8db1c.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d795115eee39/Image-14f8db1c.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+180f35f8e76c7af067d2@syzkaller.appspotmail.com

Bluetooth: hci0: unexpected cc 0x0c25 length: 249 > 3
Bluetooth: hci0: unexpected cc 0x0c38 length: 249 > 2
=====================================
WARNING: bad unlock balance detected!
6.3.0-rc7-syzkaller-g14f8db1c0f9a #0 Not tainted
-------------------------------------
kworker/u5:2/5929 is trying to release lock (&conn->chan_lock) at:
[<ffff8000115d5e64>] l2cap_disconnect_rsp+0x210/0x30c net/bluetooth/l2cap_core.c:4697
but there are no more locks to release!

other info that might help us debug this:
2 locks held by kworker/u5:2/5929:
 #0: ffff0000db5a5938 ((wq_completion)hci0#2){+.+.}-{0:0}, at: process_one_work+0x664/0x12d4 kernel/workqueue.c:2363
 #1: ffff80001e507c20 ((work_completion)(&hdev->rx_work)){+.+.}-{0:0}, at: process_one_work+0x6a8/0x12d4 kernel/workqueue.c:2365

stack backtrace:
CPU: 1 PID: 5929 Comm: kworker/u5:2 Not tainted 6.3.0-rc7-syzkaller-g14f8db1c0f9a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/30/2023
Workqueue: hci0 hci_rx_work
Call trace:
 dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:233
 show_stack+0x2c/0x44 arch/arm64/kernel/stacktrace.c:240
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0xd0/0x124 lib/dump_stack.c:106
 dump_stack+0x1c/0x28 lib/dump_stack.c:113
 print_unlock_imbalance_bug+0x250/0x2a4 kernel/locking/lockdep.c:5109
 lock_release+0x4ac/0x9ac kernel/locking/lockdep.c:5689
 __mutex_unlock_slowpath+0xe0/0x6b4 kernel/locking/mutex.c:907
 mutex_unlock+0x18/0x24 kernel/locking/mutex.c:543
 l2cap_disconnect_rsp+0x210/0x30c net/bluetooth/l2cap_core.c:4697
 l2cap_bredr_sig_cmd+0x974/0x7e94 net/bluetooth/l2cap_core.c:5748
 l2cap_sig_channel net/bluetooth/l2cap_core.c:6507 [inline]
 l2cap_recv_frame+0x83c/0x6a14 net/bluetooth/l2cap_core.c:7786
 l2cap_recv_acldata+0x4f4/0x163c net/bluetooth/l2cap_core.c:8504
 hci_acldata_packet net/bluetooth/hci_core.c:3828 [inline]
 hci_rx_work+0x2cc/0x8b8 net/bluetooth/hci_core.c:4063
 process_one_work+0x788/0x12d4 kernel/workqueue.c:2390
 worker_thread+0x8e0/0xfe8 kernel/workqueue.c:2537
 kthread+0x250/0x2d8 kernel/kthread.c:376
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:870


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.
