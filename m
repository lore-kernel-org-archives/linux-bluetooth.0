Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com [209.85.221.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07172170842
	for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 14:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715351812; cv=none; b=fjUfnAph39cAT+u8/ZB02qitMH4RBbZuxQcG2X0o848WwN+ZN/GxC9zULvuk2GNo/Ls7Un4BXTXV7FG2iObLGyQ1feqT6yaAlyddHBneQSiriXU4ymfxtysE+oDbq764oYUQl+/ubEYI/MPjMARyMwr6mLmq7ZfWj4VFf9NPop8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715351812; c=relaxed/simple;
	bh=qThs9NqFl8UkjPEGdTx5WeuQQ4Cv67ZzUfl1Jrjml1k=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=Sdl72/bi10KuRftg/5P7G9DQQ3ljGWoYPspw996IfHzY2EhkgvSWgCpELUNYo1eVHNkhuU6me0+IrC14sn3AMOA3oECal7U9UDKFpa2CRdzko1YmSt864v27dADv5MrU/P8WxKU6L5s4AlNe35TAoDLBpURJaooWDiXMZJqoW+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QddVGLw7; arc=none smtp.client-ip=209.85.221.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QddVGLw7"
Received: by mail-vk1-f180.google.com with SMTP id 71dfb90a1353d-4df3e3c674fso778796e0c.2
        for <linux-bluetooth@vger.kernel.org>; Fri, 10 May 2024 07:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715351809; x=1715956609; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IFsPqmCINRm8kd4KBUP06RMboMfkFzMxGnluIOus0CQ=;
        b=QddVGLw7NQbs/OZJbuU4L0BWlu8Sbcw2HxpmK7qW+lWmmv9j1IqAUi07U4+SY/IXBB
         1QkxQkKKRGiIIa9V4dDTH373EDvpmscU7BeX0ueZH0SZjyfUta1WoXUgpCymQOM+POAg
         6p+w6WJ8W055dmvXAYZgSlx3sUrIYksfsz8RWNGJ7xV84Kva2eakNAHzIhjMlwsUlWQz
         DWfNm9RSdqGFMN1RiAEQvWvD+XVpfGYtJajj9DNacZgHBRDR/hkcQbsHMV7mU5vkXYpC
         9bfTdht5fLHMhALHTIvl6U1Tta1cZbeueI3PfuomsEMYg9x1rRVkxZJGZBOvtnueNPF5
         qmig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715351809; x=1715956609;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IFsPqmCINRm8kd4KBUP06RMboMfkFzMxGnluIOus0CQ=;
        b=kuyqD5sYosa9cs0Yz9JKkBgM/IQCVnoi8Z4a90+3uKQTvpGWTDxfjplkbqjEM+5v+9
         /tA68uj6kW1mosbEczp8AnW/3G07JA2FqexL0gXsAy1+lpU5Vka11/84VDfOoKGhMkct
         80hblAIVa/SIIYsAT8YRp3M2QuVL+eyFG7wDFnUumD7hBydSUQ2BFvpkRlPBgXsJbBj3
         zkeSR9aMiE2BNCD5Yjzb6CizqVNaFJRTvFka3qUVw1rRYmYsuUWVhqG3qt2oSBMxDNvS
         dgg5wxpasBymksIY6jeUYe2mAgO5M2mWPWuiruwlR25MbIZSUzrgTENWSOsWi7nO+Ajp
         3IZw==
X-Gm-Message-State: AOJu0YzurirP+cSwyIyIE3OuKAHXNRTfvnI+8GuZl6gHCHVQ1We7V6Sy
	3UC3p9Ad6svIWYSqxVyJwIXSwIIuSlXfRwNhAEtAWY+AEnDzwridaj4FBA==
X-Google-Smtp-Source: AGHT+IHxwJ2Q7OpeOZCfK8CzH1oFAmGW8BjoJg2Z0+9y0MW47h45Qq20/V/Vk6cWg2cZtPBqX4b+xw==
X-Received: by 2002:a05:6122:310a:b0:4dc:a1f6:4406 with SMTP id 71dfb90a1353d-4df882802fdmr3520535e0c.3.1715351808713;
        Fri, 10 May 2024 07:36:48 -0700 (PDT)
Received: from lvondent-mobl4.. (syn-107-146-107-067.res.spectrum.com. [107.146.107.67])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-4df7bf79572sm465429e0c.18.2024.05.10.07.36.47
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 07:36:47 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3] Bluetooth: MGMT: Make MGMT_OP_LOAD_CONN_PARAM update existing connection
Date: Fri, 10 May 2024 10:36:45 -0400
Message-ID: <20240510143645.1408056-1-luiz.dentz@gmail.com>
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
index 64e66d911c74..db0685300748 100644
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
@@ -7951,6 +7978,20 @@ static int load_conn_param(struct sock *sk, struct hci_dev *hdev, void *data,
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
2.44.0

