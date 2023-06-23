Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D553C001B0
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jun 2023 17:19:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjFWRTR (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jun 2023 13:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232653AbjFWRS6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jun 2023 13:18:58 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0751E2705
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jun 2023 10:18:50 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4QnkVJ5gVqz49Q8L;
        Fri, 23 Jun 2023 20:18:48 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1687540728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w6pae5Alcoqq3vgYCiVKxWEBBEjBOhyN/nu/Ek04sVE=;
        b=CItbxaXbpDGihECOC2azjAkAcsVDzOWDw4n5Xjk6/PTHcimfKUH2K8Tf/+ZKbpv+IxGzWP
        UwXInAsRcT1uAT9sHXz/mkgKb+mdsBrzJ5y4LrvpkLwo7vnqw657UELzd7oYS+bk7hcd7J
        ttWTwY6naS7COoiGKm2DqbMZahtXlAaxNnbY2KAFmJPfH5HwyNLkOsGJ2KXXgGKNwtlhGm
        Dtkaj0bmagxKYdQhYt8EoNxqJmgjo8yL6BhMWl+vRkubr1EOacMXKw4xKG7qTvAIZ24H8S
        zzwl1l4RBtPf85BqQ71uXba5QQFJHpaqL9h+ZGquFbV2u0u9A2zKhK/sOManSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1687540728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w6pae5Alcoqq3vgYCiVKxWEBBEjBOhyN/nu/Ek04sVE=;
        b=QYfdSWNRbtT170DdAS/OsGOkOW2x4CnPo10Y7LUOwHZHjUQxDy8PlNkZCZgBlsfJuX4aMY
        CPOYO9Tdbuta8msj57rW6lnzNEGPOi64LpVNIV+P5MXo6pUkZbQOVI62SU03EpbfcTXo+6
        uMleiIrgZvGWv/e16cGqeXOy/+Nf+Gfl4BhTRfXQdWp7TMRw8YqOW1C6rPpmTWRvljzuUr
        inqCCa93pQ/WPUKZj6S/yiJ/sMp7oFDOzjjQXeAZyEhi8aSsU65RiP14YmXN1+5qCX7rsw
        I9TgkF636xydEpT0ZWhkkSxRaiPZ42BGKc2GBZ/JIXMlFYVEv+NdSu9aYkgxeg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1687540728; a=rsa-sha256;
        cv=none;
        b=BQU7zlPK4s8O/rQybd42AEj6b6edcRHfwfKM7Lwyg4xlYpEtEOXu4zTLZ2eGiR0G0Wb36o
        JL7mT7HjHsjMU6cekqIxNnEvMW2lOZQlKRpnyX5da6cJoesklRyHFGs2OkLTqJyacuFdlp
        f7aX12mNuAzl/R+keoodBeIRGpnIxOmxqhIBNsVUuO3tGbH43JzXmz/H2U7FTfEUT1GhvW
        HZUlF06cr5tKWSJIQH4L3+/dnmotgZckP0EPg8FV9CQN32XGTCy1faPoZe0OEXw2GUNcP3
        cgiGOr9v2brH2Dr5VqkoLpNnXK9sXPhf1PMtt0cjRQCfk1oyvxty04a7G5YzDQ==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH RFC 2/5] Bluetooth: hci_sync: iterate conn_hash safely in hci_disconnect_all_sync
Date:   Fri, 23 Jun 2023 20:18:39 +0300
Message-ID: <fd82a6b36542662a41c467cf3fece6e71d30998c.1687525956.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1687525956.git.pav@iki.fi>
References: <cover.1687525956.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Any element can be removed from conn_hash when no rcu or hdev->lock,
so list_for_each_entry_safe alone is not safe here.

Add conn_hash iteration that uses RCU and takes hci_conn_get to keep
cursors alive, to allow unlocked loop body safely.  Since any item may
then be deleted from conn_hash while locks are released, in rare cases
(next item from cursor deleted) the iteration needs to be restarted.

To process each item only once even if restarted, set HCI_CONN_CANCEL in
hci_abort_conn_sync, similarly to what hci_abort_conn does.

