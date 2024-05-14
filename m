Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045792AD1C
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 17:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715709114; cv=none; b=DV4X/smPlQtQhOHpxNw6wgWzXtTerUlHIIWa77bjdWmASUuarywef6Yv33coQcaoofcUPrU66EGY1srtTJO9qon2NGsL5MO7Ce2JbxYn4qzp7277MgOGIVq3RLvyM9Ny2+U5nF2geDnv0dLX/GXOyWVmmBxnSWdLMyJbvURPnss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715709114; c=relaxed/simple;
	bh=AEOU0U6jeaXxFBZ3bKXRrMlqPaEvTdWfr/QyuxhQTgA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=fHjdzuDsrWRsjRWmTE8vo5pjzCvxA1uX59jDnF68FV84MtfvmrNSgZ7ianyN5jJYbXpE3fg5PNfUXF4bcYLMg4UvCptxTnOFLA88woqwKcBmih7JewPOCFaNPPdoSKgB4EjQsZLP9VdlNc4ZDl3MraE06u9j11Y4e4azETvLl60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DRlGSN87; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DRlGSN87"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-4df265f634aso1945969e0c.3
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 10:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715709111; x=1716313911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=mWlC8lI6JXcHEKdr/rz0Yn/W6YwjmqRzmlY9wQs3tII=;
        b=DRlGSN87KyCYMEO1eHJ8ry2V0mp3ZTujHCtCE6DRaIk0s8cBKUJuFKQU36yDhwSLpM
         JJQPX4xHlxkgVc1ZitEeeljordxsNhCo/694yfkjHnkkyecUCdkQZvedGmQpNpqnre/a
         pnDa1PBVXF+RDrnqCgaOyV7dG/edgCHuoZ0wigTZsiMml+RwMhLL6nRZjnQpvm3633eW
         iXsbEemhHE1ywiRUCGe7Pz0bMCZ/jpFO0gGN9vpdeY2ZvKDEJ4UeJY+78NtwmM4G9blr
         pkzgeO5oCYBC/xvBqp2fnGmEORhQKbRgy9TYySj1OwShVGttQm/5qVoIaNKN5GOcJWEB
         t1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715709111; x=1716313911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mWlC8lI6JXcHEKdr/rz0Yn/W6YwjmqRzmlY9wQs3tII=;
        b=V92V9WsIaBD2VC40sFZ1RqpyidyCzd3HmbXmTml3wD1sj37/1+1NYDwGQr2GzhVLfc
         ko21FzXBmpCux1x2i/TUst0MIxdmcO3ez476snLKKyCC2h4nGSQ8NsBUWT7vm8hkXPM0
         ojWLE0u4YXh+B6J4NjeKZQAsdpN/5hkK+NVAVt77uVmg4iDl+dV/HKKz/c2E5O0rvNDo
         QJ4kLoBOiJsyEnVYwjLl0m41oMZUi0aCa34V3ZdPN9m5iJJql+UEMA2BGrjfQ3fqjVvU
         c4Blbm57idsvVupra+dGqdRna2Lt4ff3YjyqRVbukVydvZXDr/Fg/60iDpgz/gDYs1Hb
         GOag==
X-Gm-Message-State: AOJu0YzfvKuXs1f/q6O6uAJB1g+vUEflYzrLb6ZkBMIueFbtQMfxvyyO
	HMyRi/lioi6m61Xfkjy/0XDLxiQCaCOtOrkwvgETPq+zWduKjB1H/OwfDbrO
X-Google-Smtp-Source: AGHT+IE1Zd3yPYbTkiTJRh+hp4u+/WXOC/vqywUHktiX6tOvX6GgxbWwQJ4HJ3GeUfC0nJSOl+jidQ==
X-Received: by 2002:a05:6102:4193:b0:47c:2fb2:8b99 with SMTP id ada2fe7eead31-48077de327fmr13341106137.20.1715709111030;
        Tue, 14 May 2024 10:51:51 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-7f8ffa01134sm1630195241.10.2024.05.14.10.51.49
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 10:51:50 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v5] Bluetooth: MGMT: Make MGMT_OP_LOAD_CONN_PARAM update existing connection
Date: Tue, 14 May 2024 13:51:49 -0400
Message-ID: <20240514175149.752522-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This makes MGMT_OP_LOAD_CONN_PARAM update existing connection by
dectecting the request is just for one connection, parameters already
exists and there is a connection.

Since this is a new behavior the revision is also updated to enable
userspace to detect it.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_sync.h |  3 ++
 net/bluetooth/hci_sync.c         | 18 ++++++++++++
 net/bluetooth/mgmt.c             | 50 ++++++++++++++++++++++++++++++--
 3 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 6a9d063e9f47..b49057bbdf23 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -136,6 +136,7 @@ int hci_suspend_sync(struct hci_dev *hdev);
 int hci_resume_sync(struct hci_dev *hdev);
 
 struct hci_conn;
