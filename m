Return-Path: <cyrus@holtmann.org>
From: Vishal Agarwal <vishal.agarwal@stericsson.com>
To: <linux-bluetooth@vger.kernel.org>
Cc: <vishal.agarwal@stericsson.com>
Subject: [PATCH] Bluetooth: hci_persistent_key should return bool
Date: Thu, 12 Apr 2012 15:33:33 +0530
Message-ID: <1334225013-27564-1-git-send-email-vishal.agarwal@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch changes the return type of function hci_persistent_key
from int to bool.
Signed-off-by: Vishal Agarwal <vishal.agarwal@stericsson.com>
---
 include/net/bluetooth/hci_core.h |    2 +-
 net/bluetooth/hci_core.c         |   21 +++++++++++----------
 net/bluetooth/mgmt.c             |    2 +-
 3 files changed, 13 insertions(+), 12 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c0b232c..8a9abe2 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -983,7 +983,7 @@ int mgmt_discoverable(struct hci_dev *hdev, u8 discoverable);
 int mgmt_connectable(struct hci_dev *hdev, u8 connectable);
 int mgmt_write_scan_failed(struct hci_dev *hdev, u8 scan, u8 status);
 int mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
-		      u8 persistent);
+		      bool persistent);
 int mgmt_device_connected(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 			  u8 addr_type, u32 flags, u8 *name, u8 name_len,
 			  u8 *dev_class);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 52c7abf..703c28d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1219,40 +1219,40 @@ struct link_key *hci_find_link_key(struct hci_dev *hdev, bdaddr_t *bdaddr)
 	return NULL;
 }
 
-static int hci_persistent_key(struct hci_dev *hdev, struct hci_conn *conn,
+static bool hci_persistent_key(struct hci_dev *hdev, struct hci_conn *conn,
 						u8 key_type, u8 old_key_type)
 {
 	/* Legacy key */
 	if (key_type < 0x03)
-		return 1;
+		return true;
 
 	/* Debug keys are insecure so don't store them persistently */
 	if (key_type == HCI_LK_DEBUG_COMBINATION)
-		return 0;
+		return false;
 
 	/* Changed combination key and there's no previous one */
 	if (key_type == HCI_LK_CHANGED_COMBINATION && old_key_type == 0xff)
-		return 0;
+		return false;
 
 	/* Security mode 3 case */
 	if (!conn)
-		return 1;
+		return true;
 
 	/* Neither local nor remote side had no-bonding as requirement */
 	if (conn->auth_type > 0x01 && conn->remote_auth > 0x01)
-		return 1;
+		return true;
 
 	/* Local side had dedicated bonding as requirement */
 	if (conn->auth_type == 0x02 || conn->auth_type == 0x03)
-		return 1;
+		return true;
 
 	/* Remote side had dedicated bonding as requirement */
 	if (conn->remote_auth == 0x02 || conn->remote_auth == 0x03)
-		return 1;
+		return true;
 
 	/* If none of the above criteria match, then don't store the key
 	 * persistently */
-	return 0;
+	return false;
 }
 
 struct smp_ltk *hci_find_ltk(struct hci_dev *hdev, __le16 ediv, u8 rand[8])
@@ -1289,7 +1289,8 @@ int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 		     bdaddr_t *bdaddr, u8 *val, u8 type, u8 pin_len)
 {
 	struct link_key *key, *old_key;
-	u8 old_key_type, persistent;
+	u8 old_key_type;
+	bool persistent;
 
 	old_key = hci_find_link_key(hdev, bdaddr);
 	if (old_key) {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4e7a01f..fe36ed9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2954,7 +2954,7 @@ int mgmt_write_scan_failed(struct hci_dev *hdev, u8 scan, u8 status)
 	return 0;
 }
 
-int mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key, u8 persistent)
+int mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key, bool persistent)
 {
 	struct mgmt_ev_new_link_key ev;
 
-- 
1.7.0.4

