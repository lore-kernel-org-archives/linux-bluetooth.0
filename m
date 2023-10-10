Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C250CCD80BE
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Oct 2023 12:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbjJJMcE (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Oct 2023 08:32:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbjJJMcB (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Oct 2023 08:32:01 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F812C4
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Oct 2023 05:31:59 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4S4ZtS2Gs2zkY5P;
        Tue, 10 Oct 2023 20:28:00 +0800 (CST)
Received: from [10.174.179.200] (10.174.179.200) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 10 Oct 2023 20:31:56 +0800
Subject: Re: [PATCH v2] Bluetooth: Fix UAF for hci_chan
To:     Luiz Augusto von Dentz <luiz.dentz@gmail.com>
CC:     <marcel@holtmann.org>, <johan.hedberg@gmail.com>,
        <linux-bluetooth@vger.kernel.org>
References: <20231009123045.587882-1-william.xuanziyang@huawei.com>
 <CABBYNZ+49MXzbbJcu2oOw6apXzxXBf8J6D3+PNE_v2aDnV1DdQ@mail.gmail.com>
From:   "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Message-ID: <6dcd1d93-129e-b7bf-a04f-b316e9cb1999@huawei.com>
Date:   Tue, 10 Oct 2023 20:31:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CABBYNZ+49MXzbbJcu2oOw6apXzxXBf8J6D3+PNE_v2aDnV1DdQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.200]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

> Hi,
> 
> On Mon, Oct 9, 2023 at 5:30 AM Ziyang Xuan
> <william.xuanziyang@huawei.com> wrote:
>>
>> Syzbot reports a UAF problem as follows:
>>
>> BUG: KASAN: slab-use-after-free in hci_send_acl+0x48/0xe70 net/bluetooth/hci_core.c:3231
>> ...
>> Call Trace:
>>  <TASK>
>>  __dump_stack lib/dump_stack.c:88 [inline]
>>  dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
>>  print_address_description mm/kasan/report.c:364 [inline]
>>  print_report+0x163/0x540 mm/kasan/report.c:475
>>  kasan_report+0x175/0x1b0 mm/kasan/report.c:588
>>  hci_send_acl+0x48/0xe70 net/bluetooth/hci_core.c:3231
>>  l2cap_send_conn_req net/bluetooth/l2cap_core.c:1286 [inline]
>>  l2cap_start_connection+0x465/0x620 net/bluetooth/l2cap_core.c:1514
>>  l2cap_conn_start+0xbf3/0x1130 net/bluetooth/l2cap_core.c:1661
>>  process_one_work kernel/workqueue.c:2630 [inline]
>>  process_scheduled_works+0x90f/0x1400 kernel/workqueue.c:2703
>>  worker_thread+0xa5f/0xff0 kernel/workqueue.c:2784
>>  kthread+0x2d3/0x370 kernel/kthread.c:388
>>  ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
>>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>>  </TASK>
>>
>> Allocated by task 27110:
>>  kasan_save_stack mm/kasan/common.c:45 [inline]
>>  kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
>>  ____kasan_kmalloc mm/kasan/common.c:374 [inline]
>>  __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:383
>>  kmalloc include/linux/slab.h:599 [inline]
>>  kzalloc include/linux/slab.h:720 [inline]
>>  hci_chan_create+0xc8/0x300 net/bluetooth/hci_conn.c:2714
>>  l2cap_conn_add+0x69/0xc10 net/bluetooth/l2cap_core.c:7841
>>  l2cap_chan_connect+0x61f/0xeb0 net/bluetooth/l2cap_core.c:8053
>>  bt_6lowpan_connect net/bluetooth/6lowpan.c:894 [inline]
>>  lowpan_control_write+0x55e/0x850 net/bluetooth/6lowpan.c:1129
>>  full_proxy_write+0x113/0x1c0 fs/debugfs/file.c:236
>>  vfs_write+0x286/0xaf0 fs/read_write.c:582
>>  ksys_write+0x1a0/0x2c0 fs/read_write.c:637
>>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>>  do_syscall_64+0x41/0xc0 arch/x86/entry/common.c:80
>>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
>>
>> Freed by task 5067:
>>  kasan_save_stack mm/kasan/common.c:45 [inline]
>>  kasan_set_track+0x4f/0x70 mm/kasan/common.c:52
>>  kasan_save_free_info+0x28/0x40 mm/kasan/generic.c:522
>>  ____kasan_slab_free+0xd6/0x120 mm/kasan/common.c:236
>>  kasan_slab_free include/linux/kasan.h:164 [inline]
>>  slab_free_hook mm/slub.c:1800 [inline]
>>  slab_free_freelist_hook mm/slub.c:1826 [inline]
>>  slab_free mm/slub.c:3809 [inline]
>>  __kmem_cache_free+0x25f/0x3b0 mm/slub.c:3822
>>  hci_chan_list_flush net/bluetooth/hci_conn.c:2754 [inline]
>>  hci_conn_cleanup net/bluetooth/hci_conn.c:152 [inline]
>>  hci_conn_del+0x4f8/0xc40 net/bluetooth/hci_conn.c:1156
>>  hci_abort_conn_sync+0xa45/0xfe0
>>  hci_cmd_sync_work+0x228/0x400 net/bluetooth/hci_sync.c:306
>>  process_one_work kernel/workqueue.c:2630 [inline]
>>  process_scheduled_works+0x90f/0x1400 kernel/workqueue.c:2703
>>  worker_thread+0xa5f/0xff0 kernel/workqueue.c:2784
>>  kthread+0x2d3/0x370 kernel/kthread.c:388
>>  ret_from_fork+0x48/0x80 arch/x86/kernel/process.c:147
>>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:304
>>
>> There are two main reasons for this:
>> 1. In the case of hci_conn_add() concurrency, the handle of
>> hci_conn allocated through hci_conn_hash_alloc_unset() is not unique.
>> That will result in getting the wrong hci_conn by
>> hci_conn_hash_lookup_handle().
>> 2. The processes related to hci_abort_conn() can re-enter for the same
>> hci_conn because atomic_dec_and_test(&hci_conn->refcnt) is established
>> in hci_conn_drop(). That will make hci_conn UAF.
>>
>> To fix this, use ida to manage the allocation of conn->handle, and
>> add the HCI_CONN_DISC flag to avoid re-entering of the processes related
>> to hci_abort_conn().
>>
>> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
>> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
>> ---
>> v2:
>>   - Rebase patch base on newest repo.
>>   - Remove HCI_CONN_DISC check in lookup interfaces.
>> ---
>>  include/net/bluetooth/hci_core.h |  6 ++++-
>>  net/bluetooth/hci_conn.c         | 38 ++++++++++++++++----------------
>>  net/bluetooth/hci_core.c         |  3 +++
>>  3 files changed, 27 insertions(+), 20 deletions(-)
>>
>> diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
>> index f36c1fd5d64e..4f44f2bffa57 100644
>> --- a/include/net/bluetooth/hci_core.h
>> +++ b/include/net/bluetooth/hci_core.h
>> @@ -350,6 +350,8 @@ struct hci_dev {
>>         struct list_head list;
>>         struct mutex    lock;
>>
>> +       struct ida      unset_handle_ida;
>> +
>>         const char      *name;
>>         unsigned long   flags;
>>         __u16           id;
>> @@ -969,6 +971,7 @@ enum {
>>         HCI_CONN_AUTH_INITIATOR,
>>         HCI_CONN_DROP,
>>         HCI_CONN_CANCEL,
>> +       HCI_CONN_DISC,
> 
> Can't we just use HCI_CONN_DROP instead of introducing yet another flag?

I don't think this works. When the processes related to hci_abort_conn() be re-entered,
hci_conn can occur UAF in hci_proto_disconn_ind().

syzbot:
https://syzkaller.appspot.com/bug?extid=a0c80b06ae2cb8895bc4
Reproducer:
https://syzkaller.appspot.com/text?tag=ReproC&x=103036d6680000
config file:
https://syzkaller.appspot.com/text?tag=KernelConfig&x=bf95903690e3be2d

Ziyang Xuan
> 
>>         HCI_CONN_PARAM_REMOVAL_PEND,
