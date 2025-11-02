Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17722D9482;
	Sun,  2 Nov 2025 16:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=195.140.195.201
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762100592; cv=pass; b=MR+indJbdRkmYcJE8HkX7hcrMrvk2cRS0y8qm+495jpm4Acqd24Z4Xbd8ccWDqNq21SJz9Wj31bjOxeUHIwJDal1FzqghjgtODL+qSuWFAK3ToEIuQ0fPigvesjL+/21f0oqIJ0/U8WiKILozOm08v7OdNRq9u+VC1B37vpO5wg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762100592; c=relaxed/simple;
	bh=vqHSxlN8vW0IkYc9EJdmBchIKyWnN2BFQ2urrmra6ZI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z9zZ0WkeOPoBi5WUJHKOuzmpslQRNLGiPxiCFRrLF/ngo8vy95sTSmAFgArWO2EL79Tau0GiY8d3rgWfCLYJVfMbp/wK4T5u5qovuNVgxQX6RUCWwO+nZ+A340S+zGGPfd96dc6xAreS2XWcIe8tRbiuJ+gdEtfazSw7RYfqNr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi; spf=pass smtp.mailfrom=iki.fi; dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b=ooPYsFBj; arc=pass smtp.client-ip=195.140.195.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iki.fi
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iki.fi
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iki.fi header.i=@iki.fi header.b="ooPYsFBj"
Received: from monolith.lan (unknown [IPv6:2a02:ed04:3581:1::d001])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pav)
	by meesny.iki.fi (Postfix) with ESMTPSA id 4d00Pg1dVkz1064;
	Sun,  2 Nov 2025 18:23:03 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
	t=1762100583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bp0L8CrmTikzBpE/RQPCqJwcoGrZ9MB/Tpu/IkmyOiI=;
	b=ooPYsFBjXYBKBPevx7ySOJKLVRHr+0Ey3veZomA3VdYQZQlsghNrIbokARz4mc/xmGDSbL
	Zh0BP7ikFNRRItzKQNvsmemk4i/IBJnNuWccr5UTKQ5XSF4btlo2pP48tsxa8sIhqkR/Zb
	wJyvWx+scCBpB6JMkyEn2yeZPV72QYY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
	s=meesny; t=1762100583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bp0L8CrmTikzBpE/RQPCqJwcoGrZ9MB/Tpu/IkmyOiI=;
	b=aBBZSbSqKcotsgm7DPczOniUwJuQ89rsqxgY6yMHxSm42WHlnTq1VrGkbasU+UTfSEpO7R
	AP5fU033idhVw+c7Fi3JCj3mFFPy2meGHRl5+f6BgC+QhukOD5rNKAaa5JoyWGdym2MxvS
	s6Ac8DAvzx+DJU+Dji97IlzE9RlVaq0=
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pav smtp.mailfrom=pav@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1762100583; a=rsa-sha256; cv=none;
	b=wbc4d0UsTBtEJaa5gTLsqvJXVQc4tVy7WF8F14IKfBhp+eoPw7Dp9Gt+vqCm47o29Q7B4w
	CtqL/5eegG8ZOveCdwbdHiSqoLUI1oTFgN7ftsAQ9gepLZqFJv62UbmbK/CONe+FGQA40o
	KE+O/QvUSRzV9LBq37mkLFlQGlc3e7I=
From: Pauli Virtanen <pav@iki.fi>
To: linux-bluetooth@vger.kernel.org
Cc: Pauli Virtanen <pav@iki.fi>,
	marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 8/8] Bluetooth: hci_sync: hold references in hci_sync callbacks
Date: Sun,  2 Nov 2025 18:19:40 +0200
Message-ID: <e18591f264c50e15917cb8b9e5f9798d9880979d.1762100290.git.pav@iki.fi>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <cover.1762100290.git.pav@iki.fi>
References: <cover.1762100290.git.pav@iki.fi>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hci_conn_valid() should not be used on potentially freed hci_conn
pointers, as relying on kmalloc not reusing addresses is bad practice.

Hold a hci_conn reference for queued jobs so the pointers are not freed
too early.

This also avoids potential UAF if the conn would be freed while the jobs
are running.

Signed-off-by: Pauli Virtanen <pav@iki.fi>
---

Notes:
    v2:
    - fix also hci_past_sync()

 net/bluetooth/hci_sync.c | 66 +++++++++++++++++++++++++++++++---------
 1 file changed, 51 insertions(+), 15 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index dc95a1ebe65e..d4420d5882d6 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6962,12 +6962,23 @@ static int hci_acl_create_conn_sync(struct hci_dev *hdev, void *data)
 					conn->conn_timeout, NULL);
 }
 
+static void hci_acl_create_conn_sync_complete(struct hci_dev *hdev, void *data,
+					      int err)
+{
+	struct hci_conn *conn = data;
+
+	hci_conn_put(conn);
+}
+
 int hci_connect_acl_sync(struct hci_dev *hdev, struct hci_conn *conn)
 {
 	int err;
 
-	err = hci_cmd_sync_queue_once(hdev, hci_acl_create_conn_sync, conn,
-				      NULL);
+	err = hci_cmd_sync_queue_once(hdev, hci_acl_create_conn_sync,
+				      hci_conn_get(conn),
+				      hci_acl_create_conn_sync_complete);
+	if (err)
+		hci_conn_put(conn);
 	return (err == -EEXIST) ? 0 : err;
 }
 
