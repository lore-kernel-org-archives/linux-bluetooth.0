Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7419E6166F
	for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 21:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707859896; cv=none; b=U0CToWutVQOw/kmCjQIX/iB35CkOX/Cds1E/dqQoBzZRzz/OBpA8oEUV+WpLK6XMkdVlSMGGwD5F3LtnJfH6X0/XebuvNELKDtmSKNKybYNruxtoZZP+ZFUaj+27nml51fe1HTb8g2xDy8TGsI8fsyZJ4428IuQQAbW7bJPrg3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707859896; c=relaxed/simple;
	bh=eIKX3kk9+dW8mnlgdH05jIMejrwkZamkAWRt2dKv45M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cg86f1OCJHGU504ZpxXDMDgjFz3Sj5eFLCfV6h8GIu+gbe1Vlp7iWhAwn1opZI/8hJ3uMR5C8bGy4mEaA8JFlB+pM5aTxvdg0qKw1vsEJ8HkhTzUIS/RLIT1fBYmsl5XLgPqMO9Ciifk7fxttywn6hTH0KO7ZGPpDwuwmpM/Cl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bDbTzR5/; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bDbTzR5/"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4c01076b9faso1964392e0c.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 13 Feb 2024 13:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707859891; x=1708464691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qBhU2A09Gj11oXeShG+AaIzedAY0jeL75ZF9962FcTo=;
        b=bDbTzR5/rRv4Qr/DNJJhyHnk2LpcBPypB6TSCRT+0wKMO3Gn+SaKhXH3F4YlqGLdGN
         MbnqtieRUix300Ae1aTo2ac18B/ko1n/dPiQSRlsBeq9mnriBKwzR5+MivBUYJ7JE10P
         Xr8K0pD5C7+rnmlbDbCM5SYR1SBa0OZteYr4J1Gizm6XukPkQ+/q1nSj2Jpfxn42xbyj
         jVK7AsN0JdvFRoIB2JWH6qTuWfgp0WkNOdvjQd4YPOtruIrVQh1fspuF+EmZq/xWP2Yy
         pdy8xS/p50Ot1Ax3NAbd6j9/zb3Pbf8iLdSt3OWLsDbgUqVGvd+9yzlrdh2hpyjuPnD5
         BJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707859891; x=1708464691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qBhU2A09Gj11oXeShG+AaIzedAY0jeL75ZF9962FcTo=;
        b=Q58qVUF1pYsPeVmaZTN02oUNJ76gQ5KRKkonJoIONX4envSOrssxs53cL4TFUT6Opg
         AfIs9RYPr0hc9V4REsqdDnomqf8Xf04CAPBKVKkGH3CVa1u5Y017n1okY5VoIbu9mRnL
         IEYrINd1Q2MzThtw4MV/3Nfbp5pz/1nURcc1zeZT/oSw/qB0It5eAHhBKLFneZCnSMGv
         I+hf/qg88WToSlcV0+nQ7VfUBohUhEDsQu2X7ZRcuba95Sacy093bOSxns5R6B3hX5Cp
         csYWDvuny40uoCMxiFLFgCsesVMw0iMwK6Y3Q0C1LXDElZAgYS814qVTGhmhdcebH/iY
         iESw==
X-Gm-Message-State: AOJu0YwrgfSzolNvHNfCa5HGUj8QpNa7XnKoSqkpH0BdM4RbBpENGTsV
	5MYO4V6f+6V3rhnohEC283RSQSgBZf6TDIxw/79rkq15q2WkriTfBP6wVQHC
X-Google-Smtp-Source: AGHT+IHlHR5wIXkkDXlPuchmGG/VWDbhrP3FmR8lnmStv2R06IjqS+l87e/scLJJGrnVQtv2N78vBw==
X-Received: by 2002:a1f:e602:0:b0:4c0:2dd6:7823 with SMTP id d2-20020a1fe602000000b004c02dd67823mr870611vkh.9.1707859891027;
        Tue, 13 Feb 2024 13:31:31 -0800 (PST)
