Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 04/10] Bluetooth: Add hci_get_own_address_type() convenience function
Date: Sun, 23 Feb 2014 16:23:52 +0200
Message-Id: <1393165438-13610-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393165438-13610-1-git-send-email-johan.hedberg@gmail.com>
References: <1393165438-13610-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds a convenience function for fetching the local address
type used for advertising, scanning and initiating LE connections as
well as updating the local random address if necessary.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_core.c         | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6415514e4f17..996887793d4b 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1257,6 +1257,8 @@ void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max,
 void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
 							__u8 ltk[16]);
 
+uint8_t hci_get_own_address_type(struct hci_request *req);
+
 #define SCO_AIRMODE_MASK       0x0003
 #define SCO_AIRMODE_CVSD       0x0000
 #define SCO_AIRMODE_TRANSP     0x0003
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 92d35811b61e..973145ad8bf0 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3276,6 +3276,44 @@ static void le_scan_disable_work(struct work_struct *work)
 		BT_ERR("Disable LE scanning request failed: err %d", err);
 }
 
+uint8_t hci_get_own_address_type(struct hci_request *req)
+{
+	struct hci_dev *hdev = req->hdev;
+
+	if (test_bit(HCI_PRIVACY, &hdev->dev_flags)) {
+		bdaddr_t rpa;
+
+		if (!test_and_clear_bit(HCI_RPA_EXPIRED, &hdev->dev_flags))
+			return ADDR_LE_DEV_RANDOM;
+
+		if (smp_generate_rpa(hdev->tfm_aes, hdev->irk, &rpa) < 0) {
+			BT_ERR("%s failed to generate new RPA", hdev->name);
+			return hdev->own_addr_type;
+		}
+
+		hci_req_add(req, HCI_OP_LE_SET_RANDOM_ADDR, 6, &rpa);
+
+		if (hdev->rpa_timeout) {
+			int timeout;
+
+			timeout = msecs_to_jiffies(hdev->rpa_timeout * 1000);
+			queue_delayed_work(hdev->workqueue, &hdev->rpa_expired,
+					   timeout);
+		}
+
+		return ADDR_LE_DEV_RANDOM;
+	}
+
+	if (bacmp(&hdev->static_addr, BDADDR_ANY) &&
+	    bacmp(&hdev->static_addr, &hdev->random_addr)) {
+		hci_req_add(req, HCI_OP_LE_SET_RANDOM_ADDR, 6,
+			    &hdev->static_addr);
+		return ADDR_LE_DEV_RANDOM;
+	}
+
+	return hdev->own_addr_type;
+}
+
 /* Alloc HCI device */
 struct hci_dev *hci_alloc_dev(void)
 {
-- 
1.8.5.3

