Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566683148A7
	for <linux-bluetooth@vger.kernel.org>; Mon, 12 Oct 2026 03:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791774158; cv=none; b=mbiOFLGcI+idR/etE4hj5+a6CgRlp4uAeA+WOXlx7c91qYeFp0xmgfRKqA4v9nGQotwlh5SGFGP+deRclc3bjnGLFDf8TzhUkeU5Ky3q/3Eedlf3xQY1xwK35/JKSRDTVGxOkxVlmKy2Wkg+Ag3xXK2tQ/rU0TzX51IapOivWYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791774158; c=relaxed/simple;
	bh=SuVAYnD3a5xDMYKaPk1ig9A/mIZWPLfCf63r0FevbsE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=jg7YgV8GwcOFtpe6ThFga5DmdDhaGsHux3eWmWosAD7FWe5ymcEGi+jzNnr30SB56/E1+lXqDHQmcX7+glRkDu0Sdw3s+I9OvyOJct8/B7GbtxFMRLlJ9tI+7tB1VmOlkUiOaRiVwKrtvQT/4txgu7J7QFES3hU723awv1jeYek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fNFg9uZ6; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fNFg9uZ6"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ab98332238so577850a91.3
        for <linux-bluetooth@vger.kernel.org>; Sun, 11 Oct 2026 20:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791774157; x=1792378957; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/ypdqgvPr7OfUIUhXGpb5sQlR8bwQfco6ZrXxOL4NHw=;
        b=fNFg9uZ66BsCFGWSUnvzVgBtAEZN/KRG0vEH20/6tLQAB6p1equZ3LoQGj/inywvXm
         80PITuZEryicqlW3nK9Y4qWgEMYxbkP3wBAFR7s9vNYjczJDMWlWHYQ/K8ySS/CFFc65
         PsP0n+sB8DBjkS9P1vP4cHf/53yrOlYeGIGnmstZQL1oAjzsEaiMWcTEJ6/CQsguYIcT
         iEJa3NASL8BrEYtuUf6EJ4tPvsBHnUT0QEwTT4eBnP9PdUwnGVNzWi4jjyeKEz0GY+eC
         lZT30gBCDTQGPtdQVq61V1CX6PnscjheAldfD/45exndZ+Bz2cFJqSslo0rHZqh85D11
         9wDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791774157; x=1792378957;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=/ypdqgvPr7OfUIUhXGpb5sQlR8bwQfco6ZrXxOL4NHw=;
        b=S4e5qUvUfQqXt/reOIe24OdsO6BacbCu0j2kE7sVaN+YdiKow5RS0OwC+vPlsSQpN6
         ySosR4uInkrgwvHHxH0vNWMfEb/6H/if5rviJ/i/oKyyPkhKDrjDK79ctfUo3+R56TzS
         4TobTQqA377kGahZFs1J40byWTF2fMXn2KyA4g8VGwNQaDuDbPUGnumrTPLhJmjhsbzp
         Qijq06HDRet+0wC3txv4ZjlaaFzDTCgjEqw7AASranIRUBYMYKZhaJeLkDw7cv5b/m/B
         60vwn0b/3f47rIlpE12H1f3diaffR3UIXzgWojo/Xl99G/ANBrs2WRlCxgUfNVAKffbN
         qOkw==
X-Gm-Message-State: AFq9FYL6ueEppn8+P2rG3fFBbB0DMAepXJPxhabrl4X0tRhMofVpIA2U
	YzXpUEOPGjUci5u0hq+LJN9eJG50WWVBMQmBbOx5DcwFmmTgMkLoveCj
X-Gm-Gg: AYBFou3/LLe5COABesuM9s1bYCfeVb2n6D1anjHANaMvZaNGa36DPgIFYNRCvSJl1lp
	SHgdxTpUZ4iWJ7YoxYooyXtiE5gyBS4gUpa1YOFumU9DS8wW6rLKAStoI6be44X2rZF00XGSs7x
	lr4FrSR9xBCMvmNGBC8Roz2fw13jGU1Nx6LvEHBonT5VjZbx+Fteatr9R4qtPHmesN/qf72jJGg
	iIS1YoQzZdDyhHGgNqtn29j3Rpplj4nmfaWGBuIh7ZwlI738orGZx2ch8ekNGFpBSMrgKTB8Mpl
	BpjBfHr1lY0zmjYZA4e+DXcNdrxPCTQrrYGHgmpL/SMyyHbqD/rlSvagymf+biZ0zyJFumC6pWv
	qZNDJLj5Ncs5uTATjTkWwoX81BAlE0X2MqPloRZVxYBfO68klsOJ7zcGDpk8E6dPjbkXGdkt8E/
	tig3B2vQrkVfJdQBOP2EBeT9HUBxcoo0V4Tb7zKPVy2u4A2wBHrLqSV0de+Q9jja7SFoBWI1e70
	0lL
X-Received: by 2002:a17:90b:1a8f:b0:3a7:a6bc:9d4b with SMTP id 98e67ed59e1d1-3ab3afe44edmr7514705a91.59.1791774156559;
        Sun, 11 Oct 2026 20:02:36 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab3386ba90sm9030708a91.1.2026.10.11.20.02.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 20:02:35 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	johan.hedberg@intel.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] Bluetooth: Keep IRKs alive during updates
Date: Mon, 12 Oct 2026 11:02:30 +0800
Message-Id: <pm-bluetooth-objects-candidate-0191-v7-12caee3a7046a1a8f311@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

