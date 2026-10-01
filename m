Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5EF91F5834
	for <linux-bluetooth@vger.kernel.org>; Thu,  1 Oct 2026 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790862678; cv=none; b=N3wYAvBG5EmDOFjcfND2otwEwOFW+hdu5cc47ktzY037swRJHNU3AS0abmVpvi0s/hPcfElFO2fYd9gfmuYDisuru+dJ8n3vyLlYdUaDSeWwbDZUXkE4ggztbcTdK9IbnAxf/VqB0jVvDYLhIL1n2CSdfZX0bXBTK0yNgLo4lVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790862678; c=relaxed/simple;
	bh=mgpuNJd4pV0phO8AwNCGZZxCYoQeemgrWpuhH4jwKOA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Type; b=Z6p982ghdMsdNa5tSEg2UiA6DQqdFxdLOEN+X0uAlC2ghNKB5VcBEquIktnH4c/ziINRBbbYrzeI26RLd08+NsAV0cR8/Nb9Pcmo4Thf0G7lag+QdnqJ3bhadqA7N56gqSd0qYh/dI4Lhkbj05aJ0SvQy3ZLsWZXcoNeolofj+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=FxFt14Bz; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="FxFt14Bz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1790862673;
	bh=mgpuNJd4pV0phO8AwNCGZZxCYoQeemgrWpuhH4jwKOA=;
	h=From:To:Subject:Date:From;
	b=FxFt14Bz9JhBeJtZ84dA6Ws+f4ZRNP8Dl6aUW++VNyPRov18fpQ0I/YiWDOHemddP
	 UlALW3RZ+5jRLMrDfv6c06sBPlw1hWDDYwNZPwwLs6yms0SCFj/BonM55VWLR3yoov
	 Xr0qJBguxZbwzMx/GOLm1uN7t3wqUqSKVv47v0NQ+a9F8IYdypqCQuB/SaRtjfCN7E
	 BpIoXaV36uam17+uX59WGBk1XGCqhgFjEM7a9kxqtkVXs8chC5hARJgwX0sOqQp8oL
	 A6OEK2ezIVzQhIkEmfaSoIaTNDCCqTjobI1KmSsM8rA8eCjZadOxVYyKxMg0MAzVLL
	 RX2EVz/bw7wAg==
