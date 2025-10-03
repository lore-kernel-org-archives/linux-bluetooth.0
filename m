Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E632D8DA6
	for <linux-bluetooth@vger.kernel.org>; Fri,  3 Oct 2025 17:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759511354; cv=pass; b=sOahAu/ImI7m8yUnfv19EGQnYE21J8QNQ7boB74XdXK86kB79NrLvn5m1QjiOClIobu+k7Pa3Jf1pqz+b+hN7YjX/A6GuorvRpd4D5773oCPMGeP4UzToK+jmYE9cXHBvfWKtOLKe8VKkyngTDBg2zlOtp9MhH/gRZl0CentVFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759511354; c=relaxed/simple;
	bh=YtvjOyYQ94XBTDZkpjlJlXs/HVIEd7cge/ruxyDE8Vw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QRUXQSS8nmDDdSkV0ftyHR6NsOAimJ27eMSD8ODYWS7C2SUZMzadE9t21xvONpNE4pO2ENBZuylh9BfIv+wvVGLoCmjPwZY3QjSFBUom8MvBQqsfrjWvtI5UrTPTghua/AAEk48tew4Q1eTT/iSfhIa4NY/phENlH7zxpSrykNg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=sBW8NFgf; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="sBW8NFgf"
Received: from monolith.lan (unknown [IPv6:2a0c:f040:0:2790::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4cdZrX4xKBz1091;
	Fri,  3 Oct 2025 20:09:00 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1759511340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7MQITnvDOJlKDOCPkjCiEf2fth0/XempNMql7XP0J0Q=;
	b=sBW8NFgfw3T8aW169QoOLE6egUcMSGMpym/cg+Mcj6aDG9+cxngSvvcXj6pXpgE2DE8B0I
	IObgxWcZk8wsdM5caObzgiC/ed1H2vewURafDtNSH/wRLnl+UleQ0bZbq+VLr1HRcGfT3j
	H79fUEGHLcU8sVHhFvamxmu036Yr29E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1759511340;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7MQITnvDOJlKDOCPkjCiEf2fth0/XempNMql7XP0J0Q=;
	b=cJ1EzCntry27QsSSxoxKgIGTeB9OF93Zic/KsIZUFwwJlA1Mstu2JuNLG6Onq8lODCCazi
	jVMzbbMd3y6fXzs/JdbAnhWYJw0tESdyp/0FX6sGkthVmv/EDoffsy3ciOhArc0l8m5Vyo
	jJxxTvalYGgWiAKmbJrf7I1ttYPW4kk=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1759511340; a=rsa-sha256; cv=none;
	b=MjkPYjwUv+7iBgDPk5x25yztFVuOtPI/EV35oXAkGSra+eJAPpGewbPttvB8XiVgbCGY6B
	X8reIT+56HA+JAlZkWh42y0slNv0D79THr/ul2MqFHOvykn+msOVTlTbdm9Rwr2cMtyPxK
	WcZ3HOyzX5RWSVh6FTsEaKrOrqRs8S4=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 5/9] Bluetooth: hci_sync: extend conn_hash lookup RCU critical sections
Date: Fri,  3 Oct 2025 20:08:48 +0300
Message-ID: <7e9651d40df74fe24a771788e431541a40f14f78.1759511032.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1759511032.git.pav@iki.fi>
References: <cover.1759511032.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend critical section to cover both hci_conn_hash lookup and use of
the returned conn.  Add separate function for when we are just checking
if a conn exists.

This avoids concurrent deletion of the conn before we are done
dereferencing it.

Fixes: 58ddd115fe063 ("Bluetooth: hci_conn: Fix not setting conn_timeout for Broadcast Receiver")
Fixes: cf75ad8b41d2a ("Bluetooth: hci_sync: Convert MGMT_SET_POWERED")
Fixes: c2994b008492d ("Bluetooth: hci_sync: Fix not setting Random Address when required")
Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_sync.c | 49 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 43 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 28ad08cd7d70..bf68da42e664 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -1035,6 +1035,21 @@ static bool adv_use_rpa(struct hci_dev *hdev, uint32_t flags)
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
+	/* The return value may be wrong if the conn is modified concurrently,
+	 * e.g. by HCI event. This function should be used only when this is OK
+	 * (time of check doesn't matter or operation will be tried again).
+	 */
+	return found;
+}
+
 static int hci_set_random_addr_sync(struct hci_dev *hdev, bdaddr_t *rpa)
 {
 	/* If a random_addr has been set we're advertising or initiating an LE
@@ -1049,7 +1064,7 @@ static int hci_set_random_addr_sync(struct hci_dev *hdev, bdaddr_t *rpa)
 	 */
 	if (bacmp(&hdev->random_addr, BDADDR_ANY) &&
 	    (hci_dev_test_flag(hdev, HCI_LE_ADV) ||
-	    hci_lookup_le_connect(hdev))) {
+	    hci_check_le_connect(hdev))) {
 		bt_dev_dbg(hdev, "Deferring random address update");
 		hci_dev_set_flag(hdev, HCI_RPA_EXPIRED);
 		return 0;
@@ -2636,7 +2651,7 @@ static int hci_pause_addr_resolution(struct hci_dev *hdev)
 	 * when initiating an LE connection.
 	 */
 	if (hci_dev_test_flag(hdev, HCI_LE_SCAN) ||
-	    hci_lookup_le_connect(hdev)) {
+	    hci_check_le_connect(hdev)) {
 		bt_dev_err(hdev, "Command not allowed when scan/LE connect");
 		return -EPERM;
 	}
@@ -2778,6 +2793,8 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 	if (hci_dev_test_flag(hdev, HCI_PA_SYNC)) {
 		struct hci_conn *conn;
 
+		rcu_read_lock();
+
 		conn = hci_conn_hash_lookup_create_pa_sync(hdev);
 		if (conn) {
 			struct conn_params pa;
@@ -2787,6 +2804,8 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 			bacpy(&pa.addr, &conn->dst);
 			pa.addr_type = conn->dst_type;
 
+			rcu_read_unlock();
+
 			/* Clear first since there could be addresses left
 			 * behind.
 			 */
@@ -2796,6 +2815,8 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 			err = hci_le_add_accept_list_sync(hdev, &pa,
 							  &num_entries);
 			goto done;
+		} else {
+			rcu_read_unlock();
 		}
 	}
 
@@ -2806,10 +2827,13 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
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
@@ -2817,6 +2841,8 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 							&b->bdaddr,
 							b->bdaddr_type);
 
