Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD7401E8320
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2026 11:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779883138; cv=none; b=izLORYtP3Cjn3avZXjHKfSlXL0BfVcq0ELla+ge37t6+NPk+eICJFkdo903Q6YQUc/f8KjAkPQ968MKMPQ/g9vdSOtWVl/CBTA7H8MlgqNyvZLTRWcwLOgPsuOquIj63noaYc57dN7VzqY7HplMWFyuNP7rvG8jpi/7iWCd80BI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779883138; c=relaxed/simple;
	bh=Jk8/E99mA0CCc01rGN6Gsgl2xfOwPv9QcXTOfbcmMZM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=ZWF+fsWJ9Yf+1FfIfSYhUABTzhI3TMfbMMfbrBGEJ3sASZiyqUKg3lbagGNZeLtEviAFi67H8JaRtRX78uZRaNJyugQCH0dTtI15L8wACmc+VR0Ev54BJbrU2I+FrWBk5b4kBQu4D7qXXnpYl1NaEiOyKJWVSM386/Y+Yz5Y50w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BqdaTgpK; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BqdaTgpK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1779883129;
	bh=Jk8/E99mA0CCc01rGN6Gsgl2xfOwPv9QcXTOfbcmMZM=;
	h=From:To:Subject:Date:From;
	b=BqdaTgpKoDQl+cPsbW+UeD0WmJBAhgLsKojDwxTkmfgcYiFtYJC6D4PXNc7+y4fAV
	 fjUQ4HLZYPV4U+c1BkqCEWgOrRM4jbC8yuIiWlhxPeEtkChJ8kThAdyoi3kugv5tQy
	 IZDj8yDzDA0LLzEer4ALAwiZMTXhaiEb6wrDQEy+xCv2p2LelrESvLdxjU112UzvPB
	 iIKPwhZDfX9SLPmlnJ1z34f76sSIvv9OhXmP7E4eg3XGnm1t4NdixvNze5HbW/wskA
	 eIzeKmXhEnWKs9DT1jiYehBUKxBxkhbJlM3wB7bmVGCC5ululTtOqMu49wX6gaaozI
	 mqDuIjuccoBjg==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 25E2617E0CF3
	for <linux-bluetooth@vger.kernel.org>; Wed, 27 May 2026 13:58:49 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: MGMT: Add management security level changed event
Date: Wed, 27 May 2026 13:58:41 +0200
Message-ID: <20260527115841.267098-1-frederic.danis@collabora.com>
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

Add an event on device security level change to let user space
know which level is currently in use.
Reset security level to 0 on disconnection so further connections
will correctly report security level changes.

This will be used for BlueZ qualification automation.

Signed-off-by: Frédéric Danis <frederic.danis@collabora.com>
---
 include/net/bluetooth/hci_core.h |  7 +++++--
 include/net/bluetooth/mgmt.h     |  6 ++++++
 net/bluetooth/hci_conn.c         | 16 +++++++++++++---
 net/bluetooth/hci_event.c        |  8 ++++----
 net/bluetooth/mgmt.c             | 13 +++++++++++++
 5 files changed, 41 insertions(+), 9 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index aa600fbf9a53..5883d563bd6b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1863,6 +1863,8 @@ int hci_remove_ltk(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 bdaddr_type);
 void hci_smp_ltks_clear(struct hci_dev *hdev);
 int hci_remove_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr);
 
+void hci_conn_set_sec_level(struct hci_conn *conn, u8 sec_level);
+
 struct smp_irk *hci_find_irk_by_rpa(struct hci_dev *hdev, bdaddr_t *rpa);
 struct smp_irk *hci_find_irk_by_addr(struct hci_dev *hdev, bdaddr_t *bdaddr,
 				     u8 addr_type);
@@ -2203,10 +2205,10 @@ static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status)
 
 	if (!status) {
 		if (conn->sec_level == BT_SECURITY_SDP)
-			conn->sec_level = BT_SECURITY_LOW;
+			hci_conn_set_sec_level(conn, BT_SECURITY_LOW);
 
 		if (conn->pending_sec_level > conn->sec_level)
-			conn->sec_level = conn->pending_sec_level;
+			hci_conn_set_sec_level(conn, conn->pending_sec_level);
 	}
 
 	mutex_lock(&hci_cb_list_lock);
