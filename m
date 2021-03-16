Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA674C433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 14:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DC876507A
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 14:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236499AbhCPOaj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Mar 2021 10:30:39 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:37172 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235497AbhCPOaV (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Mar 2021 10:30:21 -0400
Received: from marcel-macbook.holtmann.net (p4fefc126.dip0.t-ipconnect.de [79.239.193.38])
        by mail.holtmann.org (Postfix) with ESMTPSA id F073ECECFC;
        Tue, 16 Mar 2021 15:37:55 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.60.0.2.21\))
Subject: Re: [PATCH] Bluetooth: avoid deadlock between hci_dev->lock and
 socket lock
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <nycvar.YFH.7.76.2103161507280.12405@cbobk.fhfr.pm>
Date:   Tue, 16 Mar 2021 15:30:18 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <657367AC-ACB8-441D-83E0-2BA1DFCD6B41@holtmann.org>
References: <nycvar.YFH.7.76.2103041405420.12405@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.2103161125530.12405@cbobk.fhfr.pm>
 <nycvar.YFH.7.76.2103161507280.12405@cbobk.fhfr.pm>
To:     Jiri Kosina <jikos@kernel.org>
X-Mailer: Apple Mail (2.3654.60.0.2.21)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Jiri,

> Commit eab2404ba798 ("Bluetooth: Add BT_PHY socket option") added a 
> dependency between socket lock and hci_dev->lock that could lead to 
> deadlock.
> 
> It turns out that hci_conn_get_phy() is not in any way relying on hdev 
> being immutable during the runtime of this function, neither does it even 
> look at any of the members of hdev, and as such there is no need to hold 
> that lock.
> 
> This fixes the lockdep splat below:
> 
> ======================================================
> WARNING: possible circular locking dependency detected
> 5.12.0-rc1-00026-g73d464503354 #10 Not tainted
> ------------------------------------------------------
> bluetoothd/1118 is trying to acquire lock:
> ffff8f078383c078 (&hdev->lock){+.+.}-{3:3}, at: hci_conn_get_phy+0x1c/0x150 [bluetooth]
> 
> but task is already holding lock:
> ffff8f07e831d920 (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}-{0:0}, at: l2cap_sock_getsockopt+0x8b/0x610
> 
> which lock already depends on the new lock.
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #3 (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}-{0:0}:
>        lock_sock_nested+0x72/0xa0
>        l2cap_sock_ready_cb+0x18/0x70 [bluetooth]
>        l2cap_config_rsp+0x27a/0x520 [bluetooth]
>        l2cap_sig_channel+0x658/0x1330 [bluetooth]
>        l2cap_recv_frame+0x1ba/0x310 [bluetooth]
>        hci_rx_work+0x1cc/0x640 [bluetooth]
>        process_one_work+0x244/0x5f0
>        worker_thread+0x3c/0x380
>        kthread+0x13e/0x160
>        ret_from_fork+0x22/0x30
> 
> -> #2 (&chan->lock#2/1){+.+.}-{3:3}:
>        __mutex_lock+0xa3/0xa10
>        l2cap_chan_connect+0x33a/0x940 [bluetooth]
>        l2cap_sock_connect+0x141/0x2a0 [bluetooth]
>        __sys_connect+0x9b/0xc0
>        __x64_sys_connect+0x16/0x20
>        do_syscall_64+0x33/0x80
>        entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> -> #1 (&conn->chan_lock){+.+.}-{3:3}:
>        __mutex_lock+0xa3/0xa10
>        l2cap_chan_connect+0x322/0x940 [bluetooth]
>        l2cap_sock_connect+0x141/0x2a0 [bluetooth]
>        __sys_connect+0x9b/0xc0
>        __x64_sys_connect+0x16/0x20
>        do_syscall_64+0x33/0x80
>        entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> -> #0 (&hdev->lock){+.+.}-{3:3}:
>        __lock_acquire+0x147a/0x1a50
>        lock_acquire+0x277/0x3d0
>        __mutex_lock+0xa3/0xa10
>        hci_conn_get_phy+0x1c/0x150 [bluetooth]
>        l2cap_sock_getsockopt+0x5a9/0x610 [bluetooth]
>        __sys_getsockopt+0xcc/0x200
>        __x64_sys_getsockopt+0x20/0x30
>        do_syscall_64+0x33/0x80
>        entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> other info that might help us debug this:
> 
> Chain exists of:
>   &hdev->lock --> &chan->lock#2/1 --> sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP);
>                                lock(&chan->lock#2/1);
>                                lock(sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP);
>   lock(&hdev->lock);
> 
>  *** DEADLOCK ***
> 
> 1 lock held by bluetoothd/1118:
>  #0: ffff8f07e831d920 (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}-{0:0}, at: l2cap_sock_getsockopt+0x8b/0x610 [bluetooth]
> 
> stack backtrace:
> CPU: 3 PID: 1118 Comm: bluetoothd Not tainted 5.12.0-rc1-00026-g73d464503354 #10
> Hardware name: LENOVO 20K5S22R00/20K5S22R00, BIOS R0IET38W (1.16 ) 05/31/2017
> Call Trace:
>  dump_stack+0x7f/0xa1
>  check_noncircular+0x105/0x120
>  ? __lock_acquire+0x147a/0x1a50
>  __lock_acquire+0x147a/0x1a50
>  lock_acquire+0x277/0x3d0
>  ? hci_conn_get_phy+0x1c/0x150 [bluetooth]
>  ? __lock_acquire+0x2e1/0x1a50
>  ? lock_is_held_type+0xb4/0x120
>  ? hci_conn_get_phy+0x1c/0x150 [bluetooth]
>  __mutex_lock+0xa3/0xa10
>  ? hci_conn_get_phy+0x1c/0x150 [bluetooth]
>  ? lock_acquire+0x277/0x3d0
>  ? mark_held_locks+0x49/0x70
>  ? mark_held_locks+0x49/0x70
>  ? hci_conn_get_phy+0x1c/0x150 [bluetooth]
>  hci_conn_get_phy+0x1c/0x150 [bluetooth]
>  l2cap_sock_getsockopt+0x5a9/0x610 [bluetooth]
>  __sys_getsockopt+0xcc/0x200
>  __x64_sys_getsockopt+0x20/0x30
>  do_syscall_64+0x33/0x80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7fb73df33eee
> Code: 48 8b 0d 85 0f 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 37 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 52 0f 0c 00 f7 d8 64 89 01 48
> RSP: 002b:00007fffcfbbbf08 EFLAGS: 00000203 ORIG_RAX: 0000000000000037
> RAX: ffffffffffffffda RBX: 0000000000000019 RCX: 00007fb73df33eee
> RDX: 000000000000000e RSI: 0000000000000112 RDI: 0000000000000018
> RBP: 0000000000000000 R08: 00007fffcfbbbf44 R09: 0000000000000000
> R10: 00007fffcfbbbf3c R11: 0000000000000203 R12: 0000000000000000
> R13: 0000000000000018 R14: 0000000000000000 R15: 0000556fcefc70d0
> 
> Fixes: eab2404ba798 ("Bluetooth: Add BT_PHY socket option")
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>
> ---
> net/bluetooth/hci_conn.c | 4 ----
> 1 file changed, 4 deletions(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

