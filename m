Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/6] Bluetooth: Convert hcon->flush_key to a proper flag
Date: Tue, 24 Jun 2014 13:15:53 +0300
Message-Id: <1403604953-19539-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1403604953-19539-1-git-send-email-johan.hedberg@gmail.com>
References: <1403604953-19539-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There's no point in having boolean variables in the hci_conn struct
since it already has a flags member. This patch converts the flush_key
member into a proper flag.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h | 2 +-
 net/bluetooth/hci_event.c        | 8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 888911d205dc..4f70605e0399 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -394,7 +394,6 @@ struct hci_conn {
 	__u8		remote_cap;
 	__u8		remote_auth;
 	__u8		remote_id;
-	bool		flush_key;
 
 	unsigned int	sent;
 
@@ -524,6 +523,7 @@ enum {
 	HCI_CONN_AES_CCM,
 	HCI_CONN_POWER_SAVE,
 	HCI_CONN_REMOTE_OOB,
+	HCI_CONN_FLUSH_KEY,
 };
 
 static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index c92c5a020fe7..90cba6a8293b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2159,7 +2159,8 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	mgmt_device_disconnected(hdev, &conn->dst, conn->type, conn->dst_type,
 				reason, mgmt_connected);
 
-	if (conn->type == ACL_LINK && conn->flush_key)
+	if (conn->type == ACL_LINK &&
+	    test_bit(HCI_CONN_FLUSH_KEY, &conn->flags))
 		hci_remove_link_key(hdev, &conn->dst);
 
 	params = hci_conn_params_lookup(hdev, &conn->dst, conn->dst_type);
@@ -3145,7 +3146,10 @@ static void hci_link_key_notify_evt(struct hci_dev *hdev, struct sk_buff *skb)
 		list_del(&key->list);
 		kfree(key);
 	} else if (conn) {
-		conn->flush_key = !persistent;
+		if (persistent)
+			clear_bit(HCI_CONN_FLUSH_KEY, &conn->flags);
+		else
+			set_bit(HCI_CONN_FLUSH_KEY, &conn->flags);
 	}
 
 unlock:
-- 
1.9.3

