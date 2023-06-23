Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C34EEB64D7
	for <linux-bluetooth@archiver.kernel.org>; Fri, 23 Jun 2023 17:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232507AbjFWRTS (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 23 Jun 2023 13:19:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbjFWRS6 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 23 Jun 2023 13:18:58 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AD592720
        for <linux-bluetooth@vger.kernel.org>; Fri, 23 Jun 2023 10:18:51 -0700 (PDT)
Received: from monolith.lan (91-152-120-101.elisa-laajakaista.fi [91.152.120.101])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4QnkVJ6C0Yz49Q8P;
        Fri, 23 Jun 2023 20:18:48 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1687540728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u8MhKiL0OH61fimV2NI4j0tPLHX8It4pkIfD4H/+7Ek=;
        b=ZwY8kp85r7SGMN+cpziRPacH927YP9A/hyjtmB4XfpyTTj14uOy1YYbj9Q9x9h7ie1Or1n
        zlsYyz15GtngCEWhGjKKhl41tcHpOx5VjRDHr+h3K3QxfUUtNPHYNBReedPpzq+N9CMmX7
        V+VaplCq5bYe2+I9cSZErt5lEx2FOfjTmAtSQ4wdkA304VQam5V6gHdcluF9TrR88zQ9Uc
        PQEOnua+DIAvnAEaQHPUBUab1bsWyc3e2FPcW31rqO7GZNybUUy8uE++Pau9y2kOPJJvR7
        389MSy3K2R8VGxB7BNWhHVNXy8CSiyBY1JPAQcJV1mY64iSB+ig1V+vRMg9AKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1687540728;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u8MhKiL0OH61fimV2NI4j0tPLHX8It4pkIfD4H/+7Ek=;
        b=BTPUwO4rL54hapt601+FJMR5z2ArNYxjLgpH/ArkkaI8v3iYiRbMpyKoN0Fa1fO30z/IcP
        yTmSR6nwhtUxvGCFa9A+Cg8Tu83MOqGmE3xwhkJKlP5S32uAr9em05ggInwDARL6ygtSTv
        0W24kEa/WpSMyX/otKcNi2jeiY+8Z8Ki6GbPsq1XleCGVYP4YGuJ/BU403ABi7xKjJWjkg
        BLseCsYpSA6DmrL3b2g1i+8BfFNfYsWU5wu++9rLWNw+GSd9MBSihcOqpL+8V/8zwpJvlq
        26TwWuXA1PFtoRq/cEKyj0HmvFprsuDZhbPvRiKSZs2wufinBguN4Jz70OSCFQ==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1687540728; a=rsa-sha256;
        cv=none;
        b=Fpqm1Re8jgT8eJmrqEGQeFSJQ4nsS/UBTWSlO5pAJUxO5XA8WSBLQdRhPJmaOasMeu1jBC
        a3NMUqvlSCVLAYI50RDCOfFAvT7rQ/I3npDXlt+PlJGibG+XCyxbXN+iXi6w7afRCgIByi
        ySSGForLxpZl4f+rSGHdwTVQZU75DgrubqMPeXrwdcxCTDO8JZYs13MFNCVFISMeivnFCm
        cf3fIi2VgoT9DMeWWRsl0b8IO3boCKY0pTh8ycn3vOR8O04hgg9fyizAyRiCwwf8dUNCHS
        IQpNdGzErBFbWgpDno7uSp3ij9n2aXVHvtNjPeH51c5BViZpyut/UCdAr1L/MA==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH RFC 3/5] Bluetooth: hci_conn: hold ref while hci_connect_le_sync is pending
Date:   Fri, 23 Jun 2023 20:18:40 +0300
Message-ID: <42201414f52949665770da6229c9946c0d0dd5d8.1687525956.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1687525956.git.pav@iki.fi>
References: <cover.1687525956.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In hci_connect_le_sync, the hci_conn may be deleted before the
hci_sync event runs.

Hold a reference to the conn while the hci_sync command is queued, so we
at least avoid the use-after-free.

Add some checks to catch a race while the hci_sync command is queued,
but this is still not quite right because the conn may be deleted during
hci_le_create_conn_sync (but now we hold ref, so UAF less likely).

