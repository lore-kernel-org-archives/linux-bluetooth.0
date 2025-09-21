Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 485F7254B1B
	for <linux-bluetooth@vger.kernel.org>; Sun, 21 Sep 2025 19:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758482099; cv=pass; b=pHwxPoF/I2BfrPOtvciQEVtwQcKVSIxUji36B7nSsx05Xcm9Pg4kvXTg6rTFPaC1eP5E/WfFv+UP3ktweq6R0xpqYJwNrYK2B4FtsAK+7GgLV8XCRtpCQDpE2kK9YHc8SSXwsG2DTYvhwu+2yOzcAHK4uWZ3vBBZLlrShZ/qfWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758482099; c=relaxed/simple;
	bh=Hy43SshXI5hn9qYXm/mI8XaiRe/2QZANCCZ2D0vUdOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I+cV0uhM2B2tyUAiMphYc2HQ8g1tEa4ceyX+dd3K8jjOuLoDhuqjDyMOHWy5VKAP/tE661snqvFn5oaSZoSjdkJUSyeVL54+M+4MAPbdL2piXPWgdZOzYBMEaZCxxVc3lUVy+U0a0x5kBD7bh4Vyrzn2SpJPXaJs6xcpkQZfa3g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=NTsnHo7A; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="NTsnHo7A"
Received: from monolith.lan (unknown [193.138.7.158])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cVGCD2qY2z10GD;
	Sun, 21 Sep 2025 22:14:48 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1758482088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=++XRYC9O0SHcVCMEk538mskKFV+4cdZW86A94UTjuZI=;
	b=NTsnHo7AAcqvDEdUWA0eaAj36u0jlXjcuwnRcNLSMoWfSzIXbXhbV9fF6twro7XGsC7Q1p
	hUAnKISBn/nrRgV5Qr6YXIFPeD91NqBu8ryQaAav8ppMaXBFg2zyJq0j8YsHkuj1Q0/zA9
	NU/GaWYLsp7Cvq2n9cj2wdTsp1clgeE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1758482088;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=++XRYC9O0SHcVCMEk538mskKFV+4cdZW86A94UTjuZI=;
	b=PULo35TAMkYJoSJrTc+4X53vtfneTAxQMf4q8WGFWDWDazgG1x5pJS/7N5O7dIOFgj9K1+
	BoD5An7dhw3KkXL0S5PdhcO5ZNomJrHKS0nuF0guKLcVKZ16Zm+oZR15XUFJdPnLwu4CYW
	hoUoabz//uCBoxvClB5EU6b5qDVgdkw=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1758482088; a=rsa-sha256; cv=none;
	b=E+VW2EUzE1F1CwvxREdTVfgGAKqZPWjostxBiL+OKWbECP9ar/x4ngCCdXlHOrY4QkI49i
	nif/BHE/WMy7PbZJEIxo3kgEwsxNburwxhwyqhAR41GVvcE+vbLhdQ5KEEWMS8d4/KmLin
	8qoX3gFbYIjbLK7Yi7a3yLs0/xg6jkM=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [RFC PATCH 08/24] Bluetooth: hci_sync: extend conn_hash lookup RCU critical sections
Date: Sun, 21 Sep 2025 22:14:23 +0300
Message-ID: <d6575384d159230c610aae3f0e22ee614bcbd0c5.1758481869.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1758481869.git.pav@iki.fi>
References: <cover.1758481869.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When doing hci_conn_hash lookups with only RCU, extend critical section
to cover also the handling of the return value.

This avoids any concurrent hci_conn_del from deleting the conn before we
are done dereferencing it.

Fixes: 58ddd115fe063 ("Bluetooth: hci_conn: Fix not setting conn_timeout for Broadcast Receiver")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_sync.c | 59 +++++++++++++++++++++++++++++++++-------
 1 file changed, 49 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index ee2d41eead17..408fe5e08c30 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1036,6 +1036,20 @@ static bool adv_use_rpa(struct hci_dev *hdev, uint32_t flags)
 	return true;
 }
 
