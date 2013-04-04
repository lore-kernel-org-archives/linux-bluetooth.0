Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 16/17] Bluetooth: Rename le_scan_disable delayed work
Date: Thu,  4 Apr 2013 20:21:14 -0300
Message-Id: <1365117675-2202-17-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1365117675-2202-1-git-send-email-andre.guedes@openbossa.org>
References: <1365117675-2202-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The le_scan_disable work basically implements a timer, but now it
does more than simply disabling the LE scanning (it may also start
the inquiry in case we are running an interleaved discovery). So,
renaming it to discovery_timeout seems suitable.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/hci_core.c         | 12 ++++++------
 net/bluetooth/mgmt.c             |  6 +++---
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6aa6a30..0c05eae 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -273,7 +273,7 @@ struct hci_dev {
 
 	unsigned long		dev_flags;
 
-	struct delayed_work	le_scan_disable;
+	struct delayed_work	discovery_timeout;
 
 	__s8			adv_tx_power;
 	__u8			adv_data[HCI_MAX_AD_LENGTH];
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index a38bf9e..ea81630 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1097,7 +1097,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	if (test_and_clear_bit(HCI_SERVICE_CACHE, &hdev->dev_flags))
 		cancel_delayed_work(&hdev->service_cache);
 
-	cancel_delayed_work_sync(&hdev->le_scan_disable);
+	cancel_delayed_work_sync(&hdev->discovery_timeout);
 
 	hci_dev_lock(hdev);
 	inquiry_cache_flush(hdev);
@@ -1854,7 +1854,7 @@ int hci_blacklist_del(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
 	return mgmt_device_unblocked(hdev, bdaddr, type);
 }
 
-static void le_scan_disable_work_complete(struct hci_dev *hdev, u8 status)
+static void discovery_timeout_complete(struct hci_dev *hdev, u8 status)
 {
 	struct hci_command_hdr *last_cmd;
 	u16 opcode;
@@ -1890,10 +1890,10 @@ static void le_scan_disable_work_complete(struct hci_dev *hdev, u8 status)
 	}
 }
 
-static void le_scan_disable_work(struct work_struct *work)
+static void hci_discovery_timeout(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev,
-					    le_scan_disable.work);
+					    discovery_timeout.work);
 	struct hci_cp_le_set_scan_enable cp;
 	struct hci_request req;
 	int err;
@@ -1927,7 +1927,7 @@ static void le_scan_disable_work(struct work_struct *work)
 		hci_req_add(&req, HCI_OP_INQUIRY, sizeof(inq_cp), &inq_cp);
 	}
 
-	err = hci_req_run(&req, le_scan_disable_work_complete);
+	err = hci_req_run(&req, discovery_timeout_complete);
 	if (err)
 		BT_ERR("Failed to disable LE scanning: err %d", err);
 }
@@ -1969,7 +1969,7 @@ struct hci_dev *hci_alloc_dev(void)
 
 	INIT_DELAYED_WORK(&hdev->power_off, hci_power_off);
 	INIT_DELAYED_WORK(&hdev->discov_off, hci_discov_off);
-	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable_work);
+	INIT_DELAYED_WORK(&hdev->discovery_timeout, hci_discovery_timeout);
 
 	skb_queue_head_init(&hdev->driver_init);
 	skb_queue_head_init(&hdev->rx_q);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 20958ba..1fa726e 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2633,12 +2633,12 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status)
 
 	switch (hdev->discovery.type) {
 	case DISCOV_TYPE_LE:
-		queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable,
+		queue_delayed_work(hdev->workqueue, &hdev->discovery_timeout,
 				   DISCOV_LE_TIMEOUT);
 		break;
 
 	case DISCOV_TYPE_INTERLEAVED:
-		queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable,
+		queue_delayed_work(hdev->workqueue, &hdev->discovery_timeout,
 				   DISCOV_INTERLEAVED_TIMEOUT);
 		break;
 
@@ -2841,7 +2841,7 @@ static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
 		if (test_bit(HCI_INQUIRY, &hdev->flags)) {
 			hci_req_add(&req, HCI_OP_INQUIRY_CANCEL, 0, NULL);
 		} else {
-			cancel_delayed_work(&hdev->le_scan_disable);
+			cancel_delayed_work(&hdev->discovery_timeout);
 
 			memset(&enable_cp, 0, sizeof(enable_cp));
 			enable_cp.enable = LE_SCAN_DISABLE;
-- 
1.8.1.2

