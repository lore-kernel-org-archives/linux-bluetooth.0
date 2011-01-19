Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: ville.tervo@nokia.com
Subject: [PATCH 5/5] Bluetooth: Fix race condition with conn->sec_level
Date: Wed, 19 Jan 2011 12:06:52 +0530
Message-Id: <1295419012-25717-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1295419012-25717-1-git-send-email-johan.hedberg@gmail.com>
References: <1295419012-25717-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

The conn->sec_level value is supposed to represent the current level of
security that the connection has. However, by assigning to it before
requesting authentication it will have the wrong value during the
authentication procedure. To fix this a pending_sec_level variable is
added which is used to track the desired security level while making
sure that sec_level always represents the current level of security.

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/hci_conn.c         |    8 ++++++--
 net/bluetooth/hci_event.c        |    9 +++++----
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index a29feb0..d2cf884 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -184,6 +184,7 @@ struct hci_conn {
 	__u32		 link_mode;
 	__u8             auth_type;
 	__u8             sec_level;
+	__u8		 pending_sec_level;
 	__u8             power_save;
 	__u16            disc_timeout;
 	unsigned long	 pend;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index fe712a8..99cd8d9 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -379,7 +379,8 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 	hci_conn_hold(acl);
 
 	if (acl->state == BT_OPEN || acl->state == BT_CLOSED) {
-		acl->sec_level = sec_level;
+		acl->sec_level = BT_SECURITY_LOW;
+		acl->pending_sec_level = sec_level;
 		acl->auth_type = auth_type;
 		hci_acl_connect(acl);
 	}
@@ -437,8 +438,11 @@ static int hci_conn_auth(struct hci_conn *conn, __u8 sec_level, __u8 auth_type)
 {
 	BT_DBG("conn %p", conn);
 
+	if (conn->pending_sec_level > sec_level)
+		sec_level = conn->pending_sec_level;
+
 	if (sec_level > conn->sec_level)
-		conn->sec_level = sec_level;
+		conn->pending_sec_level = sec_level;
 	else if (conn->link_mode & HCI_LM_AUTH)
 		return 1;
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 3810017..a290854 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -692,13 +692,13 @@ static int hci_outgoing_auth_needed(struct hci_dev *hdev,
 	if (conn->state != BT_CONFIG || !conn->out)
 		return 0;
 
-	if (conn->sec_level == BT_SECURITY_SDP)
+	if (conn->pending_sec_level == BT_SECURITY_SDP)
 		return 0;
 
 	/* Only request authentication for SSP connections or non-SSP
 	 * devices with sec_level HIGH */
 	if (!(hdev->ssp_mode > 0 && conn->ssp_mode > 0) &&
-					conn->sec_level != BT_SECURITY_HIGH)
+				conn->pending_sec_level != BT_SECURITY_HIGH)
 		return 0;
 
 	return 1;
@@ -1095,9 +1095,10 @@ static inline void hci_auth_complete_evt(struct hci_dev *hdev, struct sk_buff *s
 
 	conn = hci_conn_hash_lookup_handle(hdev, __le16_to_cpu(ev->handle));
 	if (conn) {
-		if (!ev->status)
+		if (!ev->status) {
 			conn->link_mode |= HCI_LM_AUTH;
-		else
+			conn->sec_level = conn->pending_sec_level;
+		} else
 			conn->sec_level = BT_SECURITY_LOW;
 
 		clear_bit(HCI_CONN_AUTH_PEND, &conn->pend);
-- 
1.7.2.3

