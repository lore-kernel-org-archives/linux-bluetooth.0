Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789FFC7EE29
	for <linux-bluetooth@archiver.kernel.org>; Thu,  8 Jun 2023 21:06:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236986AbjFHVGz (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 8 Jun 2023 17:06:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236968AbjFHVGy (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 8 Jun 2023 17:06:54 -0400
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0505930C8
        for <linux-bluetooth@vger.kernel.org>; Thu,  8 Jun 2023 14:06:50 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4QccGH65Gdzykm;
        Fri,  9 Jun 2023 00:06:47 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1686258407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AxQu0jI+AcZazHydptOdbBREFjCcYuiV/09/2+1LXbY=;
        b=L1gRwKr0VubmvoRGTbqsApDy+nXwMKoSKcS+8gbgCMtsOTGBaAOJs8Er0Ng+tSCy+NdF2L
        RStYEYKhHfH1oNi92ZhRk6epq72YANTZU+rMi0cQ6okgwarx4HaMeDzIXgb4eXNjFjHLju
        2hEnU8EZmfsWRO3uffyRs/f0nzpvLAg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1686258407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AxQu0jI+AcZazHydptOdbBREFjCcYuiV/09/2+1LXbY=;
        b=dL2jPyaut99T0Mi+yyGB0xGW8jxf1OnCRYW4NxDyxqH024MdIX3hep6zEX/gGpXy4q6Upk
        n+qk6Ir2M9J/8lw0oDH4RuscWHFIv/lji+DK71WMStxTit41s5tOtCWQ5TpBgTQ8pLzZ9Y
        IWTCbBclQZWPR6qZfo9f4KSoZ+2ib+Y=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1686258407; a=rsa-sha256; cv=none;
        b=Lpk1daYRhV6li85NFrHpFRdewmwvuP7UpdPUCeWcJ2y4OiTkRRgZ6xZPyrZQGEmz264cFE
        ch0JSxfvsa+GmKtQoERk0IVau3+TtdX9LDhayVW4PqOowG7Ls3ZZHd26RVgmUZstk+l92E
        LvcH4HSP5w0DseZDQwW5UmAdeWYklBc=
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 1/3] Bluetooth: hci_sync: iterate over hci_conn_params safely
Date:   Fri,  9 Jun 2023 00:06:42 +0300
Message-Id: <b723c232c6fd1f90e49b147180420d1856fb907d.1686252492.git.pav@iki.fi>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1686252492.git.pav@iki.fi>
References: <cover.1686252492.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

hci_update_accept_list_sync iterates over hdev->pend_le_conns and
hdev->pend_le_reports, and waits for controller events in the loop body,
without holding hdev lock.

Meanwhile, these lists and the items may be modified e.g. by
le_scan_cleanup.  This can invalidate the list cursor in the ongoing
iterations, resulting to invalid behavior (eg use-after-free).

hdev lock should be held when operating on these lists, but it cannot be
held in the loop bodies here as they block. The loops are in hci_sync,
so at most one loop runs at a time (per hdev).

Fix this by doing the iteration in a safe way vs. list mutation, and
copy data to avoid locking. Add hci_conn_params.add_pending flag to
track which items are left.

Lock also around hci_pend_le_action_lookup there.

This fixes the following, which can be triggered at least by changing
hci_le_set_cig_params to always return false, and running BlueZ
iso-tester, which causes connections to be created and dropped fast:

==================================================================
BUG: KASAN: slab-use-after-free in hci_update_passive_scan_sync (net/bluetooth/hci_sync.c:2536 net/bluetooth/hci_sync.c:2723 net/bluetooth/hci_sync.c:2841)
Read of size 8 at addr ffff888001265018 by task kworker/u3:0/32

Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
Workqueue: hci0 hci_cmd_sync_work
Call Trace:
<TASK>
dump_stack_lvl (./arch/x86/include/asm/irqflags.h:134 lib/dump_stack.c:107)
print_report (mm/kasan/report.c:320 mm/kasan/report.c:430)
? __virt_addr_valid (./include/linux/mmzone.h:1915 ./include/linux/mmzone.h:2011 arch/x86/mm/physaddr.c:65)
? hci_update_passive_scan_sync (net/bluetooth/hci_sync.c:2536 net/bluetooth/hci_sync.c:2723 net/bluetooth/hci_sync.c:2841)
kasan_report (mm/kasan/report.c:538)
? hci_update_passive_scan_sync (net/bluetooth/hci_sync.c:2536 net/bluetooth/hci_sync.c:2723 net/bluetooth/hci_sync.c:2841)
hci_update_passive_scan_sync (net/bluetooth/hci_sync.c:2536 net/bluetooth/hci_sync.c:2723 net/bluetooth/hci_sync.c:2841)
? __pfx_hci_update_passive_scan_sync (net/bluetooth/hci_sync.c:2780)
? mutex_lock (kernel/locking/mutex.c:282)
? __pfx_mutex_lock (kernel/locking/mutex.c:282)
? __pfx_mutex_unlock (kernel/locking/mutex.c:538)
? __pfx_update_passive_scan_sync (net/bluetooth/hci_sync.c:2861)
hci_cmd_sync_work (net/bluetooth/hci_sync.c:306)
process_one_work (./arch/x86/include/asm/preempt.h:27 kernel/workqueue.c:2399)
worker_thread (./include/linux/list.h:292 kernel/workqueue.c:2538)
? __pfx_worker_thread (kernel/workqueue.c:2480)
kthread (kernel/kthread.c:376)
? __pfx_kthread (kernel/kthread.c:331)
ret_from_fork (arch/x86/entry/entry_64.S:314)
</TASK>

Allocated by task 31:
kasan_save_stack (mm/kasan/common.c:46)
kasan_set_track (mm/kasan/common.c:52)
__kasan_kmalloc (mm/kasan/common.c:374 mm/kasan/common.c:383)
hci_conn_params_add (./include/linux/slab.h:580 ./include/linux/slab.h:720 net/bluetooth/hci_core.c:2277)
hci_connect_le_scan (net/bluetooth/hci_conn.c:1419 net/bluetooth/hci_conn.c:1589)
hci_connect_cis (net/bluetooth/hci_conn.c:2266)
iso_connect_cis (net/bluetooth/iso.c:390)
iso_sock_connect (net/bluetooth/iso.c:899)
__sys_connect (net/socket.c:2003 net/socket.c:2020)
__x64_sys_connect (net/socket.c:2027)
do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/entry/common.c:80)
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:120)

