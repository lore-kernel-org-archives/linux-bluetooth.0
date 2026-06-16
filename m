Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D5635201E
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 14:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781621951; cv=none; b=Py0H4QFF6BSSnC7AkqS/0JdUXbbGe4mvl+pEVcD4q/HhpKOg/64yYVlvYp8gzIEth6MmIyPHm3jpPzG6M+JMlbXb2sCSTmWJMlBT0SML4rSqJ/LB0gAxUmSEmL9neS4KjL1kmczPXl7gerVDo2fleoVAKzi+a4W2su3zuY86XTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781621951; c=relaxed/simple;
	bh=oQYrAJ6SufV6gxGAtlR1UU3RkZ2lYBbUc65ezJ5Op3Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=ubpz/HLbgkhz1Y9Ql3gncyWc2OGe6uv/kq5wVOEKvHacdHzF3J0pIgWhSJJOYNry61TeoIjdIvmaeGxtAHKrLTCGkJJHhv9MePYhDCcxD1nhEj1Gy/DXOibQmkHoPBridnyAH9t7lVKP0diG1y17ac2I0CmHjuEeeYE+A7mC8LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=QP/rpM86; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="QP/rpM86"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1781621948;
	bh=oQYrAJ6SufV6gxGAtlR1UU3RkZ2lYBbUc65ezJ5Op3Y=;
	h=From:To:Subject:Date:From;
	b=QP/rpM863oez9ccKSWQ0CgJUNKtQDK4AyhcbtW29lzmaXYja4St2YSsfvYH7HVSV7
	 jzQajtrIMC1cXdcK2Vg02Y9eoA7B5KbrLG7sZa6ziog86J0WTI0SwYCMd9OcARspbc
	 BS3qwXKizSxOO153tYD4wxu55jYUsCRT5jMo2w5fKYwvKE619m5wJ6Rczdjp8hDuo/
	 y9tBAWlexnlxSpCLMBoKS4aspC662uTLNsRl+AIIC7nv+F06+K3LHkAb9EAT/5boda
	 KKpkfV1B414W544oFOm/FBOfcgaY9qeleW9jxjhkfG7H9IATzFenx0WUusQWQ4vt41
	 L1qcYZQHmMFgg==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id D458D17E03CE
	for <linux-bluetooth@vger.kernel.org>; Tue, 16 Jun 2026 16:59:07 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: MGMT: Add management security level changed event
Date: Tue, 16 Jun 2026 16:58:55 +0200
Message-ID: <20260616145855.342740-1-frederic.danis@collabora.com>
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

Signed-off-by: Frédéric Danis <frederic.danis@collabora.com>
---
v1->v2:
 - Add encryption type to the mgmt event
 - Send event on security level or encryption type change

 include/net/bluetooth/hci_core.h | 15 +++++++++++++--
 include/net/bluetooth/mgmt.h     | 11 +++++++++++
 net/bluetooth/hci_conn.c         |  8 ++++++++
 net/bluetooth/hci_event.c        | 20 ++++++++++++++++++--
 net/bluetooth/mgmt.c             | 20 ++++++++++++++++++++
 5 files changed, 70 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 7e15da47fe3a..2920229c7f0b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -2177,6 +2177,8 @@ static inline void hci_auth_cfm(struct hci_conn *conn, __u8 status)
 		conn->security_cfm_cb(conn, status);
 }
 
