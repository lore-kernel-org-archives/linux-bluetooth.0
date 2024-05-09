Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D95D2E6
	for <linux-bluetooth@vger.kernel.org>; Thu,  9 May 2024 20:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715288350; cv=none; b=YbwD+Zt7KNulgLy7zLotAgnmKor2Tad8KKqEyXt5Zr6wZUlG4mnGsBPCSCZAzydr8nHT1brUSKXO2RmlB/NfUV2eztNNQWwOMbW3S5MjoI6OPjr9wUr67JBGHqB0C9yRaHf2J+tNe4bI8/PqYz2CdV565TWCmI89J+gGMq2TFwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715288350; c=relaxed/simple;
	bh=KfhJ3MfCK4gpotvqoTUN1qrXO+exWpAqzuWma9SReGQ=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Y8rk64iEKnuT6oevpm843a5/uE765p2ppTCbn+eRRnxVbOq6fUYLqLbwcuRNJEh2Z4Gv8eUpJyqKuYSDHvJLDOLmdoiR5WPYDbWuMmEgGYojRv62cuWEb9wjox+5/NQgrjS6L+sJd07rJ9I7QcjEuAacWCV0YPNIkPVW6694tNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G68L8g6K; arc=none smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G68L8g6K"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-47f01423c30so392749137.2
        for <linux-bluetooth@vger.kernel.org>; Thu, 09 May 2024 13:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715288347; x=1715893147; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=kOfyYJIoupNSEo9O4amkSBenQ9g7P974dxL55eociWk=;
        b=G68L8g6KFPyFKD4sG3w/3zfC7aT/bLiXWNpc1n8gRI6RCsiEKNd4Uqt8ABrhIxZhq9
         6XADLMSNyWevvmxHMLkrHQ15WDuQO7xTZCBxjohcaezaNvXlkO/s9a+07cMQGgbcHcxC
         CR0VQKgm72yLcL8VI48vj7sMpcvh8L3QeqzU/yQNQagkdXPBG256J17Fj2XhX8XkpL3g
         qKvAHAk1mwtV5xm7gzoyODRpiTckNjgLjISZgzhwvhE2fiLLH5H0Tn/CRkh1g2U+ebzS
         cu5j+a316U3rGOmNbNhMWpnADKTmxOpSDcjs7XydHy85e9Fb6xwQqLRo0hooc7qXVo9G
         V3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715288347; x=1715893147;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kOfyYJIoupNSEo9O4amkSBenQ9g7P974dxL55eociWk=;
        b=PxHVFVYtwfP31RlBAYg53Z3AactAeHfHdcZcUZAwRAiIry2/KP8u7RdsfrycAVH9Kv
         BzyLyRf7PpyVTVdN6I+hUgxnh6QknbOBjoAxZns0goIKPDVExsPc0Drv95RKmXEbeEnA
         IKyibl3a0N+qnbs2j2I0ul1NHHvbIMuU174NepGomDW68JRYr9yCmrT8PvqhoGuNfgzH
         mRZT6BwYU4hDD7i/LM/NB4t5oZ9JyYbk93dE+Wn+L6+QMBbot2UmBMCD4yP7VIOWRPSq
         4xV/2/gJhanG0hB79fggkB2inxCvI/1/TQVX9XlmBu5oeMHx2Lrotj83L+MWx+E8vPZ5
         x/hg==
X-Gm-Message-State: AOJu0YyhqFx3iHS8s6lZhhn/uRqvnc/n4LBNW+3XPV2/a/NBewKlrufs
	DulmVKmvVfh6MUu8lwtWYrCB5tIAVTBSfzQfMzAmVwJhRvt3J3u8SdZS7A==
X-Google-Smtp-Source: AGHT+IFm1Zqjltn+mt0zGFZVH+LVg3SQ7WaRRG3dLbselkPXf3TlE/i5TrExM6JOYJbao6DZWaRKyA==
X-Received: by 2002:a05:6102:14aa:b0:47f:2c10:24e2 with SMTP id ada2fe7eead31-48077e5bfaemr1237880137.28.1715288346630;
        Thu, 09 May 2024 13:59:06 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4806cb6c492sm282866137.14.2024.05.09.13.59.05
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 13:59:05 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v1] Bluetooth: MGMT: Make MGMT_OP_LOAD_CONN_PARAM update existing connection
Date: Thu,  9 May 2024 16:59:04 -0400
Message-ID: <20240509205904.1275416-1-luiz.dentz@gmail.com>
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

