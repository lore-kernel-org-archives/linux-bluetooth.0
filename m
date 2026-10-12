Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD0033A70A
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 02:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791773858; cv=none; b=k2gPdwoRMCRxde3r7G5GdNCZ4I6h+D22uGi8N5/gzmfGf7uRiuaMny8FLfpeD889fW+TSrRkwQCbUzZU0vCYZ12tVNRsFh41iTwVq3wHiw8FEgtsv0JCn689Pp9eOdtxR2SfT91e1fy+DPa9kgQne1yrUdeBTuCLcZlNV2lklp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791773858; c=relaxed/simple;
	bh=xiKzgHF1uSn5c7XWzhanvLxymdkP8B3dBves5YNQ6bI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Ll5HorZyIPM+9EGKDaCn2CB377P0vSCwR0ecwC5bFeiJhCBiUfQqcYjk+z3PaByhU4WxON1o0MUHoJ0o8x+5wXI1rxVGOzSiOGpg6rENbnKyl1eCYIqJofykAEuhkI2JVZ3Y7LRsbAeZisSa11LYDKFh2dwTM5kH+IfAJE5UimU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bbjWd1JX; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bbjWd1JX"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2dd1dcdcf95so6540295ad.1
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Oct 2026 19:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791773857; x=1792378657; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KcVwrlk/RusHSGFd4wfyV4XhJQdgwcVH2ElON8D9dbY=;
        b=bbjWd1JXumncN//8ZSweQS9Cd4vs0Fw2lbBBaaoB2M5eEyOaAzC9u09tdkYWAmdUdk
         SVQZldUX/3Xebh8WfELQJHSDz3XlS0Q2Ay/wLZQu0vUIsf8++MNFZzUEGdbOs9PBMCRJ
         j9N878QodZHUBh30H18tqrJRI7gUsOPRbWqKJP8mF/D/01i3lxXwD+ZUHnGklZCqb1vQ
         OWdbZCIJ53PXC2fP0AduHHtSHR4ebYyDLmrB91Oj/rwN9AQXMrcV6zkoQmu1Bg2PWJYO
         7CBSloRjSDKLuLkTEhyqjOmHSNbT4qQB2Gm7hQYD8BMrfeYHoIWkFOdyPQCqzI1Q5Dv3
         I7YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791773857; x=1792378657;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KcVwrlk/RusHSGFd4wfyV4XhJQdgwcVH2ElON8D9dbY=;
        b=FHNHDR3xbzQeE9bLLEPsdJWmJCliMIzyTPTm+RQOonimwRbIkaTFDsz/lLiJk7RHOt
         S4c2wvHRvm0kaozRzHhlHgpIDq1vrAzzRkbhp8COp6egBYL5jEmuL/l3eu/twXxFNGqW
         tQGu49UXYDT72t5wEJMMRDVYMmoOii2RM2zJK4AEepiBfnw/t535nsUK7qb97m6D9XXC
         URDJV7/Y8JykCSfUt/F+3vOi5vKlOKYSs7MjP8wfdyDQH6mcIR1gWKUHXrATqcf/+83B
         5V6fbiehrgfyz1Jh2X5puGHVRLev3N8pH3UZw5QtZwazoLSMrmtCtu7Gl5KhJmXIb5PM
         Yghg==
X-Gm-Message-State: AFq9FYJMnchx38tnM9Jrq8Nanewvk9MRbnTIM5UT/hVcZvqCdaMjtg0O
	KIp5TX3tBSELJNX5TM9OV0ng+Xt6RxeV8TgATP6zNLp/kQs+lJ3wiTdw
X-Gm-Gg: AYBFou3cS3CnbkqK5rdvfxjMtSZjmEfToD0A4EiD+xM1pxiUMWKZ7wuJ09GjsdELG6g
	qiaeQrA3YVqL+lF8FWnyGipf7WOqPDF9vXFKmF0bfOfL3tg7y6EObYnXKQ+eI//SKro/dwQGOMk
	1HB7TerHAdA15he1U4bQcQhyemDo+k9TAdUYZmR0SScGkxUVP3PLhZWtlgzIvBMaEsjMIfDC4rZ
	5i5H1M6I4SSgctDQIkvVWQD0RpyraOlaLTwYP8p44yLzy6nMABkyazX2dePXwzBBh7cmT296BC5
	zOjvgIC9WCmUx7gfMS/j1XDfdyCs+meRmOEKqvAcE71iE463ZDuJ7u8zSF1TU70oGjewNfW5UAk
	ME4RXNp0BRlHYtzwmZBRIq0EZUbobwmVFslnAaJ3r9bPvbwPSfLW1Hoa1lb1awuXHo1ijNLolM0
	/htthv6QO09s8DkbaD1ydPfp2YM96uhptGCmXu7qVs9VZsjoezvdsnFgGQs1MDZuc+7Cs=
