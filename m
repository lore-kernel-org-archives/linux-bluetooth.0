Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C66DDC432BE
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Aug 2021 07:58:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A10B160FD8
	for <linux-bluetooth@archiver.kernel.org>; Fri, 27 Aug 2021 07:58:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244423AbhH0H72 (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 27 Aug 2021 03:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244363AbhH0H71 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 27 Aug 2021 03:59:27 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9A7FC0613CF;
        Fri, 27 Aug 2021 00:58:38 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id j4-20020a17090a734400b0018f6dd1ec97so4254060pjs.3;
        Fri, 27 Aug 2021 00:58:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9mrKdolaJPPUg+OjeAOe1CFywuPMoBgL3X64Ti5LxsU=;
        b=TgYKmWR+FpDD/6WEZ7W8GaDrqWIHDpj6C3/NgGjW9LO3OZrVRROCWhhTdwf/2kRN43
         qzL/TFnuYEXKYrJB7uL9B9WKXeRDZmZHWYQiTSgPTvuO2j3Uir7b3wFHQXd6/rLMftYx
         c5+jl0KrjHNqp2FBz/nWcvPJmCwRTECYFV36ePB9YjWuR1UfnDgIx4ovmDJKbFjePeHZ
         AUAZeH3vorSn5T4xTVIxLCzPVlROjD98Tl4q+x6qTBZ6TxxCa6iZ+fRXy3ANukfIMuvh
         QzMYQssYJbC3CRD8mUmH1BpHfCm4WVv04Im1JWM9sdLNxG/HBTUQV6Qhfu9xPNCWAF5V
         0Tzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9mrKdolaJPPUg+OjeAOe1CFywuPMoBgL3X64Ti5LxsU=;
        b=uRyQs9xL/VM9HJa8Wl/51lL5q/pmAVJ3Sp7UqUvOpQHpI78rGuDVUdZN13Lt/e2G5a
         xt9FV8O85tjAqMFCVgKnGjJC9gdlV/RJ4kC8PEKFOrL+Zdd6arvTRioeO1oEi3SylVFJ
         MX+hHiPrlFvfPJUxBKnlBDm+1pANsrV1s+TBisIX2AqxttWp1fzX+tZ5ETWD9nFJJLdX
         Ts/Vn0ZgHs7o+1aoKJWahdvVIipIlxVVaSkPY/AMnA4e2jttbwdGqKjTYa399TfkgmvT
         VQs5umGCNotK9Eao+Xyb/NEHnESZw90G3SsZxRe455688206ztSUSYh3HYL3D3kxmjfK
         4cfA==
X-Gm-Message-State: AOAM530SvMoBNSD4afG+T2Skdb8Zm+pEfZufmIGCFcbK/vVlXJ3BIpmP
        ORp6hkQ9XqhREz94qlvXHyg=
X-Google-Smtp-Source: ABdhPJzPgo8bV2OgA3jrjKe3/48ma57A3PImsyrVYV2K4YK26QBYW6DsTzy6s8BemyrKfThcrG7mMA==
X-Received: by 2002:a17:90a:ba03:: with SMTP id s3mr892207pjr.168.1630051118247;
        Fri, 27 Aug 2021 00:58:38 -0700 (PDT)
Received: from [192.168.1.237] ([118.200.190.93])
        by smtp.gmail.com with ESMTPSA id g14sm1017771pfo.59.2021.08.27.00.58.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Aug 2021 00:58:37 -0700 (PDT)
Subject: Re: [syzbot] KASAN: use-after-free Write in sco_sock_timeout
To:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+2bef95d3ab4daa10155b@syzkaller.appspotmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        luiz.von.dentz@intel.com, marcel@holtmann.org,
        syzkaller-bugs@googlegroups.com
References: <000000000000b2725705ca78de29@google.com>
 <20210827011931.2323-1-hdanton@sina.com>
From:   Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
Message-ID: <94797577-0517-99b5-374c-62e4486790d3@gmail.com>
Date:   Fri, 27 Aug 2021 15:58:34 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210827011931.2323-1-hdanton@sina.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

On 27/8/21 9:19 am, Hillf Danton wrote:
> On Thu, 26 Aug 2021 09:29:24 -0700
>> syzbot found the following issue on:
>>
>> HEAD commit:    e3f30ab28ac8 Merge branch 'pktgen-samples-next'
>> git tree:       net-next
>> console output: https://syzkaller.appspot.com/x/log.txt?x=13249c96300000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=ef482942966bf763
>> dashboard link: https://syzkaller.appspot.com/bug?extid=2bef95d3ab4daa10155b
>> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16a29ea9300000
>>
>> The issue was bisected to:
>>
>> commit e1dee2c1de2b4dd00eb44004a4bda6326ed07b59
>> Author: Desmond Cheong Zhi Xi <desmondcheongzx@gmail.com>
>> Date:   Tue Aug 10 04:14:10 2021 +0000
>>
>>      Bluetooth: fix repeated calls to sco_sock_kill
>>
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15030c91300000
>> final oops:     https://syzkaller.appspot.com/x/report.txt?x=17030c91300000
>> console output: https://syzkaller.appspot.com/x/log.txt?x=13030c91300000
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+2bef95d3ab4daa10155b@syzkaller.appspotmail.com
>> Fixes: e1dee2c1de2b ("Bluetooth: fix repeated calls to sco_sock_kill")
>>
>> ==================================================================
>> BUG: KASAN: use-after-free in instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
>> BUG: KASAN: use-after-free in atomic_fetch_add_relaxed include/asm-generic/atomic-instrumented.h:111 [inline]
>> BUG: KASAN: use-after-free in __refcount_add include/linux/refcount.h:193 [inline]
>> BUG: KASAN: use-after-free in __refcount_inc include/linux/refcount.h:250 [inline]
>> BUG: KASAN: use-after-free in refcount_inc include/linux/refcount.h:267 [inline]
>> BUG: KASAN: use-after-free in sock_hold include/net/sock.h:702 [inline]
>> BUG: KASAN: use-after-free in sco_sock_timeout+0x64/0x290 net/bluetooth/sco.c:88
>> Write of size 4 at addr ffff888034b46080 by task kworker/1:0/20
>>
>> CPU: 1 PID: 20 Comm: kworker/1:0 Not tainted 5.14.0-rc6-syzkaller #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
>> Workqueue: events sco_sock_timeout
>> Call Trace:
>>   __dump_stack lib/dump_stack.c:88 [inline]
>>   dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
>>   print_address_description.constprop.0.cold+0x6c/0x309 mm/kasan/report.c:233
>>   __kasan_report mm/kasan/report.c:419 [inline]
>>   kasan_report.cold+0x83/0xdf mm/kasan/report.c:436
>>   check_region_inline mm/kasan/generic.c:183 [inline]
>>   kasan_check_range+0x13d/0x180 mm/kasan/generic.c:189
>>   instrument_atomic_read_write include/linux/instrumented.h:101 [inline]
>>   atomic_fetch_add_relaxed include/asm-generic/atomic-instrumented.h:111 [inline]
>>   __refcount_add include/linux/refcount.h:193 [inline]
>>   __refcount_inc include/linux/refcount.h:250 [inline]
>>   refcount_inc include/linux/refcount.h:267 [inline]
>>   sock_hold include/net/sock.h:702 [inline]
>>   sco_sock_timeout+0x64/0x290 net/bluetooth/sco.c:88
>>   process_one_work+0x98d/0x1630 kernel/workqueue.c:2276
>>   worker_thread+0x658/0x11f0 kernel/workqueue.c:2422
>>   kthread+0x3e5/0x4d0 kernel/kthread.c:319
>>   ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
>>
>> Allocated by task 4872:
>>   kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
>>   kasan_set_track mm/kasan/common.c:46 [inline]
>>   set_alloc_info mm/kasan/common.c:434 [inline]
>>   ____kasan_kmalloc mm/kasan/common.c:513 [inline]
>>   ____kasan_kmalloc mm/kasan/common.c:472 [inline]
>>   __kasan_kmalloc+0x9b/0xd0 mm/kasan/common.c:522
>>   kmalloc include/linux/slab.h:596 [inline]
>>   sk_prot_alloc+0x110/0x290 net/core/sock.c:1822
>>   sk_alloc+0x32/0xbc0 net/core/sock.c:1875
>>   __netlink_create+0x63/0x2f0 net/netlink/af_netlink.c:640
>>   netlink_create+0x3ad/0x5e0 net/netlink/af_netlink.c:703
>>   __sock_create+0x353/0x790 net/socket.c:1461
>>   sock_create net/socket.c:1512 [inline]
>>   __sys_socket+0xef/0x200 net/socket.c:1554
>>   __do_sys_socket net/socket.c:1563 [inline]
>>   __se_sys_socket net/socket.c:1561 [inline]
>>   __x64_sys_socket+0x6f/0xb0 net/socket.c:1561
>>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>>
>> Freed by task 0:
>>   kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
>>   kasan_set_track+0x1c/0x30 mm/kasan/common.c:46
>>   kasan_set_free_info+0x20/0x30 mm/kasan/generic.c:360
>>   ____kasan_slab_free mm/kasan/common.c:366 [inline]
>>   ____kasan_slab_free mm/kasan/common.c:328 [inline]
>>   __kasan_slab_free+0xfb/0x130 mm/kasan/common.c:374
>>   kasan_slab_free include/linux/kasan.h:230 [inline]
>>   slab_free_hook mm/slub.c:1628 [inline]
>>   slab_free_freelist_hook+0xdf/0x240 mm/slub.c:1653
>>   slab_free mm/slub.c:3213 [inline]
>>   kfree+0xe4/0x540 mm/slub.c:4267
>>   sk_prot_free net/core/sock.c:1858 [inline]
>>   __sk_destruct+0x6a8/0x900 net/core/sock.c:1943
>>   sk_destruct+0xbd/0xe0 net/core/sock.c:1958
>>   __sk_free+0xef/0x3d0 net/core/sock.c:1969
>>   sk_free+0x78/0xa0 net/core/sock.c:1980
>>   deferred_put_nlk_sk+0x151/0x2f0 net/netlink/af_netlink.c:740
>>   rcu_do_batch kernel/rcu/tree.c:2550 [inline]
>>   rcu_core+0x7ab/0x1380 kernel/rcu/tree.c:2785
>>   __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
>>
>> Last potentially related work creation:
>>   kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
>>   kasan_record_aux_stack+0xe5/0x110 mm/kasan/generic.c:348
>>   __call_rcu kernel/rcu/tree.c:3029 [inline]
>>   call_rcu+0xb1/0x750 kernel/rcu/tree.c:3109
>>   netlink_release+0xdd4/0x1dd0 net/netlink/af_netlink.c:812
>>   __sock_release+0xcd/0x280 net/socket.c:649
>>   sock_close+0x18/0x20 net/socket.c:1311
>>   __fput+0x288/0x920 fs/file_table.c:280
>>   task_work_run+0xdd/0x1a0 kernel/task_work.c:164
>>   exit_task_work include/linux/task_work.h:32 [inline]
>>   do_exit+0xbd4/0x2a60 kernel/exit.c:825
>>   do_group_exit+0x125/0x310 kernel/exit.c:922
>>   __do_sys_exit_group kernel/exit.c:933 [inline]
>>   __se_sys_exit_group kernel/exit.c:931 [inline]
>>   __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:931
>>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>>
>> Second to last potentially related work creation:
>>   kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
>>   kasan_record_aux_stack+0xe5/0x110 mm/kasan/generic.c:348
>>   __call_rcu kernel/rcu/tree.c:3029 [inline]
>>   call_rcu+0xb1/0x750 kernel/rcu/tree.c:3109
>>   netlink_release+0xdd4/0x1dd0 net/netlink/af_netlink.c:812
>>   __sock_release+0xcd/0x280 net/socket.c:649
>>   sock_close+0x18/0x20 net/socket.c:1311
>>   __fput+0x288/0x920 fs/file_table.c:280
>>   task_work_run+0xdd/0x1a0 kernel/task_work.c:164
>>   exit_task_work include/linux/task_work.h:32 [inline]
>>   do_exit+0xbd4/0x2a60 kernel/exit.c:825
>>   do_group_exit+0x125/0x310 kernel/exit.c:922
>>   __do_sys_exit_group kernel/exit.c:933 [inline]
>>   __se_sys_exit_group kernel/exit.c:931 [inline]
>>   __x64_sys_exit_group+0x3a/0x50 kernel/exit.c:931
>>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>>
>> The buggy address belongs to the object at ffff888034b46000
>>   which belongs to the cache kmalloc-2k of size 2048
>> The buggy address is located 128 bytes inside of
>>   2048-byte region [ffff888034b46000, ffff888034b46800)
>> The buggy address belongs to the page:
>> page:ffffea0000d2d000 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x34b40
>> head:ffffea0000d2d000 order:3 compound_mapcount:0 compound_pincount:0
>> flags: 0xfff00000010200(slab|head|node=0|zone=1|lastcpupid=0x7ff)
>> raw: 00fff00000010200 ffffea0000c37a00 0000000200000002 ffff888010c42000
>> raw: 0000000000000000 0000000000080008 00000001ffffffff 0000000000000000
>> page dumped because: kasan: bad access detected
>> page_owner tracks the page as allocated
>> page last allocated via order 3, migratetype Unmovable, gfp_mask 0xd20c0(__GFP_IO|__GFP_FS|__GFP_NOWARN|__GFP_NORETRY|__GFP_COMP|__GFP_NOMEMALLOC), pid 8634, ts 417197903424, free_ts 417180376519
>>   prep_new_page mm/page_alloc.c:2436 [inline]
>>   get_page_from_freelist+0xa72/0x2f80 mm/page_alloc.c:4169
>>   __alloc_pages+0x1b2/0x500 mm/page_alloc.c:5391
>>   alloc_pages+0x18c/0x2a0 mm/mempolicy.c:2244
>>   alloc_slab_page mm/slub.c:1691 [inline]
>>   allocate_slab+0x32e/0x4b0 mm/slub.c:1831
>>   new_slab mm/slub.c:1894 [inline]
>>   new_slab_objects mm/slub.c:2640 [inline]
>>   ___slab_alloc+0x473/0x7b0 mm/slub.c:2803
>>   __slab_alloc.constprop.0+0xa7/0xf0 mm/slub.c:2843
>>   slab_alloc_node mm/slub.c:2925 [inline]
>>   __kmalloc_node_track_caller+0x2e3/0x360 mm/slub.c:4653
>>   kmalloc_reserve net/core/skbuff.c:355 [inline]
>>   __alloc_skb+0xde/0x340 net/core/skbuff.c:426
>>   alloc_skb include/linux/skbuff.h:1116 [inline]
>>   alloc_skb_with_frags+0x93/0x620 net/core/skbuff.c:6073
>>   sock_alloc_send_pskb+0x783/0x910 net/core/sock.c:2475
>>   mld_newpack+0x1df/0x770 net/ipv6/mcast.c:1756
>>   add_grhead+0x265/0x330 net/ipv6/mcast.c:1859
>>   add_grec+0x1053/0x14e0 net/ipv6/mcast.c:1997
>>   mld_send_initial_cr.part.0+0xf6/0x230 net/ipv6/mcast.c:2244
>>   mld_send_initial_cr net/ipv6/mcast.c:1232 [inline]
>>   ipv6_mc_dad_complete+0x1d0/0x690 net/ipv6/mcast.c:2255
>>   addrconf_dad_completed+0xa20/0xd60 net/ipv6/addrconf.c:4181
>> page last free stack trace:
>>   reset_page_owner include/linux/page_owner.h:24 [inline]
>>   free_pages_prepare mm/page_alloc.c:1346 [inline]
>>   free_pcp_prepare+0x2c5/0x780 mm/page_alloc.c:1397
>>   free_unref_page_prepare mm/page_alloc.c:3332 [inline]
>>   free_unref_page+0x19/0x690 mm/page_alloc.c:3411
>>   unfreeze_partials+0x16c/0x1b0 mm/slub.c:2421
>>   put_cpu_partial+0x13d/0x230 mm/slub.c:2457
>>   qlink_free mm/kasan/quarantine.c:146 [inline]
>>   qlist_free_all+0x5a/0xc0 mm/kasan/quarantine.c:165
>>   kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:272
>>   __kasan_slab_alloc+0x8e/0xa0 mm/kasan/common.c:444
>>   kasan_slab_alloc include/linux/kasan.h:254 [inline]
>>   slab_post_alloc_hook mm/slab.h:519 [inline]
>>   slab_alloc_node mm/slub.c:2959 [inline]
>>   slab_alloc mm/slub.c:2967 [inline]
>>   kmem_cache_alloc+0x285/0x4a0 mm/slub.c:2972
>>   getname_flags.part.0+0x50/0x4f0 fs/namei.c:138
>>   getname_flags fs/namei.c:2747 [inline]
>>   user_path_at_empty+0xa1/0x100 fs/namei.c:2747
>>   user_path_at include/linux/namei.h:57 [inline]
>>   vfs_statx+0x142/0x390 fs/stat.c:203
>>   vfs_fstatat fs/stat.c:225 [inline]
>>   vfs_lstat include/linux/fs.h:3386 [inline]
>>   __do_sys_newlstat+0x91/0x110 fs/stat.c:380
>>   do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>   do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>>   entry_SYSCALL_64_after_hwframe+0x44/0xae
>>
>> Memory state around the buggy address:
>>   ffff888034b45f80: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>>   ffff888034b46000: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>> ffff888034b46080: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>                     ^
>>   ffff888034b46100: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>>   ffff888034b46180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
>> ==================================================================
> 
> Ensure work is canceled before sk_free by using the sync version, and if
> this is a cure then the duplicate cancel in sco_conn_del() can be cleaned
> up in a seperate one.
> 
> Only for thoughts now.
> 
> +++ x/net/bluetooth/sco.c
> @@ -116,7 +116,7 @@ static void sco_sock_clear_timer(struct
>   		return;
>   
>   	BT_DBG("sock %p state %d", sk, sk->sk_state);
> -	cancel_delayed_work(&sco_pi(sk)->conn->timeout_work);
> +	cancel_delayed_work_sync(&sco_pi(sk)->conn->timeout_work);
>   }
>   
>   /* ---- SCO connections ---- */
> 

Hi Hillf,

Thanks for looking into this.

The problem with using cancel_delayed_work_sync is that 
sco_sock_clear_timer is called under the locked socket. So this 
deadlocks with sco_sock_timeout.

What surprises me is that sock_hold is still being called on a killed 
socket. This part of sco_sock_timeout
> 	sco_conn_lock(conn);
> 	sk = conn->sk;
> 	if (sk)
> 		sock_hold(sk);
> 	sco_conn_unlock(conn);

is meant to avoid races with sco_chan_del, which is called on both the 
shutdown and release paths, and prevent the socket from being freed 
while sco_sock_timeout is running. But I'm probably missing something, 
so thoughts would be appreciated.
