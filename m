Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC32C001B0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 11 Aug 2023 23:16:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjHKXQQ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 11 Aug 2023 19:16:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjHKXQP (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 11 Aug 2023 19:16:15 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A72F100
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Aug 2023 16:16:14 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-1bbafe6fd8fso2141604fac.3
        for <linux-bluetooth@vger.kernel.org>; Fri, 11 Aug 2023 16:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691795773; x=1692400573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=txaNYPFjoKE5LMPZMX//vYXsFHC4qgE/scux8+LFxzM=;
        b=O3NPduVdN9W0rf7XeU+hM8B6cZq++DMHPoqRtyeyHqsAqdm2n7pSEyYoV0Q6LK14gr
         NWJd7h8qz/DyKAgVwezxExIIP+W8DBSf7iXTE/750yVHTWtZAcqtxq438ta++YHQYHD7
         1yAm4B293Mo3mQ77KKWKhCNigCJa6HB/TAulpzhzV4UFY+eUXM9e9lMTFcg4YaSgUUbb
         CrLWjubcYFPBPAl5g8+YWf4RacTC5zMVW0B82EmCZdDJrYnrGWK7+V13PihBVHrA2V2c
         qlxEK9CISzfQb9H2yOSkbhiagCxv9n2S6SEkQGZj6EwcyQvU630kyeLR+9SmfHRDur6p
         Sa9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691795773; x=1692400573;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=txaNYPFjoKE5LMPZMX//vYXsFHC4qgE/scux8+LFxzM=;
        b=ASBKOAgPj59VNtJL2/SWVTGhPVztfehGOLGCD7REfvry5ztesbAWJe842LzppNpDp9
         IscK+gkyHzokyPnI3Wm6JpIo1Bv86Rs3DBfOMwmZSLKN1Dl+8fmX/8qirswHaTjO+Yne
         8uDw0SukRoSThuTAPX60VVZRiRcu22MHXDeAQXhyk52mf+bwZV0CeXa9hIv8GqXN7FES
         +pd5UcEoS9YSf0L6DBBClvpq0FkQYOZ8WrrSQPHO4LeSjtWET6c+aXCDtAV/RpkvziE/
         AU6V4Hxrmb7pGwauFgFj8KvbMMxtb5YDAKYbw59Lqd9FvYM1RwJkruU5zoOjR0fZD4Fz
         RhtQ==
X-Gm-Message-State: AOJu0YzsaijLcbHy7QHY3rOcS7xjwhU8pYsJLjS56SYuDd6N5x/+GrkZ
        1ZdaKGo5xAIA4hgsHu/3aJUpzuwtwX0=
X-Google-Smtp-Source: AGHT+IFZtM3rawPc3QE2aD1OeyAIfYH6mmWmJEEKzFqrDL4kJ3iqzrV25Fcb81OMhZTJ68Cdnf70nw==
X-Received: by 2002:a05:6870:8301:b0:1be:f46d:a26c with SMTP id p1-20020a056870830100b001bef46da26cmr3710058oae.27.1691795773013;
        Fri, 11 Aug 2023 16:16:13 -0700 (PDT)
Received: from lvondent-mobl4.. (c-98-232-221-87.hsd1.or.comcast.net. [98.232.221.87])
        by smtp.gmail.com with ESMTPSA id 8-20020a17090a198800b00262fc3d911esm6118791pji.28.2023.08.11.16.16.11
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 16:16:11 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: hci_sync: Fix UAF in hci_disconnect_all_sync
Date:   Fri, 11 Aug 2023 16:16:10 -0700
Message-ID: <20230811231610.2025814-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Use-after-free can occur in hci_disconnect_all_sync if a connection is
deleted by concurrent processing of a controller event.

To prevent this the code now tries to iterate over the list backwards
to ensure the links are cleanup before its parents, also it no longer
relies on a cursor, instead it always uses the last element since
hci_abort_conn_sync is guaranteed to call hci_conn_del.

UAF crash log:
==================================================================
BUG: KASAN: slab-use-after-free in hci_set_powered_sync
(net/bluetooth/hci_sync.c:5424) [bluetooth]
Read of size 8 at addr ffff888009d9c000 by task kworker/u9:0/124

CPU: 0 PID: 124 Comm: kworker/u9:0 Tainted: G        W
6.5.0-rc1+ #10
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
1.16.2-1.fc38 04/01/2014
Workqueue: hci0 hci_cmd_sync_work [bluetooth]
Call Trace:
 <TASK>
 dump_stack_lvl+0x5b/0x90
 print_report+0xcf/0x670
 ? __virt_addr_valid+0xdd/0x160
 ? hci_set_powered_sync+0x2c9/0x4a0 [bluetooth]
 kasan_report+0xa6/0xe0
 ? hci_set_powered_sync+0x2c9/0x4a0 [bluetooth]
 ? __pfx_set_powered_sync+0x10/0x10 [bluetooth]
 hci_set_powered_sync+0x2c9/0x4a0 [bluetooth]
 ? __pfx_hci_set_powered_sync+0x10/0x10 [bluetooth]
 ? __pfx_lock_release+0x10/0x10
 ? __pfx_set_powered_sync+0x10/0x10 [bluetooth]
 hci_cmd_sync_work+0x137/0x220 [bluetooth]
 process_one_work+0x526/0x9d0
 ? __pfx_process_one_work+0x10/0x10
 ? __pfx_do_raw_spin_lock+0x10/0x10
 ? mark_held_locks+0x1a/0x90
 worker_thread+0x92/0x630
 ? __pfx_worker_thread+0x10/0x10
 kthread+0x196/0x1e0
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x2c/0x50
 </TASK>

Allocated by task 1782:
 kasan_save_stack+0x33/0x60
 kasan_set_track+0x25/0x30
 __kasan_kmalloc+0x8f/0xa0
 hci_conn_add+0xa5/0xa80 [bluetooth]
 hci_bind_cis+0x881/0x9b0 [bluetooth]
 iso_connect_cis+0x121/0x520 [bluetooth]
 iso_sock_connect+0x3f6/0x790 [bluetooth]
 __sys_connect+0x109/0x130
 __x64_sys_connect+0x40/0x50
 do_syscall_64+0x60/0x90
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8

Freed by task 695:
 kasan_save_stack+0x33/0x60
 kasan_set_track+0x25/0x30
 kasan_save_free_info+0x2b/0x50
 __kasan_slab_free+0x10a/0x180
 __kmem_cache_free+0x14d/0x2e0
 device_release+0x5d/0xf0
 kobject_put+0xdf/0x270
 hci_disconn_complete_evt+0x274/0x3a0 [bluetooth]
 hci_event_packet+0x579/0x7e0 [bluetooth]
 hci_rx_work+0x287/0xaa0 [bluetooth]
 process_one_work+0x526/0x9d0
 worker_thread+0x92/0x630
 kthread+0x196/0x1e0
 ret_from_fork+0x2c/0x50
==================================================================

Fixes: 182ee45da083 ("Bluetooth: hci_sync: Rework hci_suspend_notifier")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_sync.c | 51 ++++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 5eb30ba21370..86e18e09136e 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5370,6 +5370,7 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 {
 	int err = 0;
 	u16 handle = conn->handle;
+	struct hci_conn *c;
 
 	switch (conn->state) {
 	case BT_CONNECTED:
@@ -5389,43 +5390,53 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 		hci_dev_unlock(hdev);
 		return 0;
 	default:
+		hci_dev_lock(hdev);
 		conn->state = BT_CLOSED;
+		hci_disconn_cfm(conn, reason);
+		hci_conn_del(conn);
+		hci_dev_unlock(hdev);
 		return 0;
 	}
 
+	/* Check if the connection hasn't been cleanup while waiting
+	 * commands to complete.
+	 */
+	c = hci_conn_hash_lookup_handle(hdev, handle);
+	if (!c || c != conn)
+		return 0;
+
 	/* Cleanup hci_conn object if it cannot be cancelled as it
 	 * likelly means the controller and host stack are out of sync
 	 * or in case of LE it was still scanning so it can be cleanup
 	 * safely.
 	 */
-	if (err) {
-		struct hci_conn *c;
-
-		/* Check if the connection hasn't been cleanup while waiting
-		 * commands to complete.
-		 */
-		c = hci_conn_hash_lookup_handle(hdev, handle);
-		if (!c || c != conn)
-			return 0;
-
-		hci_dev_lock(hdev);
-		hci_conn_failed(conn, err);
-		hci_dev_unlock(hdev);
-	}
+	hci_dev_lock(hdev);
+	hci_conn_failed(conn, reason);
+	hci_dev_unlock(hdev);
 
 	return err;
 }
 
 static int hci_disconnect_all_sync(struct hci_dev *hdev, u8 reason)
 {
-	struct hci_conn *conn, *tmp;
-	int err;
+	struct list_head *head = &hdev->conn_hash.list;
+	struct hci_conn *conn;
 
-	list_for_each_entry_safe(conn, tmp, &hdev->conn_hash.list, list) {
-		err = hci_abort_conn_sync(hdev, conn, reason);
-		if (err)
-			return err;
+	rcu_read_lock();
+	while ((conn = list_first_or_null_rcu(head, struct hci_conn, list))) {
+		/* Make sure the connection is not freed while unlocking */
+		conn = hci_conn_get(conn);
+		rcu_read_unlock();
+		/* Disregard possible errors since hci_conn_del shall have been
+		 * called even in case of errors had occurred since it would
+		 * then cause hci_conn_failed to be called which calls
+		 * hci_conn_del internally.
+		 */
+		hci_abort_conn_sync(hdev, conn, reason);
+		hci_conn_put(conn);
+		rcu_read_lock();
 	}
+	rcu_read_unlock();
 
 	return 0;
 }
-- 
2.41.0

