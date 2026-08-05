Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC42F42AFB5
	for <linux-bluetooth@vger.kernel.org>; Wed,  5 Aug 2026 13:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785936133; cv=none; b=KoHDyM8LQpUx6YT7fhEXDe8hd546l2one7IZTZEOfe4QrJREOaV42BFAtU8CzXMYB2jwxXQbfeB9JAWh3lWWB+vIUHddf9bleG9Qrwfsk6gdt8OPgVB8X2fMUFJM6lJCtLgb0xTOpNiCQG101/N9qmFO8/KAVxFhHUH9/+oQwe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785936133; c=relaxed/simple;
	bh=XDlTnEiRcwnJj+o7tyvRtU2DE2NZNN+aUR4wghtb0Wc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=OC7PmD/iiQgzo5P2gOXgGu2SkeK26V6qwW+uwtrHNz+44ZW2KBIqidVspDawRhdlJcWt1Ns37dfUZWnwUSDEQO5JmhqG7puFrvGBQJN67EVOwX6BCQfBAoE9UbkYcX8b5oFozu/iNjRADhmeQChNMsCBLoNKwWdoIqTY0RSMcqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=hSJkDoZ9; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="hSJkDoZ9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1785936129;
	bh=XDlTnEiRcwnJj+o7tyvRtU2DE2NZNN+aUR4wghtb0Wc=;
	h=From:To:Subject:Date:From;
	b=hSJkDoZ92Uc38G2ZCWFwVJuawhGfYKmTuWAeTW46gDAWJK7fCFKOqFZ3QsapLuopX
	 CITM6vD/E25upkjscXhFSm/oskEW4yOBZL0vnPVsZhwMQZ1+KNzFCsNqoaln/SgU0E
	 caMC2t5SEJG/4F5uZqhkcWcdbSKo1v8BDblpIbcDJP+dK9PYWdQ2ufG0QhRe+xhmLz
	 XRkgwZAMjI8cpEsL8TWCzGCPryLkb2mLGNEzyZBJaatoJdOcpIu5i3Bze38SZYQEXH
	 BWtc5P8KBYDIGq21bfi7BWGlDBOikeNssAbiIuX2cwvTR7aQY8plO93EVO/yUFL4YI
	 eTtxp4h7UqS4w==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 7E0F417E025E
	for <linux-bluetooth@vger.kernel.org>; Wed, 05 Aug 2026 15:22:09 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v4] Bluetooth: MGMT: Add management security level changed event
Date: Wed,  5 Aug 2026 15:22:03 +0200
Message-ID: <20260805132203.176213-1-frederic.danis@collabora.com>
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

 include/net/bluetooth/hci_core.h | 15 ++++++++++--
 include/net/bluetooth/mgmt.h     | 14 +++++++++++
 net/bluetooth/hci_conn.c         |  8 +++++++
 net/bluetooth/hci_event.c        | 20 ++++++++++++++--
 net/bluetooth/mgmt.c             | 40 ++++++++++++++++++++++++++++++++
 5 files changed, 93 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 01b938c4b24a..c7a4c0e74cbd 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2199,6 +2199,8 @@ static inline void hci_auth_cfm(struct hci_conn *conn, __u8 status)
 		conn->security_cfm_cb(conn, status);
 }
 