Received: from fdanis-ThinkPad-X1.. (unknown [100.64.1.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 6BAA517E01C2
	for <linux-bluetooth@vger.kernel.org>; Thu, 01 Oct 2026 15:51:13 +0200 (CEST)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v9] Bluetooth: MGMT: Add management security level changed event
Date: Thu,  1 Oct 2026 15:51:08 +0200
Message-ID: <20261001135108.964362-1-frederic.danis@collabora.com>
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
Assisted-by: Copilot:claude-sonnet-5
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
v6->v7: Address Sashiko comments:
 - report the security level only from mgmt_device_connected(), right
   after MGMT_EV_DEVICE_CONNECTED, when the connection is still being
   set up (BT_CONFIG) at the time the change happens, so userspace is
   never told about a security level before knowing about the connection
 - in hci_cc_read_enc_key_size(), always pre-apply hci_encrypt_cfm()'s
   upgrade rules, since hci_encrypt_change_evt() can already have set
   conn->sec_level directly and defeat hci_encrypt_cfm()'s own change
   detection
 - in hci_cc_read_enc_key_size(), use
   test_bit(HCI_CONN_MGMT_CONNECTED, ...) instead of
   conn->state == BT_CONFIG to decide whether to report immediately or
   defer to mgmt_device_connected(): the latter can already have fired
   while still in BT_CONFIG (e.g. pairing with authentication pending),
   which was silently dropping the encryption type update
 - keep reporting the security level reset in hci_conn_unlink() on
   disconnection, after MGMT_EV_DEVICE_DISCONNECTED: userspace (e.g.
   BlueZ) relies on this event to clear its cached security level and
   encryption type
 - in le_conn_complete_evt(), set conn->sec_level to BT_SECURITY_LOW
   before calling mgmt_device_connected() instead of after, to avoid
   reporting a spurious initial SDP event before the real one
v7->v8: Address Sashiko comments:
 - move the HCI_CONN_MGMT_CONNECTED check into
   mgmt_security_level_changed() itself, dropping the now redundant
   check from all call sites, to stop premature events for connections
   not yet announced to userspace
 - change mgmt_connect_failed() to peek at HCI_CONN_MGMT_CONNECTED
   instead of consuming it, so hci_conn_unlink() can still see it to
   report the security level reset
 - remove the now dead mgmt_security_level_changed() call in
   hci_conn_complete_evt()
 - stop reporting the security level right after authentication
   completes in hci_auth_complete_evt(), before encryption is actually
   confirmed
 - downgrade conn->sec_level to BT_SECURITY_LOW before reporting when
   encryption is disabled (hci_encrypt_change_evt()) or the key-size
   check fails (hci_cc_read_enc_key_size()), instead of advertising a
   stale elevated level alongside MGMT_CONN_SEC_ENCRYPT_NONE
 - set conn->sec_level to BT_SECURITY_LOW for incoming BR/EDR
   connections in hci_conn_request_evt(), like already done for LE in
   le_conn_complete_evt()
 - skip the security level reset report in hci_conn_unlink() when hdev
   is down, since no MGMT_EV_DEVICE_DISCONNECTED was ever sent in that
   case
 - remove the dead pending_sec_level > sec_level upgrade check in
   hci_encrypt_cfm(), unreachable since all callers already set
   conn->sec_level = conn->pending_sec_level themselves
v8->v9: Address Sashiko comments:
 - in hci_cc_read_enc_key_size(), also clear HCI_CONN_ENCRYPT/AES_CCM
   and downgrade conn->sec_level when the READ_ENC_KEY_SIZE command
   itself fails, matching the key-size-too-small path, so the
   unconditional mgmt_security_level_changed() call does not broadcast
   a stale elevated security level

 include/net/bluetooth/hci_core.h |  18 +++--
 include/net/bluetooth/mgmt.h     |  14 ++++
 net/bluetooth/hci_conn.c         |  28 ++++++++
 net/bluetooth/hci_event.c        | 118 +++++++++++++++++++++++++++++--
 net/bluetooth/mgmt.c             |  67 +++++++++++++++++-
 5 files changed, 233 insertions(+), 12 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index fb85a0ccb250..f631d9484a0b 100644
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
@@ -2277,11 +2279,19 @@ static inline void hci_encrypt_cfm(struct hci_conn *conn, __u8 status)
 		encrypt = 0x01;
 
 	if (!status) {
-		if (conn->sec_level == BT_SECURITY_SDP)
+		/* Callers either set conn->sec_level = conn->pending_sec_level
+		 * unconditionally before calling this function, or never
+		 * reach here with status == 0 (e.g. conn->state == BT_CONFIG
+		 * returns early above, or status is actually an error).  So
+		 * conn->pending_sec_level is never greater than
+		 * conn->sec_level at this point; only the initial
+		 * BT_SECURITY_SDP -> BT_SECURITY_LOW bump can still happen
+		 * here.
+		 */
+		if (conn->sec_level == BT_SECURITY_SDP) {
 			conn->sec_level = BT_SECURITY_LOW;
-
-		if (conn->pending_sec_level > conn->sec_level)
-			conn->sec_level = conn->pending_sec_level;
+			mgmt_security_level_changed(conn);
+		}
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
index cf44452e0766..29da3fe2b953 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1233,6 +1233,29 @@ static void hci_conn_unlink(struct hci_conn *conn)
 	if (!conn->parent) {
 		struct hci_link *link, *t;
 
+		conn->sec_level = BT_SECURITY_SDP;
+		clear_bit(HCI_CONN_ENCRYPT, &conn->flags);
+		clear_bit(HCI_CONN_AES_CCM, &conn->flags);
+		/* mgmt_security_level_changed() reports the reset only if
+		 * this connection was actually reported to userspace as
+		 * connected (it checks HCI_CONN_MGMT_CONNECTED itself), so it
+		 * must be called before the flag is cleared below.
+		 * Callers that already know whether the connection was
+		 * mgmt-connected (e.g. disconnect event handlers) only peek
+		 * at the flag, so it is still set here; this is the place
+		 * actually clearing it.
+		 *
+		 * Skip the report if hdev is down: this means
+		 * hci_dev_close_sync()/hci_conn_hash_flush() is in progress
+		 * and no MGMT_EV_DEVICE_DISCONNECTED was ever sent for this
+		 * connection, so sending a security level reset here would
+		 * be a spurious, order-less event; the adapter-wide powered
+		 * off notification is enough for userspace to reset state.
+		 */
+		if (test_bit(HCI_UP, &hdev->flags))
+			mgmt_security_level_changed(conn);
+		clear_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags);
+
 		list_for_each_entry_safe(link, t, &conn->link_list, list) {
 			struct hci_conn *child = link->conn;
 
@@ -1543,6 +1566,11 @@ struct hci_conn *hci_connect_le(struct hci_dev *hdev, bdaddr_t *dst,
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
index 5ac2357e92c9..a3359aaad001 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -732,6 +732,14 @@ static u8 hci_cc_read_enc_key_size(struct hci_dev *hdev, void *data,
 		bt_dev_err(hdev, "failed to read key size for handle %u",
 			   handle);
 		conn->enc_key_size = 0;
+		clear_bit(HCI_CONN_ENCRYPT, &conn->flags);
+		clear_bit(HCI_CONN_AES_CCM, &conn->flags);
+		/* Downgrade to reflect the connection no longer being
+		 * encrypted, instead of advertising a stale elevated
+		 * security level alongside MGMT_CONN_SEC_ENCRYPT_NONE.
+		 */
+		if (conn->sec_level > BT_SECURITY_LOW)
+			conn->sec_level = BT_SECURITY_LOW;
 	} else {
 		u8 *key_enc_size = hci_conn_key_enc_size(conn);
 
@@ -755,6 +763,25 @@ static u8 hci_cc_read_enc_key_size(struct hci_dev *hdev, void *data,
 			status = HCI_ERROR_AUTH_FAILURE;
 			clear_bit(HCI_CONN_ENCRYPT, &conn->flags);
 			clear_bit(HCI_CONN_AES_CCM, &conn->flags);
+			/* Downgrade to reflect the connection no longer being
+			 * encrypted, instead of advertising a stale elevated
+			 * security level alongside MGMT_CONN_SEC_ENCRYPT_NONE.
+			 */
+			if (conn->sec_level > BT_SECURITY_LOW)
+				conn->sec_level = BT_SECURITY_LOW;
+		} else {
+			/* Pre-apply hci_encrypt_cfm()'s own upgrade rules
+			 * here unconditionally on success, so its internal
+			 * change check below always finds nothing new: this
+			 * function remains the sole place deciding whether
+			 * and when to report the change, regardless of
+			 * whether the caller already touched conn->sec_level
+			 * (e.g. hci_encrypt_change_evt()) or not.
+			 */
+			if (conn->sec_level == BT_SECURITY_SDP)
+				conn->sec_level = BT_SECURITY_LOW;
+			if (conn->pending_sec_level > conn->sec_level)
+				conn->sec_level = conn->pending_sec_level;
 		}
 
 		/* Update the key encryption size with the connection one */
@@ -764,6 +791,13 @@ static u8 hci_cc_read_enc_key_size(struct hci_dev *hdev, void *data,
 
 	hci_encrypt_cfm(conn, status);
 
+	/* mgmt_security_level_changed() only reports the change for
+	 * connections already announced to userspace (it checks
+	 * HCI_CONN_MGMT_CONNECTED itself); otherwise it is a no-op here and
+	 * reporting is deferred to mgmt_device_connected().
+	 */
+	mgmt_security_level_changed(conn);
+
 done:
 	hci_dev_unlock(hdev);
 
@@ -2762,7 +2796,11 @@ static void hci_cs_disconnect(struct hci_dev *hdev, u8 status)
 	if (hdev->suspended)
 		conn->state = BT_CLOSED;
 
-	mgmt_conn = test_and_clear_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags);
+	/* Only peek at the flag here: hci_conn_del() (via hci_conn_unlink())
+	 * still needs it set to know whether to report the security level
+	 * reset, so it is consumed there instead of here.
+	 */
+	mgmt_conn = test_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags);
 
 	if (conn->type == ACL_LINK) {
 		if (test_and_clear_bit(HCI_CONN_FLUSH_KEY, &conn->flags))
@@ -3366,6 +3404,16 @@ static void hci_conn_request_evt(struct hci_dev *hdev, void *data,
 			bt_dev_err(hdev, "connection err: %ld", PTR_ERR(conn));
 			goto unlock;
 		}
+
+		/* Unlike outgoing BR/EDR connections, conn->sec_level is not
+		 * set at connection request time for incoming connections,
+		 * so it is still at its zero-initialized value
+		 * (BT_SECURITY_SDP) here. Set it to BT_SECURITY_LOW so
+		 * mgmt_device_connected() later reports the correct initial
+		 * security level instead of a transient, never-really-in-use
+		 * SDP value.
+		 */
+		conn->sec_level = BT_SECURITY_LOW;
 	}
 
 	memcpy(conn->dev_class, ev->dev_class, 3);
@@ -3432,7 +3480,11 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, void *data,
 
 	conn->state = BT_CLOSED;
 
-	mgmt_connected = test_and_clear_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags);
+	/* Only peek at the flag here: hci_conn_del() (via hci_conn_unlink())
+	 * still needs it set to know whether to report the security level
+	 * reset, so it is consumed there instead of here.
+	 */
+	mgmt_connected = test_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags);
 
 	if (test_bit(HCI_CONN_AUTH_FAILURE, &conn->flags))
 		reason = MGMT_DEV_DISCONN_AUTH_FAILURE;
@@ -3516,6 +3568,15 @@ static void hci_auth_complete_evt(struct hci_dev *hdev, void *data,
 	if (!ev->status) {
 		clear_bit(HCI_CONN_AUTH_FAILURE, &conn->flags);
 		set_bit(HCI_CONN_AUTH, &conn->flags);
+		/* Authentication alone does not imply encryption: for SSP
+		 * capable devices, encryption is only requested below, and
+		 * for legacy devices it is requested by a separate
+		 * HCI_OP_SET_CONN_ENCRYPT command. Do not report the new
+		 * security level yet, to avoid userspace seeing an elevated
+		 * level alongside no encryption; hci_encrypt_change_evt()
+		 * (possibly via hci_cc_read_enc_key_size() for ACL links)
+		 * reports it once encryption is actually confirmed.
+		 */
 		conn->sec_level = conn->pending_sec_level;
 	} else {
 		if (ev->status == HCI_ERROR_PIN_OR_KEY_MISSING)
@@ -3632,9 +3693,28 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
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
+			/* Elevated security levels (MEDIUM and above) require
+			 * encryption, so downgrade to reflect the connection
+			 * no longer being encrypted before reporting, instead
+			 * of advertising a stale elevated level alongside
+			 * MGMT_CONN_SEC_ENCRYPT_NONE.
+			 */
+			if (conn->sec_level > BT_SECURITY_LOW)
+				conn->sec_level = BT_SECURITY_LOW;
+			mgmt_security_level_changed(conn);
 		}
 	}
 
@@ -3667,8 +3747,14 @@ static void hci_encrypt_change_evt(struct hci_dev *hdev, void *data,
 
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
@@ -5228,8 +5314,14 @@ static void hci_key_refresh_complete_evt(struct hci_dev *hdev, void *data,
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
 
@@ -5858,9 +5950,16 @@ static void le_conn_complete_evt(struct hci_dev *hdev, u8 status,
 		goto unlock;
 	}
 
+	/* Unlike outgoing BR/EDR connections, conn->sec_level is not set at
+	 * connection request time for LE, so it is still at its
+	 * zero-initialized value (BT_SECURITY_SDP) here. Set it to
+	 * BT_SECURITY_LOW before reporting the connection so
+	 * mgmt_device_connected() reports the correct initial security level
+	 * instead of a transient, never-really-in-use SDP value.
+	 */
+	conn->sec_level = BT_SECURITY_LOW;
 	mgmt_device_connected(hdev, conn, NULL, 0);
 
-	conn->sec_level = BT_SECURITY_LOW;
 	conn->state = BT_CONFIG;
 
 	/* Store current advertising instance as connection advertising instance
@@ -7311,8 +7410,13 @@ static void hci_le_big_sync_lost_evt(struct hci_dev *hdev, void *data,
 						     BT_CONNECTED,
 						     HCI_ROLE_SLAVE))) {
 		if (!mgmt_conn) {
-			mgmt_conn = test_and_clear_bit(HCI_CONN_MGMT_CONNECTED,
-						       &bis->flags);
+			/* Only peek at the flag here: hci_conn_del() (via
+			 * hci_conn_unlink()) still needs it set to know
+			 * whether to report the security level reset, so
+			 * it is consumed there instead of here.
+			 */
+			mgmt_conn = test_bit(HCI_CONN_MGMT_CONNECTED,
+					     &bis->flags);
 			mgmt_device_disconnected(hdev, &bis->dst, bis->type,
 						 bis->dst_type, ev->reason,
 						 mgmt_conn);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9b4688015abf..b5b55fe4698c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -177,6 +177,7 @@ static const u16 mgmt_events[] = {
 	MGMT_EV_CONTROLLER_RESUME,
 	MGMT_EV_ADV_MONITOR_DEVICE_FOUND,
 	MGMT_EV_ADV_MONITOR_DEVICE_LOST,
+	MGMT_EV_SECURITY_LEVEL_CHANGED,
 };
 
 static const u16 mgmt_untrusted_commands[] = {
@@ -10082,6 +10083,15 @@ void mgmt_device_connected(struct hci_dev *hdev, struct hci_conn *conn,
 	ev->eir_len = cpu_to_le16(eir_len);
 
 	mgmt_event_skb(skb, NULL);
+
+	/* Report the security level currently in use now that the connection
+	 * itself has been announced. For connections that negotiate
+	 * encryption as part of setup (e.g. via an existing link key),
+	 * conn->sec_level is already finalized by this point, so this is
+	 * the first opportunity to report it without risking a premature
+	 * event for a connection userspace does not know about yet.
+	 */
+	mgmt_security_level_changed(conn);
 }
 
 static void unpair_device_rsp(struct mgmt_pending_cmd *cmd, void *data)
@@ -10188,7 +10198,11 @@ void mgmt_connect_failed(struct hci_dev *hdev, struct hci_conn *conn, u8 status)
 {
 	struct mgmt_ev_connect_failed ev;
 
-	if (test_and_clear_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags)) {
+	/* Only peek at the flag here: hci_conn_del() (via hci_conn_unlink())
+	 * still needs it set to know whether to report the security level
+	 * reset, so it is consumed there instead of here.
+	 */
+	if (test_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags)) {
 		mgmt_device_disconnected(hdev, &conn->dst, conn->type,
 					 conn->dst_type,
 					 hci_to_mgmt_reason(status), true);
@@ -10822,6 +10836,57 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	mgmt_adv_monitor_device_found(hdev, bdaddr, report_device, skb, NULL);
 }
 
+void mgmt_security_level_changed(struct hci_conn *conn)
+{
+	struct mgmt_ev_security_level_changed *ev;
+	struct mgmt_tlv *tlv;
+	u8 *tlv_data;
+	u8 tlv_len;
+
+	if (!test_bit(HCI_CONN_MGMT_CONNECTED, &conn->flags))
+		return;
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