X-Received: by 2002:a17:902:e790:b0:2df:8ad8:dc5d with SMTP id d9443c01a7336-2e842ac4a72mr54068285ad.12.1791773856625;
        Sun, 11 Oct 2026 19:57:36 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e841a04b22sm37546305ad.8.2026.10.11.19.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 19:57:36 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	johan.hedberg@intel.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] Bluetooth: hci_core: Keep link keys alive during updates
Date: Mon, 12 Oct 2026 10:57:29 +0800
Message-Id: <pm-bluetooth-objects-candidate-0189-v6-def2692b4feebc514f3f@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Link keys must remain allocated until hci_add_link_key() finishes
reading the old type and writing the new fields. hci_find_link_key()
returns a borrowed pointer after dropping its RCU read lock, and a
new key is linked before its fields are filled in.

When LE Secure Connections pairing derives a BR/EDR link key,
smp_notify_keys() calls hci_add_link_key() without hdev->lock. The
L2CAP connection and channel locks held on this path do not exclude
the device lock taken by a concurrent MGMT Load Link Keys command.
The following ordering is possible:

  SMP receive worker                 MGMT / RCU callback
  ------------------                 -------------------
  hci_add_link_key():
    select or publish K
                                     load_link_keys(): lock hdev
                                     hci_link_keys_clear():
                                       unlink K
                                       queue kfree_rcu(K, rcu)
                                     unlock hdev
                                     grace period ends; free K
    write fields in K

Removal and the grace period can complete after selection or
publication but before the remaining stores. This writes to freed
memory; KASAN reported a six-byte address-field write in
hci_add_link_key().

Hold an outer RCU read-side section across lookup and the last helper
access to the key. On a lookup miss, drop it for the sleeping
allocation and reacquire it before publishing the private new key.
Removal may still unlink the node, but its deferred free must wait
until the helper has finished updating it. This preserves the existing
allocation flags and avoids reversing the device-to-L2CAP lock order.

