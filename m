Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Ensure that background scanning gets enabled on power on
Date: Tue,  1 Jul 2014 19:28:24 +0200
Message-Id: <1404235704-10483-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The background scanning normally gets enabled during power on by
adding devices to the pending connection list. However devices
might be already on that list and the list of devices is empty,
then it is better to trigger the background manually.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 336a2311bdca..408468c07a8a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5283,11 +5283,27 @@ void mgmt_index_removed(struct hci_dev *hdev)
 static void restart_le_auto_conns(struct hci_dev *hdev)
 {
 	struct hci_conn_params *p;
+	bool added = false;
 
 	list_for_each_entry(p, &hdev->le_conn_params, list) {
-		if (p->auto_connect == HCI_AUTO_CONN_ALWAYS)
+		if (p->auto_connect == HCI_AUTO_CONN_ALWAYS) {
 			hci_pend_le_conn_add(hdev, &p->addr, p->addr_type);
+			added = true;
+		}
 	}
+
+	/* Calling hci_pend_le_conn_add will actually already trigger
+	 * background scanning when needed. So no need to trigger it
+	 * just another time.
+	 *
+	 * This check is here to avoid an unneeded restart of the
+	 * passive scanning. Since this is during the controller
+	 * power up phase the duplicate filtering is not an issue.
+	 */
+	if (added)
+		return;
+
+	hci_update_background_scan(hdev);
 }
 
 static void powered_complete(struct hci_dev *hdev, u8 status)
-- 
1.9.3

