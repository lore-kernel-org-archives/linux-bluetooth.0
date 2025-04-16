Received: from mail-ua1-f45.google.com (mail-ua1-f45.google.com [209.85.222.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C717822577C
	for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 19:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744833334; cv=none; b=M22neXVGAZ3lphjPY7a8qMftznllaDT54cfFHzw8ys2QTDPXeykopVLgmy6eceD+tiJSSoPjDrLXEYBOfLZ/ijcSIpOP0rTAuhdMuymlTFFHL6gpkS3eBRBFn8EylU7kk8lei2fZ7csXmNdCVX2wn0Zdkr4/nVI3RcWfSe7zPH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744833334; c=relaxed/simple;
	bh=VMEuZTQb6T+TjQeDLHhqLk9mlXAxqIWTBWdaHRCtmcI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nu+JeahXZHstYOTsQFFafgSQeyCkb8JNuy5j6fWZ0HGyRJ1LVQZRugCcpTfCtLg4ym4hWFgSTYAnVSRrBIfyXCQfokzAURpnwazN8NRKWkeZWbckdMaGwTPclHwu0n2p/5gnPSgcy+aMB8yoq0uxIWZvdRV3BOfudJEnsv9b/EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UzzDiFj0; arc=none smtp.client-ip=209.85.222.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UzzDiFj0"
Received: by mail-ua1-f45.google.com with SMTP id a1e0cc1a2514c-86fbc8717fcso19770241.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 16 Apr 2025 12:55:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744833331; x=1745438131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zXNsW6tRxV5cSah1rHmuP2/qTkRVkWP7G7Itgz2s4dM=;
        b=UzzDiFj02BsESYCKL0XVXp3d7gZdQGa6ZqCF+xXdpsB/KwSpBfAnzjamSwZHD5nNSN
         j+OqRTHc8TZu0+XtOX+oMGccYwuYnQHB7w050VldYJS/nU6NGCug7znqFIpQMsHqf7ET
         AUMGADD3ippMs+lnqrAiZElmhsI1i9OzBtDkJ3/mzYQ+LKGqHwyByZfeTCuB4zd2/IJz
         xg/aXl3OPCDNTpY15WJmOTXgYJnrIpjn+DQPukJ9H9rlDDENjzVYqaR1fZ+4iYi4KMkm
         +/3W8ejGZLP+KdA9rE+yOAj/vibnPy8OE943EV91w3LQCyTomh7B5uXUtPAN/e7fpC9Y
         vd4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744833331; x=1745438131;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zXNsW6tRxV5cSah1rHmuP2/qTkRVkWP7G7Itgz2s4dM=;
        b=Iz0jNS1egsER0nuU2jeMsMkl3mAq6hkWNRIkuzmKvoAWbOYxzgYG4MBlK5UmKSIagA
         6Yoji3D/MNePTFmnuy23f+eaidJPLh1DpEra8cLIo4ZSMti1OKvAvY9hWK4FUCPqwRrW
         +i5xA0EKbVrxl7cqmNtSd/6UqpzasirJTB056rFE2ILz74b5fCLjc8LbBcqRTQ6SZ1T/
         eMeaorsF/Wd2Uecye/xB7qk9h0/zJvC5ddQ4Io6ZmprdDMCp6oeNyQ7+cE+1GvNSCQq/
         LZLexEVFeP4RTQyg3AVUUeHZyyMn9XBvFQR535TnDqiMT2rYxBHr7zRoVa3+HteJ7LZz
         rI8Q==
X-Gm-Message-State: AOJu0YyvDBOJkLz59iXBAP8qkwpBG0mFMWZGVHAVrExVf1kkDvx3nuKk
	9BZ3OiiLfvaDieUA8boLeVbtIaGsvKETBweMIv2YE1UI71UEMHZTKe6ouC/F
X-Gm-Gg: ASbGncsQhA9tSlI5xvgh4XnRddrFTVdWXa0+ZUCMnST0v69MDURp7gNzgbo1Gi+j1Og
	1M5B8CS7DJRdLVHJDmAKnrffM7Gp1JGbEnkLYs520XHWn6qndJWlCs4LASecB2PBauvHAoJQYcS
	Xo1Kr20dpw4hT29dh7auXhiBGv0EmgEpRGqKxfJKlx25FSMFMMUsUcZn9VbBQUTRlPU4qsXbT1g
	xG1HBqj5CzA2un8JC4x1u4mXulFnNPOzrWF4/m01STXDBNwUb+/xpsSYCI/QsSE0BTP47w3dYnt
	KCKHUL+bMiAxsNa+03GxVMRLrk/zfVe5Pevoex+60dUp8+15bYR3KpnGg2vinYvSTOWOqKtYHpS
	bO+HaEe2wDQ==
X-Google-Smtp-Source: AGHT+IHnwakQYqVzYDMdvE+Iq/OcGnVzYkEYRh8TTDAN8tw1etkixlMXnxnvLDOXv3C1CHXKnYQrmA==
X-Received: by 2002:a67:f083:0:b0:4c2:fa6a:7e2d with SMTP id ada2fe7eead31-4cb591b80admr1959962137.1.1744833330760;
        Wed, 16 Apr 2025 12:55:30 -0700 (PDT)
Received: from lvondent-mobl5.. (syn-050-089-067-214.res.spectrum.com. [50.89.67.214])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-87557281a80sm3243415241.27.2025.04.16.12.55.29
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Apr 2025 12:55:30 -0700 (PDT)
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 2/4] Bluetooth: hci_conn: Fix not setting timeout for BIG Create Sync
Date: Wed, 16 Apr 2025 15:55:24 -0400
Message-ID: <20250416195526.1989143-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250416195526.1989143-1-luiz.dentz@gmail.com>
References: <20250416195526.1989143-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

BIG Create Sync requires the command to just generates a status so this
makes use of __hci_cmd_sync_status_sk to wait for
HCI_EVT_LE_BIG_SYNC_ESTABLISHED, also because of this chance it is not
longer necessary to use a custom method to serialize the process of
creating the BIG sync since the cmd_work_sync itself ensures only one
command would be pending which now awaits for
HCI_EVT_LE_BIG_SYNC_ESTABLISHED before proceeding to next connection.

Fixes: 42ecf1947135 ("Bluetooth: ISO: Do not emit LE BIG Create Sync if previous is pending")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci.h      |  2 +-
 include/net/bluetooth/hci_core.h |  7 ++-
 include/net/bluetooth/hci_sync.h |  1 +
 net/bluetooth/hci_conn.c         | 89 ++------------------------------
 net/bluetooth/hci_event.c        |  9 ++--
 net/bluetooth/hci_sync.c         | 63 ++++++++++++++++++++++
 net/bluetooth/iso.c              | 26 +++++-----
 7 files changed, 88 insertions(+), 109 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 0e785047b1d4..2502febf4da7 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -2833,7 +2833,7 @@ struct hci_evt_le_create_big_complete {
 	__le16  bis_handle[];
 } __packed;
 
-#define HCI_EVT_LE_BIG_SYNC_ESTABILISHED 0x1d
+#define HCI_EVT_LE_BIG_SYNC_ESTABLISHED 0x1d
 struct hci_evt_le_big_sync_estabilished {
 	__u8    status;
 	__u8    handle;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 1b016d5811a9..965ca1ca841c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1527,7 +1527,6 @@ bool hci_setup_sync(struct hci_conn *conn, __u16 handle);
 void hci_sco_setup(struct hci_conn *conn, __u8 status);
 bool hci_iso_setup_path(struct hci_conn *conn);
 int hci_le_create_cis_pending(struct hci_dev *hdev);
-int hci_le_big_create_sync_pending(struct hci_dev *hdev);
 int hci_conn_check_create_cis(struct hci_conn *conn);
 
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst,
@@ -1568,9 +1567,9 @@ struct hci_conn *hci_connect_bis(struct hci_dev *hdev, bdaddr_t *dst,
 				 __u8 data_len, __u8 *data);
 struct hci_conn *hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst,
 		       __u8 dst_type, __u8 sid, struct bt_iso_qos *qos);
-int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
-			   struct bt_iso_qos *qos,
-			   __u16 sync_handle, __u8 num_bis, __u8 bis[]);
+int hci_conn_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
+			     struct bt_iso_qos *qos, __u16 sync_handle,
+			     __u8 num_bis, __u8 bis[]);
 int hci_conn_check_link_mode(struct hci_conn *conn);
 int hci_conn_check_secure(struct hci_conn *conn, __u8 sec_level);
 int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type,
