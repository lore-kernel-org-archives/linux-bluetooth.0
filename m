Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A54DFC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 13 May 2022 20:14:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379949AbiEMUO3 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 13 May 2022 16:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357601AbiEMUO2 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 13 May 2022 16:14:28 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A463338A8
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 May 2022 13:14:27 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id x12so8460933pgj.7
        for <linux-bluetooth@vger.kernel.org>; Fri, 13 May 2022 13:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F11AVYXqh+U80R/v5zNgg1gLExrcWUuOK/9L2wgeeqo=;
        b=F+QdAZL9OIv+RnP18Zj4/27Z2JWH9lYleF1KlReWTYD0chETAvwUjRtjQ1eBH4AUM5
         /BqKn7T3KsruLXUS8QTaMeB41pJtjBUaoMhpeljF7V4dtvwMT+opdwnEA3dceIeKVj3Q
         4f4mCyGKt5u5MAKcQseDiFzFPk3DPG5izIWXRvHz3TK3zI/bhh112gLT/FyXzq6cGWg9
         JT59gQuOrWRqCj7VUOGBwrD3+tPvWgSzuB8Xa8O0J1XtPdCszNGkj9QV36J+r01/cCkd
         8ze/QBwDIZcTg5ODgkwRN/+v64TvgRwNTw59a+ASPH0aGRCUzTmAAWq1RUe/RE6aDBox
         /F6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F11AVYXqh+U80R/v5zNgg1gLExrcWUuOK/9L2wgeeqo=;
        b=jf0XZUJugh+WmhCfiqQ4/omoRCP1SrkkFj/x6XAn0+2Qy+sbCRYsGiQLyjAj4XGe7G
         TdYKXBtciw8QpgoRjn3MpU7ouHcwK/xRxhS+0+KBRZ1gK/wxPSd/IF1dIg7zVm4sQkWM
         Kp3BhuPoo1OKF9K5SkhjsmPnQMc/5W63wb7pVt1CFOpiuY/MXSgxFaZ3SPKBKfLUEbHN
         cWcquONgixwAR7m+YfldsT/IChi1Y2Ar857lEFb8/VBWq4goATQOBJhyRQKhCDSc9/gh
         c06YTrC8DbQMaIBAt7zfTQX/VJrZd5U7Ua4eRfQE55dNasENttbqg1qNVu+Aw2JK2C0u
         rp8g==
X-Gm-Message-State: AOAM533BxV0lkerGGe81cLfyFmE+WaEq/ekTfcHWV/xDb4B3U9hujWnU
        l9GCig+zSJctM18KUmkoqqRWU94C69O5jOOaG18=
X-Google-Smtp-Source: ABdhPJz2jiiMGZvRKfgykF7D9fs8RZtfXTt9ld6uFqWHe1tp9gLfGf6qFJ0MEYNvRyTF19sbTln95LOJ5vASedLQ77c=
X-Received: by 2002:a65:4685:0:b0:3da:eb4e:61ed with SMTP id
 h5-20020a654685000000b003daeb4e61edmr5205524pgr.591.1652472866609; Fri, 13
 May 2022 13:14:26 -0700 (PDT)
MIME-Version: 1.0
References: <a1ce1743-e450-6cdb-dfab-56a3e3eb9aed@pengutronix.de>
In-Reply-To: <a1ce1743-e450-6cdb-dfab-56a3e3eb9aed@pengutronix.de>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 13 May 2022 13:14:15 -0700
Message-ID: <CABBYNZ+z8kBUKGXbZSfb0ynJaTnPQRp0wFDUb12AW1ymbNx1eg@mail.gmail.com>
Subject: Re: [BUG] BLE device unpairing triggers kernel panic
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Hi Ahmad,

