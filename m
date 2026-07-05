Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEFD127A107;
	Sun,  5 Jul 2026 22:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783291387; cv=pass; b=OhUqBq1es5ZxnvzdIbHehKL4Hri47EJgK3DyzNksDI7igI+vIxTYwl5OpESKV6GM1V+CFGn8pc5BuSqXn2kx+I62J9GOYpMmyrup+7hx0GSI0A8mksjZhTP5P/CZNNaRX6gkYcAujINWEC9ZpjkI1d8dTklma5CV6XsEbMb6Xoo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783291387; c=relaxed/simple;
	bh=PR3fj/ExqQSWz1do8zP/IZiOPuepyOKnMkZrJbiTGR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F15YvbOltWwm6YYXq3DHCxVfFT2u3S+3VREh6Q6ncnHQZyIC7zdr72h2h5Wj0J6IVrcLdWkM3+L8+++L6LSW+6qPt7wKESV/WUQPYIsd4FtQ9CnnncXj3NUrzxF2HKBa4K8/Uvg7cb3PO1hKvgNN3A2aKB5oMvzpKC3WhGOBNKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=enathGbY; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="enathGbY"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gtjF33N0LzyZq;
	Mon, 06 Jul 2026 01:43:03 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1783291384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mzrGA84DXz9W9iHVU/yUztzV79ORkdizyf7zHiCs6kc=;
	b=enathGbYAyLHRaKhtzDmCNtSMwHsyueAmTd5sKP7ZoQbJZ7+DUrqsKA3gYftntpIbFX7fl
	8NmQbTWi+CS1MEaaAmJAmr2Pw8BNAuKtOS4Si7oFKIK2inNXOV1ivJw1r2TxL3h7EWKl/N
	mu1v0gVQwfy/K6QGPZhnxF82hndZNDs=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1783291384;
	b=c4oMZzvVPqSPJ43PH4E8tk8vYC0QU3BK6BNWkRlq/Rt5jYlQKN3SKbDZuuqcHMPdmCc/0+
	vBMRutNXQqU4XsYQsGE033LrSxJqSZYEhdeiDyCC4RWyDWDbEEA5FY9yuScOhVvB/51+0X
	RBrmXmsoTKfu59a47jIwsn9InSmgseg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1783291384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mzrGA84DXz9W9iHVU/yUztzV79ORkdizyf7zHiCs6kc=;
	b=WsopIFg3inMonM4fjxDtG2UPXvhk7TiqvnAZQp0b1YKNGbI/fIIEggKfgIhmQIHO0HXezP
	9ycce2JgaqxCYvFsqKC0HLoghMto9f3YG0kjqO2zs9bfFSktECJaFZP6MkR6O7dsuCwn7B
	VSFE5PZY2DWq204Ueiv5ExvKulGb7GA=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] Bluetooth: hci_sync: extend conn_hash lookup critical sections
Date: Mon,  6 Jul 2026 01:42:44 +0300
Message-ID: <4853db33fb044122e1eac76736c5cd0529d13349.1783275015.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1783275015.git.pav@iki.fi>
References: <cover.1783275015.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using RCU-protected pointers outside the critical sections without
refcount is incorrect and may result to UAF.

Extend critical section to cover both hci_conn_hash lookup and use of
the returned conn.

Add surrounding rcu_read_lock() also when return value is not used, in
preparation for RCU lockdep requirement to hci_lookup_le_connect().

This avoids concurrent deletion of the conn before we are done
dereferencing it.

Also, make sure to hold hdev->lock when accessing hdev->accept_list.

Fixes: 58ddd115fe063 ("Bluetooth: hci_conn: Fix not setting conn_timeout for Broadcast Receiver")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v2:
    - take hdev->lock instead of RCU in hci_update_scan_sync() to
      guard also the hdev->accept_list access

 net/bluetooth/hci_sync.c | 42 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 39 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index b096fca86bb5..5dddeed11372 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1028,14 +1028,19 @@ static int hci_set_random_addr_sync(struct hci_dev *hdev, bdaddr_t *rpa)
 	 * In this kind of scenario skip the update and let the random
 	 * address be updated at the next cycle.
 	 */
+	rcu_read_lock();
+
 	if (bacmp(&hdev->random_addr, BDADDR_ANY) &&
 	    (hci_dev_test_flag(hdev, HCI_LE_ADV) ||
 	    hci_lookup_le_connect(hdev))) {
 		bt_dev_dbg(hdev, "Deferring random address update");
 		hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
+		rcu_read_unlock();
 		return 0;
 	}
 
+	rcu_read_unlock();
+
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_SET_RANDOM_ADDR,
 				     6, rpa, HCI_CMD_TIMEOUT);
 }
