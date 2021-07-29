Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FE21C4338F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 12:05:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E101360E94
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 12:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235368AbhG2MFQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 08:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbhG2MFP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 08:05:15 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6C3C061765;
        Thu, 29 Jul 2021 05:05:11 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id t3so4605627plg.9;
        Thu, 29 Jul 2021 05:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gjrMSa3piEpTTB3wWrNokP96IQ6EcaaAV2wejFXs0NM=;
        b=F35IRTMDS9KkoZViDb5T0H+083oauZsQFhpvpzc2F6/ArLsKM+wCc3ZB5cXY9yhFIU
         v1KPcOkYs1lkyKAH6yZpcjNgICaqAbiQSQjdA7Io5R08unECV3dR0KHn8fLq7ZGZy600
         wy5BYKKgH8trqKPtmtatRSyBfIrHfHgXSukDHmyvIHsKxvEGq6cEWq+5ULdsKgy7GAb9
         09rCfhAZkDw919kHNnzsEQLqp7oDOBu276nlHRYlUtQKxjzgplxd5+BhGIDwyCXxC0il
         fG17vpUifNN49lEcuQp/AMMw7/EPaUG442+O8HzFzRQUlHzr3QsOq1NUi3ZrUan83asr
         y07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gjrMSa3piEpTTB3wWrNokP96IQ6EcaaAV2wejFXs0NM=;
        b=lHs+OCkQnaZqgiVRgghDAgKD5/VRFAoEv17+Aox/scYQhXuaYpJTZVCzoFXv6lD6ax
         9q136ajxoxWBvZuphMOLM4IgEFQvd1uXR8jeVwAyuAsiE6ylEO6HuD8cE7P7PkqNFWek
         XFGs9QHTYUtaOL893gIlYGU6F3V003CA4B0Hum4KyGtYMVC2TB2Bt/tbg5xenIOjyckl
         T04BVmZlYgn1bfSxbK9blE18xlSudoqG7tvvZ1VwXBBLRtINZ80VI1TJmLv0CjLfSlPB
         aYuyEU+7VT/MCYW5k/CDiCpIXJimnAxxMEwFzbLjc06061Mchy74dA7z8WJFEtwR9rSY
         cdbg==
X-Gm-Message-State: AOAM533Y+QPcTkRBbl2mcnU7kRFCqWK3cdoFU7SOZb6xMFRRRSy6N342
        Zw1/9iFhzyfUqGvTcELYVMFNNSNEXKdBOA==
X-Google-Smtp-Source: ABdhPJyC2Wu5Q8RFBmCJIUeR8Ugxy+KzVlFYH4BNtakcX6muzX5l4gVbLsazDJFwMB8B7xRKJJlmiQ==
X-Received: by 2002:a63:4f50:: with SMTP id p16mr2996219pgl.378.1627560311092;
        Thu, 29 Jul 2021 05:05:11 -0700 (PDT)
Received: from [192.168.1.38] (bb42-60-144-185.singnet.com.sg. [42.60.144.185])
        by smtp.gmail.com with ESMTPSA id s3sm3506467pfk.61.2021.07.29.05.05.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 05:05:10 -0700 (PDT)
Subject: Re: memory leak in h4_recv_buf
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
References: <0000000000006b1779058c0cbdda@google.com>
 <d71a274f-fdeb-4da1-898e-06f6944e04dan@googlegroups.com>
 <a125c3e6-7723-185a-3c47-219c201c6785@gmail.com>
 <E59B3DB2-3D96-459B-9902-C9E729407ED2@holtmann.org>
