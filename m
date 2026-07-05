Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A52137754C;
	Sun,  5 Jul 2026 14:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.185.170.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783262885; cv=pass; b=YTNpNgyMWCWTzyABIOeuoRqFhiFcBQ1ajuexTBk3mjlLY3YuaST7cI53x86KcrfKq5INEi62oxfZEFdvCkdjREdha4YYcXg7PCc25xVhoKkkK4iB+0HhUeIbBDkppVZaEtdvJAMedsEoo7elu/j3mlrp7/aaVyLUsO3/e9Od8MQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783262885; c=relaxed/simple;
	bh=Sm7g4bUx6PmhqrHLXgy1Fw2qNJS8aAhpZOOqXyMyBSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S2dsIdJAbjhf9CriYpF/C17f8sYKc08b7au1zOqoJWsNdFecnTQ3kmMC6P6wzMvrFF/vtehku5USbGkZcsMvMN6qKE6q7eK1iJmtQwV0Nt34+7sm+wJCBpJdVC8dhTyoM740XALi3nexr9RR4zNe5S33mnMi4oNhLx8t6tyEMBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b=lMf9y7bY; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=uYi98StZ; arc=pass smtp.client-ip=185.185.170.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iki.fi header.i=@iki.fi header.b="lMf9y7bY";
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="uYi98StZ"
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4gtVhp57M7z49Q9Q;
	Sun, 05 Jul 2026 17:47:54 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
	t=1783262874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pBJwqEcZ7bmgp9c5IrQWY69X0dXcy5FZodDKYdc8AGk=;
	b=lMf9y7bYjvPqIpvfZVvJRa7LoA+bB2amLPvYcUqF9VsT1j8z4X1JI3UBPsTJTpUWe5+x5d
	yVkBJvjN6iTov/0QB/JVRFLf4iwK/qqIwn3xu5Z2tV4iPkSbzKa2+3qFyu/SY2S0TbkiVv
	koYuXE8y96xr9ECZLm4RdXxXqaxwTCdtjy3xcSBaj1aBOKv+TulCwETKgbM1SYrgIiDA6B
	cfDPWqt2iTemuGkgMP9g71wrt5kMq2fbZm+zOJqkvpEeb2hQXAwDYxhnsfkhZSm6l4KgpU
	B6lMMvGUHvXtH1xin6pEypyZZ15c9z2HYxgsl8bAx5Hqa2mmSC2XNf99RKkP0w==
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4gtVhd6c0GzyZ2;
	Sun, 05 Jul 2026 17:47:45 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1783262866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pBJwqEcZ7bmgp9c5IrQWY69X0dXcy5FZodDKYdc8AGk=;
	b=uYi98StZ+Ag6EQIctE0yhsnNk6BqFGV96yp86OjyK/8wr9MR+GbjwCRoJ7yTi0GtRkBcBh
	5scoik8Mm9Y2bzGmnoPote1Vsl5dfzEvJmZEQQ7gSzXypFvl2yYnLf+nPt90f9L4OVFKXV
	iX9EneEr4jWUkBijqCPWn7RwG5IjS3g=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1783262866;
	b=XakcjHTwV9KQkZy+7F8a2WoDqMyvyjlOL26pQiuKs4gnnJCTtJItM36xATZRs+IKVkHEI8
	dtD0bLCV9WH8unwS8HmKZ/4buRXCZNV5GMWmCGhKtWq+9bzL5RW+SUgrmihRZml76UjTvD
	wpjjJSj6/B+Er0D80+9oQMRJ8xJYzzQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1783262866;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pBJwqEcZ7bmgp9c5IrQWY69X0dXcy5FZodDKYdc8AGk=;
	b=bx9xE+G5g6cDrGoJ2j9ye03sJNZVQeBjul5uOoSITh/BqonTGseAG+z31cJbsEsq1pkAQc
	esiw/u1u4AC6RL69VK84BFytorVZleO0G70qXlTL05iGtY+qhxJPt3MKz/Ym4OuQe7PxPu
	SznrQRuyNEGBQXDEwGcEeXnCdu3NbYU=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: hci_sync: extend conn_hash lookup RCU critical sections
Date: Sun,  5 Jul 2026 17:47:36 +0300
Message-ID: <acd866db0f2eb2cb4279f3b76e4be0e76feb39c4.1783262689.git.pav@iki.fi>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1783262689.git.pav@iki.fi>
References: <cover.1783262689.git.pav@iki.fi>
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

Fixes: 58ddd115fe063 ("Bluetooth: hci_conn: Fix not setting conn_timeout for Broadcast Receiver")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_sync.c | 41 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 38 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index b096fca86bb5..a614bab77119 100644
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
@@ -3468,12 +3499,16 @@ int hci_update_scan_sync(struct hci_dev *hdev)
 	if (hdev->scanning_paused)
 		return 0;
 
+	rcu_read_lock();
+
 	if (hci_dev_test_flag(hdev, HCI_CONNECTABLE) ||
 	    disconnected_accept_list_entries(hdev))
 		scan = SCAN_PAGE;
 	else
 		scan = SCAN_DISABLED;
 
+	rcu_read_unlock();
+
 	if (hci_dev_test_flag(hdev, HCI_DISCOVERABLE))
 		scan |= SCAN_INQUIRY;
 
-- 
2.55.0

