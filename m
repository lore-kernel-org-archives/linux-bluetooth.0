Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A3F3EC837
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 09:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790761918; cv=none; b=oLFiDUJb1odEtHdx+RwH8B2T74SNpbDiqQ6/izckoK2R2VAWosWBGA0qucUkh2ySKrRF3IrLetkZa4g6djpmjbkV4RR/2guE5mVHAPA6G1RfhEoOWt0dWpU5FMPuXspT877R0/ExoGDVwFdq7y4u7OdQ5LjSF6jN37YO+SQBeKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790761918; c=relaxed/simple;
	bh=8bkBmuqUW674YMqwdixPhb0AHfzFKXhB7epqe8W+QYw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=GXt90jF8AHA82nbCExK8MKYokVEbUb98i3Y2XGKLLXL/+q0OAqYtSlyq8fD130jBll58luQQHJijLNmUmlNBJoBWUtzAqRBIXXrF7sj9eG7ST8YLcstxJqHty43zje7saLmKD8nZuPs9WEDvZhOKzsbj24nEgPfjQhLx5FlDpY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=JISoHEZF; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="JISoHEZF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790761911;
	bh=8bkBmuqUW674YMqwdixPhb0AHfzFKXhB7epqe8W+QYw=;
	h=From:To:Subject:Date:From;
	b=JISoHEZFcl6nM73EJShefBAaZ3NZNBGerffKJdqrfKFyHoIGouIg4eLHg2PdJVZCX
	 yPs2mVvXGMXitlgEpuJCcj3TR5KelqjmuNYYwpXV9yyz3BQbXW5Ix339QTLmF0rF2g
	 o3mtwpibQ+ewtxmOQPVT946o8GKRNVyqJnmTNxCZscHqsEif10oHmcg00Twn9ExNY/
	 3XASMCrWmVs3wOKsq8ypWJLRG4loYHI9RHv05CpL4chGNd7g/gig3KvUQaVlYftzQv
	 IcVpdiRf7DOBUJ243CbZGPNNBKiI6+eGTNlShHayFWNZ1b5x9gfUwDnS1/QoeDnyiL
	 TIrMNQHREcknw==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id C162317E02EB
	for <linux-bluetooth@vger.kernel.org>; Wed, 30 Sep 2026 11:51:51 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v6] Bluetooth: MGMT: Add management security level changed event
Date: Wed, 30 Sep 2026 11:51:46 +0200
Message-ID: <20260930095147.554276-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

Add an event on device security level or encryption type change to
let user space know which level is currently in use.
Reset security level to 0 on disconnection so further connections
will correctly report security level changes.

This will be used for BlueZ qualification automation.

Assisted-by: GPT:GPT-5.3-Codex
Signed-off-by: Frédéric Danis <frederic.danis@collabora.com>
---
v1->v2:
 - Add encryption type to the mgmt event
 - Send event on security level or encryption type change
v2->v3:
 - Replace fixed security level and ancryption type parameters by TLV array
   to allow later enhancement.
v3->v4:
 - Change MGMT_EV_SECURITY_LEVEL_CHANGED to 0x0034
 - Add __counted_by for the tlv_data
 - dynamically allow the mgmt_ev_security_level_changed structure
v4->v5: Address Sashiko comments:
 - stop overwriting tlv_count and replace it by tlv_length as kzalloc_flex()
   should already set it to the byte length. This depends on compiler
   supporting __builtin_counted_by_ref(), so explicitly set it too.
 - filter on link type to prevent sending the event for child connections
 - remove premature calls to mgmt_security_level_changed()
 - send events only on security level changes
