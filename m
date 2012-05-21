Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 1/3] Bluetooth: Use defined link key size
Date: Mon, 21 May 2012 15:10:58 +0300
Message-Id: <1337602260-30458-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1337350806-20326-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1337350806-20326-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Remove magic number with defined link key size.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/hci.h      |    6 ++++--
 include/net/bluetooth/hci_core.h |    2 +-
 net/bluetooth/hci_core.c         |    2 +-
 net/bluetooth/hci_event.c        |    2 +-
 net/bluetooth/mgmt.c             |    2 +-
 5 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 66a7b57..4530e9d 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -30,6 +30,8 @@
 #define HCI_MAX_EVENT_SIZE	260
 #define HCI_MAX_FRAME_SIZE	(HCI_MAX_ACL_SIZE + 4)
 
+#define HCI_LINK_KEY_SIZE	16
+
 /* HCI dev events */
 #define HCI_DEV_REG			1
 #define HCI_DEV_UNREG			2
@@ -371,7 +373,7 @@ struct hci_cp_reject_conn_req {
 #define HCI_OP_LINK_KEY_REPLY		0x040b
 struct hci_cp_link_key_reply {
 	bdaddr_t bdaddr;
-	__u8     link_key[16];
+	__u8     link_key[HCI_LINK_KEY_SIZE];
 } __packed;
 
 #define HCI_OP_LINK_KEY_NEG_REPLY	0x040c
@@ -1048,7 +1050,7 @@ struct hci_ev_link_key_req {
 #define HCI_EV_LINK_KEY_NOTIFY		0x18
 struct hci_ev_link_key_notify {
 	bdaddr_t bdaddr;
-	__u8     link_key[16];
+	__u8     link_key[HCI_LINK_KEY_SIZE];
 	__u8     key_type;
 } __packed;
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 9fc7728..6c658fc 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -105,7 +105,7 @@ struct link_key {
 	struct list_head list;
 	bdaddr_t bdaddr;
 	u8 type;
-	u8 val[16];
+	u8 val[HCI_LINK_KEY_SIZE];
 	u8 pin_len;
 };
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d0a960d..4feecf3 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1291,7 +1291,7 @@ int hci_add_link_key(struct hci_dev *hdev, struct hci_conn *conn, int new_key,
 	}
 
 	bacpy(&key->bdaddr, bdaddr);
-	memcpy(key->val, val, 16);
+	memcpy(key->val, val, HCI_LINK_KEY_SIZE);
 	key->pin_len = pin_len;
 
 	if (type == HCI_LK_CHANGED_COMBINATION)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6c2d7cc..1795c0c 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2739,7 +2739,7 @@ static inline void hci_link_key_request_evt(struct hci_dev *hdev,
 	}
 
 	bacpy(&cp.bdaddr, &ev->bdaddr);
-	memcpy(cp.link_key, key->val, 16);
+	memcpy(cp.link_key, key->val, HCI_LINK_KEY_SIZE);
 
 	hci_send_cmd(hdev, HCI_OP_LINK_KEY_REPLY, sizeof(cp), &cp);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6a7e926..1fd49e6 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2955,7 +2955,7 @@ int mgmt_new_link_key(struct hci_dev *hdev, struct link_key *key,
 	bacpy(&ev.key.addr.bdaddr, &key->bdaddr);
 	ev.key.addr.type = BDADDR_BREDR;
 	ev.key.type = key->type;
-	memcpy(ev.key.val, key->val, 16);
+	memcpy(ev.key.val, key->val, HCI_LINK_KEY_SIZE);
 	ev.key.pin_len = key->pin_len;
 
 	return mgmt_event(MGMT_EV_NEW_LINK_KEY, hdev, &ev, sizeof(ev), NULL);
-- 
1.7.9.5