+void mgmt_security_level_changed(struct hci_conn *conn);
+
 static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status)
 {
 	struct hci_cb *cb;
@@ -2199,11 +2201,20 @@ static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status)
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
index 08daed7a96d5..69e0f3503e79 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -1192,3 +1192,14 @@ struct mgmt_ev_mesh_device_found {
 struct mgmt_ev_mesh_pkt_cmplt {
 	__u8	handle;
 } __packed;
+
+#define MGMT_CONN_SEC_ENCRYPT_NONE		0x00
+#define MGMT_CONN_SEC_ENCRYPT_E0		0x01
+#define MGMT_CONN_SEC_ENCRYPT_AES_CCM		0x02
+
+#define MGMT_EV_SECURITY_LEVEL_CHANGED		0x0033
+struct mgmt_ev_security_level_changed {
+	struct mgmt_addr_info addr;
+	__u8   level;
+	__u8   enc_type;
+} __packed;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index c335372e4062..c9fb134c8891 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1200,6 +1200,11 @@ static void hci_conn_unlink(struct hci_conn *conn)
 	if (!conn->parent) {
 		struct hci_link *link, *t;
 
+		conn->sec_level = BT_SECURITY_SDP;
+		clear_bit(HCI_CONN_ENCRYPT, &conn->flags);
+		clear_bit(HCI_CONN_AES_CCM, &conn->flags);
+		mgmt_security_level_changed(conn);
+
 		list_for_each_entry_safe(link, t, &conn->link_list, list) {
 			struct hci_conn *child = link->conn;
 
@@ -1502,6 +1507,7 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 	}
 
 	conn->sec_level = BT_SECURITY_LOW;
+	mgmt_security_level_changed(conn);
 	conn->conn_timeout = conn_timeout;
 	conn->le_adv_phy = phy;
 	conn->le_adv_sec_phy = sec_phy;
@@ -1729,6 +1735,7 @@ struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
 	conn->state = BT_CONNECT;
 	set_bit(HCI_CONN_SCANNING, &conn->flags);
 	conn->sec_level = BT_SECURITY_LOW;
+	mgmt_security_level_changed(conn);
 	conn->pending_sec_level = sec_level;
 	conn->conn_timeout = conn_timeout;
 	conn->conn_reason = conn_reason;
@@ -1777,6 +1784,7 @@ struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 		int err;
 
 		acl->sec_level = BT_SECURITY_LOW;
+		mgmt_security_level_changed(acl);
 		acl->pending_sec_level = sec_level;
 		acl->auth_type = auth_type;
 		acl->conn_timeout = timeout;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b6d963ce26d0..15086780b766 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -762,6 +762,7 @@ static u8 hci_cc_read_enc_key_size(struct hci_dev *hdev, void *data,
 			status = HCI_ERROR_AUTH_FAILURE;
 			clear_bit(HCI_CONN_ENCRYPT, &conn->flags);
 			clear_bit(HCI_CONN_AES_CCM, &conn->flags);
+			mgmt_security_level_changed(conn);
 		}
 
 		/* Update the key encryption size with the connection one */
@@ -3184,6 +3185,8 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 	}
 
 	if (!status) {
+		bool encrypt_change = false;
+
 		status = hci_conn_set_handle(conn, __le16_to_cpu(ev->handle));
 		if (status)
 			goto done;
@@ -3206,8 +3209,10 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
 		if (test_bit(HCI_AUTH, &hdev->flags))
 			set_bit(HCI_CONN_AUTH, &conn->flags);
 
-		if (test_bit(HCI_ENCRYPT, &hdev->flags))
+		if (test_bit(HCI_ENCRYPT, &hdev->flags)) {
 			set_bit(HCI_CONN_ENCRYPT, &conn->flags);
+			encrypt_change = true;
+		}
 
 		/* "Link key request" completed ahead of "connect request" completes */
 		if (ev->encr_mode == 1 && !test_bit(HCI_CONN_ENCRYPT, &conn->flags) &&
@@ -3217,11 +3222,15 @@ static void hci_conn_complete_evt(struct hci_dev *hdev, void *data,
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
@@ -3507,6 +3516,7 @@ static void hci_auth_complete_evt(struct hci_dev *hdev, void *data,
 		clear_bit(HCI_CONN_AUTH_FAILURE, &conn->flags);
 		set_bit(HCI_CONN_AUTH, &conn->flags);
 		conn->sec_level = conn->pending_sec_level;
+		mgmt_security_level_changed(conn);
 	} else {
 		if (ev->status == HCI_ERROR_PIN_OR_KEY_MISSING)
 			set_bit(HCI_CONN_AUTH_FAILURE, &conn->flags);
@@ -3622,9 +3632,12 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
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
 
@@ -5215,8 +5228,10 @@ static void hci_key_refresh_complete_evt(struct hci_dev *hdev, void *data,
 	if (conn->type != LE_LINK)
 		goto unlock;
 
-	if (!ev->status)
+	if (!ev->status) {
 		conn->sec_level = conn->pending_sec_level;
+		mgmt_security_level_changed(conn);
+	}
 
 	clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
 
@@ -5847,6 +5862,7 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 	mgmt_device_connected(hdev, conn, NULL, 0);
 
 	conn->sec_level = BT_SECURITY_LOW;
+	mgmt_security_level_changed(conn);
 	conn->state = BT_CONFIG;
 
 	/* Store current advertising instance as connection advertising instance
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index dc55763f9e58..b02181f945d8 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -177,6 +177,7 @@ static const u16 mgmt_events[] = {
 	MGMT_EV_CONTROLLER_RESUME,
 	MGMT_EV_ADV_MONITOR_DEVICE_FOUND,
 	MGMT_EV_ADV_MONITOR_DEVICE_LOST,
+	MGMT_EV_SECURITY_LEVEL_CHANGED,
 };
 
 static const u16 mgmt_untrusted_commands[] = {
@@ -10534,6 +10535,25 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	mgmt_adv_monitor_device_found(hdev, bdaddr, report_device, skb, NULL);
 }
 
+void mgmt_security_level_changed(struct hci_conn *conn)
+{
+	struct mgmt_ev_security_level_changed ev;
+
+	bacpy(&ev.addr.bdaddr, &conn->dst);
+	ev.addr.type = link_to_bdaddr(conn->type, conn->dst_type);
+	ev.level = conn->sec_level;
+
+	if (!test_bit(HCI_CONN_ENCRYPT, &conn->flags))
+		ev.enc_type = MGMT_CONN_SEC_ENCRYPT_NONE;
+	else if (test_bit(HCI_CONN_AES_CCM, &conn->flags))
+		ev.enc_type = MGMT_CONN_SEC_ENCRYPT_AES_CCM;
+	else
+		ev.enc_type = MGMT_CONN_SEC_ENCRYPT_E0;
+
+	mgmt_event(MGMT_EV_SECURITY_LEVEL_CHANGED, conn->hdev, &ev, sizeof(ev),
+		   NULL);
+}
+
 void mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		      u8 addr_type, s8 rssi, u8 *name, u8 name_len)
 {
-- 
2.43.0