Freed by task 15:
kasan_save_stack (mm/kasan/common.c:46)
kasan_set_track (mm/kasan/common.c:52)
kasan_save_free_info (mm/kasan/generic.c:523)
__kasan_slab_free (mm/kasan/common.c:238 mm/kasan/common.c:200 mm/kasan/common.c:244)
__kmem_cache_free (mm/slub.c:1807 mm/slub.c:3787 mm/slub.c:3800)
hci_conn_params_del (net/bluetooth/hci_core.c:2323)
le_scan_cleanup (net/bluetooth/hci_conn.c:202)
process_one_work (./arch/x86/include/asm/preempt.h:27 kernel/workqueue.c:2399)
worker_thread (./include/linux/list.h:292 kernel/workqueue.c:2538)
kthread (kernel/kthread.c:376)
ret_from_fork (arch/x86/entry/entry_64.S:314)
==================================================================

Fixes: e8907f76544f ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 3")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    It might be that even more of hci_passive_scan_sync and the routines it
    calls should hold hdev->lock, but don't know that right now.

 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_sync.c         | 81 ++++++++++++++++++++++++++++----
 2 files changed, 74 insertions(+), 8 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 683666ea210c..e79b3831fcf3 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -822,6 +822,7 @@ struct hci_conn_params {
 
 	struct hci_conn *conn;
 	bool explicit_connect;
+	bool add_pending;
 	hci_conn_flags_t flags;
 	u8  privacy_mode;
 };
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 97da5bcaa904..e6fde15dc9ca 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2160,15 +2160,23 @@ static int hci_le_del_accept_list_sync(struct hci_dev *hdev,
 	return 0;
 }
 
