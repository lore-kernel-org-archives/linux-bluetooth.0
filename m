Return-Path: <SRS0=/O/j=EP=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF160C2D0A3
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Nov 2020 13:39:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 88FC0206CB
	for <linux-bluetooth@archiver.kernel.org>; Mon,  9 Nov 2020 13:39:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731217AbgKINiQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 9 Nov 2020 08:38:16 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:54208 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730659AbgKINDl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 9 Nov 2020 08:03:41 -0500
Received: from marcel-macbook.fritz.box (p4fefcf0f.dip0.t-ipconnect.de [79.239.207.15])
        by mail.holtmann.org (Postfix) with ESMTPSA id 09E33CECC6;
        Mon,  9 Nov 2020 14:10:33 +0100 (CET)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [PATCH] Bluetooth: hidp: use correct wait queue when removing
 ctrl_wait
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20201017111544.2838773-1-omidtbo@cisco.com>
Date:   Mon, 9 Nov 2020 14:03:24 +0100
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <24E384B4-2182-4ABE-9765-ED8F0FC3FD64@holtmann.org>
References: <20201017111544.2838773-1-omidtbo@cisco.com>
To:     =?utf-8?B?T2xlIEJqw7hybiBNaWR0YsO4?= <omidtbo@cisco.com>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ole,

> A different wait queue was used when removing ctrl_wait than when adding
> it. This effectively made the remove operation without locking compared
> to other operations on the wait queue ctrl_wait was part of. This caused
> issues like below where dead000000000100 is LIST_POISON1 and
> dead000000000200 is LIST_POISON2.
> 
> list_add corruption. next->prev should be prev (ffffffc1b0a33a08), \
> 	but was dead000000000200. (next=ffffffc03ac77de0).
> ------------[ cut here ]------------
> CPU: 3 PID: 2138 Comm: bluetoothd Tainted: G           O    4.4.238+ #9
> ...
> ---[ end trace 0adc2158f0646eac ]---
> Call trace:
> [<ffffffc000443f78>] __list_add+0x38/0xb0
> [<ffffffc0000f0d04>] add_wait_queue+0x4c/0x68
> [<ffffffc00020eecc>] __pollwait+0xec/0x100
> [<ffffffc000d1556c>] bt_sock_poll+0x74/0x200
> [<ffffffc000bdb8a8>] sock_poll+0x110/0x128
> [<ffffffc000210378>] do_sys_poll+0x220/0x480
> [<ffffffc0002106f0>] SyS_poll+0x80/0x138
> [<ffffffc00008510c>] __sys_trace_return+0x0/0x4
> 
> Unable to handle kernel paging request at virtual address dead000000000100
> ...
> CPU: 4 PID: 5387 Comm: kworker/u15:3 Tainted: G        W  O    4.4.238+ #9
> ...
> Call trace:
>  [<ffffffc0000f079c>] __wake_up_common+0x7c/0xa8
>  [<ffffffc0000f0818>] __wake_up+0x50/0x70
>  [<ffffffc000be11b0>] sock_def_wakeup+0x58/0x60
>  [<ffffffc000de5e10>] l2cap_sock_teardown_cb+0x200/0x224
>  [<ffffffc000d3f2ac>] l2cap_chan_del+0xa4/0x298
>  [<ffffffc000d45ea0>] l2cap_conn_del+0x118/0x198
>  [<ffffffc000d45f8c>] l2cap_disconn_cfm+0x6c/0x78
>  [<ffffffc000d29934>] hci_event_packet+0x564/0x2e30
>  [<ffffffc000d19b0c>] hci_rx_work+0x10c/0x360
>  [<ffffffc0000c2218>] process_one_work+0x268/0x460
>  [<ffffffc0000c2678>] worker_thread+0x268/0x480
>  [<ffffffc0000c94e0>] kthread+0x118/0x128
>  [<ffffffc000085070>] ret_from_fork+0x10/0x20
>  ---[ end trace 0adc2158f0646ead ]---
> 
> Signed-off-by: Ole Bjørn Midtbø <omidtbo@cisco.com>
> ---
> net/bluetooth/hidp/core.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)

patch has been applied to bluetooth-next tree.

Regards

Marcel

