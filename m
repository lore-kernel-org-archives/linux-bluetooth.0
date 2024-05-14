Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C11C2AD1C
	for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 17:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715708883; cv=none; b=kzvaJw3VSDnJp54xwzJlh4F8BaYhrgrDVsoXCF+W/Oy5yiJ6RsldNWSVy3BD3KgoNQ5GG9RzeaNtL3otLJU3zIp3/4tg8ooK/UQSDgvQ1zRQsvBkmjvXD1vmKeGAYHzHcuQYnkcbD18mlvAxS8Ov/uCMfQMOcBN2XYwg47KL+PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715708883; c=relaxed/simple;
	bh=b99+/+BBL+s59L2dJNosMWscALYWtHiVOLC+2lXtnBc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=bVkweSBCCgJ//SaMpRKFwIVW0sVvJFoEflLbojote16UqWBpBuhO56RC03qgyJFDUg3/TkCO6fAuBRF6DY8PT8GwVglRA00oFmrh99TMGlbeO9Y3jVVpldtGljx8AG6XCX3VmJnK8oWGPaPWP1aYjs2yp5SlWb8OcuWnpBX8RLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtpVzySL; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtpVzySL"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7f15c0296d9so1814015241.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 14 May 2024 10:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715708880; x=1716313680; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=nzXSMATkfjygrJK+1ZJ2FLwN9v4VtDPiI3a0TZCqcdQ=;
        b=NtpVzySLq3QiOBYWJMsfdlXzWkiN7GcLKPDq9krVuiuxLpk2vScSF8txaf9FK0qPrL
         xRPSAQqNi+cHLcYSWjV9B9oIXDwCmGFlFNc2Jd8glig5/LSo396ESknQwspllaNQ2xEX
         j7Sn8V9FZHRvsgvKGMNRla2ygnr2fdt86pRladV1rUv7c0o2zFeE3QSfMknrkLMYmAa1
         J9Sd1Sh3KZYTfGMuA/nHkCer5nvvJ6v1N/LDcKZ+cp84oSB2c6zkFejLpme77BQCUnUh
         3jCwMsUOHv4w2jxU8rmpvhuzHjD+Y502ohv7Tk0+OIZeYg7rVFORkmMi8tgECUsB9y1s
         D3IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715708880; x=1716313680;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nzXSMATkfjygrJK+1ZJ2FLwN9v4VtDPiI3a0TZCqcdQ=;
        b=GL/aBWzsdXvFSeXRslev9l9oXQbY0VW6OuXkreo7zYh/ng3a9MLpfAfhqQcncP7f1m
         DEUWrpWMJ/UV6KzjReJYImL9ftnS0DJrRxHa3k11yQtB75JRtBns8aULGUhNCCZiaEQT
         XPwVOVk0rEvfyuwMzn26hdA87WkxM06kL+dGCF6KGYWIh42+vov0ZqqUfPBjeB14KisS
         4+8LdKSWQOdFsKUyQzIIuq59opKe2eUo1AbKC5SFU9O6xXYJoq965L4sIIp2hcc7KAWP
         OfJmroPnzbOyRXJYsQ4hABd8DEuktDOSmVUoQ3tMuDHg3l48UOVoFPCYYybMJtf+TJKP
         fUyw==
X-Gm-Message-State: AOJu0YxF+PUe+wlBq5rzWkddpdJlSfdESoVucGL0Iw5YuS8ruwtCY5l4
	mMZPS6/Ctr5sE10FkIrM0CtUfchMzr8J1GfC1KnGudw8RPWAMfyZ860LqNOA
X-Google-Smtp-Source: AGHT+IGZb0nqtn6TvRfkCz4hKqI29qvIZeFyPRwrSdHkOHcF2QxFIUl8Gzx/8ONOqS/8mwrocDQBCA==
X-Received: by 2002:a05:6102:1489:b0:47e:a1fc:3b82 with SMTP id ada2fe7eead31-48077ebcd98mr15356119137.35.1715708878874;
        Tue, 14 May 2024 10:47:58 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4806cbfd83csm1793357137.21.2024.05.14.10.47.57
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 10:47:57 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v4] Bluetooth: MGMT: Make MGMT_OP_LOAD_CONN_PARAM update existing connection
Date: Tue, 14 May 2024 13:47:55 -0400
Message-ID: <20240514174755.750764-1-luiz.dentz@gmail.com>
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
 include/net/bluetooth/hci_sync.h |  3 +++
 net/bluetooth/hci_sync.c         | 18 +++++++++++++
 net/bluetooth/mgmt.c             | 45 ++++++++++++++++++++++++++++++--
 3 files changed, 64 insertions(+), 2 deletions(-)

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
index 80f220b7e19d..29f142269f6b 100644
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
@@ -7890,6 +7917,20 @@ static int load_conn_param(struct sock *sk, struct hci_dev *hdev, void *data,
 		hci_param->conn_max_interval = max;
 		hci_param->conn_latency = latency;
 		hci_param->supervision_timeout = timeout;
+
+		if (update) {
+			struct hci_conn *conn;
+
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