+struct conn_params {
+	bdaddr_t addr;
+	u8 addr_type;
+	hci_conn_flags_t flags;
+	u8 privacy_mode;
+};
+
 /* Adds connection to resolve list if needed.
  * Setting params to NULL programs local hdev->irk
  */
 static int hci_le_add_resolve_list_sync(struct hci_dev *hdev,
-					struct hci_conn_params *params)
+					struct conn_params *params)
 {
 	struct hci_cp_le_add_to_resolv_list cp;
 	struct smp_irk *irk;
 	struct bdaddr_list_with_irk *entry;
+	struct hci_conn_params *hparams;
 
 	if (!use_ll_privacy(hdev))
 		return 0;
@@ -2203,6 +2211,13 @@ static int hci_le_add_resolve_list_sync(struct hci_dev *hdev,
 	/* Default privacy mode is always Network */
 	params->privacy_mode = HCI_NETWORK_PRIVACY;
 
+	hci_dev_lock(hdev);
+	hparams = hci_conn_params_lookup(hdev, &params->addr,
+					 params->addr_type);
+	if (hparams)
+		hparams->privacy_mode = HCI_NETWORK_PRIVACY;
+	hci_dev_unlock(hdev);
+
 done:
 	if (hci_dev_test_flag(hdev, HCI_PRIVACY))
 		memcpy(cp.local_irk, hdev->irk, 16);
@@ -2215,7 +2230,7 @@ static int hci_le_add_resolve_list_sync(struct hci_dev *hdev,
 
 /* Set Device Privacy Mode. */
 static int hci_le_set_privacy_mode_sync(struct hci_dev *hdev,
-					struct hci_conn_params *params)
+					struct conn_params *params)
 {
 	struct hci_cp_le_set_privacy_mode cp;
 	struct smp_irk *irk;
@@ -2249,7 +2264,7 @@ static int hci_le_set_privacy_mode_sync(struct hci_dev *hdev,
  * properly set the privacy mode.
  */
 static int hci_le_add_accept_list_sync(struct hci_dev *hdev,
-				       struct hci_conn_params *params,
+				       struct conn_params *params,
 				       u8 *num_entries)
 {
 	struct hci_cp_le_add_to_accept_list cp;
@@ -2447,6 +2462,37 @@ struct sk_buff *hci_read_local_oob_data_sync(struct hci_dev *hdev,
 	return __hci_cmd_sync_sk(hdev, opcode, 0, NULL, 0, HCI_CMD_TIMEOUT, sk);
 }
 
+static void conn_params_iter_init(struct list_head *list)
+{
+	struct hci_conn_params *params;
+
+	list_for_each_entry(params, list, action)
+		params->add_pending = true;
+}
+
+static bool conn_params_iter_next(struct list_head *list,
+				  struct conn_params *item)
+{
+	struct hci_conn_params *params;
+
+	/* Must hold hdev lock. Not reentrant. Mutating list is allowed. */
+
+	list_for_each_entry(params, list, action) {
+		if (!params->add_pending)
+			continue;
+
+		memcpy(&item->addr, &params->addr, sizeof(params->addr));
+		item->addr_type = params->addr_type;
+		item->privacy_mode = params->privacy_mode;
+		item->flags = params->flags;
+
+		params->add_pending = false;
+		return true;
+	}
+
+	return false;
+}
+
 /* Device must not be scanning when updating the accept list.
  *
  * Update is done using the following sequence:
@@ -2466,7 +2512,7 @@ struct sk_buff *hci_read_local_oob_data_sync(struct hci_dev *hdev,
  */
 static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 {
-	struct hci_conn_params *params;
+	struct conn_params params;
 	struct bdaddr_list *b, *t;
 	u8 num_entries = 0;
 	bool pend_conn, pend_report;
@@ -2494,6 +2540,8 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 		goto done;
 	}
 
+	hci_dev_lock(hdev);
+
 	/* Go through the current accept list programmed into the
 	 * controller one by one and check if that address is connected or is
 	 * still in the list of pending connections or list of devices to
@@ -2515,8 +2563,10 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 		 * remove it from the acceptlist.
 		 */
 		if (!pend_conn && !pend_report) {
+			hci_dev_unlock(hdev);
 			hci_le_del_accept_list_sync(hdev, &b->bdaddr,
 						    b->bdaddr_type);
+			hci_dev_lock(hdev);
 			continue;
 		}
 
@@ -2532,23 +2582,38 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 	 * available accept list entries in the controller, then
 	 * just abort and return filer policy value to not use the
 	 * accept list.
+	 *
+	 * The list may be mutated at any time outside hdev lock,
+	 * so use special iteration with copies.
 	 */
-	list_for_each_entry(params, &hdev->pend_le_conns, action) {
-		err = hci_le_add_accept_list_sync(hdev, params, &num_entries);
+
+	conn_params_iter_init(&hdev->pend_le_conns);
+
+	while (conn_params_iter_next(&hdev->pend_le_conns, &params)) {
+		hci_dev_unlock(hdev);
+		err = hci_le_add_accept_list_sync(hdev, &params, &num_entries);
 		if (err)
 			goto done;
+		hci_dev_lock(hdev);
 	}
 
 	/* After adding all new pending connections, walk through
 	 * the list of pending reports and also add these to the
 	 * accept list if there is still space. Abort if space runs out.
 	 */
-	list_for_each_entry(params, &hdev->pend_le_reports, action) {
-		err = hci_le_add_accept_list_sync(hdev, params, &num_entries);
+
+	conn_params_iter_init(&hdev->pend_le_reports);
+
+	while (conn_params_iter_next(&hdev->pend_le_reports, &params)) {
+		hci_dev_unlock(hdev);
+		err = hci_le_add_accept_list_sync(hdev, &params, &num_entries);
 		if (err)
 			goto done;
+		hci_dev_lock(hdev);
 	}
 
+	hci_dev_unlock(hdev);
+
 	/* Use the allowlist unless the following conditions are all true:
 	 * - We are not currently suspending
 	 * - There are 1 or more ADV monitors registered and it's not offloaded
-- 
2.40.1

