Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1287B1E32A0
	for <linux-bluetooth@vger.kernel.org>; Wed,  9 Apr 2025 20:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744229703; cv=none; b=MyXju1e0KBbJUqHzF8kxmEukN9lzxffvVuHtxNqfmN04hyemcz1J3gKlrNoohqilO6HJwuqVC8wvnNRKVauVxc68RupaSlJwAI5apahPK8L38qhI3zfmmSRaLr1KFUmQLDLuU7PnEk3wcladpD3zk+VA5CJrSHsQhNCSYtAymng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744229703; c=relaxed/simple;
	bh=ggRX7rl+WvJND9tPCi4pFAMfYQl6fGI6lEFo62G+wmg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=HO37TWVR3abm1nmUGyevrenIdzX8Dh4d/a28ewvxSLtIOlFytyVTsfrEgSVB+pBGf1WXRWfLzov6GtHUp0ujBRTRyx4jHTjQkUEarBmI/SLTghp7+5GVQQwN5X0RazQNiaqfMxj+dhj4+WWnWrAC+/DZv4UT1axo8RYeZfZ8vUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h15VJvQQ; arc=none smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h15VJvQQ"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-873a2ba6f7cso6869241.3
        for <linux-bluetooth@vger.kernel.org>; Wed, 09 Apr 2025 13:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744229699; x=1744834499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0hAt9ksuLeory9oHZVXfRbL0l1HfbL0otTFFPhDJETQ=;
        b=h15VJvQQkdxlmMw/azVVN02SEZs34m04iPKicZo2875XceGeTgVT+VzfN0cgoqmAgh
         2DbpFZqzY0hIUEZw3OxXgaF+DuK/E8D5lbhBuVcMEhXn9QBqQ71U8RkBRaRuaSpv/9O2
         asHIheWsDNaU9/VTDF6MaNGW1OwXY87HDhZmMKJRQq4rMdIv0Oejd8VZ6PZmi30l4nnh
         k5dH2tnKRHwC33Xyp1TE56WpFkx6g5ZWEamB/fM70JxZkIKKJ0Di6i5kGRjfh3+rUx76
         KeuYPgo5OqUJMyGuWIJi9PKUecRAOCDtu5szQj7u/JFMjRGRq0KfqFY336BeIwEMWtKF
         vQAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744229699; x=1744834499;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0hAt9ksuLeory9oHZVXfRbL0l1HfbL0otTFFPhDJETQ=;
        b=N+WdAnUI37lf38h2TdT2x+d8lpph8A3FnXHoGgRFdHUZgZxG6W9hlhoz5yh0Nkk0Jj
         P8cYHxWubASieaT3bM5mVq5mv1SHZ6BdG/kulCCxU4gq99ija2iAUDU1gXNrNayc/fjg
         4A09vXYgJPap6s/hWCO1HnH3In+iRXnpJyIoN/CMMpel/HHrg4OqtvWV67y+tDTZmY1a
         3OK4IW1GsD1j5XGVrnwoCNsX/4pPmw4w0evTXRND3MkCMPKq2xi49+ka6qiid987eIRq
         4OxUzJJDlQabnZ60t1qix7qcuNG60JqMQFMe5mvrq+BtINZMpuwb2JXh+QPqd77X3dc1
         GZAA==
X-Gm-Message-State: AOJu0YyUI5DNL6V7iM5ixa45842TV+5DP4ar5orV2XFEtZhjXv/TO6cw
	Sn0YrmCbFL8cCVI3/naI/Xog4n5WtoWH4zauUpSUBStdWn8l3FMYjA9l3Q==
X-Gm-Gg: ASbGncujaIHmZ0e121gN5XBjFEJpZ7KGEh0PjbGLVbjtP4oo16LLhDH3oaRHEMtuoNQ
	Y5d/dcy7DUzLGDpCanqjrbiIq2Xq7bO/805s4QVIs3veePtNByTErS69SdY705H8vbvLExApAg4
	pKqyGefP5qxrHX6M8nziOWIzHZxA3Q5Ky6O2jcDKsyVQ4OqL78k/X3yvFonok/WU6H462cBXC8W
	GDNr8WD0jbMTwl+0Bn+sRI9GGSpwThAd96KTYP3/MvDeUds4qyakUxOZas1Ns0ADtx/VzISLNlA
	xiC3eJMppbf3IyYNPTkyxyxIzTwWOuFcEhl6s8MkZHNBktH4pKwtF1ArE41atsnKQzl0my49y/R
	sOgJyxI+oRVhbImOMsXXN