On Fri, May 13, 2022 at 7:10 AM Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>
> Hello,
>
> On Linux v5.18-rc5, I can reliably crash the kernel on the second (un)pairing
> with a customer's BLE device. I have bisected the issue and found two commits:
>
> - Commit 6cd29ec6ae5e ("Bluetooth: hci_sync: Wait for proper events when
>   connecting LE") causes previously working pairing to time out, presumably
>   because it keeps waiting for the wrong event.

Can you describe in more details what is the second pairing, are you
pairing 2 devices concurrently? I recall someone for nxp having
similar problem, at least the traces look pretty similar, the problem
seems to be the expected event don't match the event the controller
send, in this case hci_le_enh_conn_complete_evt, so hci_event process
it and frees the hci_conn instead of first running the callback.

> - Commit a56a1138cbd8 ("Bluetooth: hci_sync: Fix not using conn_timeout")
>   fixes, despite the title, what event is waited on. First Pairing works now,
>   but the second pairing times out and crashes the kernel:
>
>   [   84.191684] Bluetooth: hci0: Opcode 0x200d failed: -110
>   [   84.230478] Bluetooth: hci0: request failed to create LE connection: err -110
>   [   84.237690] Unable to handle kernel read from unreadable memory at virtual address 0000000000000ca8
>
> KASAN tells me that the problem is that the sync workqueue runs with a freed hci_conn:
>
>   [   94.155409] ==================================================================
>   [   94.162658] BUG: KASAN: use-after-free in hci_le_conn_failed+0x38/0x224
>   [   94.162969] imx-sdma 302c0000.dma-controller: restart cyclic channel 1
>   [   94.169316] Read of size 8 at addr ffff00000c88d568 by task kworker/u9:0/70
>   [   94.182811]
>   [   94.184319] CPU: 3 PID: 70 Comm: kworker/u9:0 Tainted: G           O      5.18.0-rc5 #1
>   [   94.192869] Hardware name: i.MX8MM custom board
>   [   94.197676] Workqueue: hci0 hci_cmd_sync_work
>   [   94.202072] Call trace:
>   [   94.204530]  dump_backtrace+0x198/0x200
>   [   94.208394]  show_stack+0x1c/0x30
>   [   94.211729]  dump_stack_lvl+0x64/0x7c
>   [   94.215415]  print_report+0x158/0x5b0
>   [   94.219107]  kasan_report+0xac/0xf0
>   [   94.222619]  __asan_load8+0x8c/0xc4
>   [   94.226131]  hci_le_conn_failed+0x38/0x224
>   [   94.230255]  create_le_conn_complete+0x60/0xac
>   [   94.234726]  hci_cmd_sync_work+0x13c/0x16c
>   [   94.238851]  process_one_work+0x418/0x7f0
>   [   94.242884]  worker_thread+0x328/0x7b0
>   [   94.246655]  kthread+0x138/0x140
>   [   94.249913]  ret_from_fork+0x10/0x20
>   [   94.253512]
>   [   94.255011] Allocated by task 0:
>   [   94.258251] (stack is not available)
>   [   94.261833]
>   [   94.263332] Freed by task 365:
>   [   94.266400]  kasan_save_stack+0x28/0x50
>   [   94.270261]  kasan_set_track+0x28/0x40
>   [   94.274032]  kasan_set_free_info+0x24/0x44
>   [   94.278168]  __kasan_slab_free+0xe8/0x130
>   [   94.282203]  slab_free_freelist_hook+0x6c/0x220
>   [   94.286758]  kfree+0xd0/0x2c0
>   [   94.289743]  bt_link_release+0x18/0x20
>   [   94.293517]  device_release+0x94/0x10c
>   [   94.297294]  kobject_put+0x110/0x290
>   [   94.300899]  put_device+0x18/0x24
>   [   94.304238]  hci_conn_cleanup+0x1d0/0x1e0
>   [   94.308272]  hci_conn_del+0x144/0x158
>   [   94.311955]  hci_conn_failed+0xc0/0xd0
>   [   94.315727]  le_conn_complete_evt+0x4f4/0x760
>   [   94.320107]  hci_le_enh_conn_complete_evt+0xe8/0x104
>   [   94.325094]  hci_le_meta_evt+0x1bc/0x1d8
>   [   94.329047]  hci_event_packet+0x4e8/0x600
>   [   94.333086]  hci_rx_work+0x1dc/0x3ac
>   [   94.336683]  process_one_work+0x418/0x7f0
>   [   94.340719]  worker_thread+0x328/0x7b0
>   [   94.344494]  kthread+0x138/0x140
>   [   94.347753]  ret_from_fork+0x10/0x20
>   [   94.351358]
>   [   94.352855] The buggy address belongs to the object at ffff00000c88d000
>   [   94.352855]  which belongs to the cache kmalloc-2k of size 2048
>   [   94.365395] The buggy address is located 1384 bytes inside of
>   [   94.365395]  2048-byte region [ffff00000c88d000, ffff00000c88d800)
>   [   94.377329]
>   [   94.378832] The buggy address belongs to the physical page:
>   [   94.384421] page:000000009fb0e042 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x4c888
>   [   94.393754] head:000000009fb0e042 order:3 compound_mapcount:0 compound_pincount:0
>   [   94.401256] flags: 0x10200(slab|head|node=0|zone=0)
>   [   94.406168] raw: 0000000000010200 dead000000000100 dead000000000122 ffff000000002900
>   [   94.413934] raw: 0000000000000000 0000000080080008 00000001ffffffff 0000000000000000
>   [   94.421697] page dumped because: kasan: bad access detected
>   [   94.427285]
>   [   94.428783] Memory state around the buggy address:
>   [   94.433590]  ffff00000c88d400: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   [   94.440835]  ffff00000c88d480: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   [   94.448078] >ffff00000c88d500: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   [   94.455316]                                                           ^
>   [   94.461949]  ffff00000c88d580: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   [   94.469196]  ffff00000c88d600: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>   [   94.476436] ==================================================================
>
>
> As a workaround I am reverting 6cd29ec6ae5e for now, but this doesn't fix
> the underlying crash...
>
> I have not been successful in figuring out where the HCI reference counting
> goes wrong. Would be great if someone with more familiarity with the code
> could look into it. Please let me know what more information may be needed.
>
> Cheers,
> Ahmad
>
> ---
> #regzb introduced: a56a1138cbd8 ("Bluetooth: hci_sync: Fix not using conn_timeout")
>
> --
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |



-- 
Luiz Augusto von Dentz