@@ -2493,6 +2495,7 @@ void mgmt_advertising_removed(struct sock *sk, struct hci_dev *hdev,
 int mgmt_phy_configuration_changed(struct hci_dev *hdev, struct sock *skip);
 void mgmt_adv_monitor_device_lost(struct hci_dev *hdev, u16 handle,
 				  bdaddr_t *bdaddr, u8 addr_type);
+void mgmt_security_level_changed(struct hci_conn *conn, u8 level);
 
 int hci_abort_conn(struct hci_conn *conn, u8 reason);
 void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max, u16 latency,
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 8234915854b6..9f145e387e3c 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -1195,3 +1195,9 @@ struct mgmt_ev_mesh_device_found {
 struct mgmt_ev_mesh_pkt_cmplt {
 	__u8	handle;
 } __packed;
+
+#define MGMT_EV_SECURITY_LEVEL_CHANGED		0x0033
+struct mgmt_ev_security_level_changed {
+	struct mgmt_addr_info addr;
+	__u8   level;
+} __packed;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 54eabaa46960..6eeebd1583fe 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1203,6 +1203,8 @@ static void hci_conn_unlink(struct hci_conn *conn)
 	if (!conn->parent) {
 		struct hci_link *link, *t;
 
+		hci_conn_set_sec_level(conn, BT_SECURITY_SDP);
+
 		list_for_each_entry_safe(link, t, &conn->link_list, list) {
 			struct hci_conn *child = link->conn;
 
@@ -1504,7 +1506,7 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
 		conn->pending_sec_level = sec_level;
 	}
 
-	conn->sec_level = BT_SECURITY_LOW;
+	hci_conn_set_sec_level(conn, BT_SECURITY_LOW);
 	conn->conn_timeout = conn_timeout;
 	conn->le_adv_phy = phy;
 	conn->le_adv_sec_phy = sec_phy;
@@ -1731,7 +1733,7 @@ struct hci_conn *hci_connect_le_scan(struct hci_dev *hdev, bdaddr_t *dst,
 
 	conn->state = BT_CONNECT;
 	set_bit(HCI_CONN_SCANNING, &conn->flags);
-	conn->sec_level = BT_SECURITY_LOW;
+	hci_conn_set_sec_level(conn, BT_SECURITY_LOW);
 	conn->pending_sec_level = sec_level;
 	conn->conn_timeout = conn_timeout;
 	conn->conn_reason = conn_reason;
@@ -1779,7 +1781,7 @@ struct hci_conn *hci_connect_acl(struct hci_dev *hdev, bdaddr_t *dst,
 	if (acl->state == BT_OPEN || acl->state == BT_CLOSED) {
 		int err;
 
-		acl->sec_level = BT_SECURITY_LOW;
+		hci_conn_set_sec_level(acl, BT_SECURITY_LOW);
 		acl->pending_sec_level = sec_level;
 		acl->auth_type = auth_type;
 		acl->conn_timeout = timeout;
@@ -3391,3 +3393,11 @@ int hci_ethtool_ts_info(unsigned int index, int sk_proto,
 	hci_dev_put(hdev);
 	return 0;
 }
+
+void hci_conn_set_sec_level(struct hci_conn *conn, u8 sec_level)
+{
+	if (sec_level != conn->sec_level) {
+		conn->sec_level = sec_level;
+		mgmt_security_level_changed(conn, sec_level);
+	}
+}
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index eea2f810aafa..d1108ce73a39 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3502,7 +3502,7 @@ static void hci_auth_complete_evt(struct hci_dev *hdev, void *data,
 	if (!ev->status) {
 		clear_bit(HCI_CONN_AUTH_FAILURE, &conn->flags);
 		set_bit(HCI_CONN_AUTH, &conn->flags);
-		conn->sec_level = conn->pending_sec_level;
+		hci_conn_set_sec_level(conn, conn->pending_sec_level);
 	} else {
 		if (ev->status == HCI_ERROR_PIN_OR_KEY_MISSING)
 			set_bit(HCI_CONN_AUTH_FAILURE, &conn->flags);
@@ -3609,7 +3609,7 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
 			/* Encryption implies authentication */
 			set_bit(HCI_CONN_AUTH, &conn->flags);
 			set_bit(HCI_CONN_ENCRYPT, &conn->flags);
-			conn->sec_level = conn->pending_sec_level;
+			hci_conn_set_sec_level(conn, conn->pending_sec_level);
 
 			/* P-256 authentication key implies FIPS */
 			if (conn->key_type == HCI_LK_AUTH_COMBINATION_P256)
@@ -5212,7 +5212,7 @@ static void hci_key_refresh_complete_evt(struct hci_dev *hdev, void *data,
 		goto unlock;
 
 	if (!ev->status)
-		conn->sec_level = conn->pending_sec_level;
+		hci_conn_set_sec_level(conn, conn->pending_sec_level);
 
 	clear_bit(HCI_CONN_ENCRYPT_PEND, &conn->flags);
 
@@ -5842,7 +5842,7 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 
 	mgmt_device_connected(hdev, conn, NULL, 0);
 
-	conn->sec_level = BT_SECURITY_LOW;
+	hci_conn_set_sec_level(conn, BT_SECURITY_LOW);
 	conn->state = BT_CONFIG;
 
 	/* Store current advertising instance as connection advertising instance
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index de5bd6b637b2..933ac34fc8ac 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -180,6 +180,7 @@ static const u16 mgmt_events[] = {
 	MGMT_EV_CONTROLLER_RESUME,
 	MGMT_EV_ADV_MONITOR_DEVICE_FOUND,
 	MGMT_EV_ADV_MONITOR_DEVICE_LOST,
+	MGMT_EV_SECURITY_LEVEL_CHANGED,
 };
 
 static const u16 mgmt_untrusted_commands[] = {
@@ -10533,6 +10534,18 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	mgmt_adv_monitor_device_found(hdev, bdaddr, report_device, skb, NULL);
 }
 
+void mgmt_security_level_changed(struct hci_conn *conn, u8 level)
+{
+	struct mgmt_ev_security_level_changed ev;
+
+	bacpy(&ev.addr.bdaddr, &conn->dst);
+	ev.addr.type = link_to_bdaddr(conn->type, conn->dst_type);
+	ev.level = level;
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