X-Google-Smtp-Source: AGHT+IEJWfogYAsBJO1Y+Yiaf5f0EOmf2v+Ig7ZRBq6ZyP/OHm451zTK1FRUuFCI0sLElPWnKT800w==
X-Received: by 2002:a05:6102:dca:b0:4c4:f128:3abb with SMTP id ada2fe7eead31-4c9d3668f89mr303171137.25.1744229698990;
        Wed, 09 Apr 2025 13:14:58 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-4c9c97a304esm316485137.17.2025.04.09.13.14.56
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 13:14:57 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v1] Bluetooth: hci_conn: Fix not setting conn_timeout for Broadcast Receiver
Date: Wed,  9 Apr 2025 16:14:55 -0400
Message-ID: <20250409201455.345144-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Broadcast Receiver requires creating PA sync but the command just
generates a status so this makes use of __hci_cmd_sync_status_sk to wait
for HCI_EV_LE_PA_SYNC_ESTABLISHED, also because of this chance it is not
longer necessary to use a custom method to serialize the process of
creating the PA sync since the cmd_work_sync itself ensures only one
command would be pending which now awaits for
HCI_EV_LE_PA_SYNC_ESTABLISHED before proceeding to next connection.

Fixes: 4a5e0ba68676 ("Bluetooth: ISO: Do not emit LE PA Create Sync if previous is pending")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 -
 include/net/bluetooth/hci_sync.h |  2 +
 net/bluetooth/hci_conn.c         | 92 +-------------------------------
 net/bluetooth/hci_event.c        |  4 --
 net/bluetooth/hci_sync.c         | 65 ++++++++++++++++++++++
 5 files changed, 69 insertions(+), 96 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5115da34f881..b4ee408100a3 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -960,7 +960,6 @@ enum {
 	HCI_CONN_CREATE_BIG_SYNC,
 	HCI_CONN_BIG_SYNC,
 	HCI_CONN_BIG_SYNC_FAILED,
-	HCI_CONN_CREATE_PA_SYNC,
 	HCI_CONN_PA_SYNC,
 	HCI_CONN_PA_SYNC_FAILED,
 };
@@ -1524,7 +1523,6 @@ bool hci_setup_sync(struct hci_conn *conn, __u16 handle);
 void hci_sco_setup(struct hci_conn *conn, __u8 status);
 bool hci_iso_setup_path(struct hci_conn *conn);
 int hci_le_create_cis_pending(struct hci_dev *hdev);
-int hci_pa_create_sync_pending(struct hci_dev *hdev);
 int hci_le_big_create_sync_pending(struct hci_dev *hdev);
 int hci_conn_check_create_cis(struct hci_conn *conn);
 
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 7e2cf0cca939..93dac4c7f9e3 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -185,3 +185,5 @@ int hci_connect_le_sync(struct hci_dev *hdev, struct hci_conn *conn);
 int hci_cancel_connect_sync(struct hci_dev *hdev, struct hci_conn *conn);
 int hci_le_conn_update_sync(struct hci_dev *hdev, struct hci_conn *conn,
 			    struct hci_conn_params *params);
+
+int hci_connect_pa_sync(struct hci_dev *hdev, struct hci_conn *conn);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 7e1b53857648..c3112ce39f67 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2064,95 +2064,6 @@ static int create_big_sync(struct hci_dev *hdev, void *data)
 	return hci_le_create_big(conn, &conn->iso_qos);
 }
 
-static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
-{
-	bt_dev_dbg(hdev, "");
-
-	if (err)
-		bt_dev_err(hdev, "Unable to create PA: %d", err);
-}
-
-static bool hci_conn_check_create_pa_sync(struct hci_conn *conn)
-{
-	if (conn->type != ISO_LINK || conn->sid == HCI_SID_INVALID)
-		return false;
-
-	return true;
-}
-
-static int create_pa_sync(struct hci_dev *hdev, void *data)
-{
-	struct hci_cp_le_pa_create_sync cp = {0};
-	struct hci_conn *conn;
-	int err = 0;
-
-	hci_dev_lock(hdev);
-
-	rcu_read_lock();
-
-	/* The spec allows only one pending LE Periodic Advertising Create
-	 * Sync command at a time. If the command is pending now, don't do
-	 * anything. We check for pending connections after each PA Sync
-	 * Established event.
-	 *
-	 * BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
-	 * page 2493:
-	 *
-	 * If the Host issues this command when another HCI_LE_Periodic_
-	 * Advertising_Create_Sync command is pending, the Controller shall
-	 * return the error code Command Disallowed (0x0C).
-	 */
-	list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
-		if (test_bit(HCI_CONN_CREATE_PA_SYNC, &conn->flags))
-			goto unlock;
-	}
-
-	list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
-		if (hci_conn_check_create_pa_sync(conn)) {
-			struct bt_iso_qos *qos = &conn->iso_qos;
-
-			cp.options = qos->bcast.options;
-			cp.sid = conn->sid;
-			cp.addr_type = conn->dst_type;
-			bacpy(&cp.addr, &conn->dst);
-			cp.skip = cpu_to_le16(qos->bcast.skip);
-			cp.sync_timeout = cpu_to_le16(qos->bcast.sync_timeout);
-			cp.sync_cte_type = qos->bcast.sync_cte_type;
-
-			break;
-		}
-	}
-
-unlock:
-	rcu_read_unlock();
-
-	hci_dev_unlock(hdev);
-
-	if (bacmp(&cp.addr, BDADDR_ANY)) {
-		hci_dev_set_flag(hdev, HCI_PA_SYNC);
-		set_bit(HCI_CONN_CREATE_PA_SYNC, &conn->flags);
-
-		err = __hci_cmd_sync_status(hdev, HCI_OP_LE_PA_CREATE_SYNC,
-					    sizeof(cp), &cp, HCI_CMD_TIMEOUT);
-		if (!err)
-			err = hci_update_passive_scan_sync(hdev);
-
-		if (err) {
-			hci_dev_clear_flag(hdev, HCI_PA_SYNC);
-			clear_bit(HCI_CONN_CREATE_PA_SYNC, &conn->flags);
-		}
-	}
-
-	return err;
-}
-
-int hci_pa_create_sync_pending(struct hci_dev *hdev)
-{
-	/* Queue start pa_create_sync and scan */
-	return hci_cmd_sync_queue(hdev, create_pa_sync,
-				  NULL, create_pa_complete);
-}
-
 struct hci_conn *hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst,
 				    __u8 dst_type, __u8 sid,
 				    struct bt_iso_qos *qos)