diff --git a/include/net/bluetooth/hci_sync.h b/include/net/bluetooth/hci_sync.h
index 93dac4c7f9e3..72558c826aa1 100644
--- a/include/net/bluetooth/hci_sync.h
+++ b/include/net/bluetooth/hci_sync.h
@@ -187,3 +187,4 @@ int hci_le_conn_update_sync(struct hci_dev *hdev, struct hci_conn *conn,
 			    struct hci_conn_params *params);
 
 int hci_connect_pa_sync(struct hci_dev *hdev, struct hci_conn *conn);
+int hci_connect_big_sync(struct hci_dev *hdev, struct hci_conn *conn);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index c3112ce39f67..6533e281ada3 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -2087,89 +2087,9 @@ struct hci_conn *hci_pa_create_sync(struct hci_dev *hdev, bdaddr_t *dst,
 	return conn;
 }
 
-static bool hci_conn_check_create_big_sync(struct hci_conn *conn)
-{
-	if (!conn->num_bis)
-		return false;
-
-	return true;
-}
-
-static void big_create_sync_complete(struct hci_dev *hdev, void *data, int err)
-{
-	bt_dev_dbg(hdev, "");
-
-	if (err)
-		bt_dev_err(hdev, "Unable to create BIG sync: %d", err);
-}
-
-static int big_create_sync(struct hci_dev *hdev, void *data)
-{
-	DEFINE_FLEX(struct hci_cp_le_big_create_sync, pdu, bis, num_bis, 0x11);
-	struct hci_conn *conn;
-
-	rcu_read_lock();
-
-	pdu->num_bis = 0;
-
-	/* The spec allows only one pending LE BIG Create Sync command at
-	 * a time. If the command is pending now, don't do anything. We
-	 * check for pending connections after each BIG Sync Established
-	 * event.
-	 *
-	 * BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
-	 * page 2586:
-	 *
-	 * If the Host sends this command when the Controller is in the
-	 * process of synchronizing to any BIG, i.e. the HCI_LE_BIG_Sync_
-	 * Established event has not been generated, the Controller shall
-	 * return the error code Command Disallowed (0x0C).
-	 */
-	list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
-		if (test_bit(HCI_CONN_CREATE_BIG_SYNC, &conn->flags))
-			goto unlock;
-	}
-
-	list_for_each_entry_rcu(conn, &hdev->conn_hash.list, list) {
-		if (hci_conn_check_create_big_sync(conn)) {
-			struct bt_iso_qos *qos = &conn->iso_qos;
-
-			set_bit(HCI_CONN_CREATE_BIG_SYNC, &conn->flags);
-
-			pdu->handle = qos->bcast.big;
-			pdu->sync_handle = cpu_to_le16(conn->sync_handle);
-			pdu->encryption = qos->bcast.encryption;
-			memcpy(pdu->bcode, qos->bcast.bcode,
-			       sizeof(pdu->bcode));
-			pdu->mse = qos->bcast.mse;
-			pdu->timeout = cpu_to_le16(qos->bcast.timeout);
-			pdu->num_bis = conn->num_bis;
-			memcpy(pdu->bis, conn->bis, conn->num_bis);
-
-			break;
-		}
-	}
-
-unlock:
-	rcu_read_unlock();
-
-	if (!pdu->num_bis)
-		return 0;
-
-	return hci_send_cmd(hdev, HCI_OP_LE_BIG_CREATE_SYNC,
-			    struct_size(pdu, bis, pdu->num_bis), pdu);
-}
-
-int hci_le_big_create_sync_pending(struct hci_dev *hdev)
-{
-	/* Queue big_create_sync */
-	return hci_cmd_sync_queue_once(hdev, big_create_sync,
-				       NULL, big_create_sync_complete);
-}
-
-int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
-			   struct bt_iso_qos *qos,
-			   __u16 sync_handle, __u8 num_bis, __u8 bis[])
+int hci_conn_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
+			     struct bt_iso_qos *qos, __u16 sync_handle,
+			     __u8 num_bis, __u8 bis[])
 {
 	int err;
 
@@ -2186,9 +2106,10 @@ int hci_le_big_create_sync(struct hci_dev *hdev, struct hci_conn *hcon,
 
 		hcon->num_bis = num_bis;
 		memcpy(hcon->bis, bis, num_bis);
+		hcon->conn_timeout = msecs_to_jiffies(qos->bcast.timeout * 10);
 	}
 
-	return hci_le_big_create_sync_pending(hdev);
+	return hci_connect_big_sync(hdev, hcon);
 }
 
 static void create_big_complete(struct hci_dev *hdev, void *data, int err)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index ea7ccafd055a..6d6061111ac5 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -6928,7 +6928,7 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 
 	bt_dev_dbg(hdev, "status 0x%2.2x", ev->status);
 
