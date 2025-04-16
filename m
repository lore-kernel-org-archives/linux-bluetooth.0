Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10DE522541F
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 19:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744833333; cv=none; b=XWdKDsyEI3OU3UJLbe3nHuYDzLxTpqQFdokdGYBHqmrsMkzRfTb0RC+Ki2IvMem/vZmvQVNdZE9p5Yd3NQCEXZsu7cOTN4mOuJOW07Xuz7Ph85c3+Gq0I61/VIZyhaHIjuQE15y0fkT8N53ns22V5RWa8Q5ztPL34x/fhVztiaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744833333; c=relaxed/simple;
	bh=tPp4ItNjOBrIaADqN7zpO1PYuCXEHfpZZHgeIOWCB9Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZajVUn0oijZOHjdPgE9bvmQsfMYlwyGageEYcw2NOFqwI5RCAeAOduplqIXtXrDokxDrOzt8JlB/nZyy7tj3dVlCOFvC7m0akz0RMxG0jRVLsm/6euYMWddOJdDsgyEAy7Rm3Dl0ERVKK6xd+7hVlL5MOff3rD3Fmi+JryAGpLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HC4UlVbH; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HC4UlVbH"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-52403e39a23so24375e0c.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 12:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744833329; x=1745438129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qSb88k68w5zxmDusv8Aggx9rkbFHs6KsrtEzjU+6Nks=;
        b=HC4UlVbHzcR8OF12+wP8nlrzbOZHq5hOjItKZkl69C7k+djn48JTLWvpJHqSqu8jSo
         l9W4jzX4dfjABf8ZHdibaNLAvYQOip9bmPqYIrlUhLcfHvtpSP3I3XwC1G1ruUnDoG1n
         +qYG/eWQA2k7dVoxQy3aAkA1CL93DeAnWUp36LsMoC7G2jxO8tfgITlD0w8zc0+2nkST
         Fc/Rxhg/DV77a6iToh4RKaQjt0lZSzNxwsqQqc63hT1xhHMRNAtoE2ZNDQAKbqYNzbzx
         HsJEJElYH5dedOymxtVueXRSiH9EdvVfetEVTuFj8TWoOhIiH8mKkEzosK+H18pxCTVP
         oYZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744833329; x=1745438129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qSb88k68w5zxmDusv8Aggx9rkbFHs6KsrtEzjU+6Nks=;
        b=r54rdjDr9zrdDVxIjS0LkHysMiWVTooFnZ3UIZP8bYPB5WkLr219IxqpzUMsHFRnCv
         wbHxXilTSSquiBHnn1oPsNlTZ9qGN87EhcGQfErIlswPzHSNOlUFCEXdQnttYcmc1X+c
         F9AsHAUK7gq7T/IYvO5sDuuQqOiFvrchImjqKBYwB1yfzhwkg7vjuvtwY3tMLNTrq4Zg
         bUuj2Jb7XPxqQHNKlGcetVVVe4UBERSOUSSFAVm21cZHCPbOxwGzl5cQTBeNMMZt17Xj
         5Mrd2AUxBAvpCW4kRuii72ncC9oCzPqXLeySaX8/U+vfZFABn32o4UZbszAxLPcpMjo0
         dTqA==
X-Gm-Message-State: AOJu0Ywes55kkVc2Z4qgA56XwZrK1mDqVp7mfAKLGAN/Dj2UIMADqcsx
	fAjX+BQhRSatHKrILWl048Mz6woY8Ykx8cksIHeqRQasNwfcC7I7/1o/zOQr
X-Gm-Gg: ASbGnctuXTXeuD9R+jH++gJlKWC9+lSeaVT3SomWZuVd/fJe7481nMjHuIB8gVMWYR9
	e0qK5jH3v2dKU18hsek1qmOEfyizofxgJSw3OhNpjWfu/APUMalO8+qf7EyKjyYqh69bg3xjXoW
	xWNRCMAiJ7X0i3rWtYlvnEHQ/QbjauJzkmh+dtkq4Y81ocdBCovYajy3er+2hPdzfqi19KLxZJB
	SR9/2ovSOdoQfTxU4xxLB77ZkVWUONVxkZLgqq4LCrF3YaM2CrXAbVwFINV/lorZk+AXFLA5KWO
	8GbKdd8Q7bhGrLoKzaDDtqBxM5iFp5fXZEb850qjdCna5Qdn74OxPwYgoEW+zVFXcwEYoDHAn+4
	h7go2saoN+w==
X-Google-Smtp-Source: AGHT+IFjO49l24eHEd4IsVzUfjNkn4YHo8o/rYfEvRq3jdk5CgXaJxBr8kl3ZEiRraLZk6byE9RQ8A==
X-Received: by 2002:a05:6102:3210:b0:4c3:2803:61c1 with SMTP id ada2fe7eead31-4cb592ed1fcmr2372027137.18.1744833328982;
        Wed, 16 Apr 2025 12:55:28 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87557281a80sm3243415241.27.2025.04.16.12.55.27
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 12:55:27 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 1/4] Bluetooth: hci_conn: Fix not setting conn_timeout for Broadcast Receiver
Date: Wed, 16 Apr 2025 15:55:23 -0400
Message-ID: <20250416195526.1989143-1-luiz.dentz@gmail.com>
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
 include/net/bluetooth/hci.h      |  2 +
 include/net/bluetooth/hci_core.h | 13 +++--
 include/net/bluetooth/hci_sync.h |  2 +
 net/bluetooth/hci_conn.c         | 92 +-------------------------------
 net/bluetooth/hci_event.c        |  6 +--
 net/bluetooth/hci_sync.c         | 87 ++++++++++++++++++++++++++++--
 6 files changed, 95 insertions(+), 107 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index e297b312d2b7..0e785047b1d4 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1932,6 +1932,8 @@ struct hci_cp_le_pa_create_sync {
 	__u8      sync_cte_type;
 } __packed;
 
