Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/7] Bluetooth: Clean up HCI state when doing power off
Date: Mon, 24 Feb 2014 14:52:22 +0200
Message-Id: <1393246342-27980-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393246342-27980-1-git-send-email-johan.hedberg@gmail.com>
References: <1393246342-27980-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

To be friendly to user space and to behave well with controllers that
lack a proper internal power off procedure we should try to clean up as
much state as possible before requesting the HCI driver to power off.

This patch updates the power off procedure that's triggered by
mgmt_set_powered to clean any scan modes, stop LE scanning and
advertising and to disconnect any open connections.

The asynchronous cleanup procedure uses the HCI request framework,
however since HCI_Disconnect is only covered until its Command Status
event we need some extra tracking/waiting of disconnections. This is
done by monitoring when hci_conn_count() indicates that there are no
more connections.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 70 +++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 66 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 610ac32e797b..25b8b278debd 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1026,6 +1026,49 @@ static int send_settings_rsp(struct sock *sk, u16 opcode, struct hci_dev *hdev)
 			    sizeof(settings));
 }
 
+static void clean_up_hci_complete(struct hci_dev *hdev, u8 status)
+{
+	BT_DBG("%s status 0x%02x", hdev->name, status);
+
+	if (hci_conn_count(hdev) == 0)
+		queue_work(hdev->req_workqueue, &hdev->power_off.work);
+}
+
+static int clean_up_hci_state(struct hci_dev *hdev)
+{
+	struct hci_request req;
+	struct hci_conn *conn;
+
+	hci_req_init(&req, hdev);
+
+	if (test_bit(HCI_ISCAN, &hdev->flags) ||
+	    test_bit(HCI_PSCAN, &hdev->flags)) {
+		u8 scan = 0x00;
+		hci_req_add(&req, HCI_OP_WRITE_SCAN_ENABLE, 1, &scan);
+	}
+
+	if (test_bit(HCI_ADVERTISING, &hdev->dev_flags))
+		disable_advertising(&req);
+
+	if (test_bit(HCI_LE_SCAN, &hdev->dev_flags)) {
+		struct hci_cp_le_set_scan_enable cp;
+
+		memset(&cp, 0, sizeof(cp));
+		cp.enable = LE_SCAN_DISABLE;
+		hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
+	}
+
+	list_for_each_entry(conn, &hdev->conn_hash.list, list) {
+		struct hci_cp_disconnect dc;
+
+		dc.handle = cpu_to_le16(conn->handle);
+		dc.reason = 0x15; /* Terminated due to Power Off */
+		hci_req_add(&req, HCI_OP_DISCONNECT, sizeof(dc), &dc);
+	}
+
+	return hci_req_run(&req, clean_up_hci_complete);
+}
+
 static int set_powered(struct sock *sk, struct hci_dev *hdev, void *data,
 		       u16 len)
 {
@@ -1069,12 +1112,19 @@ static int set_powered(struct sock *sk, struct hci_dev *hdev, void *data,
 		goto failed;
 	}
 
-	if (cp->val)
+	if (cp->val) {
 		queue_work(hdev->req_workqueue, &hdev->power_on);
-	else
-		queue_work(hdev->req_workqueue, &hdev->power_off.work);
+		err = 0;
+	} else {
+		/* Disconnect connections, stop scans, etc */
+		err = clean_up_hci_state(hdev);
 
-	err = 0;
+		/* ENODATA means there were no HCI commands queued */
+		if (err == -ENODATA) {
+			queue_work(hdev->req_workqueue, &hdev->power_off.work);
+			err = 0;
+		}
+	}
 
 failed:
 	hci_dev_unlock(hdev);
@@ -5028,8 +5078,20 @@ void mgmt_device_disconnected(struct hci_dev *hdev, bdaddr_t *bdaddr,
 			      bool mgmt_connected)
 {
 	struct mgmt_ev_device_disconnected ev;
+	struct pending_cmd *power_off;
 	struct sock *sk = NULL;
 
+	power_off = mgmt_pending_find(MGMT_OP_SET_POWERED, hdev);
+	if (power_off) {
+		struct mgmt_mode *cp = power_off->param;
+
+		/* The connection is still in hci_conn_hash so test for 1
+		 * instead of 0 to know if this is the last one.
+		 */
+		if (!cp->val && hci_conn_count(hdev) == 1)
+			queue_work(hdev->req_workqueue, &hdev->power_off.work);
+	}
+
 	if (!mgmt_connected)
 		return;
 
-- 
1.8.5.3

