Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A85406264
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774460077; cv=pass; b=B241AZUTO25f75eAI29F6q4tAhMYqrZ/M4hO+LoIzM0wXMD65s76cGYPUaWUb4cja9s19WK05Bv6sR4Muafu2JBt7798OBtMfyeV0ORWqa4fV4NgexRS2uiEizFxlpCK3SE9BDgKvZ0vbKOT5dxVjAhsgf+Ygg5cqUaZCkwo0vY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774460077; c=relaxed/simple;
	bh=p57ZMb7Ous7viZY9F0CpUTFjC+FMCPYM6+RMvBqcoeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lUkyynlGOLawL0PT2kcmaxrsrfQHeFklDslZle8UYFeXsQiC9E8v0iIU6WcUsomdG1jSTHzXe/2ynMempsBGaVsoYJdBNW5WKczcz+aegQvyOWnbU9GNLstPdG3FtPlUVRiK4kvBrkV9oYkqOfDqNEK7S8yUcjCGrr73VHXqHO0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=uV5KwGcT; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="uV5KwGcT"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:1:f410::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fgvD71tH2zyWr;
	Wed, 25 Mar 2026 19:34:31 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1774460071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b1jeNgo3rj39YHtytxc/6OQjFCoXGp2g3jNWEZhQ2VY=;
	b=uV5KwGcToQeUU/6GrhV9gMGDujdn9NaySoGS4sFzadnmSlBxUTGkhcTtbQMiAFBijpi3r0
	emMaU0udA8dlK836878or/N4mXxBj/rIdAMoePP1PXgsBXZTXWamHgWlN83VHoF2tOXmJj
	cKbrAogKgjhg5x4NNcRMM8FJIWyDKsU=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774460071;
	b=MN60kU3LIRwTyDv7Wz4zaYA5jmqFw2qkPexPiBOpWXzPtRV2uCn21nY+5MkDRe6GBav1zI
	Dg1w5s1zb5ah23WpqRkWNKyV6uFxTrQEdDI4jdc613MT+/Go+qqrUjV3DqTCMwFkmkO96M
	eyDhaJtpEoF/euuyWxfXmCKYtttH0F8=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1774460071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=b1jeNgo3rj39YHtytxc/6OQjFCoXGp2g3jNWEZhQ2VY=;
	b=NcElbmPs9Q5ji9V49OvmEcZBU81RQ9GmggX898HrC/VQmQr02KDGUJOWrA9KLuB3vl/YLE
	o1Wsz6GTy0KnQFTzXUKSn/1PGDeUHNjPURc2nm77poTDLdNu0jlkv5hsDRrDVLFPaYxz7d
	zApd3r2EFmOH4VPPp37ArAyDxNfkcpE=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH 1/3] Bluetooth: hci_sync: hci_cmd_sync_queue_once() return -EEXIST if exists
Date: Wed, 25 Mar 2026 19:34:21 +0200
Message-ID: <f7ccb4a4f9e462a6c1c1ddba8dd1cdcc9456944b.1774459946.git.pav@iki.fi>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_cmd_sync_queue_once() needs to indicate whether a queue item was
added, so caller can know if callbacks are called, so it can avoid
leaking resources.

Change the function to return -EEXIST if queue item already exists.

Modify all callsites to handle that.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---
 net/bluetooth/hci_sync.c | 53 +++++++++++++++++++++++++++-------------
 1 file changed, 36 insertions(+), 17 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 45d16639874a..4e2c8a759e63 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -780,7 +780,7 @@ int hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 			    void *data, hci_cmd_sync_work_destroy_t destroy)
 {
 	if (hci_cmd_sync_lookup_entry(hdev, func, data, destroy))
-		return 0;
+		return -EEXIST;
 
 	return hci_cmd_sync_queue(hdev, func, data, destroy);
 }
@@ -3255,6 +3255,8 @@ static int update_passive_scan_sync(struct hci_dev *hdev, void *data)
 
 int hci_update_passive_scan(struct hci_dev *hdev)
 {
+	int err;
+
 	/* Only queue if it would have any effect */
 	if (!test_bit(HCI_UP, &hdev->flags) ||
 	    test_bit(HCI_INIT, &hdev->flags) ||
@@ -3264,8 +3266,9 @@ int hci_update_passive_scan(struct hci_dev *hdev)
 	    hci_dev_test_flag(hdev, HCI_UNREGISTER))
 		return 0;
 
-	return hci_cmd_sync_queue_once(hdev, update_passive_scan_sync, NULL,
-				       NULL);
+	err = hci_cmd_sync_queue_once(hdev, update_passive_scan_sync, NULL,
+				      NULL);
+	return (err == -EEXIST) ? 0 : err;
 }
 
 int hci_write_sc_support_sync(struct hci_dev *hdev, u8 val)
