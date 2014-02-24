Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Store current RPA and update it if needed
Date: Sun, 23 Feb 2014 20:39:22 -0800
Message-Id: <1393216763-14836-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The RPA needs to be stored to know which is the current one. Otherwise
it is impossible to ensure that always the correct RPA can be programmed
into the controller when it is needed.

Current code checks if the address in the controller is a RPA, but that
can potentially lead to using a RPA that can not be resolved with the
IRK that has been distributed.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 11 +++++------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b0350c032b26..2ad907cf23e8 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -308,6 +308,7 @@ struct hci_dev {
 	__u8			irk[16];
 	__u32			rpa_timeout;
 	struct delayed_work	rpa_expired;
+	bdaddr_t		rpa;
 
 	int (*open)(struct hci_dev *hdev);
 	int (*close)(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e3caad5c1e6e..6928989ec906 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3339,26 +3339,25 @@ int hci_update_random_address(struct hci_request *req, bool allow_privacy,
 	int err;
 
 	/* If privacy is enabled use a resolvable private address. If
-	 * the current RPA has expired or there's something else than an
-	 * RPA currently in use regenerate a new one.
+	 * current RPA has expired or there is something else than
+	 * the current RPA in use, then generate a new one.
 	 */
 	if (test_bit(HCI_PRIVACY, &hdev->dev_flags)) {
-		bdaddr_t rpa;
 		int to;
 
 		*own_addr_type = ADDR_LE_DEV_RANDOM;
 
 		if (!test_and_clear_bit(HCI_RPA_EXPIRED, &hdev->dev_flags) &&
-		    hci_bdaddr_is_rpa(&hdev->random_addr, ADDR_LE_DEV_RANDOM))
+		    !bacmp(&hdev->random_addr, &hdev->rpa))
 			return 0;
 
-		err = smp_generate_rpa(hdev->tfm_aes, hdev->irk, &rpa);
+		err = smp_generate_rpa(hdev->tfm_aes, hdev->irk, &hdev->rpa);
 		if (err < 0) {
 			BT_ERR("%s failed to generate new RPA", hdev->name);
 			return err;
 		}
 
-		hci_req_add(req, HCI_OP_LE_SET_RANDOM_ADDR, 6, &rpa);
+		hci_req_add(req, HCI_OP_LE_SET_RANDOM_ADDR, 6, &hdev->rpa);
 
 		to = msecs_to_jiffies(hdev->rpa_timeout * 1000);
 		queue_delayed_work(hdev->workqueue, &hdev->rpa_expired, to);
-- 
1.8.5.3

