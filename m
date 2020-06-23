Return-Path: <SRS0=Gzv7=AE=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94198C433DF
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Jun 2020 12:32:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B99C20724
	for <linux-bluetooth@archiver.kernel.org>; Tue, 23 Jun 2020 12:32:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732579AbgFWMc3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 23 Jun 2020 08:32:29 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:51164 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729611AbgFWMc3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 23 Jun 2020 08:32:29 -0400
Received: from marcel-macpro.fritz.box (p5b3d2638.dip0.t-ipconnect.de [91.61.38.56])
        by mail.holtmann.org (Postfix) with ESMTPSA id 7DAB8CECC3;
        Tue, 23 Jun 2020 14:42:20 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: [PATCH] net: add a mutex lock to avoid UAF in do_enale_set
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <20200623122841.9832-1-koulihong@huawei.com>
Date:   Tue, 23 Jun 2020 14:32:27 +0200
Cc:     Johan Hedberg <johan.hedberg@gmail.com>,
        BlueZ <linux-bluetooth@vger.kernel.org>, fangwei1@huawei.com
Content-Transfer-Encoding: 8BIT
Message-Id: <06790AB6-8342-4A32-8DCE-4A18094A3C49@holtmann.org>
References: <20200623122841.9832-1-koulihong@huawei.com>
To:     Lihong Kou <koulihong@huawei.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Lihong,

> In the case we set or free the global value listen_chan in
> different threads, we can encounter the UAF problems because
> the method is not protected by any lock, add one to avoid
> this bug.
> 
> BUG: KASAN: use-after-free in l2cap_chan_close+0x48/0x990
> net/bluetooth/l2cap_core.c:730
> Read of size 8 at addr ffff888096950000 by task kworker/1:102/2868
> 
> CPU: 1 PID: 2868 Comm: kworker/1:102 Not tainted 5.5.0-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS Google 01/01/2011
> Workqueue: events do_enable_set
> Call Trace:
> __dump_stack lib/dump_stack.c:77 [inline]
> dump_stack+0x1fb/0x318 lib/dump_stack.c:118
> print_address_description+0x74/0x5c0 mm/kasan/report.c:374
> __kasan_report+0x149/0x1c0 mm/kasan/report.c:506
> kasan_report+0x26/0x50 mm/kasan/common.c:641
> __asan_report_load8_noabort+0x14/0x20 mm/kasan/generic_report.c:135
> l2cap_chan_close+0x48/0x990 net/bluetooth/l2cap_core.c:730
> do_enable_set+0x660/0x900 net/bluetooth/6lowpan.c:1074
> process_one_work+0x7f5/0x10f0 kernel/workqueue.c:2264
> worker_thread+0xbbc/0x1630 kernel/workqueue.c:2410
> kthread+0x332/0x350 kernel/kthread.c:255
> ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> 
> Allocated by task 2870:
> save_stack mm/kasan/common.c:72 [inline]
> set_track mm/kasan/common.c:80 [inline]
> __kasan_kmalloc+0x118/0x1c0 mm/kasan/common.c:515
> kasan_kmalloc+0x9/0x10 mm/kasan/common.c:529
> kmem_cache_alloc_trace+0x221/0x2f0 mm/slab.c:3551
> kmalloc include/linux/slab.h:555 [inline]
> kzalloc include/linux/slab.h:669 [inline]
> l2cap_chan_create+0x50/0x320 net/bluetooth/l2cap_core.c:446
> chan_create net/bluetooth/6lowpan.c:640 [inline]
> bt_6lowpan_listen net/bluetooth/6lowpan.c:959 [inline]
> do_enable_set+0x6a4/0x900 net/bluetooth/6lowpan.c:1078
> process_one_work+0x7f5/0x10f0 kernel/workqueue.c:2264
> worker_thread+0xbbc/0x1630 kernel/workqueue.c:2410
> kthread+0x332/0x350 kernel/kthread.c:255
> ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> 
> Freed by task 2870:
> save_stack mm/kasan/common.c:72 [inline]
> set_track mm/kasan/common.c:80 [inline]
> kasan_set_free_info mm/kasan/common.c:337 [inline]
> __kasan_slab_free+0x12e/0x1e0 mm/kasan/common.c:476
> kasan_slab_free+0xe/0x10 mm/kasan/common.c:485
> __cache_free mm/slab.c:3426 [inline]
> kfree+0x10d/0x220 mm/slab.c:3757
> l2cap_chan_destroy net/bluetooth/l2cap_core.c:484 [inline]
> kref_put include/linux/kref.h:65 [inline]
> l2cap_chan_put+0x170/0x190 net/bluetooth/l2cap_core.c:498
> do_enable_set+0x66c/0x900 net/bluetooth/6lowpan.c:1075
> process_one_work+0x7f5/0x10f0 kernel/workqueue.c:2264
> worker_thread+0xbbc/0x1630 kernel/workqueue.c:2410
> kthread+0x332/0x350 kernel/kthread.c:255
> ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> 
> The buggy address belongs to the object at ffff888096950000
> which belongs to the cache kmalloc-2k of size 2048
> The buggy address is located 0 bytes inside of
> 2048-byte region [ffff888096950000, ffff888096950800)
> The buggy address belongs to the page:
> page:ffffea00025a5400 refcount:1 mapcount:0 mapping:ffff8880aa400e00 index:0x0
> flags: 0xfffe0000000200(slab)
> raw: 00fffe0000000200 ffffea00027d1548 ffffea0002397808 ffff8880aa400e00
> raw: 0000000000000000 ffff888096950000 0000000100000001 0000000000000000
> page dumped because: kasan: bad access detected
> 
> Memory state around the buggy address:
> ffff88809694ff00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ffff88809694ff80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>> ffff888096950000: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                   ^
> ffff888096950080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ffff888096950100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
> 
> Reported-by: syzbot+96414aa0033c363d8458@syzkaller.appspotmail.com
> Signed-off-by: Lihong Kou <koulihong@huawei.com>
> ---
> net/bluetooth/6lowpan.c | 5 +++++
> 1 file changed, 5 insertions(+)

patch has been applied to bluetooth-next tree.

Regards

Marcel

