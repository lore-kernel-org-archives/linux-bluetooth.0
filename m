Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v11 15/15] Bluetooth: Update background scan parameters
Date: Mon, 24 Feb 2014 19:31:01 -0300
Message-Id: <1393281061-14320-16-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1393281061-14320-1-git-send-email-andre.guedes@openbossa.org>
References: <1393281061-14320-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If new scanning parameters are set while background scan is running,
we should restart background scanning so these parameters are updated.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 26 ++++++++++++++++++++++++++
 net/bluetooth/mgmt.c             |  7 +++++++
 3 files changed, 34 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c81847e..2c5289d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -812,6 +812,7 @@ void hci_pend_le_conn_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type);
 void hci_pend_le_conns_clear(struct hci_dev *hdev);
 
 void hci_update_background_scan(struct hci_dev *hdev);
+void hci_restart_background_scan(struct hci_dev *hdev);
 
 void hci_uuids_clear(struct hci_dev *hdev);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e0ebbd9..55c01e9 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -5179,3 +5179,29 @@ void hci_update_background_scan(struct hci_dev *hdev)
 	if (err)
 		BT_ERR("Failed to run HCI request: err %d", err);
 }
+
+static void restart_background_scan_complete(struct hci_dev *hdev, u8 status)
+{
+	if (status)
+		BT_DBG("HCI request failed to restart background scan: "
+		       "status 0x%2.2x", status);
+}
+
+void hci_restart_background_scan(struct hci_dev *hdev)
+{
+	struct hci_request req;
+	int err;
+
+	hci_req_init(&req, hdev);
+
+	hci_req_add_le_scan_disable(&req);
+	hci_req_add_le_passive_scan(&req, hdev);
+
+	err = hci_req_run(&req, restart_background_scan_complete);
+	if (err) {
+		BT_ERR("Failed to run HCI request: err %d", err);
+		return;
+	}
+
+	BT_DBG("%s re-starting background scanning", hdev->name);
+}
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4745fb5..679670d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3917,6 +3917,13 @@ static int set_scan_params(struct sock *sk, struct hci_dev *hdev,
 
 	err = cmd_complete(sk, hdev->id, MGMT_OP_SET_SCAN_PARAMS, 0, NULL, 0);
 
+	/* If background scan is running, restart it so new parameters are
+	 * loaded.
+	 */
+	if (test_bit(HCI_LE_SCAN, &hdev->dev_flags) &&
+	    hdev->discovery.state == DISCOVERY_STOPPED)
+		hci_restart_background_scan(hdev);
+
 	hci_dev_unlock(hdev);
 
 	return err;
-- 
1.8.5.4