-	if (!hci_le_ev_skb_pull(hdev, skb, HCI_EVT_LE_BIG_SYNC_ESTABILISHED,
+	if (!hci_le_ev_skb_pull(hdev, skb, HCI_EVT_LE_BIG_SYNC_ESTABLISHED,
 				flex_array_size(ev, bis, ev->num_bis)))
 		return;
 
@@ -6999,9 +6999,6 @@ static void hci_le_big_sync_established_evt(struct hci_dev *hdev, void *data,
 		}
 
 unlock:
-	/* Handle any other pending BIG sync command */
-	hci_le_big_create_sync_pending(hdev);
-
 	hci_dev_unlock(hdev);
 }
 
@@ -7123,8 +7120,8 @@ static const struct hci_le_ev {
 		     hci_le_create_big_complete_evt,
 		     sizeof(struct hci_evt_le_create_big_complete),
 		     HCI_MAX_EVENT_SIZE),
-	/* [0x1d = HCI_EV_LE_BIG_SYNC_ESTABILISHED] */
-	HCI_LE_EV_VL(HCI_EVT_LE_BIG_SYNC_ESTABILISHED,
+	/* [0x1d = HCI_EV_LE_BIG_SYNC_ESTABLISHED] */
+	HCI_LE_EV_VL(HCI_EVT_LE_BIG_SYNC_ESTABLISHED,
 		     hci_le_big_sync_established_evt,
 		     sizeof(struct hci_evt_le_big_sync_estabilished),
 		     HCI_MAX_EVENT_SIZE),
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 99c116b056ce..e56b1cbedab9 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6972,3 +6972,66 @@ int hci_connect_pa_sync(struct hci_dev *hdev, struct hci_conn *conn)
 	return hci_cmd_sync_queue_once(hdev, hci_le_pa_create_sync, conn,
 				       create_pa_complete);
 }
+
+static void create_big_complete(struct hci_dev *hdev, void *data, int err)
+{
+	struct hci_conn *conn = data;
+
+	bt_dev_dbg(hdev, "err %d", err);
+
+	if (err == -ECANCELED)
+		return;
+
+	if (hci_conn_valid(hdev, conn))
+		clear_bit(HCI_CONN_CREATE_BIG_SYNC, &conn->flags);
+}
+
+static int hci_le_big_create_sync(struct hci_dev *hdev, void *data)
+{
+	DEFINE_FLEX(struct hci_cp_le_big_create_sync, cp, bis, num_bis, 0x11);
+	struct hci_conn *conn = data;
+	struct bt_iso_qos *qos = &conn->iso_qos;
+	int err;
+
+	if (!hci_conn_valid(hdev, conn))
+		return -ECANCELED;
+
+	set_bit(HCI_CONN_CREATE_BIG_SYNC, &conn->flags);
+
+	memset(cp, 0, sizeof(*cp));
+	cp->handle = qos->bcast.big;
+	cp->sync_handle = cpu_to_le16(conn->sync_handle);
+	cp->encryption = qos->bcast.encryption;
+	memcpy(cp->bcode, qos->bcast.bcode, sizeof(cp->bcode));
+	cp->mse = qos->bcast.mse;
+	cp->timeout = cpu_to_le16(qos->bcast.timeout);
+	cp->num_bis = conn->num_bis;
+	memcpy(cp->bis, conn->bis, conn->num_bis);
+
+	/* The spec allows only one pending LE BIG Create Sync command at
+	 * a time, so we forcefully wait for BIG Sync Established event since
+	 * cmd_work can only schedule one command at a time.
+	 *
+	 * BLUETOOTH CORE SPECIFICATION Version 5.3 | Vol 4, Part E
+	 * page 2586:
+	 *
+	 * If the Host sends this command when the Controller is in the
+	 * process of synchronizing to any BIG, i.e. the HCI_LE_BIG_Sync_
+	 * Established event has not been generated, the Controller shall
+	 * return the error code Command Disallowed (0x0C).
+	 */
+	err = __hci_cmd_sync_status_sk(hdev, HCI_OP_LE_BIG_CREATE_SYNC,
+				       struct_size(cp, bis, cp->num_bis), cp,
+				       HCI_EVT_LE_BIG_SYNC_ESTABLISHED,
+				       conn->conn_timeout, NULL);
+	if (err == -ETIMEDOUT)
+		hci_le_big_terminate_sync(hdev, cp->handle);
+
+	return err;
+}
+
+int hci_connect_big_sync(struct hci_dev *hdev, struct hci_conn *conn)
+{
+	return hci_cmd_sync_queue_once(hdev, hci_le_big_create_sync, conn,
+				       create_big_complete);
+}
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index 3501a991f1c6..2819cda616bc 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1462,14 +1462,13 @@ static void iso_conn_big_sync(struct sock *sk)
 	lock_sock(sk);
 
 	if (!test_and_set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags)) {
-		err = hci_le_big_create_sync(hdev, iso_pi(sk)->conn->hcon,
-					     &iso_pi(sk)->qos,
-					     iso_pi(sk)->sync_handle,
-					     iso_pi(sk)->bc_num_bis,
-					     iso_pi(sk)->bc_bis);
+		err = hci_conn_big_create_sync(hdev, iso_pi(sk)->conn->hcon,
+					       &iso_pi(sk)->qos,
+					       iso_pi(sk)->sync_handle,
+					       iso_pi(sk)->bc_num_bis,
+					       iso_pi(sk)->bc_bis);
 		if (err)
-			bt_dev_err(hdev, "hci_le_big_create_sync: %d",
-				   err);
+			bt_dev_err(hdev, "hci_big_create_sync: %d", err);
 	}
 
 	release_sock(sk);
