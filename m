Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 814D73D9DBA
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 10:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790676587; cv=none; b=ebJEtxaZS0CoMZatZl57g0me+N31bzLHKIFi2JNz8Jcd3niL2EYl/lczW2aILN888isqEr4fx0GnjZCC6sU0I8aWVMFr5cOGFBtu1UMY4If+JLsABk56F/oVSEr+9Dbv91y/4L+XedRGUdXIO11MD5I4+Q4Zw9yr8+0bHRfsecI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790676587; c=relaxed/simple;
	bh=2f89lGzBj83QCpV/NBK2d1edoxrkBei/ReUM26OM7hU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=QPziNDd2D/0YfD9K1iGADebL9iwWxi2pU93ezZptOIKjXI1PPoJtmvkADm3lw9YUT0g9HyOnmG8jKWL+H5azBRV/U02tfFj6l9gqIIXjK7VD2+15OJkPGdoDOjs9ui//uaes9psPYrDK1mZfeBa2s199f1EtNIDGoT2uX2NpvFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UA7yFZzd; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UA7yFZzd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790676569;
	bh=2f89lGzBj83QCpV/NBK2d1edoxrkBei/ReUM26OM7hU=;
	h=From:To:Subject:Date:From;
	b=UA7yFZzddtc/gNyy5Vto/jGxDRxQvNHC1JatkYp06r5G2gGM9uBStVAHGSr7kqw0v
	 3IAKSTezyfMd+lZlAoz628rWjvH9V/u06dQaLWIPl/x+uXdcLkI6V2/9I9S06jmjag
	 T2Z+5+W3bBoIMVyJNXscwDavpK72Tvc8hCuM+zOe67WFQBBrAKub+qv1I4jKtu8R4V
	 hScsjwpwk6lODpW+lemM5nztC6uSSoktz9yZMFV+L6QtasBv9Mn2Po82ksCDtsvAR8
	 bmNt3S5+r7zAZK+Bt6gYg60TsR7ERaJnSP9VFCuh7Q2NluLckYmQpHxmgJdShTdhTG
	 EVvXBxXySw0ig==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 31B5417E007B
	for <linux-bluetooth@vger.kernel.org>; Tue, 29 Sep 2026 12:09:29 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5] Bluetooth: MGMT: Add management security level changed event
Date: Tue, 29 Sep 2026 12:09:23 +0200
Message-ID: <20260929100923.252597-1-frederic.danis@collabora.com>
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
 - filter on link type to prevent to send event for child connection
 - remove premature calls to mgmt_security_level_changed()
 - send events only on security level changes

 include/net/bluetooth/hci_core.h | 15 ++++++++--
 include/net/bluetooth/mgmt.h     | 14 +++++++++
 net/bluetooth/hci_conn.c         | 10 +++++++
 net/bluetooth/hci_event.c        | 28 ++++++++++++++++--
 net/bluetooth/mgmt.c             | 49 ++++++++++++++++++++++++++++++++
 5 files changed, 112 insertions(+), 4 deletions(-)

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
index 5ac2357e92c9..e2961e1837aa 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -755,6 +755,7 @@ static u8 hci_cc_read_enc_key_size(struct hci_dev *hdev, void *data,
 			status = HCI_ERROR_AUTH_FAILURE;
 			clear_bit(HCI_CONN_ENCRYPT, &conn->flags);
 			clear_bit(HCI_CONN_AES_CCM, &conn->flags);
+			mgmt_security_level_changed(conn);
 		}
 
 		/* Update the key encryption size with the connection one */
@@ -3210,6 +3211,8 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 	}
 
 	if (!status) {
+		bool encrypt_change = false;
+
 		status = hci_conn_set_handle(conn, __le16_to_cpu(ev->handle));
 		if (status)
 			goto done;
@@ -3232,8 +3235,10 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 		if (test_bit(HCI_AUTH, &hdev->flags))
 			set_bit(HCI_CONN_AUTH, &conn->flags);
 
-		if (test_bit(HCI_ENCRYPT, &hdev->flags))
+		if (test_bit(HCI_ENCRYPT, &hdev->flags)) {
 			set_bit(HCI_CONN_ENCRYPT, &conn->flags);
+			encrypt_change = true;
+		}
 
 		/* "Link key request" completed ahead of "connect request" completes */
 		if (ev->encr_mode == 1 && !test_bit(HCI_CONN_ENCRYPT, &conn->flags) &&
@@ -3243,11 +3248,15 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 			key = hci_find_link_key(hdev, &ev->bdaddr);
 			if (key) {
 				set_bit(HCI_CONN_ENCRYPT, &conn->flags);
+				encrypt_change = true;
 				hci_read_enc_key_size(hdev, conn);
 				hci_encrypt_cfm(conn, ev->status);
 			}
 		}
 
+		if (encrypt_change)
+			mgmt_security_level_changed(conn);
+
 		/* Get remote features */
 		if (conn->type == ACL_LINK) {
 			struct hci_cp_read_remote_features cp;
@@ -3514,9 +3523,14 @@ static void hci_auth_complete_evt(struct hci_dev *hdev, void *data,
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
@@ -3632,9 +3646,12 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
 			if ((conn->type == ACL_LINK && ev->encrypt == 0x02) ||
 			    conn->type == LE_LINK)
 				set_bit(HCI_CONN_AES_CCM, &conn->flags);
+
+			mgmt_security_level_changed(conn);
 		} else {
 			clear_bit(HCI_CONN_ENCRYPT, &conn->flags);
 			clear_bit(HCI_CONN_AES_CCM, &conn->flags);
+			mgmt_security_level_changed(conn);
 		}
 	}
 
@@ -5228,8 +5245,14 @@ static void hci_key_refresh_complete_evt(struct hci_dev *hdev, void *data,
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
 
@@ -5861,6 +5884,7 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
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

