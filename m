Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 05/13] Bluetooth: Add hci_update_random_address() convenience function
Date: Sun, 23 Feb 2014 19:42:21 +0200
Message-Id: <1393177349-361-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393177349-361-1-git-send-email-johan.hedberg@gmail.com>
References: <1393177349-361-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds a convenience function for updating the local random
address which is needed before advertising, scanning and initiating LE
connections.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_core.c         | 55 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6415514e4f17..2506963c7a06 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1257,6 +1257,8 @@ void hci_le_conn_update(struct hci_conn *conn, u16 min, u16 max,
 void hci_le_start_enc(struct hci_conn *conn, __le16 ediv, __u8 rand[8],
 							__u8 ltk[16]);
 
+int hci_update_random_address(struct hci_request *req, u8 *own_addr_type);
+
 #define SCO_AIRMODE_MASK       0x0003
 #define SCO_AIRMODE_CVSD       0x0000
 #define SCO_AIRMODE_TRANSP     0x0003
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 92d35811b61e..7bc67b4e47a7 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3276,6 +3276,61 @@ static void le_scan_disable_work(struct work_struct *work)
 		BT_ERR("Disable LE scanning request failed: err %d", err);
 }
 
+int hci_update_random_address(struct hci_request *req, u8 *own_addr_type)
+{
+	struct hci_dev *hdev = req->hdev;
+	int err;
+
+	/* If privacy is enabled use a resolvable private address. If
+	 * the current RPA has expired or there's something else than an
+	 * RPA currently in use regenerate a new one.
+	 */
+	if (test_bit(HCI_PRIVACY, &hdev->dev_flags)) {
+		bdaddr_t rpa;
+		int to;
+
+		*own_addr_type = ADDR_LE_DEV_RANDOM;
+
+		if (!test_and_clear_bit(HCI_RPA_EXPIRED, &hdev->dev_flags) &&
+		    hci_bdaddr_is_rpa(&hdev->random_addr, ADDR_LE_DEV_RANDOM))
+			return 0;
+
+		err = smp_generate_rpa(hdev->tfm_aes, hdev->irk, &rpa);
+		if (err < 0) {
+			BT_ERR("%s failed to generate new RPA", hdev->name);
+			return err;
+		}
+
+		hci_req_add(req, HCI_OP_LE_SET_RANDOM_ADDR, 6, &rpa);
+
+		to = msecs_to_jiffies(hdev->rpa_timeout * 1000);
+		queue_delayed_work(hdev->workqueue, &hdev->rpa_expired, to);
+
+		return 0;
+	}
+
+	/* If forcing static address is in use or there is no public
+	 * address use the static address as random address (but skip
+	 * the HCI command if the current random address is already the
+	 * static one.
+	 */
+	if (test_bit(HCI_FORCE_STATIC_ADDR, &hdev->dev_flags) ||
+	    !bacmp(&hdev->bdaddr, BDADDR_ANY)) {
+		*own_addr_type = ADDR_LE_DEV_RANDOM;
+		if (bacmp(&hdev->static_addr, &hdev->random_addr))
+			hci_req_add(req, HCI_OP_LE_SET_RANDOM_ADDR, 6,
+				    &hdev->static_addr);
+		return 0;
+	}
+
+	/* Neither privacy nor static address is being used so use a
+	 * public address.
+	 */
+	*own_addr_type = ADDR_LE_DEV_PUBLIC;
+
+	return 0;
+}
+
 /* Alloc HCI device */
 struct hci_dev *hci_alloc_dev(void)
 {
-- 
1.8.5.3