@@ -2621,12 +2626,17 @@ static int hci_pause_addr_resolution(struct hci_dev *hdev)
 	/* Cannot disable addr resolution if scanning is enabled or
 	 * when initiating an LE connection.
 	 */
+	rcu_read_lock();
+
 	if (hci_dev_test_flag(hdev, HCI_LE_SCAN) ||
 	    hci_lookup_le_connect(hdev)) {
+		rcu_read_unlock();
 		bt_dev_err(hdev, "Command not allowed when scan/LE connect");
 		return -EPERM;
 	}
 
+	rcu_read_unlock();
+
 	/* Cannot disable addr resolution if advertising is enabled. */
 	err = hci_pause_advertising_sync(hdev);
 	if (err) {
@@ -2764,6 +2774,8 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 	if (hci_dev_test_flag(hdev, HCI_PA_SYNC)) {
 		struct hci_conn *conn;
 
+		rcu_read_lock();
+
 		conn = hci_conn_hash_lookup_create_pa_sync(hdev);
 		if (conn) {
 			struct conn_params pa;
@@ -2773,6 +2785,8 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 			bacpy(&pa.addr, &conn->dst);
 			pa.addr_type = conn->dst_type;
 
+			rcu_read_unlock();
+
 			/* Clear first since there could be addresses left
 			 * behind.
 			 */
@@ -2782,6 +2796,8 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 			err = hci_le_add_accept_list_sync(hdev, &pa,
 							  &num_entries);
 			goto done;
+		} else {
+			rcu_read_unlock();
 		}
 	}
 
@@ -2792,10 +2808,13 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 	 * the controller.
 	 */
 	list_for_each_entry_safe(b, t, &hdev->le_accept_list, list) {
-		if (hci_conn_hash_lookup_le(hdev, &b->bdaddr, b->bdaddr_type))
+		rcu_read_lock();
+
+		if (hci_conn_hash_lookup_le(hdev, &b->bdaddr, b->bdaddr_type)) {
+			rcu_read_unlock();
 			continue;
+		}
 
-		/* Pointers not dereferenced, no locks needed */
 		pend_conn = hci_pend_le_action_lookup(&hdev->pend_le_conns,
 						      &b->bdaddr,
 						      b->bdaddr_type);
@@ -2803,6 +2822,8 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 							&b->bdaddr,
 							b->bdaddr_type);
 
+		rcu_read_unlock();
+
 		/* If the device is not likely to connect or report,
 		 * remove it from the acceptlist.
 		 */
@@ -2929,6 +2950,8 @@ static int hci_le_set_ext_scan_param_sync(struct hci_dev *hdev, u8 type,
 		if (sent) {
 			struct hci_conn *conn;
 
+			rcu_read_lock();
+
 			conn = hci_conn_hash_lookup_ba(hdev, PA_LINK,
 						       &sent->bdaddr);
 			if (conn) {
@@ -2953,8 +2976,12 @@ static int hci_le_set_ext_scan_param_sync(struct hci_dev *hdev, u8 type,
 					phy++;
 				}
 
+				rcu_read_unlock();
+
 				if (num_phy)
 					goto done;
+			} else {
+				rcu_read_unlock();
 			}
 		}
 	}
@@ -3205,12 +3232,16 @@ int hci_update_passive_scan_sync(struct hci_dev *hdev)
 		/* If there is at least one pending LE connection, we should
 		 * keep the background scan running.
 		 */
+		bool exists;
 
 		/* If controller is connecting, we should not start scanning
 		 * since some controllers are not able to scan and connect at
 		 * the same time.
 		 */
-		if (hci_lookup_le_connect(hdev))
+		rcu_read_lock();
+		exists = hci_lookup_le_connect(hdev);
+		rcu_read_unlock();
+		if (exists)
 			return 0;
 
 		bt_dev_dbg(hdev, "start background scanning");
@@ -3428,6 +3459,7 @@ int hci_write_fast_connectable_sync(struct hci_dev *hdev, bool enable)
 }
 
 static bool disconnected_accept_list_entries(struct hci_dev *hdev)
+	__must_hold(&hdev->lock)
 {
 	struct bdaddr_list *b;
 
@@ -3468,12 +3500,16 @@ int hci_update_scan_sync(struct hci_dev *hdev)
 	if (hdev->scanning_paused)
 		return 0;
 
+	hci_dev_lock(hdev);
+
 	if (hci_dev_test_flag(hdev, HCI_CONNECTABLE) ||
 	    disconnected_accept_list_entries(hdev))
 		scan = SCAN_PAGE;
 	else
 		scan = SCAN_DISABLED;
 
+	hci_dev_unlock(hdev);
+
 	if (hci_dev_test_flag(hdev, HCI_DISCOVERABLE))
 		scan |= SCAN_INQUIRY;
 
-- 
2.55.0