@@ -6958,8 +6961,11 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
 
 int hci_connect_acl_sync(struct hci_dev *hdev, struct hci_conn *conn)
 {
-	return hci_cmd_sync_queue_once(hdev, hci_acl_create_conn_sync, conn,
-				       NULL);
+	int err;
+
+	err = hci_cmd_sync_queue_once(hdev, hci_acl_create_conn_sync, conn,
+				      NULL);
+	return (err == -EEXIST) ? 0 : err;
 }
 
 static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
@@ -6995,8 +7001,11 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
 
 int hci_connect_le_sync(struct hci_dev *hdev, struct hci_conn *conn)
 {
-	return hci_cmd_sync_queue_once(hdev, hci_le_create_conn_sync, conn,
-				       create_le_conn_complete);
+	int err;
+
+	err = hci_cmd_sync_queue_once(hdev, hci_le_create_conn_sync, conn,
+				      create_le_conn_complete);
+	return (err == -EEXIST) ? 0 : err;
 }
 
 int hci_cancel_connect_sync(struct hci_dev *hdev, struct hci_conn *conn)
@@ -7203,8 +7212,11 @@ static int hci_le_pa_create_sync(struct hci_dev *hdev, void *data)
 
 int hci_connect_pa_sync(struct hci_dev *hdev, struct hci_conn *conn)
 {
-	return hci_cmd_sync_queue_once(hdev, hci_le_pa_create_sync, conn,
-				       create_pa_complete);
+	int err;
+
+	err = hci_cmd_sync_queue_once(hdev, hci_le_pa_create_sync, conn,
+				      create_pa_complete);
+	return (err == -EEXIST) ? 0 : err;
 }
 
 static void create_big_complete(struct hci_dev *hdev, void *data, int err)
@@ -7266,8 +7278,11 @@ static int hci_le_big_create_sync(struct hci_dev *hdev, void *data)
 
 int hci_connect_big_sync(struct hci_dev *hdev, struct hci_conn *conn)
 {
-	return hci_cmd_sync_queue_once(hdev, hci_le_big_create_sync, conn,
-				       create_big_complete);
+	int err;
+
+	err = hci_cmd_sync_queue_once(hdev, hci_le_big_create_sync, conn,
+				      create_big_complete);
+	return (err == -EEXIST) ? 0 : err;
 }
 
 struct past_data {
@@ -7359,7 +7374,7 @@ int hci_past_sync(struct hci_conn *conn, struct hci_conn *le)
 	if (err)
 		kfree(data);
 
-	return err;
+	return (err == -EEXIST) ? 0 : err;
 }
 
 static void le_read_features_complete(struct hci_dev *hdev, void *data, int err)
@@ -7446,7 +7461,7 @@ int hci_le_read_remote_features(struct hci_conn *conn)
 	else
 		err = -EOPNOTSUPP;
 
-	return err;
+	return (err == -EEXIST) ? 0 : err;
 }
 
 static void pkt_type_changed(struct hci_dev *hdev, void *data, int err)
@@ -7472,6 +7487,7 @@ int hci_acl_change_pkt_type(struct hci_conn *conn, u16 pkt_type)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_cp_change_conn_ptype *cp;
+	int err;
 
 	cp = kmalloc_obj(*cp);
 	if (!cp)
@@ -7480,8 +7496,9 @@ int hci_acl_change_pkt_type(struct hci_conn *conn, u16 pkt_type)
 	cp->handle = cpu_to_le16(conn->handle);
 	cp->pkt_type = cpu_to_le16(pkt_type);
 
-	return hci_cmd_sync_queue_once(hdev, hci_change_conn_ptype_sync, cp,
-				       pkt_type_changed);
+	err = hci_cmd_sync_queue_once(hdev, hci_change_conn_ptype_sync, cp,
+				      pkt_type_changed);
+	return (err == -EEXIST) ? 0 : err;
 }
 
 static void le_phy_update_complete(struct hci_dev *hdev, void *data, int err)
@@ -7507,6 +7524,7 @@ int hci_le_set_phy(struct hci_conn *conn, u8 tx_phys, u8 rx_phys)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_cp_le_set_phy *cp;
+	int err;
 
 	cp = kmalloc_obj(*cp);
 	if (!cp)
@@ -7517,6 +7535,7 @@ int hci_le_set_phy(struct hci_conn *conn, u8 tx_phys, u8 rx_phys)
 	cp->tx_phys = tx_phys;
 	cp->rx_phys = rx_phys;
 
-	return hci_cmd_sync_queue_once(hdev, hci_le_set_phy_sync, cp,
-				       le_phy_update_complete);
+	err = hci_cmd_sync_queue_once(hdev, hci_le_set_phy_sync, cp,
+				      le_phy_update_complete);
+	return (err == -EEXIST) ? 0 : err;
 }
-- 
2.53.0

