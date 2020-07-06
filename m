Return-Path: <SRS0=7cy9=AR=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2216C433E1
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Jul 2020 03:32:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC1EB2074F
	for <linux-bluetooth@archiver.kernel.org>; Mon,  6 Jul 2020 03:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="hjZ+nHV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728724AbgGFDcw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 5 Jul 2020 23:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728686AbgGFDcv (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 5 Jul 2020 23:32:51 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCCCC08C5DE
        for <linux-bluetooth@vger.kernel.org>; Sun,  5 Jul 2020 20:32:51 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id t11so11542208pfq.11
        for <linux-bluetooth@vger.kernel.org>; Sun, 05 Jul 2020 20:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dJ6KC89zq4JHk4HwHxXJeuQRbWKXL9v2dmGLn/RXOwQ=;
        b=hjZ+nHV3lTcZ+01aIKLB+dzeetHzoQdvvxOzyZNfNlbqqkMgwfMtp9tXKOxOyrpS2y
         ie4OLrhQkJp940oZJyyy3LeOiP1Pfi0yzbPf36LczrG5OZslSkAgiOpjUvEUuvppiDtk
         GMzehUp2bnqH7S5OThRfcfQ3EUMXa+Si4/FVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=dJ6KC89zq4JHk4HwHxXJeuQRbWKXL9v2dmGLn/RXOwQ=;
        b=bEUaI5tPJHADPVhMBOe74JiFc5OJg35ReQnzyG7UXNQJBfrtVmWGAixB6Jj6n8XO17
         Q6+W2e+kQuvo33P2HKi2wFDOrUi7yhHm3JbyY3KCwUuEKiO1YBhvcAdw8r9LWbJd2Vdr
         5kqZlD+3XrGnUMi0exofYxOwq5IL3Gmwt3HLH102o9PNT4bgMQAirXoaNzIt/8trLnNs
         hDmFNeSzfnhif9iT/MFjOkCmwbmFgK7j89BoWz29NPbCDk5o7vnpkETCfl2ldFCoXXeo
         g0g72gzLgChZ4vPPaoFd4OZqFzI5uILawh7U8RI1RZXSkVVdUNQ2X8dg8ncFAlABXQDx
         KjsA==
X-Gm-Message-State: AOAM531q7WDiuRU04YoVWhHfPQqLDXCnwmhcQVeYcuDc9XmmibSeI5jj
        tnqzakV6I1LYLiV0O55y/29u0A==
X-Google-Smtp-Source: ABdhPJyXLbBZZRqMW0IFSiPfcpoFoDD04pDA5gw2IyyJHGwCVkr/7j8KHqWKBMg/0Sj3/ImpBH9j6Q==
X-Received: by 2002:aa7:8f2a:: with SMTP id y10mr41288831pfr.182.1594006370798;
        Sun, 05 Jul 2020 20:32:50 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id bg6sm16835521pjb.51.2020.07.05.20.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jul 2020 20:32:49 -0700 (PDT)
Date:   Sun, 5 Jul 2020 20:32:48 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jukka Rissanen <jukka.rissanen@linux.intel.com>,
        Johan Hedberg <johan.hedberg@intel.com>
Cc:     davem@davemloft.net, kuba@kernel.org,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+7dd7f2f77a7a01d1dc14@syzkaller.appspotmail.com>,
        Michael Scott <mike@foundries.io>,
        Josua Mayer <josua.mayer@jm0.eu>
Subject: Re: use-after-free in Bluetooth: 6lowpan (was Re: KASAN:
 use-after-free Write in refcount_warn_saturate)
