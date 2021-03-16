Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B69AC433DB
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 10:28:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5532665020
	for <linux-bluetooth@archiver.kernel.org>; Tue, 16 Mar 2021 10:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236402AbhCPK2V (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 16 Mar 2021 06:28:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:34958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236388AbhCPK2P (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 16 Mar 2021 06:28:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CD23865025;
        Tue, 16 Mar 2021 10:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615890494;
        bh=Ek1bMmgEROcrwltu3afjHikqeT9vUmjpYs+Ey8ul8Bo=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=MtLDUqpd3tt9CJ5JSTtoiqVd4C8Ho+dQL7vggxZnEI/Hlqd8u6xyrpoybM5MXnV/w
         1uARuNw7ptB78+1ORMRSxKNRAtz7bEXr9t9sFKMgWtM6wsTJAQtgBXmssQ9Qy9+Bb3
         BCtS1anUyOp10/Uhzp+YLyth368sOYcwFXsQv6ewqKbFE26c2PBeFfJmHSdANCka+y
         Yd7ALKIYqCH7LnMf7nCDPvmFB03H8AMWN/dmqMqt/YR0SJBJ63NWEaN1L6H9sws11+
         mBsgMlDf+pqqI7cQ3oG87wUtoV/Ot73vqICLFFhxtCqQLkRzMh/UrRgEmXTgknrsNY
         IbDTFXAYsT2hQ==
Date:   Tue, 16 Mar 2021 11:28:11 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Lockdep report for hci_conn_get_phy()
In-Reply-To: <nycvar.YFH.7.76.2103041405420.12405@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.2103161125530.12405@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2103041405420.12405@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, 4 Mar 2021, Jiri Kosina wrote:

>  ======================================================
>  WARNING: possible circular locking dependency detected
>  5.12.0-rc1-00026-g73d464503354 #10 Not tainted
>  ------------------------------------------------------
>  bluetoothd/1118 is trying to acquire lock:
>  ffff8f078383c078 (&hdev->lock){+.+.}-{3:3}, at: hci_conn_get_phy+0x1c/0x150 [bluetooth]
>  
>  but task is already holding lock:
>  ffff8f07e831d920 (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}-{0:0}, at: l2cap_sock_getsockopt+0x8b/0x610 
> 
>  
>  which lock already depends on the new lock.
> 
>  
>  the existing dependency chain (in reverse order) is:
>  
>  -> #3 (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}-{0:0}:
>         lock_sock_nested+0x72/0xa0
>         l2cap_sock_ready_cb+0x18/0x70 [bluetooth]
>         l2cap_config_rsp+0x27a/0x520 [bluetooth]
>         l2cap_sig_channel+0x658/0x1330 [bluetooth]
>         l2cap_recv_frame+0x1ba/0x310 [bluetooth]
>         hci_rx_work+0x1cc/0x640 [bluetooth]
>         process_one_work+0x244/0x5f0
>         worker_thread+0x3c/0x380
>         kthread+0x13e/0x160
>         ret_from_fork+0x22/0x30
>  
>  -> #2 (&chan->lock#2/1){+.+.}-{3:3}:
>         __mutex_lock+0xa3/0xa10
>         l2cap_chan_connect+0x33a/0x940 [bluetooth]
>         l2cap_sock_connect+0x141/0x2a0 [bluetooth]
>         __sys_connect+0x9b/0xc0
>         __x64_sys_connect+0x16/0x20
>         do_syscall_64+0x33/0x80
>         entry_SYSCALL_64_after_hwframe+0x44/0xae
>  
>  -> #1 (&conn->chan_lock){+.+.}-{3:3}:
>         __mutex_lock+0xa3/0xa10
>         l2cap_chan_connect+0x322/0x940 [bluetooth]
>         l2cap_sock_connect+0x141/0x2a0 [bluetooth]
>         __sys_connect+0x9b/0xc0
>         __x64_sys_connect+0x16/0x20
>         do_syscall_64+0x33/0x80
>         entry_SYSCALL_64_after_hwframe+0x44/0xae
>  
>  -> #0 (&hdev->lock){+.+.}-{3:3}:
>         __lock_acquire+0x147a/0x1a50
>         lock_acquire+0x277/0x3d0
>         __mutex_lock+0xa3/0xa10
>         hci_conn_get_phy+0x1c/0x150 [bluetooth]
>         l2cap_sock_getsockopt+0x5a9/0x610 [bluetooth]
>         __sys_getsockopt+0xcc/0x200
>         __x64_sys_getsockopt+0x20/0x30
>         do_syscall_64+0x33/0x80
>         entry_SYSCALL_64_after_hwframe+0x44/0xae

So looking at the code and digging a bit in the history, it seems like the 
above dependency chain has been there since ever ...

>  other info that might help us debug this:
> 
>  Chain exists of:
>    &hdev->lock --> &chan->lock#2/1 --> sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP
>   Possible unsafe locking scenario:
> 
>         CPU0                    CPU1
>         ----                    ----
>    lock(sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP);
>                                 lock(&chan->lock#2/1);
>                                 lock(sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP);
>    lock(&hdev->lock);
>  
>   *** DEADLOCK ***
> 
>  1 lock held by bluetoothd/1118:
>   #0: ffff8f07e831d920 (sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP){+.+.}-{0:0}, at: l2cap_sock_getsockopt+0x8b/0x610 [bluetooth]
>  
>  stack backtrace:
>  CPU: 3 PID: 1118 Comm: bluetoothd Not tainted 5.12.0-rc1-00026-g73d464503354 #10
>  Hardware name: LENOVO 20K5S22R00/20K5S22R00, BIOS R0IET38W (1.16 ) 05/31/2017
>  Call Trace:
>   dump_stack+0x7f/0xa1
>   check_noncircular+0x105/0x120
>   ? __lock_acquire+0x147a/0x1a50
>   __lock_acquire+0x147a/0x1a50
>   lock_acquire+0x277/0x3d0
>   ? hci_conn_get_phy+0x1c/0x150 [bluetooth]
>   ? __lock_acquire+0x2e1/0x1a50
>   ? lock_is_held_type+0xb4/0x120
>   ? hci_conn_get_phy+0x1c/0x150 [bluetooth]
>   __mutex_lock+0xa3/0xa10
>   ? hci_conn_get_phy+0x1c/0x150 [bluetooth]
>   ? lock_acquire+0x277/0x3d0
>   ? mark_held_locks+0x49/0x70
>   ? mark_held_locks+0x49/0x70
>   ? hci_conn_get_phy+0x1c/0x150 [bluetooth]
>   hci_conn_get_phy+0x1c/0x150 [bluetooth]
>   l2cap_sock_getsockopt+0x5a9/0x610 [bluetooth]
>   __sys_getsockopt+0xcc/0x200
>   __x64_sys_getsockopt+0x20/0x30
>   do_syscall_64+0x33/0x80
>   entry_SYSCALL_64_after_hwframe+0x44/0xae

... but the sk_lock-AF_BLUETOOTH-BTPROTO_L2CAP -> conn->hdev dependency 
has been added only in eab2404ba798 ("Bluetooth: Add BT_PHY socket 
option") and I've started to see this splat only now as I've probably 
recently acquired userspace that excercises this getsockopt(BT_PHY).

-- 
Jiri Kosina
SUSE Labs