KASAN report as below:

    BUG: KASAN: slab-use-after-free in hci_add_link_key+0x772/0x970
    Write of size 6 at addr ffff8881074b8120 by task kworker/u17:1/502

    Workqueue: hci0 hci_rx_work
    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? hci_add_link_key+0x772/0x970
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20d/0x410
     ? hci_add_link_key+0x772/0x970
     kasan_report+0xe0/0x110
     ? hci_add_link_key+0x772/0x970
     kasan_check_range+0x105/0x1b0
     __asan_memcpy+0x3c/0x60
     hci_add_link_key+0x772/0x970
     smp_distribute_keys+0xaf6/0x2800
     ? __pfx_smp_distribute_keys+0x10/0x10
     ? kasan_save_track+0x14/0x30
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __kasan_kmalloc+0xaa/0xb0
     ? smp_recv_cb+0x4d32/0x8d80
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __kmalloc_cache_noprof+0x251/0x610
     ? smp_recv_cb+0x4d32/0x8d80
     ? smp_recv_cb+0x4e25/0x8d80
     ? srso_alias_return_thunk+0x5/0xfbef5
     smp_recv_cb+0x4e25/0x8d80
     ? __pfx_smp_recv_cb+0x10/0x10
     ? __pfx___might_resched+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? stack_depot_save_flags+0x29/0x9a0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __mutex_lock+0x182c/0x2590
     ? kasan_save_stack+0x42/0x60
     ? l2cap_recv_frame+0x9ef/0x8830
     ? __kasan_slab_free+0x5f/0x80
     ? kmem_cache_free+0x242/0x580
     ? kfree_skbmem+0x15e/0x1d0
     ? sk_skb_reason_drop+0x12f/0x490
     ? hci_event_packet+0x556/0xc70
     ? hci_rx_work+0x367/0xf00
     ? process_one_work+0x908/0x19c0
     ? worker_thread+0x65c/0xe40
     ? __pfx___mutex_lock+0x10/0x10
     ? __lock_acquire+0x466/0x2260
     ? __pfx_l2cap_chan_hold_unless_zero+0x10/0x10
     ? l2cap_recv_frame+0x13cc/0x8830
     ? __pfx_smp_recv_cb+0x10/0x10
     l2cap_recv_frame+0x13cc/0x8830
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __mutex_lock+0x182c/0x2590
     ? __pfx_l2cap_recv_frame+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? find_held_lock+0x2b/0x80
     ? l2cap_recv_acldata+0x1eb/0x10e0
     ? __pfx___mutex_lock+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __mutex_unlock_slowpath+0x147/0x920
     ? __pfx_l2cap_conn_hold_unless_zero+0x10/0x10
     ? __pfx_hci_conn_enter_active_mode+0x10/0x10
     ? l2cap_recv_acldata+0x13d/0x10e0
     ? srso_alias_return_thunk+0x5/0xfbef5
     l2cap_recv_acldata+0xe9f/0x10e0
     ? srso_alias_return_thunk+0x5/0xfbef5
     hci_rx_work+0x5a6/0xf00
     ? srso_alias_return_thunk+0x5/0xfbef5
     process_one_work+0x908/0x19c0
     ? __pfx_process_one_work+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lock_is_held_type+0x8f/0x100
     ? srso_alias_return_thunk+0x5/0xfbef5
     worker_thread+0x65c/0xe40
     ? __pfx_worker_thread+0x10/0x10
     kthread+0x34f/0x460
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_kthread+0x10/0x10
     ret_from_fork+0x659/0x940
     ? __pfx_ret_from_fork+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __switch_to+0x74f/0xf80
     ? __pfx_kthread+0x10/0x10
     ret_from_fork_asm+0x1a/0x30
     </TASK>

    Allocated by task 502:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_kmalloc+0xaa/0xb0
     __kmalloc_cache_noprof+0x251/0x610
     hci_add_link_key+0x5b8/0x970
     smp_distribute_keys+0xaf6/0x2800
     smp_recv_cb+0x4e25/0x8d80
     l2cap_recv_frame+0x13cc/0x8830
     l2cap_recv_acldata+0xe9f/0x10e0
     hci_rx_work+0x5a6/0xf00
     process_one_work+0x908/0x19c0
     worker_thread+0x65c/0xe40
     kthread+0x34f/0x460
     ret_from_fork+0x659/0x940
     ret_from_fork_asm+0x1a/0x30

    Freed by task 0:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     kasan_save_free_info+0x3b/0x60
     __kasan_slab_free+0x5f/0x80
     __rcu_free_sheaf_prepare+0x65/0x2a0
     rcu_free_sheaf+0x1f/0xe0
     rcu_core+0x661/0x1d10
     handle_softirqs+0x201/0x930
     __irq_exit_rcu+0x110/0x1e0
     irq_exit_rcu+0xe/0x20
     sysvec_apic_timer_interrupt+0x6c/0x80
     asm_sysvec_apic_timer_interrupt+0x1a/0x20

    The buggy address belongs to the object at ffff8881074b8100
                                                                which
                                belongs to the cache kmalloc-64 of size 64
    The buggy address is located 32 bytes inside of
                                                                freed
                                64-byte region [ffff8881074b8100,
                                ffff8881074b8140)

    The buggy address belongs to the physical page:
        page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0
    pfn:0x1074b8
    flags: 0x200000000000000(node=0|zone=2)
    page_type: f5(slab)
        raw: 0200000000000000 ffff8881000428c0 dead000000000100
    dead000000000122
        raw: 0000000000000000 0000000000200020 00000000f5000000
    0000000000000000
    page dumped because: kasan: bad access detected

    Memory state around the buggy address:
     ffff8881074b8000: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
     ffff8881074b8080: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
    >ffff8881074b8100: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                                   ^
     ffff8881074b8180: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
     ffff8881074b8200: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
    ==================================================================

Fixes: 0378b5977013 ("Bluetooth: Convert link keys list to use RCU")
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 209244fd93918..272812ee3d5ae 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1243,15 +1243,21 @@ struct link_key *hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn,
 	struct link_key *key, *old_key;
 	u8 old_key_type;
 
+	/* Keep the key alive until all field updates are complete. */
+	rcu_read_lock();
 	old_key = hci_find_link_key(hdev, bdaddr);
 	if (old_key) {
 		old_key_type = old_key->type;
 		key = old_key;
 	} else {
+		rcu_read_unlock();
+
 		old_key_type = conn ? conn->key_type : 0xff;
 		key = kzalloc_obj(*key);
 		if (!key)
 			return NULL;
+
+		rcu_read_lock();
 		list_add_rcu(&key->list, &hdev->link_keys);
 	}
 
@@ -1280,6 +1286,8 @@ struct link_key *hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn,
 		*persistent = hci_persistent_key(hdev, conn, type,
 						 old_key_type);
 
+	rcu_read_unlock();
+
 	return key;
 }
 
