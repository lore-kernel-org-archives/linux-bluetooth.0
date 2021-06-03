Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34517C4708F
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 02:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A525613EE
	for <linux-bluetooth@archiver.kernel.org>; Thu,  3 Jun 2021 02:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbhFCC6y (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 2 Jun 2021 22:58:54 -0400
Received: from mail-yb1-f178.google.com ([209.85.219.178]:39471 "EHLO
        mail-yb1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbhFCC6y (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 2 Jun 2021 22:58:54 -0400
Received: by mail-yb1-f178.google.com with SMTP id n133so6754569ybf.6
        for <linux-bluetooth@vger.kernel.org>; Wed, 02 Jun 2021 19:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CPUsA8RxiDfXdrxAO9V7bEj5VcTznHwaHX4sd94wt3g=;
        b=eMrY1+5itbswj5Pd2VWI1uwOip1ZJ9uoQgv16nPCMP1XehuegTBQBf7upQNhLuk+E3
         B7V47o42WYEHmp44WmneoLfs7f9GGhnjcfrDJLdYMs4haV+fOWkJUoQ7WgNn2etKQrAU
         XFT2XRtYk5XMuMMfGSxP7i1LpRSYHYNyC4RbhjPSYZBinUYqCt1xtblfm3HfDDOfJi1d
         Vbfzi7rt4IboFbxlpa2vsd4Aai1Vybep9I8F+Cs1734RtX2NsnN3wIYbcsts+0EarEfD
         sy8Mm7h282xQmqg9wZWwTYMCSA0lWh8nsZssgIs5tjjLHJg7/bWfGs6qjkxz9bH7b5pz
         7+8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CPUsA8RxiDfXdrxAO9V7bEj5VcTznHwaHX4sd94wt3g=;
        b=UT7PtY73nd5c9VtIS5uIQV79q68pSVlIO/QierzxCXmqBLqjb7dfiGL11m/3WPyiGy
         JqNH/Tk/G+JyRaRjSoVlrqR6rYRMjdOm2fDyxLOMted+f+ncsfc9+YuLg1hLazgUOBqb
         2nlzXMUv4O5UFyTyfNem5zyCgJNqH3iT6v7C7fLLtda8KrbQz87zpmjPn9s81vblQX7f
         KL7vFmAtWRJvrcM94Y8Pz3Sz1j3zS7/6a/r8TuEbvC1odcA81FfQERURmZl356wKVN49
         YfX+n888e0yST04fc3u8MGvmTjAU9Qt9+TXOm8gzLRh+WfV5H7KV3z6OOF9pv18sdy1l
         I5qg==
X-Gm-Message-State: AOAM532V3eMqdD2HZ9etLTIAe3pM1Ijugfn+5UDsIlxImjOIWjx7+t41
        u8d9D3etcV3gLbux+uer4TbVXdczs4MEwP7FtWg=
X-Google-Smtp-Source: ABdhPJzF2QGG9nsC7UjfJeAsV5QFzt61q/KRc+RmgMojm2kNaaQggcf3loYE+ECC5EyarPL6LAdihh1GlNj9R+aSAKQ=
X-Received: by 2002:a25:2388:: with SMTP id j130mr50604730ybj.222.1622688956676;
 Wed, 02 Jun 2021 19:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAJjojJvVPwssDxY-GcQcw0TXMzhEX4RgiNeGWowKo6mKTw13=g@mail.gmail.com>
In-Reply-To: <CAJjojJvVPwssDxY-GcQcw0TXMzhEX4RgiNeGWowKo6mKTw13=g@mail.gmail.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Wed, 2 Jun 2021 19:55:45 -0700
Message-ID: <CABBYNZJm+ScxVjVBcxRpUuu+9J8sgyEmrnFaVpVii0FCg3EMxw@mail.gmail.com>
Subject: Re: BUG: KASAN: use-after-free in l2cap_send_cmd from l2cap_chan_timeout
To:     Lin Horse <kylin.formalin@gmail.com>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Lin,

On Wed, Jun 2, 2021 at 7:29 PM Lin Horse <kylin.formalin@gmail.com> wrote:
>
> I have seen one patch to l2cap_chan_timeout() is discussed and
> approved to fix the use-after-free in function l2cap_chan_timeout().
> https://lore.kernel.org/linux-bluetooth/20210602232348.766496-1-luiz.dentz@gmail.com/T/#u
>
> In fact, I recently found some similar crashes using syzkaller. It's
> just quite similar to the discussed one.
>
> Below is the crash log
>
> ==================================================================
> BUG: KASAN: use-after-free in l2cap_send_cmd+0x78d/0x810
> net/bluetooth/l2cap_core.c:940
> Read of size 1 at addr ffff8880042c2264 by task kworker/3:2/80
>
> CPU: 3 PID: 80 Comm: kworker/3:2 Not tainted 5.11.11+ #7
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
> 1.10.2-1ubuntu1 04/01/2014
> Workqueue: events l2cap_chan_timeout
> Call Trace:
>  __dump_stack lib/dump_stack.c:79 [inline]
>  dump_stack+0x1b9/0x22e lib/dump_stack.c:120
>  print_address_description+0x7b/0x3a0 mm/kasan/report.c:230
>  __kasan_report+0x14e/0x200 mm/kasan/report.c:396
>  kasan_report+0x47/0x60 mm/kasan/report.c:413
>  l2cap_send_cmd+0x78d/0x810 net/bluetooth/l2cap_core.c:940
>  l2cap_send_disconn_req+0x303/0x4c0 net/bluetooth/l2cap_core.c:1592
>  l2cap_chan_close+0x5d5/0xd10 net/bluetooth/l2cap_core.c:802
>  l2cap_chan_timeout+0xf9/0x1a0 net/bluetooth/l2cap_core.c:436
>  process_one_work+0x6df/0xf80 kernel/workqueue.c:2275
>  worker_thread+0xac1/0x1340 kernel/workqueue.c:2421
>  kthread+0x2fc/0x320 kernel/kthread.c:292
>  ret_from_fork+0x22/0x30 arch/x86/entry/entry_64.S:296
>
> Allocated by task 125:
>  kasan_save_stack mm/kasan/common.c:38 [inline]
>  kasan_set_track mm/kasan/common.c:46 [inline]
>  set_alloc_info mm/kasan/common.c:401 [inline]
>  ____kasan_kmalloc+0xc6/0x100 mm/kasan/common.c:429
>  kasan_kmalloc include/linux/kasan.h:219 [inline]
>  kmem_cache_alloc_trace+0x124/0x200 mm/slub.c:2919
>  kmalloc include/linux/slab.h:552 [inline]
>  kzalloc include/linux/slab.h:682 [inline]
>  hci_alloc_dev+0x4d/0x1ab0 net/bluetooth/hci_core.c:3643
>  __vhci_create_device drivers/bluetooth/hci_vhci.c:99 [inline]
>  vhci_create_device+0x10e/0x510 drivers/bluetooth/hci_vhci.c:148
>  process_one_work+0x6df/0xf80 kernel/workqueue.c:2275
>  worker_thread+0xac1/0x1340 kernel/workqueue.c:2421
>  kthread+0x2fc/0x320 kernel/kthread.c:292
>  ret_from_fork+0x22/0x30 arch/x86/entry/entry_64.S:296
>
> Last potentially related work creation:
>  kasan_save_stack+0x27/0x50 mm/kasan/common.c:38
>  kasan_record_aux_stack+0xbd/0xe0 mm/kasan/generic.c:344
>  insert_work+0x4f/0x340 kernel/workqueue.c:1331
>  __queue_work+0x9cc/0xdb0 kernel/workqueue.c:1497
>  queue_work_on+0xd8/0x130 kernel/workqueue.c:1524
>  process_one_work+0x6df/0xf80 kernel/workqueue.c:2275
>  worker_thread+0xac1/0x1340 kernel/workqueue.c:2421
>  kthread+0x2fc/0x320 kernel/kthread.c:292
>  ret_from_fork+0x22/0x30 arch/x86/entry/entry_64.S:296
>
> Second to last potentially related work creation:
>  kasan_save_stack+0x27/0x50 mm/kasan/common.c:38
>  kasan_record_aux_stack+0xbd/0xe0 mm/kasan/generic.c:344
>  insert_work+0x4f/0x340 kernel/workqueue.c:1331
>  __queue_work+0x9cc/0xdb0 kernel/workqueue.c:1497
>  call_timer_fn+0x35/0x210 kernel/time/timer.c:1417
>  expire_timers+0x264/0x3a0 kernel/time/timer.c:1457
>  __run_timers+0x503/0x660 kernel/time/timer.c:1731
>  run_timer_softirq+0x19/0x30 kernel/time/timer.c:1744
>  __do_softirq+0x216/0x539 kernel/softirq.c:343
>
> The buggy address belongs to the object at ffff8880042c2000
>  which belongs to the cache kmalloc-8k of size 8192
> The buggy address is located 612 bytes inside of
>  8192-byte region [ffff8880042c2000, ffff8880042c4000)
> The buggy address belongs to the page:
> page:000000004e07f003 refcount:1 mapcount:0 mapping:0000000000000000
> index:0xffff8880042c2000 pfn:0x42c0
> head:000000004e07f003 order:3 compound_mapcount:0 compound_pincount:0
> flags: 0x100000000010200(slab|head)
> raw: 0100000000010200 ffffea000038e608 ffffea00003dfe08 ffff88800104d1c0
> raw: ffff8880042c2000 0000000000010000 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff8880042c2100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8880042c2180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> >ffff8880042c2200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>                                                        ^
>  ffff8880042c2280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>  ffff8880042c2300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ==================================================================
>
> The vulnerable code line is presented below
>
> static void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len,
>   void *data)
> {
>     struct sk_buff *skb = l2cap_build_cmd(conn, code, ident, len, data);
>     u8 flags;
>
>     BT_DBG("code 0x%2.2x", code);
>
>     if (!skb)
>         return;
>
>     /* Use NO_FLUSH if supported or we have an LE link (which does
>      * not support auto-flushing packets) */
>     if (lmp_no_flush_capable(conn->hcon->hdev) ||    // { 1 }
>         conn->hcon->type == LE_LINK)
>         flags = ACL_START_NO_FLUSH;
>     else
>         flags = ACL_START;
> ......
> }
>
> The mark-{ 1 } code will dereference hdev->features, which is caught
> by the KASan as UAF read. This means that when the l2cap_send_cmd() is
> called, the controller has been already removed and the hdev object
> has been released.
> The problem may be the l2cap_chan_timeout() function again. I guess
> this delayed work is not properly cancelled when the controller is
> detached. Perhaps additional checks need to be added in this function
> or another proper cancel_delayed_work() is required.

Try with the following patch:

https://patchwork.kernel.org/project/bluetooth/patch/20210602232348.766496-1-luiz.dentz@gmail.com/

If that doesn't work we may need to use cancel_delayed_work_sync but
Im not sure if that is safe to use since that blocks the context.


-- 
Luiz Augusto von Dentz
