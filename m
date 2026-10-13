Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43EA51CF65
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 16:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791908798; cv=none; b=Amet4TMYVwf/MNDQxd9ktzeYQXcLPwGPYgO7fzP2QTmXHGFH5exzalJsqi97HG7IJOkEMc7xr0n32oV6wIoSCxnXSyZ/6DjOaYKcOa+VwFe63mrLS+w28iW1Q6agp/n2B7NgQfBUnagR5hMincn9J34o8QnHYBHT/rrDlLxgfU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791908798; c=relaxed/simple;
	bh=asdKm+yELUWfETh9fJn2xsCNIckpc0tZKijaE7PLoPc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=plL3x4n7CLzHxv3Jes5UgxStW52NDpyXOy9OGisAQElcyhcqD/oDpPSH8+4BNX6aYQancUHRWht8AB8HgaUd9B/qzQlffBlZgMy4Oy1OCMp/SlKZMeZ0uCQpp9tWV3sZ4pA0sgpDOQMvGL4y+Mcm2RkusMl/1ATJbVlNDjOIR7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K0u7xuaC; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K0u7xuaC"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8819033dbadso1938090b3a.0
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Oct 2026 09:26:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791908794; x=1792513594; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sXiiiOJbyXWBqNuOxuAXuY9kXp9RzJjbsniea4O17pQ=;
        b=K0u7xuaC/Y0YWwomfPFhT6O0/rGbLlBvimEXEsdASAJT8fZpA3VtBePbLfbrG91PlZ
         3sAbOAhc+vX3wDXyHAHLdOxm2iq3QeiPIfcAaZh0xr9jtnMm3uaywrrHDlu/+2SadhqU
         fS+82GZqWaY1fq/ry/T2+PZjyCyczNVMd8/l7wjqQQ/r4tyrCr6wYQ/mqxSvrx1W6NAN
         aZ/Ypo6maTLwDmSG5mCaOf+pLZvrLsPm4601MjI09GtGYjPybdGhrKIb6AO1M82n4PSg
         YencYKSgoi4PMR2wmvsLJIraDNv5p/kdL6MuqbDxhMV11ke/PzaIqsobNB98dygThbGl
         +neA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791908794; x=1792513594;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sXiiiOJbyXWBqNuOxuAXuY9kXp9RzJjbsniea4O17pQ=;
        b=IQIitiPCpN33b29cVGER22jGLMSJlC0Li/TqP+Q9sd/3qW3us0nPjUr4DdS1NIsc8N
         G/vIe8+UnR9fTA3WKFUjNBBibNFIOkYPs1ib3nC9BnhUfcyxMKv9Vy3yg45Zn7OM4A7u
         KLzRoLSCbuom6Uwvp2qoPVGHFsb8r1uSbzlNygJna37ttr3AQ9ywbkfAQb+BVT2YLY55
         5JTpGAcyM9wTPil7LjuLfWXF0URUtqEaFoNqCQdbgE1Py51HMufPK3X9KklJlXF4Y2yn
         CGdgPydT8Ec8v/WOPPuGRjuo+LcIIkBXTYjbWQuaMwooPuuPxzC6nHgZ0AG5dT/Qip2Q
         lmig==
X-Gm-Message-State: AFq9FYIZK1v6Ij3+tKHLZ0k4/tDERebjh1ldmeLcMzQ34w9bUuuGRBf/
	EJeknJmmiV+DrQcI6OdiVErPF0oBxkFrTVJxfDbaoavQ/DvyLNvZ8m00
X-Gm-Gg: AYBFou3kTwyTXapIafH1AOq+JKtiPrxMLvOsk9SrjC95jUJ+QaFEX8rb5wLQCjZOJDr
	eaCO3Rw5UDlQzlUgrUJ3n3e9JEISiYtbyY2VK08cH5Tu7Ho5HaxSnMUWyvkrdJUluYWYRN2Qpa7
	tM+NjfgHlwzSPW0uPWMpYtbdI9OxbdwNLClmLYlcGMYJDAkNzWlOyH8AsBI/CVDV84dfWBUYDtO
	nKdVQZVwbDodCIRhNDmkbcqlqFodQvPDT7keDI5+u5CEWPzhAvE6w5+SovwjRti12wUE57rKFoO
	Ue8DDowWuNtGK/yPx+RTAjgdEom6Z5k0Q9uT+lsvj38dnOYYmXo/20RkVgasHbY9aklWMxXeAGH
	274QC278cpwjKADkNBFpIyKsE2R330qxrBqNm1Utmrt5usWvly04ikCHRpJTNMmd6V/t7M3cgO4
	jGNQ8nRnaKQdmmiNZQX/fdTFWOOxksMAac/agq8HEwoqJNLk7KIF7dPS1BakywvZHyWgg=
X-Received: by 2002:a05:6a00:44c9:b0:891:771a:473c with SMTP id d2e1a72fcca58-897c7fbecbemr11427031b3a.53.1791908793851;
        Tue, 13 Oct 2026 09:26:33 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89d803cf66fsm99760b3a.32.2026.10.13.09.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 09:26:33 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	johan.hedberg@intel.com,
	vinicius.gomes@openbossa.org
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] Bluetooth: MGMT: Reject LTK loads while connections exist
Date: Wed, 14 Oct 2026 00:26:26 +0800
Message-Id: <pm-bluetooth-objects-candidate-0136-v7-7f507d267b3bec2ac955@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

SMP channels retain LTK pointers from the controller's long_term_keys
list until key notification or pairing teardown. load_long_term_keys()
clears that list under hdev->lock without invalidating the channels'
saved pointers. The SMP channel lock does not serialize the management
clear; kfree_rcu() does not keep a key alive for the rest of pairing.

