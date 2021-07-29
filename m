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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 032A6C4320A
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 17:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9EC86044F
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Jul 2021 17:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbhG2RnC (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 29 Jul 2021 13:43:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhG2RnB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 29 Jul 2021 13:43:01 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C34DC061765;
        Thu, 29 Jul 2021 10:42:57 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id ds11-20020a17090b08cbb0290172f971883bso16863115pjb.1;
        Thu, 29 Jul 2021 10:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=MRoPJio2MUhOU0/m1G20970+YlOhtWlEzTe9sZ5FefE=;
        b=JvMYmBi5p9PZelD1NaHz1n+P41kdfl+ssE1Y0qC0mmY7wp5TnYcug1wCbaoiliGpn9
         Ymil3yI60pM07jB8Pz61KGNx0W6KsT1Qc4KlP1MjujRJi/huIfRrCXaAKWA+IJ5p40qB
         i+ieiSTHdgz2TqmqNLzQbvpbXE/DjR/2Q2Tew+DeH+CSQKDgNh2JJ6J1ddEnvOZP6O48
         Sx8KlmF+9mthyvh15veA2zvY4AGydVEgZjoyJSHKGGGHTlt451O+jqctXLS1TiP503Js
         2b1deNsHg0czefe+9eOR+V70Zg2PbLOXQc6/hiABN2/9o7EahjrAmoHyM+TP9cn4Hcs9
         NeJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=MRoPJio2MUhOU0/m1G20970+YlOhtWlEzTe9sZ5FefE=;
        b=bolqKP/2QQwaHJIPR54/Rgp6fenHAv45BmEewlSoXi3IY9RIWpBRWG7JpLcg6fmvYT
         oziAFYDgYx/ca6XEOQPMNtKkojxb+7FfvumtwK6bOTwdfiyDuHEXaCjuJHzJ6lTAU1KE
         9Ei3hqVnGHIZoyBfxjIJUbIv5pJG1no3Aj1mex63doNeFOQ2sU1wggD79uX9zM/Prbdr
         N/ajOwqaK9iQC+fF4ZPR/EqMOcnaanFNktPmf0P0CEbf9o8bOpNN65CKHHZCUysafQev
         moCv7ewY4hnyhTlWwwsrK7pUvtKtRVWeuBLj5r7+trqf6TEeTWpyngaN3X0/gMwFSKoO
         ncQA==
X-Gm-Message-State: AOAM5324xY2GH/eqIt+khSzHMZlHdC5zKJCS6o5QiryL0ByKtSSOeoRI
        F5sBKO4VIwSo/r/TYgfzqlZWwrgsBbAhKjv8
X-Google-Smtp-Source: ABdhPJzVVsEOYzsLtrsbTin/WwJSnu2eLbQUAEXBqMqjcS0/MPBbBhnisjst3ypzyx8vNAcxKNPTNw==
X-Received: by 2002:a65:4242:: with SMTP id d2mr4676368pgq.243.1627580576671;
        Thu, 29 Jul 2021 10:42:56 -0700 (PDT)
Received: from [192.168.1.38] (bb42-60-144-185.singnet.com.sg. [42.60.144.185])
        by smtp.gmail.com with ESMTPSA id y12sm1672446pgk.7.2021.07.29.10.42.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 10:42:56 -0700 (PDT)
Subject: Re: memory leak in h4_recv_buf
To:     Marcel Holtmann <marcel@holtmann.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>,
        linux-kernel@vger.kernel.org
References: <0000000000006b1779058c0cbdda@google.com>
 <d71a274f-fdeb-4da1-898e-06f6944e04dan@googlegroups.com>
 <a125c3e6-7723-185a-3c47-219c201c6785@gmail.com>
 <E59B3DB2-3D96-459B-9902-C9E729407ED2@holtmann.org>
 <20210729120706.GU1931@kadam>
 <AF823758-2063-4E9C-8EF8-9F22107FFB71@holtmann.org>
From:   Phi Nguyen <phind.uet@gmail.com>
Message-ID: <15df8c9d-8809-7da3-842b-a65bfb06abeb@gmail.com>
Date:   Fri, 30 Jul 2021 01:42:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <AF823758-2063-4E9C-8EF8-9F22107FFB71@holtmann.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 7/29/2021 11:39 PM, Marcel Holtmann wrote:
> Hi Dan,
> 
>>>>>    syzbot found the following crash on:
>>>>>    HEAD commit: abf02e29 Merge tag 'pm-5.2-rc6' of
>>>>>    git://git.kernel.org/pu <http://git.kernel.org/pu>..
>>>>>    git tree: upstream
>>>>>    console output:
>>>>>    https://syzkaller.appspot.com/x/log.txt?x=1054e6b2a00000
>>>>>    <https://syzkaller.appspot.com/x/log.txt?x=1054e6b2a00000>
>>>>>    kernel config:
>>>>>    https://syzkaller.appspot.com/x/.config?x=56f1da14935c3cce
>>>>>    <https://syzkaller.appspot.com/x/.config?x=56f1da14935c3cce>
>>>>>    dashboard link:
>>>>>    https://syzkaller.appspot.com/bug?extid=97388eb9d31b997fe1d0
>>>>>    <https://syzkaller.appspot.com/bug?extid=97388eb9d31b997fe1d0>
>>>>>    compiler: gcc (GCC) 9.0.0 20181231 (experimental)
>>>>>    syz repro:
>>>>>    https://syzkaller.appspot.com/x/repro.syz?x=1073d8aaa00000
>>>>>    <https://syzkaller.appspot.com/x/repro.syz?x=1073d8aaa00000>
>>>>>    C reproducer:
>>>>>    https://syzkaller.appspot.com/x/repro.c?x=17b36fbea00000
>>>>>    <https://syzkaller.appspot.com/x/repro.c?x=17b36fbea00000>
>>>>>    IMPORTANT: if you fix the bug, please add the following tag to the
>>>>>    commit:
>>>>>    Reported-by: syzbot+97388e...@syzkaller.appspotmail.com
>>>>>    program
>>>>>    BUG: memory leak
>>>>>    unreferenced object 0xffff88810991fa00 (size 224):
>>>>>    comm "syz-executor739", pid 7080, jiffies 4294949854 (age 18.640s)
>>>>>    hex dump (first 32 bytes):
>>>>>    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
>>>>>    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 ................
>>>>>    backtrace:
>>>>>    [<00000000da42c09f>] kmemleak_alloc_recursive
>>>>>    include/linux/kmemleak.h:43 [inline]
>>>>>    [<00000000da42c09f>] slab_post_alloc_hook mm/slab.h:439 [inline]
>>>>>    [<00000000da42c09f>] slab_alloc_node mm/slab.c:3269 [inline]
>>>>>    [<00000000da42c09f>] kmem_cache_alloc_node+0x153/0x2a0 mm/slab.c:3579
>>>>>    [<00000000f6fbcf84>] __alloc_skb+0x6e/0x210 net/core/skbuff.c:194
>>>>>    [<00000000ea93fc4c>] alloc_skb include/linux/skbuff.h:1054 [inline]
>>>>>    [<00000000ea93fc4c>] bt_skb_alloc include/net/bluetooth/bluetooth.h:339
>>>>>    [inline]
>>>>>    [<00000000ea93fc4c>] h4_recv_buf+0x26d/0x450
>>>>>    drivers/bluetooth/hci_h4.c:182
>>>>>    [<00000000e0312475>] h4_recv+0x51/0xb0 drivers/bluetooth/hci_h4.c:116
>>>>>    [<00000000ebf11fab>] hci_uart_tty_receive+0xba/0x200
>>>>>    drivers/bluetooth/hci_ldisc.c:592
>>>>>    [<0000000095e1216e>] tiocsti drivers/tty/tty_io.c:2195 [inline]
>>>>>    [<0000000095e1216e>] tty_ioctl+0x81c/0xa30 drivers/tty/tty_io.c:2571
>>>>>    [<000000009fa523f0>] vfs_ioctl fs/ioctl.c:46 [inline]
>>>>>    [<000000009fa523f0>] file_ioctl fs/ioctl.c:509 [inline]
>>>>>    [<000000009fa523f0>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
>>>>>    [<000000000cebb5d9>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
>>>>>    [<000000001630008a>] __do_sys_ioctl fs/ioctl.c:720 [inline]
>>>>>    [<000000001630008a>] __se_sys_ioctl fs/ioctl.c:718 [inline]
>>>>>    [<000000001630008a>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
>>>>>    [<00000000c62091e3>] do_syscall_64+0x76/0x1a0
>>>>>    arch/x86/entry/common.c:301
>>>>>    [<000000005c213625>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>>>    BUG: memory leak
>>>>>    unreferenced object 0xffff8881204f4400 (size 1024):
>>>>>    comm "syz-executor739", pid 7080, jiffies 4294949854 (age 18.640s)
>>>>>    hex dump (first 32 bytes):
>>>>>    6c 69 62 75 64 65 76 00 fe ed ca fe 28 00 00 00 libudev.....(...
>>>>>    28 00 00 00 a0 00 00 00 52 ca da 77 00 00 00 00 (.......R..w....
>>>>>    backtrace:
>>>>>    [<0000000034504843>] kmemleak_alloc_recursive
>>>>>    include/linux/kmemleak.h:43 [inline]
>>>>>    [<0000000034504843>] slab_post_alloc_hook mm/slab.h:439 [inline]
>>>>>    [<0000000034504843>] slab_alloc_node mm/slab.c:3269 [inline]
>>>>>    [<0000000034504843>] kmem_cache_alloc_node_trace+0x15b/0x2a0
>>>>>    mm/slab.c:3597
>>>>>    [<0000000056d30eb5>] __do_kmalloc_node mm/slab.c:3619 [inline]
>>>>>    [<0000000056d30eb5>] __kmalloc_node_track_caller+0x38/0x50
>>>>>    mm/slab.c:3634
>>>>>    [<00000000df40176c>] __kmalloc_reserve.isra.0+0x40/0xb0
>>>>>    net/core/skbuff.c:138
>>>>>    [<0000000035340e64>] __alloc_skb+0xa0/0x210 net/core/skbuff.c:206
>>>>>    [<00000000ea93fc4c>] alloc_skb include/linux/skbuff.h:1054 [inline]
>>>>>    [<00000000ea93fc4c>] bt_skb_alloc include/net/bluetooth/bluetooth.h:339
>>>>>    [inline]
>>>>>    [<00000000ea93fc4c>] h4_recv_buf+0x26d/0x450
>>>>>    drivers/bluetooth/hci_h4.c:182
>>>>>    [<00000000e0312475>] h4_recv+0x51/0xb0 drivers/bluetooth/hci_h4.c:116
>>>>>    [<00000000ebf11fab>] hci_uart_tty_receive+0xba/0x200
>>>>>    drivers/bluetooth/hci_ldisc.c:592
>>>>>    [<0000000095e1216e>] tiocsti drivers/tty/tty_io.c:2195 [inline]
>>>>>    [<0000000095e1216e>] tty_ioctl+0x81c/0xa30 drivers/tty/tty_io.c:2571
>>>>>    [<000000009fa523f0>] vfs_ioctl fs/ioctl.c:46 [inline]
>>>>>    [<000000009fa523f0>] file_ioctl fs/ioctl.c:509 [inline]
>>>>>    [<000000009fa523f0>] do_vfs_ioctl+0x62a/0x810 fs/ioctl.c:696
>>>>>    [<000000000cebb5d9>] ksys_ioctl+0x86/0xb0 fs/ioctl.c:713
>>>>>    [<000000001630008a>] __do_sys_ioctl fs/ioctl.c:720 [inline]
>>>>>    [<000000001630008a>] __se_sys_ioctl fs/ioctl.c:718 [inline]
>>>>>    [<000000001630008a>] __x64_sys_ioctl+0x1e/0x30 fs/ioctl.c:718
>>>>>    [<00000000c62091e3>] do_syscall_64+0x76/0x1a0
>>>>>    arch/x86/entry/common.c:301
>>>>>    [<000000005c213625>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
>>>>>    ---
>>>>>    This bug is generated by a bot. It may contain errors.
>>>>>    See https://goo.gl/tpsmEJ <https://goo.gl/tpsmEJ> for more
>>>>>    information about syzbot.
>>>>>    syzbot engineers can be reached at syzk...@googlegroups.com.
>>>>>    syzbot will keep track of this bug report. See:
>>>>>    https://goo.gl/tpsmEJ#status <https://goo.gl/tpsmEJ#status> for how
>>>>>    to communicate with syzbot.
>>>>>    syzbot can test patches for this bug, for details see:
>>>>>    https://goo.gl/tpsmEJ#testing-patches
>>>>>    <https://goo.gl/tpsmEJ#testing-patches>
>>>>> -- 
>>>>> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
>>>>> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com <mailto:syzkaller-bugs+unsubscribe@googlegroups.com>.
>>>>> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/d71a274f-fdeb-4da1-898e-06f6944e04dan%40googlegroups.com <https://groups.google.com/d/msgid/syzkaller-bugs/d71a274f-fdeb-4da1-898e-06f6944e04dan%40googlegroups.com?utm_medium=email&utm_source=footer>.
>>>>
>>>> The reason of this memory leak is tty_ldisc_receive_buf() and tiocsti()
>>>> can access the h4->rx_skb concurrently by calling
>>>> hci_uart_tty_receive(), so the rx_skb be overwritten without
>>>> deallocating. There used to be an spin_lock in hci_uart_tty_receive(),
>>>> but it was removed by commit 7649ffaff1cfe(Bluetooth: Remove useless
>>>> rx_lock spinlock).
>>>
>>> I don’t have that commit in my Linus’ tree. Where is it?
>>>
>>
>> There is a typo in the git hash.  It should be: 7649faff1cfe4 ("Bluetooth:
>> Remove useless rx_lock spinlock").
>>
>>>> The commit message claims that hci_uart_tty_receive() was only called by
>>>> flush_to_ldisc(), but it seems incorrect.
>>>
>>> That seems to be a larger problem in the TTY layer if its contract with its users have changed.
>>
>> The tiocsti() function has an ancient comment which suggests that the
>> documentation has always been wrong.
>>
>> *      FIXME: may race normal receive processing
> 
> so what are we suppose to do now? Fix this in TTY layer or try to revert this patch?
> 
> And does it have to be spinlock or can we use a mutex? My knowledge of the TTY internal are limited and thus, I have no idea what we need to do here. However h4_recv_buf needs to be protected against concurrently calls.
> 
> Regards
> 
> Marcel
> 
Hi Marcel,

So far, I have tested two fixes with syzbot
The first one is to bring the spin lock back to hci_uart_tty_receive().
The second one is to use tty_buffer_lock_exclusive() in tiocsti() (I 
based on the document in tty_buffer.c).
These two can work well with the syzbot.

Regards,
Phi
