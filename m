Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/7] Bluetooth: Update class of device after changing discoverable mode
Date: Tue, 15 Oct 2013 06:33:57 -0700
Message-Id: <1381844037-24424-8-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the discoverable mode gets changed, ensure that the class of
device value has the correct limited discoverable bit value set.

Since the class of device HCI command will only be send to the
controller when the value changes, it is safe to just always
trigger the update.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 12d1cb02..6db2393 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1025,6 +1025,7 @@ static void set_discoverable_complete(struct hci_dev *hdev, u8 status)
 {
 	struct pending_cmd *cmd;
 	struct mgmt_mode *cp;
+	struct hci_request req;
 	bool changed;
 
 	BT_DBG("status 0x%02x", status);
@@ -1054,6 +1055,14 @@ static void set_discoverable_complete(struct hci_dev *hdev, u8 status)
 	if (changed)
 		new_settings(hdev, cmd->sk);
 
+	/* When the discoverable mode gets changed, make sure
+	 * that class of device has the limited discoverable
+	 * bit correctly set.
+	 */
+	hci_req_init(&req, hdev);
+	update_class(&req);
+	hci_req_run(&req, NULL);
+
 remove_cmd:
 	mgmt_pending_remove(cmd);
 
-- 
1.8.3.1

