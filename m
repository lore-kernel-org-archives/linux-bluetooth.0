Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/5] Bluetooth: Track Secure Connections support of remote devices
Date: Wed, 15 Jan 2014 22:37:38 -0800
Message-Id: <1389854262-62467-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is important to know if Secure Connections support has been enabled
for a given remote device. The information is provided in the remote
host features page. So track this information and provide a simple
helper function to extract the status.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h | 8 ++++++++
 net/bluetooth/hci_event.c        | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 66e96ebffe97..8d225e4ea2ce 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -448,6 +448,7 @@ enum {
 	HCI_CONN_LE_SMP_PEND,
 	HCI_CONN_MGMT_CONNECTED,
 	HCI_CONN_SSP_ENABLED,
+	HCI_CONN_SC_ENABLED,
 	HCI_CONN_POWER_SAVE,
 	HCI_CONN_REMOTE_OOB,
 	HCI_CONN_6LOWPAN,
@@ -460,6 +461,13 @@ static inline bool hci_conn_ssp_enabled(struct hci_conn *conn)
 	       test_bit(HCI_CONN_SSP_ENABLED, &conn->flags);
 }
 
+static inline bool hci_conn_sc_enabled(struct hci_conn *conn)
+{
+	struct hci_dev *hdev = conn->hdev;
+	return test_bit(HCI_SC_ENABLED, &hdev->dev_flags) &&
+	       test_bit(HCI_CONN_SC_ENABLED, &conn->flags);
+}
+
 static inline void hci_conn_hash_add(struct hci_dev *hdev, struct hci_conn *c)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index da1eca1c43db..8c44bbe19add 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2898,6 +2898,9 @@ static void hci_remote_ext_features_evt(struct hci_dev *hdev,
 			 * features do not indicate SSP support */
 			clear_bit(HCI_CONN_SSP_ENABLED, &conn->flags);
 		}
+
+		if (ev->features[0] & LMP_HOST_SC)
+			set_bit(HCI_CONN_SC_ENABLED, &conn->flags);
 	}
 
 	if (conn->state != BT_CONFIG)
-- 
1.8.4.2

