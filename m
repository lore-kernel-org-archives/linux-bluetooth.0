Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/7] Bluetooth: Add flag to track the real advertising state
Date: Tue,  8 Jul 2014 15:07:47 +0300
Message-Id: <1404821273-28005-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1404821273-28005-1-git-send-email-johan.hedberg@gmail.com>
References: <1404821273-28005-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Having a single HCI_ADVERTISING flag is problematic since it tries to
track both the real advertising state and the corresponding mgmt
setting. To make the logic simpler and more reliable add a new flag that
only tracks the actual advertising state that has been written to the
controller.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h | 4 ++--
 net/bluetooth/hci_event.c   | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 5481d1c8badb..6ed1f7288f13 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -175,7 +175,7 @@ enum {
 	HCI_UNCONFIGURED,
 	HCI_USER_CHANNEL,
 	HCI_EXT_CONFIGURED,
-
+	HCI_LE_ADV,
 	HCI_LE_SCAN,
 	HCI_SSP_ENABLED,
 	HCI_SC_ENABLED,
@@ -200,7 +200,7 @@ enum {
  * or the HCI device is closed.
  */
 #define HCI_PERSISTENT_MASK (BIT(HCI_LE_SCAN) | BIT(HCI_PERIODIC_INQ) | \
-			      BIT(HCI_FAST_CONNECTABLE))
+			      BIT(HCI_FAST_CONNECTABLE) | BIT(HCI_LE_ADV))
 
 /* HCI ioctl defines */
 #define HCIDEVUP	_IOW('H', 201, int)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index a6816498b0b9..10f8de9400bc 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -1069,11 +1069,15 @@ static void hci_cc_le_set_adv_enable(struct hci_dev *hdev, struct sk_buff *skb)
 	if (*sent) {
 		struct hci_conn *conn;
 
+		set_bit(HCI_LE_ADV, &hdev->dev_flags);
+
 		conn = hci_conn_hash_lookup_state(hdev, LE_LINK, BT_CONNECT);
 		if (conn)
 			queue_delayed_work(hdev->workqueue,
 					   &conn->le_conn_timeout,
 					   conn->conn_timeout);
+	} else {
+		clear_bit(HCI_LE_ADV, &hdev->dev_flags);
 	}
 
 	mgmt_advertising(hdev, *sent);
-- 
1.9.3