v5->v6: Address Sashiko comments:
 - avoid a duplicate MGMT event in hci_conn_complete_evt() by not setting
   encrypt_change when the link-key branch already reports the change via
   hci_encrypt_cfm()
 - defer reporting for encrypted ACL links until hci_cc_read_enc_key_size()
   has validated the encryption key size, instead of reporting a transient
   state that a key-size downgrade could immediately invalidate

 include/net/bluetooth/hci_core.h | 15 +++++++--
 include/net/bluetooth/mgmt.h     | 14 ++++++++
 net/bluetooth/hci_conn.c         | 10 ++++++
 net/bluetooth/hci_event.c        | 58 ++++++++++++++++++++++++++++++--
 net/bluetooth/mgmt.c             | 49 +++++++++++++++++++++++++++
 5 files changed, 141 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index fb85a0ccb250..0f4a345f492c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2255,6 +2255,8 @@ static inline void hci_auth_cfm(struct hci_conn *conn, __u8 status)
 		conn->security_cfm_cb(conn, status);
 }
 
+void mgmt_security_level_changed(struct hci_conn *conn);
+
 static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status)
 {
 	struct hci_cb *cb;
@@ -2277,11 +2279,20 @@ static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status)
 		encrypt = 0x01;
 
 	if (!status) {
-		if (conn->sec_level == BT_SECURITY_SDP)
+		bool sec_level_changed  = false;
+
+		if (conn->sec_level == BT_SECURITY_SDP) {
 			conn->sec_level = BT_SECURITY_LOW;
+			sec_level_changed = true;
+		}
 
-		if (conn->pending_sec_level > conn->sec_level)
+		if (conn->pending_sec_level > conn->sec_level) {
 			conn->sec_level = conn->pending_sec_level;
+			sec_level_changed = true;
+		}
+
+		if (sec_level_changed)
+			mgmt_security_level_changed(conn);
 	}
 
 	mutex_lock(&hci_cb_list_lock);
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 1e22eab1081c..b02e915bb44c 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -1221,3 +1221,17 @@ struct mgmt_ev_conn_subrate {
 	__le16	cont_num;
 	__le16	supv_timeout;
 } __packed;
