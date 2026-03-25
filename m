Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A8933126D7
	for <linux-bluetooth@vger.kernel.org>; Wed, 25 Mar 2026 19:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774465676; cv=pass; b=Hmt3iyjagnOgfa7gYeOpRHKIrxfG2bRZ1cWqf2uAwh3qpLsY58g2sITp3Cw+Sw+oHkCeElnKOYJ2JXqdMjUchEIeDv3ZKt2D16VtHZWk5osMlpaqJVpMOk/PCiqCX/6nmDyf59IsAB3A119nAUCivrYzNHFwVaNSqb54HzWMPeU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774465676; c=relaxed/simple;
	bh=agAgsomPzQ7vhl2Kx5G9YhYeump+71JCV3a9TEZ4jA0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oAvUHL9Gvl6BE+RhhNH1a6lqsaO1CfLDHklMjRjQhZQf/Nqf1D1Jc5Q3CcahQEshyAairvEsXJLSGK2StUx9kbm4k+0WCpzTDGC9zfLpJ0l6Uxx2sQby5be2WDO267YjBoQODZ20zc/bhdVXcX/1Uli0+G51wRMbRkIBgENgQx8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=bGhoxNcM; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="bGhoxNcM"
Received: from monolith.lan (unknown [IPv6:2a03:1b20:1:f410::a01d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4fgxHq4b4VzyNR;
	Wed, 25 Mar 2026 21:07:51 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1774465672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y20s76gt0LkoZtJVzG/zUuhdZeZHPOn779EnFXc3rIo=;
	b=bGhoxNcMURlahBrzP+EwdiafWab7Y4KnyM/ilmHD2GLpFadBlMoZhAqQj4MpH8RqrKOSfD
	6y6OHIRvorDmhkt0F9Ub3gEokagA48TbhPZU5re7+XFyzBuPvpeXaKP/uMU72duGJ474v6
	EjmTy98Ap9smp5uJ5XLZDbddXyFf6eY=
ARC-Seal: i=1; a=rsa-sha256; d=iki.fi; s=meesny; cv=none; t=1774465672;
	b=u1FK6KIXtZ2GXbjWV5LorVV4qRsWUQROtPkxsQJpF/uI3p0CyRdF2aE4woyYaxOyU8ksjj
	YCpmxlcAqj6AfiCVOy/BExaHVowbJyMFSFeMWpBZZjpguuHtAYqlVYsDOlyuY+6/6qEWVS
	kJqWyxfJpg7A+lvexLLEaZcD0tuc+rE=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1774465672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=y20s76gt0LkoZtJVzG/zUuhdZeZHPOn779EnFXc3rIo=;
	b=Q1i1M7bFjUvXHPqe8umnVKGrnF/65dbsJ1ntSamYiBV/Qksp2mDR22vs9EuMwLaIKnGhQD
	jVXr84GNAjREM2nA0CLeYbbYC1lplGhZ2VPlkXHOANXr6Wzyudzp7zkk4F9XJMxNhFVTf9
	cg5nw5g+Mb2j1+JUF2bm1j/+/Zr2HWo=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>
Subject: [PATCH v2 1/4] Bluetooth: hci_sync: hci_cmd_sync_queue_once() return -EEXIST if exists
Date: Wed, 25 Mar 2026 21:07:43 +0200
Message-ID: <f7ccb4a4f9e462a6c1c1ddba8dd1cdcc9456944b.1774465559.git.pav@iki.fi>
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

Notes:
    v2: no change

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

