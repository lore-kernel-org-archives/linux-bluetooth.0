Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52ED1129A6F
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 May 2024 22:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715295050; cv=none; b=AFJ2wjqoXqSUOfW3ce4NC973VH00ul2XBZHaqXSv/fN+W483O2AADhFBs9fNbmST+RUPyFAL+cHehdjQGK+CbBxqkdjPPrMnH3OLCR1/BQvoJJheeaHAQGpbFrbZrt3oREU1AX2yP2KbkAnlCRzmdyGBKG096QAclk3q4h8Z5q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715295050; c=relaxed/simple;
	bh=KfhJ3MfCK4gpotvqoTUN1qrXO+exWpAqzuWma9SReGQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Y90M3B91C4K4ZnALauIK655QtY/mXb/JqBpZaI+VRufSO15s3LPpJuKhQBUTGBtjPtNf/7ZoNjRq7VXfoQdvvKAw7by2//MB+8sGpl9uvPYt1f8hzlmbNbw0q+WKp3kaGy6VE7FDPAp6BMk9Mmwvjiu4C7NDo5SRa6wAaVlS8yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYV3NZ33; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYV3NZ33"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4df550a4d4fso558684e0c.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 May 2024 15:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715295047; x=1715899847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kOfyYJIoupNSEo9O4amkSBenQ9g7P974dxL55eociWk=;
        b=cYV3NZ33OvKSCQRy2PP6OiqNALINi1V+q0SVdQVz0MHWTgMTjWTkIbWiUaAj82fjYf
         N9aQaHnAQ2MuMMNNw2xM7XGTyd2A3kN8BweihcKSgxyrEYWpRo31L0BUgqf4jF2jlvGC
         pXmxQAoJOoc/VKkPfwa/p23jIYE1oMsjNLVcU7/ShhmjiJWYmTqO5bbvSvjTf6heVHbx
         Gt+rUuQrzMOZAApAI3b+AXn+WNo5NFXm6AL8yyUhlo67XinXugY4JkpFcpvaOLjrrJgU
         kn6i52p9NkPcundFXzSZBQB5XqpIRERVACypLr69yaIjTKDJGHnYf4REjz2s7LbW+Uok
         lvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715295047; x=1715899847;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kOfyYJIoupNSEo9O4amkSBenQ9g7P974dxL55eociWk=;
        b=LdRIgfyUnz2UyXPiSdBpK+Zn9ruil8FQ+UULNbxaTUqIV2Rn189fus9LOUS45z/jo3
         u/pdY2MTH5pvBl59lB6/8a9ftjV4VelS3L1+mhhDhMJAgrvAqEM2kqIWgWPmqg0Ohn9u
         G6dD2LSu+rCMeuy7hWdoZDDasHK4EQ1I65w8Avo+YyR1t880t75Z/0kKgGl6h4Cv6YfC
         hmZJ6UIPMIlNNTdzH94Kj2/GNi+BsRN6FN54/apascqRbY5wB4+i1+5c08QB0Lxdf8bs
         w4LAxI+9x3Vs1xORtt0ldXzHQhlywfsJ8LW0ieGMUX7+diKmnTRqjfRZitEWopGXaQou
         Yclw==
X-Gm-Message-State: AOJu0Yx1vmBOYI+9AocUXt3rvSeozaUVyIMTd6TtJLkBhbofgtHja2xS
	WMH27y2wFDSPvEFlW0vc4XBbi/lhnZmNo6iIwBxxzlXa7JeAMl9sYqn7kg==
X-Google-Smtp-Source: AGHT+IH75AYlHqXpZsvQ2TLXJxXOuINH4TbnTI/s1irujnoREKrgh9o3v4CoFvHo3tdGLFxFnX3eYw==
X-Received: by 2002:a05:6122:3c91:b0:4d3:45a2:ae53 with SMTP id 71dfb90a1353d-4df8838b136mr1275253e0c.16.1715295045125;
        Thu, 09 May 2024 15:50:45 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4df7bfaaa4bsm303981e0c.31.2024.05.09.15.50.44
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 15:50:44 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2] Bluetooth: MGMT: Make MGMT_OP_LOAD_CONN_PARAM update existing connection
Date: Thu,  9 May 2024 18:50:43 -0400
Message-ID: <20240509225043.1357933-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.44.0
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
 net/bluetooth/hci_sync.c | 18 +++++++++++++++
 net/bluetooth/mgmt.c     | 47 ++++++++++++++++++++++++++++++++++++++--
 2 files changed, 63 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 891cae8a30da..9f8ef175c251 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6712,3 +6712,21 @@ int hci_cancel_connect_sync(struct hci_dev *hdev, struct hci_conn *conn)
 
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
index 64e66d911c74..7e81eaddba85 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -42,7 +42,7 @@
 #include "aosp.h"
 
 #define MGMT_VERSION	1
-#define MGMT_REVISION	22
+#define MGMT_REVISION	23
 
 static const u16 mgmt_commands[] = {
 	MGMT_OP_READ_INDEX_LIST,
@@ -7874,6 +7874,18 @@ static int remove_device(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
+static int conn_update_sync(struct hci_dev *hdev, void *data)
+{
+	struct hci_conn_params *params = data;
+
+	conn = hci_conn_hash_lookup_le(hdev, params->addr.bdaddr,
+				       params->addr_type);
+	if (!conn)
+		return -ECANCELED
+
+	return hci_le_conn_update_sync(hdev, conn, params);
+}
+
 static int load_conn_param(struct sock *sk, struct hci_dev *hdev, void *data,
 			   u16 len)
 {
@@ -7907,13 +7919,15 @@ static int load_conn_param(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	hci_dev_lock(hdev);
 
-	hci_conn_params_clear_disabled(hdev);
+	if (i > 1)
+		hci_conn_params_clear_disabled(hdev);
 
 	for (i = 0; i < param_count; i++) {
 		struct mgmt_conn_param *param = &cp->params[i];
 		struct hci_conn_params *hci_param;
 		u16 min, max, latency, timeout;
 		u8 addr_type;
+		bool update;
 
 		bt_dev_dbg(hdev, "Adding %pMR (type %u)", &param->addr.bdaddr,
 			   param->addr.type);
@@ -7940,6 +7954,19 @@ static int load_conn_param(struct sock *sk, struct hci_dev *hdev, void *data,
 			continue;
 		}
 
+		/* Detect when the loading is for an existing parameter then
+		 * attempt to trigger the connection update procedure.
+		 */
+		if (!i && params == 1) {
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
@@ -7951,6 +7978,22 @@ static int load_conn_param(struct sock *sk, struct hci_dev *hdev, void *data,
 		hci_param->conn_max_interval = max;
 		hci_param->conn_latency = latency;
 		hci_param->supervision_timeout = timeout;
+
+		if (update) {
+			struct hci_conn *conn;
+
+			conn = hci_conn_hash_lookup_le(hdev,
+						       params->addr.bdaddr,
+						       addr_type);
+			if (conn && conn->role == HCI_ROLE_MASTER &&
+			    (conn->le_conn_min_interval != min ||
+			     conn->le_conn_max_interval != max ||
+			     conn->le_conn_latency != latency ||
+			     conn->le_supervision_timeout != timeout))
+				hci_cmd_sync_queue(hdev, conn_update_sync,
+						   hci_params, NULL);
+			}
+		}
 	}
 
 	hci_dev_unlock(hdev);
-- 
2.44.0