Received: from lvondent-mobl4.. (071-047-239-151.res.spectrum.com. [71.47.239.151])
        by smtp.gmail.com with ESMTPSA id z8-20020a056122148800b004c0149262dcsm1049837vkp.4.2024.02.13.13.31.28
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 13:31:28 -0800 (PST)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/3] Bluetooth: hci_sync: Attempt to dequeue connection attempt
Date: Tue, 13 Feb 2024 16:31:23 -0500
Message-ID: <20240213213123.403654-3-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213213123.403654-1-luiz.dentz@gmail.com>
References: <20240213213123.403654-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If connection is still queued/pending in the cmd_sync queue it means no
command has been generated and it should be safe to just dequeue the
callback when it is being aborted.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h | 19 ++++++++
 include/net/bluetooth/hci_sync.h | 10 +++--
 net/bluetooth/hci_conn.c         | 70 ++++++------------------------
 net/bluetooth/hci_sync.c         | 74 ++++++++++++++++++++++++++++----
 4 files changed, 102 insertions(+), 71 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 2bdea85b7c44..317d495cfcf5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1083,6 +1083,24 @@ static inline unsigned int hci_conn_count(struct hci_dev *hdev)
 	return c->acl_num + c->amp_num + c->sco_num + c->le_num + c->iso_num;
 }
 
+static inline bool hci_conn_valid(struct hci_dev *hdev, struct hci_conn *conn)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn  *c;
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(c, &h->list, list) {
+		if (c == conn) {
+			rcu_read_unlock();
+			return true;
+		}
+	}
+	rcu_read_unlock();
+
+	return false;
+}
+
 static inline __u8 hci_conn_lookup_type(struct hci_dev *hdev, __u16 handle)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
@@ -1493,6 +1511,7 @@ struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
 struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 				u8 dst_type, bool dst_resolved, u8 sec_level,
 				u16 conn_timeout, u8 role);
+void hci_connect_le_scan_cleanup(struct hci_conn *conn, u8 status);
 struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 				 u8 sec_level, u8 auth_type,
 				 enum conn_reasons conn_reason, u16 timeout);
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 4ff4aa68ee19..6a9d063e9f47 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -48,11 +48,11 @@ int hci_cmd_sync_submit(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 			void *data, hci_cmd_sync_work_destroy_t destroy);
 int hci_cmd_sync_queue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 		       void *data, hci_cmd_sync_work_destroy_t destroy);
+int hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
+			    void *data, hci_cmd_sync_work_destroy_t destroy);
 struct hci_cmd_sync_work_entry *
 hci_cmd_sync_lookup_entry(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
 			  void *data, hci_cmd_sync_work_destroy_t destroy);
-int hci_cmd_sync_queue_once(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
-			    void *data, hci_cmd_sync_work_destroy_t destroy);
 void hci_cmd_sync_cancel_entry(struct hci_dev *hdev,
 			       struct hci_cmd_sync_work_entry *entry);
 bool hci_cmd_sync_dequeue(struct hci_dev *hdev, hci_cmd_sync_work_func_t func,
@@ -139,8 +139,6 @@ struct hci_conn;
 
 int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason);
 
-int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn);
-
 int hci_le_create_cis_sync(struct hci_dev *hdev);
 
 int hci_le_remove_cig_sync(struct hci_dev *hdev, u8 handle);
@@ -152,3 +150,7 @@ int hci_le_big_terminate_sync(struct hci_dev *hdev, u8 handle);
 int hci_le_pa_terminate_sync(struct hci_dev *hdev, u16 handle);
 
 int hci_connect_acl_sync(struct hci_dev *hdev, struct hci_conn *conn);
+
+int hci_connect_le_sync(struct hci_dev *hdev, struct hci_conn *conn);
+
+int hci_cancel_connect_sync(struct hci_dev *hdev, struct hci_conn *conn);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 587eb27f374c..21e0b4064d05 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -68,7 +68,7 @@ static const struct sco_param esco_param_msbc[] = {
 };
 
 /* This function requires the caller holds hdev->lock */
