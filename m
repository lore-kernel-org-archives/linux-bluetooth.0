Received: from mail-dl2-f12.google.com (mail-dl2-f12.google.com [74.125.229.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC894BC007
	for <linux-bluetooth@vger.kernel.org>; Wed,  7 Oct 2026 15:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791387861; cv=none; b=TsSo7D+co4xa95GrowgzqYpgoEAHG6eRDihtnqcHuWCP2lLZqw9N+Rq9yIkYfoPt/oS+YrPT6AHmNnkcbuRcER1QSjhRBUPPqlDQOlbCpSt8EA4dK7MpLdjWh/cJKOkjow2RGPvMG1u2HsaHUMOyOA3iZN1YX4gMiO30H6jxWa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791387861; c=relaxed/simple;
	bh=kVkJ7OJMcommChG/sArz+rhq97PTn9T8YyHxi8wuhVM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZqZqVAIgdGqPmsCHVMu8yg0PfADS6AZG9YP0RxCtwB8EO215Qca5RIXz8+0grc/fY9ZGr5C4iKo0iSGwl2crBLRGZjasb7PUoSpBwQotPmSb+naTH/I5j9uKasxLJJ43SufvHeTHBwhUNMxoumJeOTVQZIS7tdx/uP4l2Hh0SYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hiEPUGPX; arc=none smtp.client-ip=74.125.229.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hiEPUGPX"
Received: by mail-dl2-f12.google.com with SMTP id a92af1059eb24-141a5cf1371so736868c88.2
        for <linux-bluetooth@vger.kernel.org>; Wed, 07 Oct 2026 08:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791387854; x=1791992654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vwhFsVuhT0WTTw+YrQxYsYSj+h2QHZvVIQ6QQ3MaZf4=;
        b=hiEPUGPXqU+nFwfjUSgKvPQ1I6vT0eq+GkqnZ2gWGlat6RY6/Y674Hs3gXDeI4x6k8
         i/yzS3BiY/zsAPmqzk+3UNH8Txid4OmQqy8BFYdMMHo/PYbTLBk96GyAKZQ1nswl/O9P
         aizAGHMbKRIgkroImBD7zxQV/H93Oeh2eLgRBePbMqTc2fPPyG4cLXM4XzeWDUckfqY9
         mdQiteNl5Z8bx6gpfLKp0hitrY5oQoTrDVkYl+UqnofM9bsC/TGRh/QX87aFHnbSSLTO
         UxHZJb13UGWvYgmQ2OeI3cRzPzxjUSnptpF3k7m2m6QLSGXbLLQWYacSBYCprZiw5jJy
         QTHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791387854; x=1791992654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vwhFsVuhT0WTTw+YrQxYsYSj+h2QHZvVIQ6QQ3MaZf4=;
        b=WrzEAd7QmR/YeIuywwA5ufW9+LqfhuzmXHLcki/CodqQDB9CHpRRmlpM2w3y2hTUJF
         Koc6yI7FVsmix4Oc1RPxvX7aCUdUjv12s2goHhfoJOIZ7GtDIBPjGX/kvuNaOW85BiRX
         LllAtfaBJ2m3LZM1k0vqVNOJxxFV077qvo+vRkSHL5jd5wUM4oUxVzqSRzFV266Iry0E
         TDFOgYQBsgxcU3uGdgYnK5PZc2MEIRx+aemxaR7Ff7IQyWMktyvIrpwa1y1y7oY49Xa8
         E9tgVOSHmRYLRAhb0SMRDxnCzwshDu4lz8RbLKSg8aU7qihaqLACR2oCW3KJXP4OQTfp
         lvDA==
X-Gm-Message-State: AFq9FYIA0nZbnkbs0iuqCMz3/n2P+8fdkFI5E48K1AsdS0nKlLWz3Q9z
	JzzHIBA8lP+mEeGNmbSrF28Dal7D9YDZqGZ0S3cDH49OMoMxSiNqEAmlHCrs/nq+EW0=
X-Gm-Gg: AYBFou2paEtVAhbREJtxngKMmsa9Mod45MlVrWAMO7pGuYM3XL42bwm3amxiaDoBeQC
	Svl7SHEgg5h1Jghm/1H4XCO1u77mlEqhnK9AWnLUE+eEIQlyE8Lm0G+Djd3Wpwvlkae0hXHSDFP
	aFX/1Dtg8J1NyRJqedd4INhf6zBfSapwbRL79ZFWEwe9NDYnKCCbVHOMkQavLEQyxcHWVakUlNB
	uoqaDHD1qDDgVUJxvhOrdntecdJIwK/RwZM1QGh74svgFeXuJhjwjOtUUzL7CBAUxJQJh9Gphlr
	lIN6sQloA3vfN969HeGZMWlqyczFKy1C7ctPs/RCyB14BojhfDDWY1u/dDTiHemHogImPtml7m2
	d8lfuYOdqrqTDIieUjdzdAdt3BQKZ/mWt+01kNwA+xOPGcmDce+vHJN11njuUUOthQVwICQli4I
	wbqvOCHBxUM5D25wCvhNQ0bJgdHUqTHzHY5s5CawmtPh+ecaHj5fGQ5Xy/LnObX0cjs2fI856yY
	vKLXpXytUYbeDSmrde8Qxlub9n41nkG6ZtFeSqh
X-Received: by 2002:a05:7300:6810:b0:351:6528:b57c with SMTP id 5a478bee46e88-3516528d4a1mr2868028eec.0.1791387853904;
        Wed, 07 Oct 2026 08:44:13 -0700 (PDT)
Received: from hitalo (190-33-161-131.in-addr.arpa.host.souuni.com. [131.161.33.190])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515af7ab9fsm7876955eec.18.2026.10.07.08.44.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 08:44:13 -0700 (PDT)
From: Hitalo Souza <enghitalo@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-kernel@vger.kernel.org,
	Hitalo Souza <enghitalo@gmail.com>
Subject: [PATCH 3/3] Bluetooth: Don't leave abandoned SCO links up in the controller
Date: Wed,  7 Oct 2026 11:43:53 -0400
Message-ID: <20261007154353.148223-4-enghitalo@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261007154353.148223-1-enghitalo@gmail.com>
References: <20261007154353.148223-1-enghitalo@gmail.com>
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for
aborting connections"), aborting a SCO/eSCO connection whose setup is
pending, e.g. because its socket was closed, sends Create Connection
Cancel and deletes the hci_conn. That command cannot cancel a
synchronous connection, controllers just fail it (ACL Connection Already
Exists or Unknown Connection Identifier), and the link may still
complete afterwards. Unless another connection to the device takes it
over, its completion event then finds no connection waiting for it and
is ignored; if it comes while the abort is still queued, the connection
refuses the handle as it is being aborted and is deleted all the same.
Either way the link stays up in the controller, which rejects every
later setup for the device until the ACL drops (with Unsupported LMP
Parameter Value on a MediaTek MT7921). The same happens to a second
link completing for a connection that is already up, e.g. its own setup
after it took over the abandoned one.

There is no command to cancel a pending SCO/eSCO setup, so don't send
Create Connection Cancel for one, and disconnect a SCO/eSCO link that
completes with no connection to take it.

With the disable_esco parameter of sco.c, a SCO_LINK connection can get
an eSCO link, which it does not take: its connect times out and the link
stays up until the ACL drops. That is not changed here, and such a link
is not disconnected while a SCO_LINK connection waits for its link.

Link: https://github.com/bluez/bluez/issues/2562
Fixes: a13f316e90fd ("Bluetooth: hci_conn: Consolidate code for aborting connections")
Assisted-by: LLM
Signed-off-by: Hitalo Souza <enghitalo@gmail.com>
---
 net/bluetooth/hci_event.c | 61 +++++++++++++++++++++++++++++++++++----
 net/bluetooth/hci_sync.c  |  8 +++++
 2 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index cbe53e19e..102a0a4d1 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3217,6 +3217,27 @@ static int hci_read_enc_key_size(struct hci_dev *hdev, struct hci_conn *conn)
 	return hci_send_cmd(hdev, HCI_OP_READ_ENC_KEY_SIZE, sizeof(cp), &cp);
 }
 
+/* A SCO/eSCO link that completes with no connection to take it, e.g.
+ * because its setup was abandoned while pending, must be disconnected:
+ * otherwise it stays up in the controller, which then rejects every further
+ * setup for the device.
+ */
+static void hci_sco_disconnect_orphan(struct hci_dev *hdev, __le16 handle)
+{
+	struct hci_cp_disconnect cp;
+	u16 h = __le16_to_cpu(handle);
+
+	/* Never for an invalid handle or one that a connection uses */
+	if (h > HCI_CONN_HANDLE_MAX || hci_conn_hash_lookup_handle(hdev, h))
+		return;
+
+	bt_dev_dbg(hdev, "handle 0x%4.4x", h);
+
+	cp.handle = handle;
+	cp.reason = HCI_ERROR_REMOTE_USER_TERM;
+	hci_send_cmd(hdev, HCI_OP_DISCONNECT, sizeof(cp), &cp);
+}
+
 static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 				  struct sk_buff *skb)
 {
@@ -3273,8 +3294,10 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 
 			conn = hci_conn_hash_lookup_ba(hdev, ESCO_LINK,
 						       &ev->bdaddr);
-			if (!conn)
+			if (!conn) {
+				hci_sco_disconnect_orphan(hdev, ev->handle);
 				goto unlock;
+			}
 
 			conn->type = SCO_LINK;
 		}