An IRK selected by hci_add_irk() must remain allocated until its value
and RPA have been copied. hci_find_irk_by_addr() returns a borrowed
pointer after dropping its RCU read lock, leaving the subsequent stores
without lifetime protection on the SMP receive path.

A valid SMP Identity Address Information message can update an existing
IRK while MGMT Load IRKs replaces the identity resolving key list.
l2cap_recv_acldata() drops hdev->lock before SMP processing, so the
connection and channel locks do not exclude load_irks(). One possible
ordering is:

    SMP receive worker               Management / RCU
    hci_add_irk()
      hci_find_irk_by_addr()
        rcu_read_lock()
        find matching IRK
        rcu_read_unlock()
                                     load_irks()
                                       hci_dev_lock()
                                       hci_smp_irks_clear()
                                         list_del_rcu()
                                         kfree_rcu()
                                       hci_dev_unlock()
                                     RCU grace period ends
                                     IRK is freed
      memcpy(irk->val, val, 16)
      bacpy(&irk->rpa, rpa)

The receive worker then writes into freed memory. KASAN reported a
16-byte write in hci_add_irk(), 45 bytes into a freed smp_irk
allocation.

Keep an outer RCU read-side critical section in hci_add_irk() across the
lookup and both copies. Drop it before the GFP_KERNEL allocation and
reacquire it before publishing a new node. Reclamation must then wait
until the stores finish. This also avoids acquiring hdev->lock under the
L2CAP locks, which would invert the existing lock order.

The change has not been runtime-tested.

KASAN report as below:

    ==================================================================
    BUG: KASAN: slab-use-after-free in hci_add_irk+0x77/0x2a0
    Write of size 16 at addr ffff88810bbdcc2d by task kworker/u17:0/526

    Workqueue: hci0 hci_rx_work
    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? hci_add_irk+0x77/0x2a0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20d/0x410
     ? hci_add_irk+0x77/0x2a0
     kasan_report+0xe0/0x110
     ? hci_add_irk+0x77/0x2a0
     kasan_check_range+0x105/0x1b0
     __asan_memcpy+0x3c/0x60
     hci_add_irk+0x77/0x2a0
     smp_recv_cb+0x594d/0x8e40
     ? __pfx_smp_recv_cb+0x10/0x10
     ? __pfx___might_resched+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? stack_depot_save_flags+0x29/0x9a0
     ? __mutex_lock+0x182c/0x2590
     ? kasan_save_stack+0x42/0x60
     ? l2cap_recv_frame+0x9ef/0x8830
     ? __kasan_slab_free+0x5f/0x80
     ? kmem_cache_free+0x242/0x580
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? find_held_lock+0x2b/0x80
     ? l2cap_recv_frame+0xaef/0x8830
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

    Allocated by task 520:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_kmalloc+0xaa/0xb0
     __kmalloc_cache_noprof+0x251/0x610
     hci_add_irk+0x131/0x2a0
     load_irks+0x5fb/0x8c0
     hci_sock_sendmsg+0x128b/0x22e0
     sock_write_iter+0x4c0/0x550
     do_iter_readv_writev+0x59c/0x860
     vfs_writev+0x30e/0xc10
     do_writev+0x241/0x2f0
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

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

    The buggy address belongs to the object at ffff88810bbdcc00
                                                                which
                                belongs to the cache kmalloc-64 of size 64
    The buggy address is located 45 bytes inside of
                                                                freed
                                64-byte region [ffff88810bbdcc00,
                                ffff88810bbdcc40)

    The buggy address belongs to the physical page:
        page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0
    pfn:0x10bbdc
    flags: 0x200000000000000(node=0|zone=2)
    page_type: f5(slab)
        raw: 0200000000000000 ffff8881000428c0 dead000000000100
    dead000000000122
        raw: 0000000000000000 0000000000200020 00000000f5000000
    0000000000000000
    page dumped because: kasan: bad access detected

    Memory state around the buggy address:
     ffff88810bbdcb00: 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc fc
     ffff88810bbdcb80: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
    >ffff88810bbdcc00: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
                                      ^
     ffff88810bbdcc80: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
     ffff88810bbdcd00: fa fb fb fb fb fb fb fb fc fc fc fc fc fc fc fc
    ==================================================================
    Disabling lock debugging due to kernel taint

Fixes: adae20cb2d20 ("Bluetooth: Convert IRK list to RCU")
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 209244fd93918..f8c274c21c0f7 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1317,8 +1317,14 @@ struct smp_irk *hci_add_irk(struct hci_dev *hdev, bdaddr_t *bdaddr,
 {
 	struct smp_irk *irk;
 
+	/*
+	 * Keep the IRK alive until the value and RPA copies are complete.
+	 */
+	rcu_read_lock();
 	irk = hci_find_irk_by_addr(hdev, bdaddr, addr_type);
 	if (!irk) {
+		rcu_read_unlock();
+
 		irk = kzalloc_obj(*irk);
 		if (!irk)
 			return NULL;
@@ -1326,11 +1332,13 @@ struct smp_irk *hci_add_irk(struct hci_dev *hdev, bdaddr_t *bdaddr,
 		bacpy(&irk->bdaddr, bdaddr);
 		irk->addr_type = addr_type;
 
+		rcu_read_lock();
 		list_add_rcu(&irk->list, &hdev->identity_resolving_keys);
 	}
 
 	memcpy(irk->val, val, 16);
 	bacpy(&irk->rpa, rpa);
+	rcu_read_unlock();
 
 	return irk;
 }