-static void hci_connect_le_scan_cleanup(struct hci_conn *conn, u8 status)
+void hci_connect_le_scan_cleanup(struct hci_conn *conn, u8 status)
 {
 	struct hci_conn_params *params;
 	struct hci_dev *hdev = conn->hdev;
@@ -1124,6 +1124,9 @@ void hci_conn_del(struct hci_conn *conn)
 	 * rest of hci_conn_del.
 	 */
 	hci_conn_cleanup(conn);
+
+	/* Dequeue callbacks using connection pointer as data */
+	hci_cmd_sync_dequeue(hdev, NULL, conn, NULL);
 }
 
 struct hci_dev *hci_get_route(bdaddr_t *dst, bdaddr_t *src, uint8_t src_type)
@@ -1258,53 +1261,6 @@ u8 hci_conn_set_handle(struct hci_conn *conn, u16 handle)
 	return 0;
 }
 
-static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
-{
-	struct hci_conn *conn;
-	u16 handle = PTR_UINT(data);
-
-	conn = hci_conn_hash_lookup_handle(hdev, handle);
-	if (!conn)
-		return;
-
-	bt_dev_dbg(hdev, "err %d", err);
-
-	hci_dev_lock(hdev);
-
-	if (!err) {
-		hci_connect_le_scan_cleanup(conn, 0x00);
-		goto done;
-	}
-
-	/* Check if connection is still pending */
-	if (conn != hci_lookup_le_connect(hdev))
-		goto done;
-
-	/* Flush to make sure we send create conn cancel command if needed */
-	flush_delayed_work(&conn->le_conn_timeout);
-	hci_conn_failed(conn, bt_status(err));
-
-done:
-	hci_dev_unlock(hdev);
-}
-
-static int hci_connect_le_sync(struct hci_dev *hdev, void *data)
-{
-	struct hci_conn *conn;
-	u16 handle = PTR_UINT(data);
-
-	conn = hci_conn_hash_lookup_handle(hdev, handle);
-	if (!conn)
-		return 0;
-
-	bt_dev_dbg(hdev, "conn %p", conn);
-
-	clear_bit(HCI_CONN_SCANNING, &conn->flags);
-	conn->state = BT_CONNECT;
-
-	return hci_le_create_conn_sync(hdev, conn);
-}
-
 struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 				u8 dst_type, bool dst_resolved, u8 sec_level,
 				u16 conn_timeout, u8 role)
@@ -1371,9 +1327,7 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	conn->sec_level = BT_SECURITY_LOW;
 	conn->conn_timeout = conn_timeout;
 
-	err = hci_cmd_sync_queue(hdev, hci_connect_le_sync,
-				 UINT_PTR(conn->handle),
-				 create_le_conn_complete);
+	err = hci_connect_le_sync(hdev, conn);
 	if (err) {
 		hci_conn_del(conn);
 		return ERR_PTR(err);
@@ -2909,12 +2863,10 @@ u32 hci_conn_get_phy(struct hci_conn *conn)
 
 static int abort_conn_sync(struct hci_dev *hdev, void *data)
 {
-	struct hci_conn *conn;
-	u16 handle = PTR_UINT(data);
+	struct hci_conn *conn = data;
 
-	conn = hci_conn_hash_lookup_handle(hdev, handle);
-	if (!conn)
-		return 0;
+	if (!hci_conn_valid(hdev, conn))
+		return -ECANCELED;
 
 	return hci_abort_conn_sync(hdev, conn, conn->abort_reason);
 }
@@ -2949,8 +2901,10 @@ int hci_abort_conn(struct hci_conn *conn, u8 reason)
 			hci_cmd_sync_cancel(hdev, -ECANCELED);
 			break;
 		}
+	/* Cancel connect attempt if still queued/pending */
+	} else if (!hci_cancel_connect_sync(hdev, conn)) {
+		return 0;
 	}
 