From:   Phi Nguyen <phind.uet@gmail.com>
Message-ID: <82554b3b-1b0e-6202-bb97-d969997c10b2@gmail.com>
Date:   Thu, 29 Jul 2021 20:05:07 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <E59B3DB2-3D96-459B-9902-C9E729407ED2@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 7/29/2021 7:44 PM, Marcel Holtmann wrote:
> Hi Phi,
> 
>>>     Hello,
>>>     syzbot found the following crash on:
>>>     HEAD commit: abf02e29 Merge tag 'pm-5.2-rc6' of
>>>     git://git.kernel.org/pu <http://git.kernel.org/pu>..
>>>     git tree: upstream
>>>     console output:
>>>     https://syzkaller.appspot.com/x/log.txt?x=1054e6b2a00000
>>>     <https://syzkaller.appspot.com/x/log.txt?x=1054e6b2a00000>
>>>     kernel config:
>>>     https://syzkaller.appspot.com/x/.config?x=56f1da14935c3cce
>>>     <https://syzkaller.appspot.com/x/.config?x=56f1da14935c3cce>
>>>     dashboard link:
>>>     https://syzkaller.appspot.com/bug?extid=97388eb9d31b997fe1d0
>>>     <https://syzkaller.appspot.com/bug?extid=97388eb9d31b997fe1d0>
>>>     compiler: gcc (GCC) 9.0.0 20181231 (experimental)
>>>     syz repro:
>>>     https://syzkaller.appspot.com/x/repro.syz?x=1073d8aaa00000
>>>     <https://syzkaller.appspot.com/x/repro.syz?x=1073d8aaa00000>
>>>     C reproducer:
>>>     https://syzkaller.appspot.com/x/repro.c?x=17b36fbea00000
>>>     <https://syzkaller.appspot.com/x/repro.c?x=17b36fbea00000>
>>>     IMPORTANT: if you fix the bug, please add the following tag to the
>>>     commit:
>>>     Reported-by: syzbot+97388e...@syzkaller.appspotmail.com
>>>     program
>>>     BUG: memory leak
>>>     unreferenced object 0xffff88810991fa00 (size 224):
>>>     comm "syz-executor739", pid 7080, jiffies 4294949854 (age 18.640s)
>>>     hex dump (first 32 bytes):
>>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
>>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
>>>     backtrace:
>>>     [<00000000da42c09f>] kmemleak_alloc_recursive
>>>     include/linux/kmemleak.h:43 [inline]
>>>     [<00000000da42c09f>] slab_post_alloc_hook mm/slab.h:439 [inline]
>>>     [<00000000da42c09f>] slab_alloc_node mm/slab.c:3269 [inline]
>>>     [<00000000da42c09f>] kmem_cache_alloc_node+0x153/0x2a0 mm/slab.c:3579
>>>     [<00000000f6fbcf84>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:194
>>>     [<00000000ea93fc4c>] alloc_skb include/linux/skbuff.h:1054 [inline]
>>>     [<00000000ea93fc4c>] bt_skb_alloc include/net/bluetooth/bluetooth.h:339
>>>     [inline]
>>>     [<00000000ea93fc4c>] h4_recv_buf+0x26d/0x450
>>>     drivers/bluetooth/hci_h4.c:182
>>>     [<00000000e0312475>] h4_recv+0x51/0xb0 drivers/bluetooth/hci_h4.c:116
>>>     [<00000000ebf11fab>] hci_uart_tty_receive+0xba/0x200
>>>     drivers/bluetooth/hci_ldisc.c:592
>>>     [<0000000095e1216e>] tiocsti drivers/tty/tty_io.c:2195 [inline]
>>>     [<0000000095e1216e>] tty_ioctl+0x81c/0xa30 drivers/tty/tty_io.c:2571
>>>     [<000000009fa523f0>] vfs_ioctl fs/ioctl.c:46 [inline]
>>>     [<000000009fa523f0>] file_ioctl fs/ioctl.c:509 [inline]
>>>     [<000000009fa523f0>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
>>>     [<000000000cebb5d9>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
>>>     [<000000001630008a>] __do_sys_ioctl fs/ioctl.c:720 [inline]
>>>     [<000000001630008a>] __se_sys_ioctl fs/ioctl.c:718 [inline]
>>>     [<000000001630008a>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
>>>     [<00000000c62091e3>] do_syscall_64+0x76/0x1a0
>>>     arch/x86/entry/common.c:301
>>>     [<000000005c213625>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>     BUG: memory leak
>>>     unreferenced object 0xffff8881204f4400 (size 1024):
>>>     comm "syz-executor739", pid 7080, jiffies 4294949854 (age 18.640s)
>>>     hex dump (first 32 bytes):
>>>     6c 69 62 75 64 65 76 00 fe ed ca fe 28 00 00 00 libudev.....(...
>>>     28 00 00 00 a0 00 00 00 52 ca da 77 00 00 00 00 (.......R..w....
>>>     backtrace:
>>>     [<0000000034504843>] kmemleak_alloc_recursive
>>>     include/linux/kmemleak.h:43 [inline]
>>>     [<0000000034504843>] slab_post_alloc_hook mm/slab.h:439 [inline]
>>>     [<0000000034504843>] slab_alloc_node mm/slab.c:3269 [inline]
>>>     [<0000000034504843>] kmem_cache_alloc_node_trace+0x15b/0x2a0
>>>     mm/slab.c:3597
>>>     [<0000000056d30eb5>] __do_kmalloc_node mm/slab.c:3619 [inline]
>>>     [<0000000056d30eb5>] __kmalloc_node_track_caller+0x38/0x50
>>>     mm/slab.c:3634
>>>     [<00000000df40176c>] __kmalloc_reserve.isra.0+0x40/0xb0
>>>     net/core/skbuff.c:138
>>>     [<0000000035340e64>] __alloc_skb+0xa0/0x210 net/core/skbuff.c:206
>>>     [<00000000ea93fc4c>] alloc_skb include/linux/skbuff.h:1054 [inline]
>>>     [<00000000ea93fc4c>] bt_skb_alloc include/net/bluetooth/bluetooth.h:339
>>>     [inline]
>>>     [<00000000ea93fc4c>] h4_recv_buf+0x26d/0x450
>>>     drivers/bluetooth/hci_h4.c:182
>>>     [<00000000e0312475>] h4_recv+0x51/0xb0 drivers/bluetooth/hci_h4.c:116
>>>     [<00000000ebf11fab>] hci_uart_tty_receive+0xba/0x200
>>>     drivers/bluetooth/hci_ldisc.c:592
>>>     [<0000000095e1216e>] tiocsti drivers/tty/tty_io.c:2195 [inline]
>>>     [<0000000095e1216e>] tty_ioctl+0x81c/0xa30 drivers/tty/tty_io.c:2571
>>>     [<000000009fa523f0>] vfs_ioctl fs/ioctl.c:46 [inline]
>>>     [<000000009fa523f0>] file_ioctl fs/ioctl.c:509 [inline]
>>>     [<000000009fa523f0>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
>>>     [<000000000cebb5d9>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
>>>     [<000000001630008a>] __do_sys_ioctl fs/ioctl.c:720 [inline]
>>>     [<000000001630008a>] __se_sys_ioctl fs/ioctl.c:718 [inline]
>>>     [<000000001630008a>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
>>>     [<00000000c62091e3>] do_syscall_64+0x76/0x1a0
>>>     arch/x86/entry/common.c:301
>>>     [<000000005c213625>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>     ---
>>>     This bug is generated by a bot. It may contain errors.
>>>     See https://goo.gl/tpsmEJ <https://goo.gl/tpsmEJ> for more
>>>     information about syzbot.
>>>     syzbot engineers can be reached at syzk...@googlegroups.com.
>>>     syzbot will keep track of this bug report. See:
>>>     https://goo.gl/tpsmEJ#status <https://goo.gl/tpsmEJ#status> for how
>>>     to communicate with syzbot.
>>>     syzbot can test patches for this bug, for details see:
>>>     https://goo.gl/tpsmEJ#testing-patches
>>>     <https://goo.gl/tpsmEJ#testing-patches>
>>> -- 
>>> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
>>> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com <mailto:syzkaller-bugs+unsubscribe@googlegroups.com>.
>>> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/d71a274f-fdeb-4da1-898e-06f6944e04dan%40googlegroups.com <https://groups.google.com/d/msgid/syzkaller-bugs/d71a274f-fdeb-4da1-898e-06f6944e04dan%40googlegroups.com?utm_medium=email&utm_source=footer>.
>>
>> The reason of this memory leak is tty_ldisc_receive_buf() and tiocsti()
>> can access the h4->rx_skb concurrently by calling
>> hci_uart_tty_receive(), so the rx_skb be overwritten without
>> deallocating. There used to be an spin_lock in hci_uart_tty_receive(),
>> but it was removed by commit 7649ffaff1cfe(Bluetooth: Remove useless
>> rx_lock spinlock).
> 
> I don’t have that commit in my Linus’ tree. Where is it?
> 
>> The commit message claims that hci_uart_tty_receive() was only called by
>> flush_to_ldisc(), but it seems incorrect.
> 
> That seems to be a larger problem in the TTY layer if its contract with its users have changed.
> 
> Regards
> 
> Marcel
> 
Hi  Marcel,

It was my typo, the git hash should be 7649faff1cfe4.

Regards,
Phi.
