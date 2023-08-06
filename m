Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1894C001DF
	for <linux-bluetooth@archiver.kernel.org>; Sun,  6 Aug 2023 15:27:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbjHFP1u (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sun, 6 Aug 2023 11:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjHFP1s (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Sun, 6 Aug 2023 11:27:48 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F15BF3
        for <linux-bluetooth@vger.kernel.org>; Sun,  6 Aug 2023 08:27:47 -0700 (PDT)
Received: from monolith.lan (unknown [193.138.7.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pav)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4RJjxr47bzz49Q64;
        Sun,  6 Aug 2023 18:27:44 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1691335664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ARuo5LTrE5HL803ZSwc+NL5xY+iBRrp465y+GAVAZd8=;
        b=KSCReRwuVUMzns6H8IJYxw7wncD0zg634docRDvwx4m2tFMXSo48Sf8VhVzuJqDxskwVeX
        hSq5Y2QOdBvqCGXkSyJL2tL06ydgpLaBUYyFGbww/8tJrgXrUlVeFgeSapl8fic8lnVGIM
        huTgPk138+41nOhwKuLordQNpCUH61sCVkIZGXNHlMTNh7fySXTBlIVWKjLVosOJSCc9NB
        K7HZFky1/igRwMUGgowkAdP0KYdnPKq/eALHqcF3RaKsRBtBaJ0oCwsBkyUHzw2cZ1MgYu
        cbnXa8wSGukGhmbJqfPhaCWExDeXtun+6p/tFz1ki6Ywb7qEKGpiqHyvYvTGzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1691335664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ARuo5LTrE5HL803ZSwc+NL5xY+iBRrp465y+GAVAZd8=;
        b=pSW/djYoCowB+Cdp5pExkHiZaBx7qw5zvsjZrfIDKkn7zaKcCRrBXzVxB99TUV6qleYVIX
        rlBtPDK+jRMGDMKHA1n1wJtsxqI43P9ShWaQ3p/UM0MIPG8NYKTuGx7DeLahAPOczhQU3O
        qT8WaWn9McDNUdYtlZQEcPjrduCNGYGcNPkGnK315ALTIKi4Pl9MH4jXuuCwJyXrnUtEpJ
        p73g/yoenq8EjqaZFsPwVIWPOe9j/UeLsvflQAyT8vTpfWXpXpiHeEYhfpab734KkbASAO
        uouNfUfxuWhYS1NXY1Mfsk1xcOF3u0QcWwrHO13AODqPEFWxlxnxpJ5YCAXtuw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1691335664; a=rsa-sha256;
        cv=none;
        b=vhhZKk35DOqGrXVrFmm7LqfyFwgDbBFZkjHMEWm4nP6dcz00ijMqaLXcKaZuc23+RKzkPq
        xX0I2vc6V7SMIAypfbMAieBP+HntdTZbJ8OuUaM5wh84mxc8Uec5ysxrrZOZEFqi30sA/q
        3rmjWF8fU856bfpO2dxS6+P36TkRdwPaMGQXxLH20vv9zFYC13jP5eerbdFGd2ADZjjOBL
        7fMDrAlsOUphByAmp/RE9KIP136JJBou/gW5Z/zc+GDEij1N1UpXMmB0LRvYXO+PjC1HfI
        zrVbEfH6prd5zknzIVF6fJSB4FzDzx4XdGSEiziXfn8bcSlqkRxOwCmmZ5AEtQ==
From:   Pauli Virtanen <pav@iki.fi>
To:     linux-bluetooth@vger.kernel.org
Cc:     Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 2/3] Bluetooth: hci_sync: fix use-after-free in hci_disconnect_all_sync
Date:   Sun,  6 Aug 2023 18:27:38 +0300
Message-ID: <60e979dc19e16e12489ba2ed956a7bae347e7a09.1691331800.git.pav@iki.fi>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <b2ed850478c905299c40154c1d6dfc304a93d77a.1691331800.git.pav@iki.fi>
References: <b2ed850478c905299c40154c1d6dfc304a93d77a.1691331800.git.pav@iki.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Use-after-free occurs in hci_disconnect_all_sync if a connection is
deleted by concurrent processing of a controller event.  This can occur
while waiting for controller events (big time window) or at other times
(less likely).

Fix the iteration in hci_disconnect_all_sync to allow hci_conn to be
deleted at any time.

UAF crash log:
==================================================================
BUG: KASAN: slab-use-after-free in hci_set_powered_sync (net/bluetooth/hci_sync.c:5424) [bluetooth]
Read of size 8 at addr ffff888009d9c000 by task kworker/u9:0/124

CPU: 0 PID: 124 Comm: kworker/u9:0 Tainted: G        W          6.5.0-rc1+ #10
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-1.fc38 04/01/2014
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
---
 net/bluetooth/hci_sync.c | 41 +++++++++++++++++++++++++++++++++-------
 1 file changed, 34 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 51ff682f66e0..be0f9527de2b 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5415,16 +5415,43 @@ int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason)
 
 static int hci_disconnect_all_sync(struct hci_dev *hdev, u8 reason)
 {
-	struct hci_conn *conn, *tmp;
-	int err;
+	struct hci_conn *c, *conn;
+	int err = 0;
+
+	rcu_read_lock();
+
+	/* Any conn may be gone while waiting for events, iterate safely.
+	 * If conn is in conn_hash and we didn't abort it, it probably
+	 * has not yet been aborted.
+	 */
+	list_for_each_entry_rcu(c, &hdev->conn_hash.list, list)
+		c->abort_reason = (reason == 0xff) ? 0xfe : 0xff;
+
+	do {
+		conn = NULL;
+		list_for_each_entry_rcu(c, &hdev->conn_hash.list, list) {
+			if (c->abort_reason != reason) {
+				conn = c;
+				break;
+			}
+		}
+		if (!conn)
+			break;
+
+		conn->abort_reason = reason;
+		hci_conn_get(conn);
+
+		rcu_read_unlock();
 
-	list_for_each_entry_safe(conn, tmp, &hdev->conn_hash.list, list) {
 		err = hci_abort_conn_sync(hdev, conn, reason);
-		if (err)
-			return err;
-	}
+		hci_conn_put(conn);
 
-	return 0;
+		rcu_read_lock();
+	} while (!err);
+
+	rcu_read_unlock();
+
+	return err;
 }
 
 /* This function perform power off HCI command sequence as follows:
-- 
2.41.0