Log trace:
==================================================================
BUG: KASAN: slab-use-after-free in hci_set_powered_sync (net/bluetooth/hci_sync.c:5345 net/bluetooth/hci_sync.c:5385 net/bluetooth/hci_sync.c:5397) bluetooth
Read of size 8 at addr ffff88800a4d9000 by task kworker/u5:2/966

Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
Workqueue: hci0 hci_cmd_sync_work [bluetooth]
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:108)
print_report (mm/kasan/report.c:352 mm/kasan/report.c:462)
? __virt_addr_valid (./include/linux/mmzone.h:1901 ./include/linux/mmzone.h:1997 arch/x86/mm/physaddr.c:65)
? hci_set_powered_sync (net/bluetooth/hci_sync.c:5345 net/bluetooth/hci_sync.c:5385 net/bluetooth/hci_sync.c:5397) bluetooth
kasan_report (mm/kasan/report.c:574)
? hci_set_powered_sync (net/bluetooth/hci_sync.c:5345 net/bluetooth/hci_sync.c:5385 net/bluetooth/hci_sync.c:5397) bluetooth
hci_set_powered_sync (net/bluetooth/hci_sync.c:5345 net/bluetooth/hci_sync.c:5385 net/bluetooth/hci_sync.c:5397) bluetooth
? __pfx_hci_set_powered_sync (net/bluetooth/hci_sync.c:5393) bluetooth
? set_powered_sync (net/bluetooth/mgmt.c:1369) bluetooth
? __pfx_set_powered_sync (net/bluetooth/mgmt.c:1367) bluetooth
hci_cmd_sync_work (net/bluetooth/hci_sync.c:306) bluetooth
process_one_work (kernel/workqueue.c:2410)
? __pfx_process_one_work (kernel/workqueue.c:2300)
? __pfx_do_raw_spin_lock (kernel/locking/spinlock_debug.c:113)
? mark_held_locks (kernel/locking/lockdep.c:4240)
worker_thread (./include/linux/list.h:292 kernel/workqueue.c:2553)
? __pfx_worker_thread (kernel/workqueue.c:2495)
kthread (kernel/kthread.c:379)
? __pfx_kthread (kernel/kthread.c:332)
ret_from_fork (arch/x86/entry/entry_64.S:314)
</TASK>

Allocated by task 2366:
kasan_save_stack (mm/kasan/common.c:46)
kasan_set_track (mm/kasan/common.c:52)
__kasan_kmalloc (mm/kasan/common.c:374 mm/kasan/common.c:383)
hci_conn_add (./include/linux/slab.h:559 ./include/linux/slab.h:680 net/bluetooth/hci_conn.c:1002) bluetooth
hci_bind_cis (net/bluetooth/hci_conn.c:1908) bluetooth
iso_connect_cis (net/bluetooth/iso.c:383) bluetooth
iso_sock_connect (net/bluetooth/iso.c:890) bluetooth
__sys_connect (./include/linux/file.h:44 net/socket.c:2021)
__x64_sys_connect (net/socket.c:2027)
do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)

Freed by task 2366:
kasan_save_stack (mm/kasan/common.c:46)
kasan_set_track (mm/kasan/common.c:52)
kasan_save_free_info (mm/kasan/generic.c:523)
__kasan_slab_free (mm/kasan/common.c:238 mm/kasan/common.c:200 mm/kasan/common.c:244)
__kmem_cache_free (mm/slub.c:1807 mm/slub.c:3786 mm/slub.c:3799)
device_release (drivers/base/core.c:2489)
kobject_put (lib/kobject.c:683 lib/kobject.c:714 ./include/linux/kref.h:65 lib/kobject.c:731)
__iso_sock_close (net/bluetooth/iso.c:665) bluetooth
iso_sock_release (net/bluetooth/iso.c:686 net/bluetooth/iso.c:1473) bluetooth
__sock_release (net/socket.c:654)
sock_close (net/socket.c:1399)
__fput (fs/file_table.c:322)
task_work_run (kernel/task_work.c:180)
exit_to_user_mode_prepare (./include/linux/resume_user_mode.h:49 kernel/entry/common.c:171 kernel/entry/common.c:204)
syscall_exit_to_user_mode (kernel/entry/common.c:130 kernel/entry/common.c:299)
do_syscall_64 (arch/x86/entry/common.c:87)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)
==================================================================

Fixes: 182ee45da083 ("Bluetooth: hci_sync: Rework hci_suspend_notifier")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_sync.c | 140 +++++++++++++++++++++++++++++++++++----
 1 file changed, 127 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index afb8e970e62c..46a156b44a8b 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5276,9 +5276,6 @@ static int hci_le_connect_cancel_sync(struct hci_dev *hdev,
 	if (test_bit(HCI_CONN_SCANNING, &conn->flags))
 		return 0;
 
-	if (test_and_set_bit(HCI_CONN_CANCEL, &conn->flags))
-		return 0;
-
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_CREATE_CONN_CANCEL,
 				     0, NULL, HCI_CMD_TIMEOUT);
 }