The problem:
==================================================================
BUG: KASAN: slab-use-after-free in hci_le_create_conn_sync (net/bluetooth/hci_sync.c:6167) bluetooth
Read of size 1 at addr ffff88804c3ec03a by task kworker/u5:0/110

Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
Workqueue: hci0 hci_cmd_sync_work [bluetooth]
Call Trace:
<TASK>
dump_stack_lvl (lib/dump_stack.c:108)
print_report (mm/kasan/report.c:352 mm/kasan/report.c:462)
? __virt_addr_valid (./include/linux/mmzone.h:1901 ./include/linux/mmzone.h:1997 arch/x86/mm/physaddr.c:65)
? hci_le_create_conn_sync (net/bluetooth/hci_sync.c:6167) bluetooth
kasan_report (mm/kasan/report.c:574)
? hci_le_create_conn_sync (net/bluetooth/hci_sync.c:6167) bluetooth
hci_le_create_conn_sync (net/bluetooth/hci_sync.c:6167) bluetooth
? __pfx_hci_le_create_conn_sync (net/bluetooth/hci_sync.c:6160) bluetooth
? vsnprintf (lib/vsprintf.c:2890)
? vsnprintf (lib/vsprintf.c:2890)
? __dynamic_pr_debug (lib/dynamic_debug.c:858)
? __pfx___dynamic_pr_debug (lib/dynamic_debug.c:858)
? hci_cmd_sync_work (net/bluetooth/hci_sync.c:305) bluetooth
? __pfx_hci_connect_le_sync (net/bluetooth/hci_conn.c:1311) bluetooth
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

Allocated by task 1321:
kasan_save_stack (mm/kasan/common.c:46)
kasan_set_track (mm/kasan/common.c:52)
__kasan_kmalloc (mm/kasan/common.c:374 mm/kasan/common.c:383)
hci_conn_add (./include/linux/slab.h:559 ./include/linux/slab.h:680 net/bluetooth/hci_conn.c:1002) bluetooth
hci_connect_le (net/bluetooth/hci_conn.c:1374) bluetooth
process_adv_report.constprop.0 (net/bluetooth/hci_event.c:6172 net/bluetooth/hci_event.c:6293) bluetooth
hci_le_ext_adv_report_evt (net/bluetooth/hci_event.c:6527) bluetooth
hci_event_packet (net/bluetooth/hci_event.c:7515 net/bluetooth/hci_event.c:7570) bluetooth
hci_rx_work (net/bluetooth/hci_core.c:4085) bluetooth
process_one_work (kernel/workqueue.c:2410)
worker_thread (./include/linux/list.h:292 kernel/workqueue.c:2553)
kthread (kernel/kthread.c:379)
ret_from_fork (arch/x86/entry/entry_64.S:314)

Freed by task 110:
kasan_save_stack (mm/kasan/common.c:46)
kasan_set_track (mm/kasan/common.c:52)
kasan_save_free_info (mm/kasan/generic.c:523)
__kasan_slab_free (mm/kasan/common.c:238 mm/kasan/common.c:200 mm/kasan/common.c:244)
__kmem_cache_free (mm/slub.c:1807 mm/slub.c:3786 mm/slub.c:3799)
device_release (drivers/base/core.c:2489)
kobject_put (lib/kobject.c:683 lib/kobject.c:714 ./include/linux/kref.h:65 lib/kobject.c:731)
hci_conn_hash_flush (net/bluetooth/hci_conn.c:2560) bluetooth
hci_dev_close_sync (net/bluetooth/hci_sync.c:5021) bluetooth
hci_dev_do_close (net/bluetooth/hci_core.c:556) bluetooth
process_one_work (kernel/workqueue.c:2410)
worker_thread (./include/linux/list.h:292 kernel/workqueue.c:2553)
kthread (kernel/kthread.c:379)
ret_from_fork (arch/x86/entry/entry_64.S:314)
==================================================================

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_conn.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index d489a4829be7..d6fd00ba243f 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1280,6 +1280,9 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
 
 	hci_dev_lock(hdev);
 
+	if (!hci_conn_is_alive(hdev, conn))
+		goto done;
+
 	if (!err) {
 		hci_connect_le_scan_cleanup(conn, 0x00);
 		goto done;
@@ -1295,6 +1298,7 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
 
 done:
 	hci_dev_unlock(hdev);
+	hci_conn_put(conn);
 }
 
 static int hci_connect_le_sync(struct hci_dev *hdev, void *data)
@@ -1303,6 +1307,14 @@ static int hci_connect_le_sync(struct hci_dev *hdev, void *data)
 
 	bt_dev_dbg(hdev, "conn %p", conn);
 
+	/* TODO: fix conn race conditions in hci_sync, this is not enough */
+	hci_dev_lock(hdev);
+	if (!hci_conn_is_alive(hdev, conn)) {
+		hci_dev_unlock(hdev);
+		return -ECANCELED;
+	}
+	hci_dev_unlock(hdev);
+
 	return hci_le_create_conn_sync(hdev, conn);
 }
 
@@ -1375,9 +1387,11 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	conn->state = BT_CONNECT;
 	clear_bit(HCI_CONN_SCANNING, &conn->flags);
 
+	hci_conn_get(conn);
 	err = hci_cmd_sync_queue(hdev, hci_connect_le_sync, conn,
 				 create_le_conn_complete);
 	if (err) {
+		hci_conn_put(conn);
 		hci_conn_del(conn);
 		return ERR_PTR(err);
 	}
-- 
2.41.0

