Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 07/26] Bluetooth: Add a define for the HCI persistent flags mask
Date: Fri, 15 Mar 2013 17:06:57 -0500
Message-Id: <1363385236-25704-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1363385236-25704-1-git-send-email-johan.hedberg@gmail.com>
References: <1363385236-25704-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We'll need to use this mask also when powering off the HCI device
so it's better to have this in a single and visible place.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h |    5 +++++
 net/bluetooth/hci_event.c   |    2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 1e723c7..1e40222 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -122,6 +122,11 @@ enum {
 	HCI_PERIODIC_INQ,
 };
 
+/* A mask for the flags that are supposed to remain when a reset happens
+ * or the HCI device is closed.
+ */
+#define HCI_PERSISTENT_MASK (BIT(HCI_LE_SCAN) | BIT(HCI_PERIODIC_INQ))
+
 /* HCI ioctl defines */
 #define HCIDEVUP	_IOW('H', 201, int)
 #define HCIDEVDOWN	_IOW('H', 202, int)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 5f2d008..ed4ecd9 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -194,7 +194,7 @@ static void hci_cc_reset(struct hci_dev *hdev, struct sk_buff *skb)
 	clear_bit(HCI_RESET, &hdev->flags);
 
 	/* Reset all non-persistent flags */
-	hdev->dev_flags &= ~(BIT(HCI_LE_SCAN) | BIT(HCI_PERIODIC_INQ));
+	hdev->dev_flags &= ~HCI_PERSISTENT_MASK;
 
 	hdev->discovery.state = DISCOVERY_STOPPED;
 	hdev->inq_tx_power = HCI_TX_POWER_INVALID;
-- 
1.7.10.4