+#define HCI_OP_LE_PA_CREATE_SYNC_CANCEL	0x2045
+
 #define HCI_OP_LE_PA_TERM_SYNC		0x2046
 struct hci_cp_le_pa_term_sync {
 	__le16    handle;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index dd80f1a398be..1b016d5811a9 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1116,10 +1116,8 @@ static inline struct hci_conn *hci_conn_hash_lookup_bis(struct hci_dev *hdev,
 	return NULL;
 }
 
-static inline struct hci_conn *hci_conn_hash_lookup_sid(struct hci_dev *hdev,
-							__u8 sid,
-							bdaddr_t *dst,
-							__u8 dst_type)
+static inline struct hci_conn *
+hci_conn_hash_lookup_create_pa_sync(struct hci_dev *hdev)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *c;
@@ -1127,8 +1125,10 @@ static inline struct hci_conn *hci_conn_hash_lookup_sid(struct hci_dev *hdev,
 	rcu_read_lock();
 
 	list_for_each_entry_rcu(c, &h->list, list) {
-		if (c->type != ISO_LINK  || bacmp(&c->dst, dst) ||
-		    c->dst_type != dst_type || c->sid != sid)
+		if (c->type != ISO_LINK)
+			continue;
+
+		if (!test_bit(HCI_CONN_CREATE_PA_SYNC, &c->flags))
 			continue;
 
 		rcu_read_unlock();
@@ -1527,7 +1527,6 @@ bool hci_setup_sync(struct hci_conn *conn, __u16 handle);
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
index 5f808f0b0e9a..ea7ccafd055a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6378,8 +6378,7 @@ static void hci_le_pa_sync_estabilished_evt(struct hci_dev *hdev, void *data,
 
 	hci_dev_clear_flag(hdev, HCI_PA_SYNC);
 
-	conn = hci_conn_hash_lookup_sid(hdev, ev->sid, &ev->bdaddr,
-					ev->bdaddr_type);
+	conn = hci_conn_hash_lookup_create_pa_sync(hdev);
 	if (!conn) {
 		bt_dev_err(hdev,
 			   "Unable to find connection for dst %pMR sid 0x%2.2x",
@@ -6418,9 +6417,6 @@ static void hci_le_pa_sync_estabilished_evt(struct hci_dev *hdev, void *data,
 	}
 
 unlock:
-	/* Handle any other pending PA sync command */
-	hci_pa_create_sync_pending(hdev);
-
 	hci_dev_unlock(hdev);
 }
 
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 609b035e5c90..99c116b056ce 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2693,16 +2693,16 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 
 	/* Force address filtering if PA Sync is in progress */
 	if (hci_dev_test_flag(hdev, HCI_PA_SYNC)) {
-		struct hci_cp_le_pa_create_sync *sent;
+		struct hci_conn *conn;
 
-		sent = hci_sent_cmd_data(hdev, HCI_OP_LE_PA_CREATE_SYNC);
-		if (sent) {
+		conn = hci_conn_hash_lookup_create_pa_sync(hdev);
+		if (conn) {
 			struct conn_params pa;
 
 			memset(&pa, 0, sizeof(pa));
 
-			bacpy(&pa.addr, &sent->addr);
-			pa.addr_type = sent->addr_type;
+			bacpy(&pa.addr, &conn->dst);
+			pa.addr_type = conn->dst_type;
 
 			/* Clear first since there could be addresses left
 			 * behind.
@@ -6895,3 +6895,80 @@ int hci_le_conn_update_sync(struct hci_dev *hdev, struct hci_conn *conn,
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
+	int err;
+
+	if (!hci_conn_valid(hdev, conn))
+		return -ECANCELED;
+
+	if (hci_dev_test_and_set_flag(hdev, HCI_PA_SYNC))
+		return -EBUSY;
+
+	/* Mark HCI_CONN_CREATE_PA_SYNC so hci_update_passive_scan_sync can
+	 * program the address in the allow list so PA advertisements can be
+	 * received.
+	 */
+	set_bit(HCI_CONN_CREATE_PA_SYNC, &conn->flags);
+
+	hci_update_passive_scan_sync(hdev);
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
+	err = __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_PA_CREATE_SYNC,
+				       sizeof(cp), &cp,
+				       HCI_EV_LE_PA_SYNC_ESTABLISHED,
+				       conn->conn_timeout, NULL);
+	if (err == -ETIMEDOUT)
+		__hci_cmd_sync_status(hdev, HCI_OP_LE_PA_CREATE_SYNC_CANCEL,
+				      0, NULL, HCI_CMD_TIMEOUT);
+
+	return err;
+}
+
+int hci_connect_pa_sync(struct hci_dev *hdev, struct hci_conn *conn)
+{
+	return hci_cmd_sync_queue_once(hdev, hci_le_pa_create_sync, conn,
+				       create_pa_complete);
+}
-- 
2.49.0