-	return hci_cmd_sync_queue(hdev, abort_conn_sync, UINT_PTR(conn->handle),
-				  NULL);
+	return hci_cmd_sync_queue_once(hdev, abort_conn_sync, conn, NULL);
 }
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 5b314bf844f8..b7d8e99e2a30 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6285,12 +6285,21 @@ static int hci_le_ext_create_conn_sync(struct hci_dev *hdev,
 					conn->conn_timeout, NULL);
 }
 
-int hci_le_create_conn_sync(struct hci_dev *hdev, struct hci_conn *conn)
+static int hci_le_create_conn_sync(struct hci_dev *hdev, void *data)
 {
 	struct hci_cp_le_create_conn cp;
 	struct hci_conn_params *params;
 	u8 own_addr_type;
 	int err;
+	struct hci_conn *conn = data;
+
+	if (!hci_conn_valid(hdev, conn))
+		return -ECANCELED;
+
+	bt_dev_dbg(hdev, "conn %p", conn);
+
+	clear_bit(HCI_CONN_SCANNING, &conn->flags);
+	conn->state = BT_CONNECT;
 
 	/* If requested to connect as peripheral use directed advertising */
 	if (conn->role == HCI_ROLE_SLAVE) {
@@ -6611,16 +6620,11 @@ int hci_update_adv_data(struct hci_dev *hdev, u8 instance)
 
 static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
 {
-	struct hci_conn *conn;
-	u16 handle = PTR_UINT(data);
+	struct hci_conn *conn = data;
 	struct inquiry_entry *ie;
 	struct hci_cp_create_conn cp;
 	int err;
 
-	conn = hci_conn_hash_lookup_handle(hdev, handle);
-	if (!conn)
-		return 0;
-
 	/* Many controllers disallow HCI Create Connection while it is doing
 	 * HCI Inquiry. So we cancel the Inquiry first before issuing HCI Create
 	 * Connection. This may cause the MGMT discovering state to become false
@@ -6679,6 +6683,58 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
 
 int hci_connect_acl_sync(struct hci_dev *hdev, struct hci_conn *conn)
 {
-	return hci_cmd_sync_queue(hdev, hci_acl_create_conn_sync,
-				  UINT_PTR(conn->handle), NULL);
+	return hci_cmd_sync_queue_once(hdev, hci_acl_create_conn_sync, conn,
+				       NULL);
+}
+
+static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
+{
+	struct hci_conn *conn = data;
+
+	bt_dev_dbg(hdev, "err %d", err);
+
+	if (err == -ECANCELED)
+		return;
+
+	hci_dev_lock(hdev);
+
+	if (!err) {
+		hci_connect_le_scan_cleanup(conn, 0x00);
+		goto done;
+	}
+
+	/* Check if connection is still pending */
+	if (conn != hci_lookup_le_connect(hdev))
+		goto done;
+
+	/* Flush to make sure we send create conn cancel command if needed */
+	flush_delayed_work(&conn->le_conn_timeout);
+	hci_conn_failed(conn, bt_status(err));
+
+done:
+	hci_dev_unlock(hdev);
+}
+
+int hci_connect_le_sync(struct hci_dev *hdev, struct hci_conn *conn)
+{
+	return hci_cmd_sync_queue_once(hdev, hci_le_create_conn_sync, conn,
+				       create_le_conn_complete);
+}
+
+int hci_cancel_connect_sync(struct hci_dev *hdev, struct hci_conn *conn)
+{
+	if (conn->state != BT_OPEN)
+		return -EINVAL;
+
+	switch (conn->type) {
+	case ACL_LINK:
+		return !hci_cmd_sync_dequeue_once(hdev,
+						  hci_acl_create_conn_sync,
+						  conn, NULL);
+	case LE_LINK:
+		return !hci_cmd_sync_dequeue_once(hdev, hci_le_create_conn_sync,
+						  conn, create_le_conn_complete);
+	}
+
+	return -ENOENT;
 }
-- 
2.43.0