+
+#define MGMT_CONN_SEC_ENCRYPT_NONE		0x00
+#define MGMT_CONN_SEC_ENCRYPT_E0		0x01
+#define MGMT_CONN_SEC_ENCRYPT_AES_CCM		0x02
+
+#define MGMT_SEC_LEVEL_CHANGED_PARAM_LEVEL	0x0000
+#define MGMT_SEC_LEVEL_CHANGED_PARAM_ENC_TYPE	0x0001
+
+#define MGMT_EV_SECURITY_LEVEL_CHANGED		0x0034
+struct mgmt_ev_security_level_changed {
+	struct mgmt_addr_info addr;
+	__u8	tlv_length;
+	__u8	tlv_data[] __counted_by(tlv_length);
+} __packed;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index cf44452e0766..5191fd72ac9e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1233,6 +1233,11 @@ static void hci_conn_unlink(struct hci_conn *conn)
 	if (!conn->parent) {
 		struct hci_link *link, *t;
 
+		conn->sec_level = BT_SECURITY_SDP;
+		clear_bit(HCI_CONN_ENCRYPT, &conn->flags);
+		clear_bit(HCI_CONN_AES_CCM, &conn->flags);
+		mgmt_security_level_changed(conn);
+
 		list_for_each_entry_safe(link, t, &conn->link_list, list) {
 			struct hci_conn *child = link->conn;
 
@@ -1543,6 +1548,11 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 		conn->pending_sec_level = sec_level;
 	}
 
+	/* Do not report the security level here: conn->dst may still hold
+	 * the peer's RPA instead of its identity address, and the connection
+	 * is not established yet. le_conn_complete_evt() reports it once the
+	 * connection completes and the identity address has been resolved.
+	 */
 	conn->sec_level = BT_SECURITY_LOW;
 	conn->conn_timeout = conn_timeout;
 	conn->le_adv_phy = phy;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5ac2357e92c9..c576cc808dce 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -762,6 +762,13 @@ static u8 hci_cc_read_enc_key_size(struct hci_dev *hdev, void *data,
 			*key_enc_size = conn->enc_key_size;
 	}
 
+	/* Report the final security level here rather than when encryption
+	 * was first enabled: this is the only place both the success and
+	 * key-size-downgrade outcomes are known, avoiding a transient event
+	 * for a state that a downgrade would immediately invalidate.
+	 */
+	mgmt_security_level_changed(conn);
+
 	hci_encrypt_cfm(conn, status);
 
 done:
@@ -3210,6 +3217,8 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 	}
 
 	if (!status) {
+		bool encrypt_change = false;
+
 		status = hci_conn_set_handle(conn, __le16_to_cpu(ev->handle));
 		if (status)
 			goto done;
@@ -3232,8 +3241,10 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 		if (test_bit(HCI_AUTH, &hdev->flags))
 			set_bit(HCI_CONN_AUTH, &conn->flags);
 
-		if (test_bit(HCI_ENCRYPT, &hdev->flags))
+		if (test_bit(HCI_ENCRYPT, &hdev->flags)) {
 			set_bit(HCI_CONN_ENCRYPT, &conn->flags);
+			encrypt_change = true;
+		}
 
 		/* "Link key request" completed ahead of "connect request" completes */
 		if (ev->encr_mode == 1 && !test_bit(HCI_CONN_ENCRYPT, &conn->flags) &&
@@ -3244,10 +3255,22 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 			if (key) {
 				set_bit(HCI_CONN_ENCRYPT, &conn->flags);
 				hci_read_enc_key_size(hdev, conn);
+				/* Set sec_level here so hci_encrypt_cfm()'s
+				 * own change check is a no-op below: the
+				 * async hci_cc_read_enc_key_size() completion
+				 * is the sole point reporting the final
+				 * security level for this connection, once
+				 * the key size has been validated, so
+				 * encrypt_change is not set here either.
+				 */
+				conn->sec_level = conn->pending_sec_level;
 				hci_encrypt_cfm(conn, ev->status);
 			}
 		}
 
+		if (encrypt_change)
+			mgmt_security_level_changed(conn);
+
 		/* Get remote features */
 		if (conn->type == ACL_LINK) {
 			struct hci_cp_read_remote_features cp;
@@ -3514,9 +3537,14 @@ static void hci_auth_complete_evt(struct hci_dev *hdev, void *data,
 		goto unlock;
 
 	if (!ev->status) {
+		bool sec_level_changed =
+				conn->sec_level != conn->pending_sec_level;
+
 		clear_bit(HCI_CONN_AUTH_FAILURE, &conn->flags);
 		set_bit(HCI_CONN_AUTH, &conn->flags);
 		conn->sec_level = conn->pending_sec_level;
+		if (sec_level_changed)
+			mgmt_security_level_changed(conn);
 	} else {
 		if (ev->status == HCI_ERROR_PIN_OR_KEY_MISSING)
 			set_bit(HCI_CONN_AUTH_FAILURE, &conn->flags);
@@ -3632,9 +3660,20 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
 			if ((conn->type == ACL_LINK && ev->encrypt == 0x02) ||
 			    conn->type == LE_LINK)
 				set_bit(HCI_CONN_AES_CCM, &conn->flags);
+
+			/* For ACL links the encryption key size is still
+			 * validated below via hci_read_enc_key_size(). Its
+			 * completion handler, hci_cc_read_enc_key_size(),
+			 * reports the final security level so userspace does
+			 * not see a transient "encrypted" state that a
+			 * key-size downgrade would immediately invalidate.
+			 */
+			if (conn->type != ACL_LINK)
+				mgmt_security_level_changed(conn);
 		} else {
 			clear_bit(HCI_CONN_ENCRYPT, &conn->flags);
 			clear_bit(HCI_CONN_AES_CCM, &conn->flags);
+			mgmt_security_level_changed(conn);
 		}
 	}
 
@@ -3667,8 +3706,14 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
 
 	/* Try reading the encryption key size for encrypted ACL links */
 	if (!ev->status && ev->encrypt && conn->type == ACL_LINK) {
-		if (hci_read_enc_key_size(hdev, conn))
+		if (hci_read_enc_key_size(hdev, conn)) {
+			/* Could not even issue the key-size read: report the
+			 * security level now since hci_cc_read_enc_key_size()
+			 * will not run to do it.
+			 */
+			mgmt_security_level_changed(conn);
 			goto notify;
+		}
 
 		goto unlock;
 	}
@@ -5228,8 +5273,14 @@ static void hci_key_refresh_complete_evt(struct hci_dev *hdev, void *data,
 	if (conn->type != LE_LINK)
 		goto unlock;
 
-	if (!ev->status)
+	if (!ev->status) {
+		bool sec_level_changed =
+				conn->sec_level != conn->pending_sec_level;
+
 		conn->sec_level = conn->pending_sec_level;
+		if (sec_level_changed)
+			mgmt_security_level_changed(conn);
+	}
 
 	clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
 
@@ -5861,6 +5912,7 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	mgmt_device_connected(hdev, conn, NULL, 0);
 
 	conn->sec_level = BT_SECURITY_LOW;
+	mgmt_security_level_changed(conn);
 	conn->state = BT_CONFIG;
 
 	/* Store current advertising instance as connection advertising instance
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9d3de5a0b8ee..77c958322496 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -177,6 +177,7 @@ static const u16 mgmt_events[] = {
 	MGMT_EV_CONTROLLER_RESUME,
 	MGMT_EV_ADV_MONITOR_DEVICE_FOUND,
 	MGMT_EV_ADV_MONITOR_DEVICE_LOST,
+	MGMT_EV_SECURITY_LEVEL_CHANGED,
 };
 
 static const u16 mgmt_untrusted_commands[] = {
@@ -10822,6 +10823,54 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	mgmt_adv_monitor_device_found(hdev, bdaddr, report_device, skb, NULL);
 }
 
+void mgmt_security_level_changed(struct hci_conn *conn)
+{
+	struct mgmt_ev_security_level_changed *ev;
+	struct mgmt_tlv *tlv;
+	u8 *tlv_data;
+	u8 tlv_len;
+
+	/* Only ACL, LE and BIS links are tracked as mgmt connections, so
+	 * restrict the event to those link types. Other transports (SCO,
+	 * CIS, PA sync, ...) share the parent's address and would otherwise
+	 * report a spurious security level change for it.
+	 */
+	if (conn->type != ACL_LINK && conn->type != LE_LINK &&
+	    conn->type != BIS_LINK)
+		return;
+
+	tlv_len = 2 * (sizeof(*tlv) + sizeof(__u8));
+	ev = kzalloc_flex(*ev, tlv_data, tlv_len, GFP_KERNEL);
+	if (!ev)
+		return;
+
+	bacpy(&ev->addr.bdaddr, &conn->dst);
+	ev->addr.type = link_to_bdaddr(conn->type, conn->dst_type);
+	ev->tlv_length = tlv_len;
+
+	tlv_data = ev->tlv_data;
+	tlv = (void *)tlv_data;
+	tlv->type = cpu_to_le16(MGMT_SEC_LEVEL_CHANGED_PARAM_LEVEL);
+	tlv->length = sizeof(__u8);
+	tlv->value[0] = conn->sec_level;
+
+	tlv_data += sizeof(*tlv) + sizeof(__u8);
+	tlv = (void *)tlv_data;
+	tlv->type = cpu_to_le16(MGMT_SEC_LEVEL_CHANGED_PARAM_ENC_TYPE);
+	tlv->length = sizeof(__u8);
+	if (!test_bit(HCI_CONN_ENCRYPT, &conn->flags))
+		tlv->value[0] = MGMT_CONN_SEC_ENCRYPT_NONE;
+	else if (test_bit(HCI_CONN_AES_CCM, &conn->flags))
+		tlv->value[0] = MGMT_CONN_SEC_ENCRYPT_AES_CCM;
+	else
+		tlv->value[0] = MGMT_CONN_SEC_ENCRYPT_E0;
+
+	mgmt_event(MGMT_EV_SECURITY_LEVEL_CHANGED, conn->hdev, ev,
+		   struct_size(ev, tlv_data, tlv_len), NULL);
+
+	kfree(ev);
+}
+
 void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		      u8 addr_type, s8 rssi, u8 *name, u8 name_len)
 {
-- 
2.43.0