@@ -5334,6 +5331,14 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 {
 	int err;
 
+	/* No hdev->lock: but only accessing dst/type (immutable) and
+	 * state/flags here, in worst case we just send some unnecessary
+	 * HCI commands.
+	 */
+
+	if (test_and_set_bit(HCI_CONN_CANCEL, &conn->flags))
+		return 0;
+
 	switch (conn->state) {
 	case BT_CONNECTED:
 	case BT_CONFIG:
@@ -5342,10 +5347,12 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 		err = hci_connect_cancel_sync(hdev, conn);
 		/* Cleanup hci_conn object if it cannot be cancelled as it
 		 * likelly means the controller and host stack are out of sync.
+		 * Watch out for deleted conn in calling conn_failed.
 		 */
 		if (err) {
 			hci_dev_lock(hdev);
-			hci_conn_failed(conn, err);
+			if (hci_conn_is_alive(hdev, conn))
+				hci_conn_failed(conn, err);
 			hci_dev_unlock(hdev);
 		}
 		return err;
@@ -5359,20 +5366,125 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 	return 0;
 }
 
-static int hci_disconnect_all_sync(struct hci_dev *hdev, u8 reason)
+typedef bool (*hci_conn_iter_func_t)(struct hci_dev *hdev,
+				     struct hci_conn *conn,
+				     void *data);
+
+/* Iterate connections with unlocked loop body, allowing concurrent mutation,
+ * holding references to the cursors. If both the cursor and the next item are
+ * deleted while unlocked, this fails with -EBUSY, or optionally retries
+ * iteration from start. Note that hci_conn_cleanup may be running concurrently
+ * or have already completed for the conn, which you need to deal with.
+ */
+static int hci_conn_hash_list_unlocked(struct hci_dev *hdev,
+				       bool retry,
+				       hci_conn_iter_func_t func,
+				       void *data)
 {
-	struct hci_conn *conn, *tmp;
-	int err;
+	struct list_head *head = &hdev->conn_hash.list;
+	struct hci_conn *pos, *prev, *prev_next;
 
-	list_for_each_entry_safe(conn, tmp, &hdev->conn_hash.list, list) {
-		err = hci_abort_conn_sync(hdev, conn, reason);
-		if (err)
-			return err;
+	if (!func)
+		return 0;
+
+again:
+	rcu_read_lock();
+
+	prev = NULL;
+	prev_next = NULL;
+
+	pos = list_first_or_null_rcu(head, struct hci_conn, list);
+	if (pos)
+		hci_conn_get(pos);
+
+	while (pos) {
+		struct list_head *ptr = &pos->list;
+		struct hci_conn *next;
+
+		next = list_next_or_null_rcu(head, ptr, struct hci_conn, list);
+		if (next)
+			hci_conn_get(next);
+
+		rcu_read_unlock();
+
+		/* Can't unref in RCU, so do it here */
+		if (prev) {
+			hci_conn_put(prev);
+			prev = NULL;
+		}
+
+		if (prev_next) {
+			hci_conn_put(prev_next);
+			prev_next = NULL;
+		}
+
+		if (func(hdev, pos, data)) {
+			hci_conn_put(pos);
+			if (next)
+				hci_conn_put(next);
+
+			return 0;
+		}
+
+		rcu_read_lock();
+
+		if (next && !hci_conn_is_alive(hdev, next)) {
+			if (!hci_conn_is_alive(hdev, pos)) {
+				/* Both cursors deleted */
+				rcu_read_unlock();
+				hci_conn_put(pos);
+				hci_conn_put(next);
+
+				if (retry)
+					goto again;
+
+				return -EBUSY;
+			}
+
+			/* Use the other cursor */
+			prev_next = next;
+			next = list_next_or_null_rcu(head, ptr,
+						     struct hci_conn, list);
+			if (next)
+				hci_conn_get(next);
+		}
+
+		prev = pos;
+		pos = next;
 	}
 
+	rcu_read_unlock();
+
+	if (prev)
+		hci_conn_put(prev);
+	if (prev_next)
+		hci_conn_put(prev_next);
+
 	return 0;
 }
 
+struct disconnect_all_info {
+	u8 reason;
+	int err;
+};
+
+static bool disconnect_all_sync(struct hci_dev *hdev, struct hci_conn *conn,
+				void *data)
+{
+	struct disconnect_all_info *info = data;
+
+	info->err = hci_abort_conn_sync(hdev, conn, info->reason);
+	return info->err;
+}
+
+static int hci_disconnect_all_sync(struct hci_dev *hdev, u8 reason)
+{
+	struct disconnect_all_info info = {reason, 0};
+
+	hci_conn_hash_list_unlocked(hdev, true, disconnect_all_sync, &info);
+	return info.err;
+}
+
 /* This function perform power off HCI command sequence as follows:
  *
  * Clear Advertising
@@ -6254,8 +6366,10 @@ int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
 				       conn->conn_timeout, NULL);
 
 done:
-	if (err == -ETIMEDOUT)
-		hci_le_connect_cancel_sync(hdev, conn);
+	if (err == -ETIMEDOUT) {
+		if (!test_and_set_bit(HCI_CONN_CANCEL, &conn->flags))
+			hci_le_connect_cancel_sync(hdev, conn);
+	}
 
 	/* Re-enable advertising after the connection attempt is finished. */
 	hci_resume_advertising_sync(hdev);
-- 
2.41.0