+struct hci_conn_params;
 
 int hci_abort_conn_sync(struct hci_dev *hdev, struct hci_conn *conn, u8 reason);
 
@@ -154,3 +155,5 @@ int hci_connect_acl_sync(struct hci_dev *hdev, struct hci_conn *conn);
 int hci_connect_le_sync(struct hci_dev *hdev, struct hci_conn *conn);
 
 int hci_cancel_connect_sync(struct hci_dev *hdev, struct hci_conn *conn);
+int hci_le_conn_update_sync(struct hci_dev *hdev, struct hci_conn *conn,
+			    struct hci_conn_params *params);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 16daa79b7981..353de476a5cd 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6711,3 +6711,21 @@ int hci_cancel_connect_sync(struct hci_dev *hdev, struct hci_conn *conn)
 
 	return -ENOENT;
 }
+
+int hci_le_conn_update_sync(struct hci_dev *hdev, struct hci_conn *conn,
+			    struct hci_conn_params *params)
+{
+	struct hci_cp_le_conn_update cp;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.handle		= cpu_to_le16(conn->handle);
+	cp.conn_interval_min	= cpu_to_le16(params->conn_min_interval);
+	cp.conn_interval_max	= cpu_to_le16(params->conn_max_interval);
+	cp.conn_latency		= cpu_to_le16(params->conn_latency);
+	cp.supervision_timeout	= cpu_to_le16(params->supervision_timeout);
+	cp.min_ce_len		= cpu_to_le16(0x0000);
+	cp.max_ce_len		= cpu_to_le16(0x0000);
+
+	return __hci_cmd_sync_status(hdev, HCI_OP_LE_CONN_UPDATE,
+				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
+}
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 80f220b7e19d..20eca8a9c681 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -42,7 +42,7 @@
 #include "aosp.h"
 
 #define MGMT_VERSION	1
-#define MGMT_REVISION	22
+#define MGMT_REVISION	23
 
 static const u16 mgmt_commands[] = {
 	MGMT_OP_READ_INDEX_LIST,
@@ -7813,6 +7813,18 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
+static int conn_update_sync(struct hci_dev *hdev, void *data)
+{
+	struct hci_conn_params *params = data;
+	struct hci_conn *conn;
+
+	conn = hci_conn_hash_lookup_le(hdev, &params->addr, params->addr_type);
+	if (!conn)
+		return -ECANCELED;
+
+	return hci_le_conn_update_sync(hdev, conn, params);
+}
+
 static int load_conn_param(struct sock *sk, struct hci_dev *hdev, void *data,
 			   u16 len)
 {
@@ -7846,13 +7858,15 @@ static int load_conn_param(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
-	hci_conn_params_clear_disabled(hdev);
+	if (param_count > 1)
+		hci_conn_params_clear_disabled(hdev);
 
 	for (i = 0; i < param_count; i++) {
 		struct mgmt_conn_param *param = &cp->params[i];
 		struct hci_conn_params *hci_param;
 		u16 min, max, latency, timeout;
 		u8 addr_type;
+		bool update;
 
 		bt_dev_dbg(hdev, "Adding %pMR (type %u)", &param->addr.bdaddr,
 			   param->addr.type);
@@ -7879,6 +7893,19 @@ static int load_conn_param(struct sock *sk, struct hci_dev *hdev, void *data,
 			continue;
 		}
 
+		/* Detect when the loading is for an existing parameter then
+		 * attempt to trigger the connection update procedure.
+		 */
+		if (!i && param_count == 1) {
+			hci_param = hci_conn_params_lookup(hdev,
+							   &param->addr.bdaddr,
+							   addr_type);
+			if (hci_param)
+				update = true;
+			else
+				hci_conn_params_clear_disabled(hdev);
+		}
+
 		hci_param = hci_conn_params_add(hdev, &param->addr.bdaddr,
 						addr_type);
 		if (!hci_param) {
@@ -7890,6 +7917,25 @@ static int load_conn_param(struct sock *sk, struct hci_dev *hdev, void *data,
 		hci_param->conn_max_interval = max;
 		hci_param->conn_latency = latency;
 		hci_param->supervision_timeout = timeout;
+
+		/* Check if we need to trigger a connection update */
+		if (update) {
+			struct hci_conn *conn;
+
+			/* Lookup for existing connection as central and check
+			 * if parameters match and if they don't then trigger
+			 * a connection update.
+			 */
+			conn = hci_conn_hash_lookup_le(hdev, &hci_param->addr,
+						       addr_type);
+			if (conn && conn->role == HCI_ROLE_MASTER &&
+			    (conn->le_conn_min_interval != min ||
+			     conn->le_conn_max_interval != max ||
+			     conn->le_conn_latency != latency ||
+			     conn->le_supv_timeout != timeout))
+				hci_cmd_sync_queue(hdev, conn_update_sync,
+						   hci_param, NULL);
+		}
 	}
 
 	hci_dev_unlock(hdev);
-- 
2.45.0