+		rcu_read_unlock();
+
 		/* If the device is not likely to connect or report,
 		 * remove it from the acceptlist.
 		 */
@@ -2943,6 +2969,8 @@ static int hci_le_set_ext_scan_param_sync(struct hci_dev *hdev, u8 type,
 		if (sent) {
 			struct hci_conn *conn;
 
+			rcu_read_lock();
+
 			conn = hci_conn_hash_lookup_ba(hdev, PA_LINK,
 						       &sent->bdaddr);
 			if (conn) {
@@ -2967,8 +2995,12 @@ static int hci_le_set_ext_scan_param_sync(struct hci_dev *hdev, u8 type,
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
@@ -3224,7 +3256,7 @@ int hci_update_passive_scan_sync(struct hci_dev *hdev)
 		 * since some controllers are not able to scan and connect at
 		 * the same time.
 		 */
-		if (hci_lookup_le_connect(hdev))
+		if (hci_check_le_connect(hdev))
 			return 0;
 
 		bt_dev_dbg(hdev, "start background scanning");
@@ -3479,12 +3511,17 @@ int hci_update_scan_sync(struct hci_dev *hdev)
 	if (hdev->scanning_paused)
 		return 0;
 
+	/* If connection states change we update again, so lockless is OK */
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
2.51.0