@@ -3293,8 +3316,12 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 
 	if (!status) {
 		status = hci_conn_set_handle(conn, __le16_to_cpu(ev->handle));
-		if (status)
+		if (status) {
+			/* e.g. it is being aborted: the link is not taken */
+			if (ev->link_type == SCO_LINK)
+				hci_sco_disconnect_orphan(hdev, ev->handle);
 			goto done;
+		}
 
 		if (conn->type == ACL_LINK) {
 			conn->state = BT_CONFIG;
@@ -5178,8 +5205,18 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev, void *data,
 
 	conn = hci_conn_hash_lookup_ba(hdev, ev->link_type, &ev->bdaddr);
 	if (!conn) {
-		if (ev->link_type == ESCO_LINK)
-			goto unlock;
+		if (ev->link_type == ESCO_LINK) {
+			/* A SCO_LINK connection still waiting for its link can
+			 * get an eSCO one, see disable_esco in sco.c. It does
+			 * not take it, as before, and the link is left alone.
+			 */
+			conn = hci_conn_hash_lookup_ba(hdev, SCO_LINK,
+						       &ev->bdaddr);
+			if (conn && HCI_CONN_HANDLE_UNSET(conn->handle))
+				goto unlock;
+
+			goto orphan;
+		}
 
 		/* When the link type in the event indicates SCO connection
 		 * and lookup of the connection object fails, then check
@@ -5192,7 +5229,7 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev, void *data,
 		 */
 		conn = hci_conn_hash_lookup_ba(hdev, ESCO_LINK, &ev->bdaddr);
 		if (!conn)
-			goto unlock;
+			goto orphan;
 	}
 
 	/* The HCI_Synchronous_Connection_Complete event is only sent once per connection.
@@ -5202,6 +5239,13 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev, void *data,
 	 * whether the connection is already set up.
 	 */
 	if (!HCI_CONN_HANDLE_UNSET(conn->handle)) {
+		/* Another link for a connection that is already up, e.g. its
+		 * own setup completing after it took over an abandoned one,
+		 * has no connection waiting for it either.
+		 */
+		if (__le16_to_cpu(ev->handle) != conn->handle)
+			goto orphan;
+
 		bt_dev_err(hdev, "Ignoring HCI_Sync_Conn_Complete event for existing connection");
 		goto unlock;
 	}
@@ -5210,6 +5254,8 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev, void *data,
 	case 0x00:
 		status = hci_conn_set_handle(conn, __le16_to_cpu(ev->handle));
 		if (status) {
+			/* e.g. it is being aborted: the link is not taken */
+			hci_sco_disconnect_orphan(hdev, ev->handle);
 			conn->state = BT_CLOSED;
 			break;
 		}
@@ -5260,6 +5306,11 @@ static void hci_sync_conn_complete_evt(struct hci_dev *hdev, void *data,
 	hci_connect_cfm(conn, status);
 	if (status)
 		hci_conn_del(conn);
+	goto unlock;
+
+orphan:
+	if (!status)
+		hci_sco_disconnect_orphan(hdev, ev->handle);
 
 unlock:
 	hci_dev_unlock(hdev);
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 9eca6757d..4e1c72fd2 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5940,6 +5940,14 @@ static int hci_connect_cancel_sync(struct hci_dev *hdev, struct hci_conn *conn,
 		return 0;
 	}
 
+	if (conn->type == SCO_LINK || conn->type == ESCO_LINK) {
+		/* There is no command to cancel a pending SCO/eSCO setup. If
+		 * the link completes anyway, it is disconnected then, unless
+		 * a new connection to the device takes it.
+		 */
+		return 0;
+	}
+
 	if (hdev->hci_ver < BLUETOOTH_VER_1_2)
 		return 0;
 
-- 
2.55.0

