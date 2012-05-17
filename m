Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 6/7] Bluetooth: Fix coding style in hci_conn.c
Date: Thu, 17 May 2012 00:36:25 -0300
Message-Id: <1337225786-11064-6-git-send-email-gustavo@padovan.org>
In-Reply-To: <1337225786-11064-5-git-send-email-gustavo@padovan.org>
References: <1337225786-11064-1-git-send-email-gustavo@padovan.org>
 <1337225786-11064-2-git-send-email-gustavo@padovan.org>
 <1337225786-11064-3-git-send-email-gustavo@padovan.org>
 <1337225786-11064-4-git-send-email-gustavo@padovan.org>
 <1337225786-11064-5-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Follow net subsystem rules.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/hci_conn.c |   26 ++++++++++++--------------
 1 file changed, 12 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 3f18a6e..971601e 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -185,7 +185,7 @@ void hci_setup_sync(struct hci_conn *conn, __u16 handle)
 }
 
 void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max,
-					u16 latency, u16 to_multiplier)
+			u16 latency, u16 to_multiplier)
 {
 	struct hci_cp_le_conn_update cp;
 	struct hci_dev *hdev = conn->hdev;
@@ -205,7 +205,7 @@ void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max,
 EXPORT_SYMBOL(hci_le_conn_update);
 
 void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
-							__u8 ltk[16])
+		      __u8 ltk[16])
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_cp_le_start_enc cp;
@@ -247,7 +247,7 @@ void hci_sco_setup(struct hci_conn *conn, __u8 status)
 static void hci_conn_timeout(struct work_struct *work)
 {
 	struct hci_conn *conn = container_of(work, struct hci_conn,
-							disc_work.work);
+					     disc_work.work);
 	__u8 reason;
 
 	BT_DBG("conn %p state %s", conn, state_to_string(conn->state));
@@ -327,7 +327,7 @@ static void hci_conn_auto_accept(unsigned long arg)
 	struct hci_dev *hdev = conn->hdev;
 
 	hci_send_cmd(hdev, HCI_OP_USER_CONFIRM_REPLY, sizeof(conn->dst),
-								&conn->dst);
+		     &conn->dst);
 }
 
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
@@ -376,7 +376,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 	INIT_DELAYED_WORK(&conn->disc_work, hci_conn_timeout);
 	setup_timer(&conn->idle_timer, hci_conn_idle, (unsigned long)conn);
 	setup_timer(&conn->auto_accept_timer, hci_conn_auto_accept,
-							(unsigned long) conn);
+		    (unsigned long) conn);
 
 	atomic_set(&conn->refcnt, 0);
 
@@ -545,7 +545,7 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
 	hci_conn_hold(sco);
 
 	if (acl->state == BT_CONNECTED &&
-			(sco->state == BT_OPEN || sco->state == BT_CLOSED)) {
+	    (sco->state == BT_OPEN || sco->state == BT_CLOSED)) {
 		set_bit(HCI_CONN_POWER_SAVE, &acl->flags);
 		hci_conn_enter_active_mode(acl, BT_POWER_FORCE_ACTIVE_ON);
 
@@ -600,7 +600,7 @@ static int hci_conn_auth(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
 
 		cp.handle = cpu_to_le16(conn->handle);
 		hci_send_cmd(conn->hdev, HCI_OP_AUTH_REQUESTED,
-							sizeof(cp), &cp);
+			     sizeof(cp), &cp);
 		if (conn->key_type != 0xff)
 			set_bit(HCI_CONN_REAUTH_PEND, &conn->flags);
 	}
@@ -618,7 +618,7 @@ static void hci_conn_encrypt(struct hci_conn *conn)
 		cp.handle  = cpu_to_le16(conn->handle);
 		cp.encrypt = 0x01;
 		hci_send_cmd(conn->hdev, HCI_OP_SET_CONN_ENCRYPT, sizeof(cp),
-									&cp);
+			     &cp);
 	}
 }
 
@@ -648,8 +648,7 @@ int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
 	/* An unauthenticated combination key has sufficient security for
 	   security level 1 and 2. */
 	if (conn->key_type == HCI_LK_UNAUTH_COMBINATION &&
-			(sec_level == BT_SECURITY_MEDIUM ||
-			sec_level == BT_SECURITY_LOW))
+	    (sec_level == BT_SECURITY_MEDIUM || sec_level == BT_SECURITY_LOW))
 		goto encrypt;
 
 	/* A combination key has always sufficient security for the security
@@ -657,8 +656,7 @@ int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
 	   is generated using maximum PIN code length (16).
 	   For pre 2.1 units. */
 	if (conn->key_type == HCI_LK_COMBINATION &&
-			(sec_level != BT_SECURITY_HIGH ||
-			conn->pin_length == 16))
+	    (sec_level != BT_SECURITY_HIGH || conn->pin_length == 16))
 		goto encrypt;
 
 auth:
@@ -701,7 +699,7 @@ int hci_conn_change_link_key(struct hci_conn *conn)
 		struct hci_cp_change_conn_link_key cp;
 		cp.handle = cpu_to_le16(conn->handle);
 		hci_send_cmd(conn->hdev, HCI_OP_CHANGE_CONN_LINK_KEY,
-							sizeof(cp), &cp);
+			     sizeof(cp), &cp);
 	}
 
 	return 0;
@@ -752,7 +750,7 @@ void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active)
 timer:
 	if (hdev->idle_timeout > 0)
 		mod_timer(&conn->idle_timer,
-			jiffies + msecs_to_jiffies(hdev->idle_timeout));
+			  jiffies + msecs_to_jiffies(hdev->idle_timeout));
 }
 
 /* Drop all connection on the device */
-- 
1.7.10.1