Message-ID: <202007052022.984BAD97@keescook>
References: <00000000000055e1a9059f9e169f@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000055e1a9059f9e169f@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On Thu, Feb 27, 2020 at 11:50:11PM -0800, syzbot wrote:
> Hello,
> 
> syzbot found the following crash on:
> 
> HEAD commit:    f8788d86 Linux 5.6-rc3
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=13005fd9e00000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=9833e26bab355358
> dashboard link: https://syzkaller.appspot.com/bug?extid=7dd7f2f77a7a01d1dc14
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
> userspace arch: i386
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17e3ebede00000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16a9f8f9e00000
> 
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+7dd7f2f77a7a01d1dc14@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: use-after-free in atomic_set include/asm-generic/atomic-instrumented.h:44 [inline]
> BUG: KASAN: use-after-free in refcount_set include/linux/refcount.h:123 [inline]
> BUG: KASAN: use-after-free in refcount_warn_saturate+0x1f/0x1f0 lib/refcount.c:15
> Write of size 4 at addr ffff888090eb4018 by task kworker/1:24/2888
> 
> CPU: 1 PID: 2888 Comm: kworker/1:24 Not tainted 5.6.0-rc3-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Workqueue: events do_enable_set
> Call Trace:
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0x197/0x210 lib/dump_stack.c:118
>  print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
>  __kasan_report.cold+0x1b/0x32 mm/kasan/report.c:506
>  kasan_report+0x12/0x20 mm/kasan/common.c:641
>  check_memory_region_inline mm/kasan/generic.c:185 [inline]
>  check_memory_region+0x134/0x1a0 mm/kasan/generic.c:192
>  __kasan_check_write+0x14/0x20 mm/kasan/common.c:101
>  atomic_set include/asm-generic/atomic-instrumented.h:44 [inline]
>  refcount_set include/linux/refcount.h:123 [inline]
>  refcount_warn_saturate+0x1f/0x1f0 lib/refcount.c:15
>  refcount_sub_and_test include/linux/refcount.h:261 [inline]
>  refcount_dec_and_test include/linux/refcount.h:281 [inline]
>  kref_put include/linux/kref.h:64 [inline]
>  l2cap_chan_put+0x1d9/0x240 net/bluetooth/l2cap_core.c:498
>  do_enable_set+0x54b/0x960 net/bluetooth/6lowpan.c:1075
>  process_one_work+0xa05/0x17a0 kernel/workqueue.c:2264
>  worker_thread+0x98/0xe40 kernel/workqueue.c:2410
>  kthread+0x361/0x430 kernel/kthread.c:255
>  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> 
> Allocated by task 2888:
>  save_stack+0x23/0x90 mm/kasan/common.c:72
>  set_track mm/kasan/common.c:80 [inline]
>  __kasan_kmalloc mm/kasan/common.c:515 [inline]
>  __kasan_kmalloc.constprop.0+0xcf/0xe0 mm/kasan/common.c:488
>  kasan_kmalloc+0x9/0x10 mm/kasan/common.c:529
>  kmem_cache_alloc_trace+0x158/0x790 mm/slab.c:3551
>  kmalloc include/linux/slab.h:555 [inline]
>  kzalloc include/linux/slab.h:669 [inline]
>  l2cap_chan_create+0x45/0x3a0 net/bluetooth/l2cap_core.c:446
>  chan_create+0x10/0xe0 net/bluetooth/6lowpan.c:640
>  bt_6lowpan_listen net/bluetooth/6lowpan.c:959 [inline]
>  do_enable_set+0x583/0x960 net/bluetooth/6lowpan.c:1078
>  process_one_work+0xa05/0x17a0 kernel/workqueue.c:2264
>  worker_thread+0x98/0xe40 kernel/workqueue.c:2410
>  kthread+0x361/0x430 kernel/kthread.c:255
>  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352
> 
> Freed by task 2975:
>  save_stack+0x23/0x90 mm/kasan/common.c:72
>  set_track mm/kasan/common.c:80 [inline]
>  kasan_set_free_info mm/kasan/common.c:337 [inline]
>  __kasan_slab_free+0x102/0x150 mm/kasan/common.c:476
>  kasan_slab_free+0xe/0x10 mm/kasan/common.c:485
>  __cache_free mm/slab.c:3426 [inline]
>  kfree+0x10a/0x2c0 mm/slab.c:3757
>  l2cap_chan_destroy net/bluetooth/l2cap_core.c:484 [inline]
>  kref_put include/linux/kref.h:65 [inline]
>  l2cap_chan_put+0x1b7/0x240 net/bluetooth/l2cap_core.c:498
>  do_enable_set+0x54b/0x960 net/bluetooth/6lowpan.c:1075
>  process_one_work+0xa05/0x17a0 kernel/workqueue.c:2264
>  worker_thread+0x98/0xe40 kernel/workqueue.c:2410
>  kthread+0x361/0x430 kernel/kthread.c:255
>  ret_from_fork+0x24/0x30 arch/x86/entry/entry_64.S:352

The free and use-after-free are both via the same do_enable_set() path
which implies there are racing writes to the debugfs write handler. It
seems locking is missing for both listen_chan and enable_6lowpan. The
latter seems misused in is_bt_6lowpan(), which should likely just be
checking for chan->ops == &bt_6lowpan_chan_ops, I think?

I have no way to actually test changes to this code...

-- 
Kees Cook
