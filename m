Return-Path: <cyrus@holtmann.org>
From: Jukka Rissanen <jukka.rissanen@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v3 5/8] Bluetooth: Enable 6LoWPAN if device supports it
Date: Fri,  8 Nov 2013 17:23:12 +0200
Message-Id: <1383924195-7936-6-git-send-email-jukka.rissanen@linux.intel.com>
In-Reply-To: <1383924195-7936-1-git-send-email-jukka.rissanen@linux.intel.com>
References: <1383924195-7936-1-git-send-email-jukka.rissanen@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Jukka Rissanen <jukka.rissanen@linux.intel.com>
---
 include/net/bluetooth/hci.h      | 1 +
 include/net/bluetooth/hci_core.h | 1 +
 net/bluetooth/hci_event.c        | 3 +++
 net/bluetooth/l2cap_core.c       | 3 +++
 4 files changed, 8 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 1784c48..f8f8447 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -131,6 +131,7 @@ enum {
 	HCI_PERIODIC_INQ,
 	HCI_FAST_CONNECTABLE,
 	HCI_BREDR_ENABLED,
+	HCI_6LOWPAN_ENABLED,
 };
 
 /* A mask for the flags that are supposed to remain when a reset happens
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 8c0ab3d..e689052 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -449,6 +449,7 @@ enum {
 	HCI_CONN_SSP_ENABLED,
 	HCI_CONN_POWER_SAVE,
 	HCI_CONN_REMOTE_OOB,
+	HCI_CONN_6LOWPAN,
 };
 
 static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5fb3df6..5f81245 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -3533,6 +3533,9 @@ static void hci_le_conn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 	conn->handle = __le16_to_cpu(ev->handle);
 	conn->state = BT_CONNECTED;
 
+	if (test_bit(HCI_6LOWPAN_ENABLED, &hdev->dev_flags))
+		set_bit(HCI_CONN_6LOWPAN, &conn->flags);
+
 	hci_conn_add_sysfs(conn);
 
 	hci_proto_connect_cfm(conn, ev->status);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 155485f..df475c7 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -6517,6 +6517,9 @@ int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr)
 
 static bool is_bt_6lowpan(struct hci_conn *hcon)
 {
+	if (hcon->type == LE_LINK && test_bit(HCI_CONN_6LOWPAN, &hcon->flags))
+		return true;
+
 	return false;
 }
 
-- 
1.8.3.1

