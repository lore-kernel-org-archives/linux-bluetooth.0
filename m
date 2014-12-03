Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 34/49] Bluetooth: Add hci_conn flag for new link key generation
Date: Wed,  3 Dec 2014 17:02:28 +0200
Message-Id: <1417618963-18010-35-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
References: <1417618963-18010-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

For LE Secure Connections we want to trigger cross transport key
generation only if a new link key was actually created during the BR/EDR
connection. This patch adds a new flag to track this information.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 1 +
 net/bluetooth/hci_event.c        | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 90929641d0f0..42f9362a83c1 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -559,6 +559,7 @@ enum {
 	HCI_CONN_AUTH_INITIATOR,
 	HCI_CONN_DROP,
 	HCI_CONN_PARAM_REMOVAL_PEND,
+	HCI_CONN_NEW_LINK_KEY,
 };
 
 static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 34ecbf0b7e5b..c3d6390e3b7b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3249,6 +3249,8 @@ static void hci_link_key_request_evt(struct hci_dev *hdev, struct sk_buff *skb)
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &ev->bdaddr);
 	if (conn) {
+		clear_bit(HCI_CONN_NEW_LINK_KEY, &conn->flags);
+
 		if ((key->type == HCI_LK_UNAUTH_COMBINATION_P192 ||
 		     key->type == HCI_LK_UNAUTH_COMBINATION_P256) &&
 		    conn->auth_type != 0xff && (conn->auth_type & 0x01)) {
@@ -3301,6 +3303,7 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	conn->disc_timeout = HCI_DISCONN_TIMEOUT;
 	hci_conn_drop(conn);
 
+	set_bit(HCI_CONN_NEW_LINK_KEY, &conn->flags);
 	conn_set_key(conn, ev->key_type, conn->pin_length);
 
 	if (!test_bit(HCI_MGMT, &hdev->dev_flags))
-- 
2.1.0

