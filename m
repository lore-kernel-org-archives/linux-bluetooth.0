Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Johan Hedberg <johan.hedberg@gmail.com>, <padovan@profusion.mobi>,
	Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH v2 1/6] Bluetooth: Add definitions for link key types
Date: Thu, 21 Apr 2011 09:54:16 +0200
Message-ID: <1303372461-11848-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Introduce the link key types defs and use them instead of magic numbers.

Signed-off-by: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
---
 include/net/bluetooth/hci.h |    9 +++++++++
 net/bluetooth/hci_core.c    |    2 +-
 net/bluetooth/hci_event.c   |    7 ++++---
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 6138e31..e0a3cf1 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -246,6 +246,15 @@ enum {
 #define HCI_AT_GENERAL_BONDING		0x04
 #define HCI_AT_GENERAL_BONDING_MITM	0x05
 
+/* Link Key types */
+#define HCI_LK_COMBINATION		0x00
+#define HCI_LK_LOCAL_UNIT		0x01
+#define HCI_LK_REMOTE_UNIT		0x02
+#define HCI_LK_DEBUG_COMBINATION	0x03
+#define HCI_LK_UNAUTH_COMBINATION	0x04
+#define HCI_LK_AUTH_COMBINATION		0x05
+#define HCI_LK_CHANGED_COMBINATION	0x06
+
 /* -----  HCI Commands ---- */
 #define HCI_OP_NOP			0x0000
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a80bc1c..cfa5621 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1049,7 +1049,7 @@ int hci_add_link_key(struct hci_dev *hdev, int new_key, bdaddr_t *bdaddr,
 	if (new_key)
 		mgmt_new_key(hdev->id, key, old_key_type);
 
-	if (type == 0x06)
+	if (type == HCI_LK_CHANGED_COMBINATION)
 		key->type = old_key_type;
 
 	return 0;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c7eb073..36eb062 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2037,15 +2037,16 @@ static inline void hci_link_key_request_evt(struct hci_dev *hdev, struct sk_buff
 	BT_DBG("%s found key type %u for %s", hdev->name, key->type,
 							batostr(&ev->bdaddr));
 
-	if (!test_bit(HCI_DEBUG_KEYS, &hdev->flags) && key->type == 0x03) {
+	if (!test_bit(HCI_DEBUG_KEYS, &hdev->flags) &&
+				key->type == HCI_LK_DEBUG_COMBINATION) {
 		BT_DBG("%s ignoring debug key", hdev->name);
 		goto not_found;
 	}
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
 
-	if (key->type == 0x04 && conn && conn->auth_type != 0xff &&
-						(conn->auth_type & 0x01)) {
+	if (key->type == HCI_LK_UNAUTH_COMBINATION && conn &&
+			conn->auth_type != 0xff && (conn->auth_type & 0x01)) {
 		BT_DBG("%s ignoring unauthenticated key", hdev->name);
 		goto not_found;
 	}
-- 
1.7.1