@@ -6978,36 +6989,41 @@ static void create_le_conn_complete(struct hci_dev *hdev, void *data, int err)
 	bt_dev_dbg(hdev, "err %d", err);
 
 	if (err == -ECANCELED)
-		return;
+		goto done;
 
 	hci_dev_lock(hdev);
 
 	if (!hci_conn_valid(hdev, conn))
-		goto done;
+		goto unlock;
 
 	if (!err) {
 		hci_connect_le_scan_cleanup(conn, 0x00);
-		goto done;
+		goto unlock;
 	}
 
 	/* Check if connection is still pending */
 	if (conn != hci_lookup_le_connect(hdev))
-		goto done;
+		goto unlock;
 
 	/* Flush to make sure we send create conn cancel command if needed */
 	flush_delayed_work(&conn->le_conn_timeout);
 	hci_conn_failed(conn, bt_status(err));
 
-done:
+unlock:
 	hci_dev_unlock(hdev);
+done:
+	hci_conn_put(conn);
 }
 
 int hci_connect_le_sync(struct hci_dev *hdev, struct hci_conn *conn)
 {
 	int err;
 
-	err = hci_cmd_sync_queue_once(hdev, hci_le_create_conn_sync, conn,
+	err = hci_cmd_sync_queue_once(hdev, hci_le_create_conn_sync,
+				      hci_conn_get(conn),
 				      create_le_conn_complete);
+	if (err)
+		hci_conn_put(conn);
 	return (err == -EEXIST) ? 0 : err;
 }
 
@@ -7055,7 +7071,7 @@ static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
 	bt_dev_dbg(hdev, "err %d", err);
 
 	if (err == -ECANCELED)
-		return;
+		goto done;
 
 	hci_dev_lock(hdev);
 
@@ -7079,6 +7095,8 @@ static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
 
 unlock:
 	hci_dev_unlock(hdev);
+done:
+	hci_conn_put(conn);
 }
 
 static int hci_le_past_params_sync(struct hci_dev *hdev, struct hci_conn *conn,
@@ -7217,8 +7235,11 @@ int hci_connect_pa_sync(struct hci_dev *hdev, struct hci_conn *conn)
 {
 	int err;
 
-	err = hci_cmd_sync_queue_once(hdev, hci_le_pa_create_sync, conn,
+	err = hci_cmd_sync_queue_once(hdev, hci_le_pa_create_sync,
+				      hci_conn_get(conn),
 				      create_pa_complete);
+	if (err)
+		hci_conn_put(conn);
 	return (err == -EEXIST) ? 0 : err;
 }
 
@@ -7229,10 +7250,17 @@ static void create_big_complete(struct hci_dev *hdev, void *data, int err)
 	bt_dev_dbg(hdev, "err %d", err);
 
 	if (err == -ECANCELED)
-		return;
+		goto done;
+
+	hci_dev_lock(hdev);
 
 	if (hci_conn_valid(hdev, conn))
 		clear_bit(HCI_CONN_CREATE_BIG_SYNC, &conn->flags);
+
+	hci_dev_unlock(hdev);
+
+done:
+	hci_conn_put(conn);
 }
 
 static int hci_le_big_create_sync(struct hci_dev *hdev, void *data)
@@ -7283,8 +7311,11 @@ int hci_connect_big_sync(struct hci_dev *hdev, struct hci_conn *conn)
 {
 	int err;
 
-	err = hci_cmd_sync_queue_once(hdev, hci_le_big_create_sync, conn,
+	err = hci_cmd_sync_queue_once(hdev, hci_le_big_create_sync,
+				      hci_conn_get(conn),
 				      create_big_complete);
+	if (err)
+		hci_conn_put(conn);
 	return (err == -EEXIST) ? 0 : err;
 }
 
@@ -7299,6 +7330,8 @@ static void past_complete(struct hci_dev *hdev, void *data, int err)
 
 	bt_dev_dbg(hdev, "err %d", err);
 
+	hci_conn_put(past->conn);
+	hci_conn_put(past->le);
 	kfree(past);
 }
 
@@ -7363,8 +7396,8 @@ int hci_past_sync(struct hci_conn *conn, struct hci_conn *le)
 	if (!data)
 		return -ENOMEM;
 
-	data->conn = conn;
-	data->le = le;
+	data->conn = hci_conn_get(conn);
+	data->le = hci_conn_get(le);
 
 	if (conn->role == HCI_ROLE_MASTER)
 		err = hci_cmd_sync_queue_once(conn->hdev,
@@ -7374,8 +7407,11 @@ int hci_past_sync(struct hci_conn *conn, struct hci_conn *le)
 		err = hci_cmd_sync_queue_once(conn->hdev, hci_le_past_sync,
 					      data, past_complete);
 
-	if (err)
+	if (err) {
+		hci_conn_put(data->conn);
+		hci_conn_put(data->le);
 		kfree(data);
+	}
 
 	return (err == -EEXIST) ? 0 : err;
 }
-- 
2.51.1