An ongoing pairing and management LTK loads permit this ordering:

1. smp_cmd_initiator_ident() or sc_add_ltk() saves the hci_add_ltk()
   result A in smp->ltk.
2. load_long_term_keys() takes hdev->lock, and hci_smp_ltks_clear()
   unlinks A and queues its RCU free. The pairing retains its alias.
3. After the RCU grace period, A is freed. A later management load
   allocates LTK B at the same address, possibly on another controller.
4. The old pairing reaches smp_chan_destroy() and reads smp->ltk->type
   through the saved address.

If B is still live, the old pairing can read its type and remove it
through the stale alias; smp_notify_keys() can also overwrite and report
its fields. If B has already been freed, the access is a use-after-free.
The KASAN report below shows the latter ordering: the stale teardown
read follows allocation and RCU release of the replacement LTK.

Reject MGMT_OP_LOAD_LONG_TERM_KEYS with MGMT_STATUS_BUSY while LE or
BR/EDR ACL connections exist. Both transports can have SMP channels
retaining LTKs, including keys derived over BR/EDR. Check the connection
counts under hdev->lock and keep that lock through clearing and loading.
Connections are published under the same lock, and disconnect tears
down SMP before removing the connection from the hash. A successful
load therefore runs without pairing aliases, and a new connection
cannot acquire one until the replacement finishes.

KASAN report as below:

    ==================================================================
    BUG: KASAN: slab-use-after-free in smp_chan_destroy.isra.0+0xc8b/0x1060
    Read of size 1 at addr ffff88810a45eb28 by task kworker/u17:3/506

    Workqueue: hci1 hci_rx_work
    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? smp_chan_destroy.isra.0+0xc8b/0x1060
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20d/0x410
     ? smp_chan_destroy.isra.0+0xc8b/0x1060
     kasan_report+0xe0/0x110
     ? smp_chan_destroy.isra.0+0xc8b/0x1060
     smp_chan_destroy.isra.0+0xc8b/0x1060
     smp_teardown_cb+0xc7/0x230
     l2cap_chan_del+0x123/0x8f0
     l2cap_conn_del+0x31b/0x740
     ? reacquire_held_locks+0x1e7/0x1f0
     ? __pfx_l2cap_disconn_cfm+0x10/0x10
     l2cap_disconn_cfm+0x87/0xd0
     hci_disconn_complete_evt+0x30f/0x990
     ? srso_alias_return_thunk+0x5/0xfbef5
     hci_event_packet+0x894/0xc70
     ? __pfx_hci_disconn_complete_evt+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __pfx_hci_event_packet+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? free_zapped_rcu+0xd0/0x1e0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lockdep_hardirqs_on_prepare+0xea/0x1a0
     ? __pfx_hci_cmd_sync_complete+0x10/0x10
     ? trace_hardirqs_on+0x18/0x160
     ? srso_alias_return_thunk+0x5/0xfbef5
     hci_rx_work+0x367/0xf00
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

    Allocated by task 523:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_kmalloc+0xaa/0xb0
     __kmalloc_cache_noprof+0x251/0x610
     hci_add_ltk+0x285/0x4c0
     load_long_term_keys+0x74a/0x8d0
     hci_sock_sendmsg+0x128b/0x22e0
     __sys_sendto+0x425/0x470
     __x64_sys_sendto+0xe5/0x1c0
     do_syscall_64+0x115/0x6a0
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

    Freed by task 523:
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
     sysvec_apic_timer_interrupt+0x37/0x80
     asm_sysvec_apic_timer_interrupt+0x1a/0x20

    The buggy address belongs to the object at ffff88810a45eb00
     which belongs to the cache kmalloc-96 of size 96
    The buggy address is located 40 bytes inside of
     freed 96-byte region [ffff88810a45eb00, ffff88810a45eb60)

    The buggy address belongs to the physical page:
        page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0
    pfn:0x10a45e
    flags: 0x200000000000000(node=0|zone=2)
    page_type: f5(slab)
        raw: 0200000000000000 ffff888100042280 dead000000000100
    dead000000000122
        raw: 0000000000000000 0000000000200020 00000000f5000000
    0000000000000000
    page dumped because: kasan: bad access detected

    Memory state around the buggy address:
     ffff88810a45ea00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
     ffff88810a45ea80: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
    >ffff88810a45eb00: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
                                      ^
     ffff88810a45eb80: 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc
     ffff88810a45ec00: 00 00 00 00 00 00 00 00 00 00 00 fc fc fc fc fc
    ==================================================================

Fixes: 346af67b8d11 ("Bluetooth: Add MGMT handlers for dealing with SMP LTK's")
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
---
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9f65863e7457d..c3e8ca48a0337 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7460,6 +7460,16 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 
 	hci_dev_lock(hdev);
 
+	/*
+	 * SMP over LE or BR/EDR may retain pointers to the current LTKs.
+	 */
+	if (hci_conn_num(hdev, LE_LINK) || hci_conn_num(hdev, ACL_LINK)) {
+		err = mgmt_cmd_status(sk, hdev->id,
+				      MGMT_OP_LOAD_LONG_TERM_KEYS,
+				      MGMT_STATUS_BUSY);
+		goto unlock;
+	}
+
 	hci_smp_ltks_clear(hdev);
 
 	for (i = 0; i < key_count; i++) {
@@ -7513,6 +7523,7 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_LOAD_LONG_TERM_KEYS, 0,
 			   NULL, 0);
 
+unlock:
 	hci_dev_unlock(hdev);
 
 	return err;