@@ -2167,10 +2078,11 @@ struct hci_conn *hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst,
 	conn->dst_type = dst_type;
 	conn->sid = sid;
 	conn->state = BT_LISTEN;
+	conn->conn_timeout = msecs_to_jiffies(qos->bcast.sync_timeout * 10);
 
 	hci_conn_hold(conn);
 
-	hci_pa_create_sync_pending(hdev);
+	hci_connect_pa_sync(hdev, conn);
 
 	return conn;
 }
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5f808f0b0e9a..6c9e435d3d4f 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6387,8 +6387,6 @@ static void hci_le_pa_sync_estabilished_evt(struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	clear_bit(HCI_CONN_CREATE_PA_SYNC, &conn->flags);
-
 	conn->sync_handle = le16_to_cpu(ev->handle);
 	conn->sid = HCI_SID_INVALID;
 
@@ -6418,8 +6416,6 @@ static void hci_le_pa_sync_estabilished_evt(struct hci_dev *hdev, void *data,
 	}
 
 unlock:
-	/* Handle any other pending PA sync command */
-	hci_pa_create_sync_pending(hdev);
 
 	hci_dev_unlock(hdev);
 }
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 7a822ef71a74..8e0d32cb058a 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6905,3 +6905,68 @@ int hci_le_conn_update_sync(struct hci_dev *hdev, struct hci_conn *conn,
 	return __hci_cmd_sync_status(hdev, HCI_OP_LE_CONN_UPDATE,
 				     sizeof(cp), &cp, HCI_CMD_TIMEOUT);
 }
+
+static void create_pa_complete(struct hci_dev *hdev, void *data, int err)
+{
+	bt_dev_dbg(hdev, "err %d", err);
+
+	if (!err)
+		return;
+
+	hci_dev_clear_flag(hdev, HCI_PA_SYNC);
+
+	if (err == -ECANCELED)
+		return;
+
+	hci_dev_lock(hdev);
+
+	hci_update_passive_scan_sync(hdev);
+
+	hci_dev_unlock(hdev);
+}
+
+static int hci_le_pa_create_sync(struct hci_dev *hdev, void *data)
+{
+	struct hci_cp_le_pa_create_sync cp;
+	struct hci_conn *conn = data;
+	struct bt_iso_qos *qos = &conn->iso_qos;
+
+	if (!hci_conn_valid(hdev, conn))
+		return -ECANCELED;
+
+	if (hci_dev_test_and_set_flag(hdev, HCI_PA_SYNC))
+		return -EBUSY;
+
+	memset(&cp, 0, sizeof(cp));
+	cp.options = qos->bcast.options;
+	cp.sid = conn->sid;
+	cp.addr_type = conn->dst_type;
+	bacpy(&cp.addr, &conn->dst);
+	cp.skip = cpu_to_le16(qos->bcast.skip);
+	cp.sync_timeout = cpu_to_le16(qos->bcast.sync_timeout);
+	cp.sync_cte_type = qos->bcast.sync_cte_type;
+
+	hci_update_passive_scan_sync(hdev);
+
+	/* The spec allows only one pending LE Periodic Advertising Create
+	 * Sync command at a time so we forcefully wait for PA Sync Established
+	 * event since cmd_work can only schedule one command at a time.
+	 *
+	 * BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
+	 * page 2493:
+	 *
+	 * If the Host issues this command when another HCI_LE_Periodic_
+	 * Advertising_Create_Sync command is pending, the Controller shall
+	 * return the error code Command Disallowed (0x0C).
+	 */
+	return __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_PA_CREATE_SYNC,
+				    sizeof(cp), &cp,
+				    HCI_EV_LE_PA_SYNC_ESTABLISHED,
+				    conn->conn_timeout, NULL);
+}
+
+int hci_connect_pa_sync(struct hci_dev *hdev, struct hci_conn *conn)
+{
+	return hci_cmd_sync_queue_once(hdev, hci_le_pa_create_sync, conn,
+				       create_pa_complete);
+}
-- 
2.49.0