+static bool hci_check_le_connect(struct hci_dev *hdev)
+{
+	bool found;
+
+	rcu_read_lock();
+	found = hci_lookup_le_connect(hdev);
+	rcu_read_unlock();
+
+	/* The return value may be wrong under race conditions, as the
+	 * conn may be already deleted
+	 */
+	return found;
+}
+
 static int hci_set_random_addr_sync(struct hci_dev *hdev, bdaddr_t *rpa)
 {
 	/* If a random_addr has been set we're advertising or initiating an LE
@@ -1050,7 +1064,7 @@ static int hci_set_random_addr_sync(struct hci_dev *hdev, bdaddr_t *rpa)
 	 */
 	if (bacmp(&hdev->random_addr, BDADDR_ANY) &&
 	    (hci_dev_test_flag(hdev, HCI_LE_ADV) ||
-	    hci_lookup_le_connect(hdev))) {
+	    hci_check_le_connect(hdev))) {
 		bt_dev_dbg(hdev, "Deferring random address update");
 		hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
 		return 0;
@@ -2636,7 +2650,7 @@ static int hci_pause_addr_resolution(struct hci_dev *hdev)
 	 * when initiating an LE connection.
 	 */
 	if (hci_dev_test_flag(hdev, HCI_LE_SCAN) ||
-	    hci_lookup_le_connect(hdev)) {
+	    hci_check_le_connect(hdev)) {
 		bt_dev_err(hdev, "Command not allowed when scan/LE connect");
 		return -EPERM;
 	}
@@ -2778,6 +2792,8 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 	if (hci_dev_test_flag(hdev, HCI_PA_SYNC)) {
 		struct hci_conn *conn;
 
+		rcu_read_lock();
+
 		conn = hci_conn_hash_lookup_create_pa_sync(hdev);
 		if (conn) {
 			struct conn_params pa;
@@ -2787,6 +2803,8 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 			bacpy(&pa.addr, &conn->dst);
 			pa.addr_type = conn->dst_type;
 
+			rcu_read_unlock();
+
 			/* Clear first since there could be addresses left
 			 * behind.
 			 */
@@ -2796,6 +2814,8 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 			err = hci_le_add_accept_list_sync(hdev, &pa,
 							  &num_entries);
 			goto done;
+		} else {
+			rcu_read_unlock();
 		}
 	}
 
@@ -2806,10 +2826,13 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 	 * the controller.
 	 */
 	list_for_each_entry_safe(b, t, &hdev->le_accept_list, list) {
-		if (hci_conn_hash_lookup_le(hdev, &b->bdaddr, b->bdaddr_type))
-			continue;
+		rcu_read_lock();
+
+		if (hci_conn_hash_lookup_le(hdev, &b->bdaddr, b->bdaddr_type)) {
+			rcu_read_unlock();
+			continue;
+		}
 
-		/* Pointers not dereferenced, no locks needed */
 		pend_conn = hci_pend_le_action_lookup(&hdev->pend_le_conns,
 						      &b->bdaddr,
 						      b->bdaddr_type);
@@ -2817,6 +2840,8 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 							&b->bdaddr,
 							b->bdaddr_type);
 
+		rcu_read_unlock();
+
 		/* If the device is not likely to connect or report,
 		 * remove it from the acceptlist.
 		 */
@@ -2943,6 +2968,8 @@ static int hci_le_set_ext_scan_param_sync(struct hci_dev *hdev, u8 type,
 		if (sent) {
 			struct hci_conn *conn;
 
+			rcu_read_lock();
+
 			conn = hci_conn_hash_lookup_ba(hdev, PA_LINK,
 						       &sent->bdaddr);
 			if (conn) {
@@ -2967,8 +2994,12 @@ static int hci_le_set_ext_scan_param_sync(struct hci_dev *hdev, u8 type,
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
@@ -3224,7 +3255,7 @@ int hci_update_passive_scan_sync(struct hci_dev *hdev)
 		 * since some controllers are not able to scan and connect at
 		 * the same time.
 		 */
-		if (hci_lookup_le_connect(hdev))
+		if (hci_check_le_connect(hdev))
 			return 0;
 
 		bt_dev_dbg(hdev, "start background scanning");
@@ -3448,12 +3479,20 @@ static bool disconnected_accept_list_entries(struct hci_dev *hdev)
 	list_for_each_entry(b, &hdev->accept_list, list) {
 		struct hci_conn *conn;
 
-		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &b->bdaddr);
-		if (!conn)
-			return true;
+		rcu_read_lock();
 
-		if (conn->state != BT_CONNECTED && conn->state != BT_CONFIG)
+		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &b->bdaddr);
+		if (!conn) {
+			rcu_read_unlock();
 			return true;
+		}
+
+		if (conn->state != BT_CONNECTED && conn->state != BT_CONFIG) {
+			rcu_read_unlock();
+			return true;
+		}
+
+		rcu_read_unlock();
 	}
 
 	return false;
-- 
2.51.0

