Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE5B3CD80C2
	for <linux-bluetooth@archiver.kernel.org>; Tue, 10 Oct 2023 12:49:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjJJMth (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 10 Oct 2023 08:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjJJMtg (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 10 Oct 2023 08:49:36 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E281B7
        for <linux-bluetooth@vger.kernel.org>; Tue, 10 Oct 2023 05:49:34 -0700 (PDT)
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4S4bFz53K2ztTLh;
        Tue, 10 Oct 2023 20:44:55 +0800 (CST)
Received: from [10.174.179.200] (10.174.179.200) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 10 Oct 2023 20:49:31 +0800
Subject: Re: [PATCH v2] Bluetooth: Fix UAF for hci_chan
To:     Pauli Virtanen <pav@iki.fi>,
        linux-bluetooth <linux-bluetooth@vger.kernel.org>
References: <20231009123045.587882-1-william.xuanziyang@huawei.com>
 <117a47da5324a02cece6d601ff8b51b331d072fa.camel@iki.fi>
From:   "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Message-ID: <8f61ef8e-f959-3feb-fb9b-b9b60bf26758@huawei.com>
Date:   Tue, 10 Oct 2023 20:49:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <117a47da5324a02cece6d601ff8b51b331d072fa.camel@iki.fi>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.200]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

> Hi,
> 
> ma, 2023-10-09 kello 20:30 +0800, Ziyang Xuan kirjoitti:
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
>>  	struct list_head list;
>>  	struct mutex	lock;
>>  
>> +	struct ida	unset_handle_ida;
>> +
>>  	const char	*name;
>>  	unsigned long	flags;
>>  	__u16		id;
>> @@ -969,6 +971,7 @@ enum {
>>  	HCI_CONN_AUTH_INITIATOR,
>>  	HCI_CONN_DROP,
>>  	HCI_CONN_CANCEL,
>> +	HCI_CONN_DISC,
>>  	HCI_CONN_PARAM_REMOVAL_PEND,
>>  	HCI_CONN_NEW_LINK_KEY,
>>  	HCI_CONN_SCANNING,
>> @@ -1543,7 +1546,8 @@ static inline void hci_conn_drop(struct hci_conn *conn)
>>  {
>>  	BT_DBG("hcon %p orig refcnt %d", conn, atomic_read(&conn->refcnt));
>>  
>> -	if (atomic_dec_and_test(&conn->refcnt)) {
>> +	if (atomic_dec_and_test(&conn->refcnt) &&
>> +	    !test_bit(HCI_CONN_DISC, &conn->flags)) {
>>  		unsigned long timeo;
> 
> hci_abort_conn already checks if conn->abort_reason was already set, to
> avoid queuing abort for the same conn again. Does this flag not try to
> do the same thing?

That is not enough. hci_conn occur UAF in hci_proto_disconn_ind() before enter
hci_abort_conn().

> 
> There are potential races in hci_sync vs. handle reuse since the queued
> abort is not canceled if the conn is deleted by something else. But now
> I'm not sure syzbot hits this race.

Sorry, can you give a specific scenario. I can't understand exactly what you mean.

> 
>>  
>>  		switch (conn->type) {
>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
>> index 974631e652c1..f87281b4386f 100644
>> --- a/net/bluetooth/hci_conn.c
>> +++ b/net/bluetooth/hci_conn.c
>> @@ -153,6 +153,9 @@ static void hci_conn_cleanup(struct hci_conn *conn)
>>  
>>  	hci_conn_hash_del(hdev, conn);
>>  
>> +	if (HCI_CONN_HANDLE_UNSET(conn->handle))
>> +		ida_free(&hdev->unset_handle_ida, conn->handle);
>> +
>>  	if (conn->cleanup)
>>  		conn->cleanup(conn);
>>  
>> @@ -929,29 +932,17 @@ static void cis_cleanup(struct hci_conn *conn)
>>  	hci_le_remove_cig(hdev, conn->iso_qos.ucast.cig);
>>  }
>>  
>> -static u16 hci_conn_hash_alloc_unset(struct hci_dev *hdev)
>> +static int hci_conn_hash_alloc_unset(struct hci_dev *hdev)
>>  {
>> -	struct hci_conn_hash *h = &hdev->conn_hash;
>> -	struct hci_conn  *c;
>> -	u16 handle = HCI_CONN_HANDLE_MAX + 1;
>> -
>> -	rcu_read_lock();
>> -
>> -	list_for_each_entry_rcu(c, &h->list, list) {
>> -		/* Find the first unused handle */
>> -		if (handle == 0xffff || c->handle != handle)
>> -			break;
>> -		handle++;
>> -	}
>> -	rcu_read_unlock();
> 
> The original hci_conn_hash_alloc_unset seems to have wrong logic. It'll
> e.g. always return HCI_CONN_HANDLE_MAX+1 except if the first conn in
> conn_hash (which is not in particular order) has that handle...
> 
> The code paths adding/deleting conns or entering here / setting handles
> should be holding hdev->lock, so probably no concurrency issue in it.
> 
> Is syzbot happy with just this handle allocation fixed?

Just fix handle, hci_conn occur UAF in hci_proto_disconn_ind() within hci_conn_timeout() process.

> 
>> -
>> -	return handle;
>> +	return ida_alloc_range(&hdev->unset_handle_ida, HCI_CONN_HANDLE_MAX + 1,
>> +			       U16_MAX, GFP_ATOMIC);
>>  }
>>  
> 
