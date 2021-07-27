Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86156C4338F
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jul 2021 15:05:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66B0061B03
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Jul 2021 15:05:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232746AbhG0PFT (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Jul 2021 11:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231552AbhG0PFT (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Jul 2021 11:05:19 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9B7C061757;
        Tue, 27 Jul 2021 08:05:19 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id u9-20020a17090a1f09b029017554809f35so4688557pja.5;
        Tue, 27 Jul 2021 08:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:references:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=z1jZd6pum/BR8l6CPPWniL4YmCytzhMf/odNHB5h/iA=;
        b=XvETxkUS4QZgQwEKC9XG1azlZopjw6YXqAW43yWBNdX8D+5txk7a0Els0ZfBoj928e
         0/IekyW/GAIjYaz9kj1i/2ly2Td7VLJQclkjduJlYkg7XWlTn3LuHwjeKJ/suF+SvqAP
         bGnNe8m/2RJWHC1Aw80F9rMiEbtOKZD+RqSAn/QZZkUGfYg2f+L57zZM4W8aAwwdkc19
         Ou/YRosdAt2z7uVPV1p1dEg1IE/jPk6C2yk2OjguSz2wR9f5CGhMCbIammJYUk0qUgsn
         nSr/kTx/zqsIwX72lLfYHfgbS4FM5ACpxhYB1yEAchHL2PYgO8zmlX3I3ast8CehDBTq
         6GxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z1jZd6pum/BR8l6CPPWniL4YmCytzhMf/odNHB5h/iA=;
        b=Rs9prXCmsjlNCu1j/ud4gonfy/icj33+1P6BmjKIh/h2PMvZDdrQkoHUxW41K8BkjD
         mtEQj0NQvWik+MFpwg+IOQ13FU+lFVygCJKsMwStDSr8tWg/rHJyl/RpjLOBuB9neIOT
         vwFJvcxKvDbbTAXeXkgLypkPyrB0UicH8CBgItbDkNPneQB3BZIAnmnOty/k3vpySNMW
         /ELTf2tnDPxZj7/AM2PFYYSYlCjazdO7GftuCujWhw6Q1eHTAN9iiR8PzxHuy2Ro0YNJ
         +6iX/Tpx0oj6o2SXxi6fjRFNfZ9/F7Et8TQ1oeQqOilhKMdOFBxodg0NYh92BAGOL4oR
         fZqw==
X-Gm-Message-State: AOAM531slQajscuY60KS+hPHh8+aE4RjUS+2P8CU/MqoruEGBohQk5R7
        LDt/8FEEeFQKAnXk37nhfuORtoA17+lu1w==
X-Google-Smtp-Source: ABdhPJxJTqHRMLs5ZHXfPbCrdA5nhLqrdKoXyhJiAJfrbSQiYfmGeNpsKBE51vg648gdTIH+Ojd5Eg==
X-Received: by 2002:a17:90a:bb0d:: with SMTP id u13mr23133684pjr.88.1627398318706;
        Tue, 27 Jul 2021 08:05:18 -0700 (PDT)
Received: from [192.168.1.38] (bb42-60-144-185.singnet.com.sg. [42.60.144.185])
        by smtp.gmail.com with ESMTPSA id g4sm4389248pgn.45.2021.07.27.08.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jul 2021 08:05:18 -0700 (PDT)
From:   Phi Nguyen <phind.uet@gmail.com>
Subject: Re: memory leak in h4_recv_buf
To:     syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        johan.hedberg@gmail.com, linux-bluetooth@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcel@holtmann.org
References: <0000000000006b1779058c0cbdda@google.com>
 <d71a274f-fdeb-4da1-898e-06f6944e04dan@googlegroups.com>
Message-ID: <a125c3e6-7723-185a-3c47-219c201c6785@gmail.com>
Date:   Tue, 27 Jul 2021 23:05:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <d71a274f-fdeb-4da1-898e-06f6944e04dan@googlegroups.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

>     Hello,
> 
>     syzbot found the following crash on:
> 
>     HEAD commit: abf02e29 Merge tag 'pm-5.2-rc6' of
>     git://git.kernel.org/pu <http://git.kernel.org/pu>..
>     git tree: upstream
>     console output:
>     https://syzkaller.appspot.com/x/log.txt?x=1054e6b2a00000
>     <https://syzkaller.appspot.com/x/log.txt?x=1054e6b2a00000>
>     kernel config:
>     https://syzkaller.appspot.com/x/.config?x=56f1da14935c3cce
>     <https://syzkaller.appspot.com/x/.config?x=56f1da14935c3cce>
>     dashboard link:
>     https://syzkaller.appspot.com/bug?extid=97388eb9d31b997fe1d0
>     <https://syzkaller.appspot.com/bug?extid=97388eb9d31b997fe1d0>
>     compiler: gcc (GCC) 9.0.0 20181231 (experimental)
>     syz repro:
>     https://syzkaller.appspot.com/x/repro.syz?x=1073d8aaa00000
>     <https://syzkaller.appspot.com/x/repro.syz?x=1073d8aaa00000>
>     C reproducer:
>     https://syzkaller.appspot.com/x/repro.c?x=17b36fbea00000
>     <https://syzkaller.appspot.com/x/repro.c?x=17b36fbea00000>
> 
>     IMPORTANT: if you fix the bug, please add the following tag to the
>     commit:
>     Reported-by: syzbot+97388e...@syzkaller.appspotmail.com
> 
>     program
>     BUG: memory leak
>     unreferenced object 0xffff88810991fa00 (size 224):
>     comm "syz-executor739", pid 7080, jiffies 4294949854 (age 18.640s)
>     hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
>     backtrace:
>     [<00000000da42c09f>] kmemleak_alloc_recursive
>     include/linux/kmemleak.h:43 [inline]
>     [<00000000da42c09f>] slab_post_alloc_hook mm/slab.h:439 [inline]
>     [<00000000da42c09f>] slab_alloc_node mm/slab.c:3269 [inline]
>     [<00000000da42c09f>] kmem_cache_alloc_node+0x153/0x2a0 mm/slab.c:3579
>     [<00000000f6fbcf84>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:194
>     [<00000000ea93fc4c>] alloc_skb include/linux/skbuff.h:1054 [inline]
>     [<00000000ea93fc4c>] bt_skb_alloc include/net/bluetooth/bluetooth.h:339
>     [inline]
>     [<00000000ea93fc4c>] h4_recv_buf+0x26d/0x450
>     drivers/bluetooth/hci_h4.c:182
>     [<00000000e0312475>] h4_recv+0x51/0xb0 drivers/bluetooth/hci_h4.c:116
>     [<00000000ebf11fab>] hci_uart_tty_receive+0xba/0x200
>     drivers/bluetooth/hci_ldisc.c:592
>     [<0000000095e1216e>] tiocsti drivers/tty/tty_io.c:2195 [inline]
>     [<0000000095e1216e>] tty_ioctl+0x81c/0xa30 drivers/tty/tty_io.c:2571
>     [<000000009fa523f0>] vfs_ioctl fs/ioctl.c:46 [inline]
>     [<000000009fa523f0>] file_ioctl fs/ioctl.c:509 [inline]
>     [<000000009fa523f0>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
>     [<000000000cebb5d9>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
>     [<000000001630008a>] __do_sys_ioctl fs/ioctl.c:720 [inline]
>     [<000000001630008a>] __se_sys_ioctl fs/ioctl.c:718 [inline]
>     [<000000001630008a>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
>     [<00000000c62091e3>] do_syscall_64+0x76/0x1a0
>     arch/x86/entry/common.c:301
>     [<000000005c213625>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
>     BUG: memory leak
>     unreferenced object 0xffff8881204f4400 (size 1024):
>     comm "syz-executor739", pid 7080, jiffies 4294949854 (age 18.640s)
>     hex dump (first 32 bytes):
>     6c 69 62 75 64 65 76 00 fe ed ca fe 28 00 00 00 libudev.....(...
>     28 00 00 00 a0 00 00 00 52 ca da 77 00 00 00 00 (.......R..w....
>     backtrace:
>     [<0000000034504843>] kmemleak_alloc_recursive
>     include/linux/kmemleak.h:43 [inline]
>     [<0000000034504843>] slab_post_alloc_hook mm/slab.h:439 [inline]
>     [<0000000034504843>] slab_alloc_node mm/slab.c:3269 [inline]
>     [<0000000034504843>] kmem_cache_alloc_node_trace+0x15b/0x2a0
>     mm/slab.c:3597
>     [<0000000056d30eb5>] __do_kmalloc_node mm/slab.c:3619 [inline]
>     [<0000000056d30eb5>] __kmalloc_node_track_caller+0x38/0x50
>     mm/slab.c:3634
>     [<00000000df40176c>] __kmalloc_reserve.isra.0+0x40/0xb0
>     net/core/skbuff.c:138
>     [<0000000035340e64>] __alloc_skb+0xa0/0x210 net/core/skbuff.c:206
>     [<00000000ea93fc4c>] alloc_skb include/linux/skbuff.h:1054 [inline]
>     [<00000000ea93fc4c>] bt_skb_alloc include/net/bluetooth/bluetooth.h:339
>     [inline]
>     [<00000000ea93fc4c>] h4_recv_buf+0x26d/0x450
>     drivers/bluetooth/hci_h4.c:182
>     [<00000000e0312475>] h4_recv+0x51/0xb0 drivers/bluetooth/hci_h4.c:116
>     [<00000000ebf11fab>] hci_uart_tty_receive+0xba/0x200
>     drivers/bluetooth/hci_ldisc.c:592
>     [<0000000095e1216e>] tiocsti drivers/tty/tty_io.c:2195 [inline]
>     [<0000000095e1216e>] tty_ioctl+0x81c/0xa30 drivers/tty/tty_io.c:2571
>     [<000000009fa523f0>] vfs_ioctl fs/ioctl.c:46 [inline]
>     [<000000009fa523f0>] file_ioctl fs/ioctl.c:509 [inline]
>     [<000000009fa523f0>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
>     [<000000000cebb5d9>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
>     [<000000001630008a>] __do_sys_ioctl fs/ioctl.c:720 [inline]
>     [<000000001630008a>] __se_sys_ioctl fs/ioctl.c:718 [inline]
>     [<000000001630008a>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
>     [<00000000c62091e3>] do_syscall_64+0x76/0x1a0
>     arch/x86/entry/common.c:301
>     [<000000005c213625>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> 
> 
> 
>     ---
>     This bug is generated by a bot. It may contain errors.
>     See https://goo.gl/tpsmEJ <https://goo.gl/tpsmEJ> for more
>     information about syzbot.
>     syzbot engineers can be reached at syzk...@googlegroups.com.
> 
>     syzbot will keep track of this bug report. See:
>     https://goo.gl/tpsmEJ#status <https://goo.gl/tpsmEJ#status> for how
>     to communicate with syzbot.
>     syzbot can test patches for this bug, for details see:
>     https://goo.gl/tpsmEJ#testing-patches
>     <https://goo.gl/tpsmEJ#testing-patches>
> 
> -- 
> You received this message because you are subscribed to the Google 
> Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send 
> an email to syzkaller-bugs+unsubscribe@googlegroups.com 
> <mailto:syzkaller-bugs+unsubscribe@googlegroups.com>.
> To view this discussion on the web visit 
> https://groups.google.com/d/msgid/syzkaller-bugs/d71a274f-fdeb-4da1-898e-06f6944e04dan%40googlegroups.com 
> <https://groups.google.com/d/msgid/syzkaller-bugs/d71a274f-fdeb-4da1-898e-06f6944e04dan%40googlegroups.com?utm_medium=email&utm_source=footer>.

The reason of this memory leak is tty_ldisc_receive_buf() and tiocsti()
can access the h4->rx_skb concurrently by calling
hci_uart_tty_receive(), so the rx_skb be overwritten without
deallocating. There used to be an spin_lock in hci_uart_tty_receive(),
but it was removed by commit 7649ffaff1cfe(Bluetooth: Remove useless
rx_lock spinlock).

The commit message claims that hci_uart_tty_receive() was only called by
flush_to_ldisc(), but it seems incorrect.