+void mgmt_security_level_changed(struct hci_conn *conn);
+
 static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status)
 {
 	struct hci_cb *cb;
@@ -2221,11 +2223,20 @@ static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status)
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
index 1e22eab1081c..7d9cec30bf08 100644
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
+	__u8	tlv_count;
+	__u8	tlv_data[] __counted_by(tlv_count);
+} __packed;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b1f911fd4ad6..d87a1bf096e4 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1202,6 +1202,11 @@ static void hci_conn_unlink(struct hci_conn *conn)
 	if (!conn->parent) {
 		struct hci_link *link, *t;
 
+		conn->sec_level = BT_SECURITY_SDP;
+		clear_bit(HCI_CONN_ENCRYPT, &conn->flags);
+		clear_bit(HCI_CONN_AES_CCM, &conn->flags);
+		mgmt_security_level_changed(conn);
+
 		list_for_each_entry_safe(link, t, &conn->link_list, list) {
 			struct hci_conn *child = link->conn;
 
@@ -1504,6 +1509,7 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	}
 
 	conn->sec_level = BT_SECURITY_LOW;
+	mgmt_security_level_changed(conn);
 	conn->conn_timeout = conn_timeout;
 	conn->le_adv_phy = phy;
 	conn->le_adv_sec_phy = sec_phy;
@@ -1731,6 +1737,7 @@ struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
 	conn->state = BT_CONNECT;
 	set_bit(HCI_CONN_SCANNING, &conn->flags);
 	conn->sec_level = BT_SECURITY_LOW;
+	mgmt_security_level_changed(conn);
 	conn->pending_sec_level = sec_level;
 	conn->conn_timeout = conn_timeout;
 	conn->conn_reason = conn_reason;
@@ -1779,6 +1786,7 @@ struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 		int err;
 
 		acl->sec_level = BT_SECURITY_LOW;
+		mgmt_security_level_changed(acl);
 		acl->pending_sec_level = sec_level;
 		acl->auth_type = auth_type;
 		acl->conn_timeout = timeout;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 9c8bf6708356..8ec12e62e864 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -767,6 +767,7 @@ static u8 hci_cc_read_enc_key_size(struct hci_dev *hdev, void *data,
 			status = HCI_ERROR_AUTH_FAILURE;
 			clear_bit(HCI_CONN_ENCRYPT, &conn->flags);
 			clear_bit(HCI_CONN_AES_CCM, &conn->flags);
+			mgmt_security_level_changed(conn);
 		}
 
 		/* Update the key encryption size with the connection one */
@@ -3222,6 +3223,8 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 	}
 
 	if (!status) {
+		bool encrypt_change = false;
+
 		status = hci_conn_set_handle(conn, __le16_to_cpu(ev->handle));
 		if (status)
 			goto done;
@@ -3244,8 +3247,10 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 		if (test_bit(HCI_AUTH, &hdev->flags))
 			set_bit(HCI_CONN_AUTH, &conn->flags);
 
-		if (test_bit(HCI_ENCRYPT, &hdev->flags))
+		if (test_bit(HCI_ENCRYPT, &hdev->flags)) {
 			set_bit(HCI_CONN_ENCRYPT, &conn->flags);
+			encrypt_change = true;
+		}
 
 		/* "Link key request" completed ahead of "connect request" completes */
 		if (ev->encr_mode == 1 && !test_bit(HCI_CONN_ENCRYPT, &conn->flags) &&
@@ -3255,11 +3260,15 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
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
@@ -3529,6 +3538,7 @@ static void hci_auth_complete_evt(struct hci_dev *hdev, void *data,
 		clear_bit(HCI_CONN_AUTH_FAILURE, &conn->flags);
 		set_bit(HCI_CONN_AUTH, &conn->flags);
 		conn->sec_level = conn->pending_sec_level;
+		mgmt_security_level_changed(conn);
 	} else {
 		if (ev->status == HCI_ERROR_PIN_OR_KEY_MISSING)
 			set_bit(HCI_CONN_AUTH_FAILURE, &conn->flags);
@@ -3644,9 +3654,12 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
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
 
@@ -5240,8 +5253,10 @@ static void hci_key_refresh_complete_evt(struct hci_dev *hdev, void *data,
 	if (conn->type != LE_LINK)
 		goto unlock;
 
-	if (!ev->status)
+	if (!ev->status) {
 		conn->sec_level = conn->pending_sec_level;
+		mgmt_security_level_changed(conn);
+	}
 
 	clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
 
@@ -5872,6 +5887,7 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	mgmt_device_connected(hdev, conn, NULL, 0);
 
 	conn->sec_level = BT_SECURITY_LOW;
+	mgmt_security_level_changed(conn);
 	conn->state = BT_CONFIG;
 
 	/* Store current advertising instance as connection advertising instance
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 09edd72acc22..b74c99bb8cb9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -177,6 +177,7 @@ static const u16 mgmt_events[] = {
 	MGMT_EV_CONTROLLER_RESUME,
 	MGMT_EV_ADV_MONITOR_DEVICE_FOUND,
 	MGMT_EV_ADV_MONITOR_DEVICE_LOST,
+	MGMT_EV_SECURITY_LEVEL_CHANGED,
 };
 
 static const u16 mgmt_untrusted_commands[] = {
@@ -10777,6 +10778,45 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	mgmt_adv_monitor_device_found(hdev, bdaddr, report_device, skb, NULL);
 }
 
+void mgmt_security_level_changed(struct hci_conn *conn)
+{
+	struct mgmt_ev_security_level_changed *ev;
+	struct mgmt_tlv *tlv;
+	u8 *tlv_data;
+	u8 tlv_len;
+
+	tlv_len = 2 * (sizeof(*tlv) + sizeof(__u8));
+	ev = kzalloc_flex(*ev, tlv_data, tlv_len, GFP_ATOMIC);
+	if (!ev)
+		return;
+
+	bacpy(&ev->addr.bdaddr, &conn->dst);
+	ev->addr.type = link_to_bdaddr(conn->type, conn->dst_type);
+	ev->tlv_count = 2;
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