@@ -1922,7 +1921,7 @@ static void iso_conn_ready(struct iso_conn *conn)
 					      hcon);
 		} else if (test_bit(HCI_CONN_BIG_SYNC_FAILED, &hcon->flags)) {
 			ev = hci_recv_event_data(hcon->hdev,
-						 HCI_EVT_LE_BIG_SYNC_ESTABILISHED);
+						 HCI_EVT_LE_BIG_SYNC_ESTABLISHED);
 
 			/* Get reference to PA sync parent socket, if it exists */
 			parent = iso_get_sock(&hcon->src, &hcon->dst,
@@ -2113,12 +2112,11 @@ int iso_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 *flags)
 
 			if (!test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags) &&
 			    !test_and_set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags)) {
-				err = hci_le_big_create_sync(hdev,
-							     hcon,
-							     &iso_pi(sk)->qos,
-							     iso_pi(sk)->sync_handle,
-							     iso_pi(sk)->bc_num_bis,
-							     iso_pi(sk)->bc_bis);
+				err = hci_conn_big_create_sync(hdev, hcon,
+							       &iso_pi(sk)->qos,
+							       iso_pi(sk)->sync_handle,
+							       iso_pi(sk)->bc_num_bis,
+							       iso_pi(sk)->bc_bis);
 				if (err) {
 					bt_dev_err(hdev, "hci_le_big_create_sync: %d",
 						   err);
-- 
2.49.0

