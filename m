Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/5] Bluetooth: Read stored link key information when powering on controller
Date: Sun, 11 Jan 2015 13:44:23 -0800
Message-Id: <1421012665-4842-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The information about max stored link keys and current stored link keys
should be read at controller initialization. So issue HCI Read Stored
Link Key command with BDADDR_ANY and read_all flag set to 0x01 to
retrieve this information.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ba0d1fdccbd9..96572a48948e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -731,6 +731,14 @@ static void hci_init3_req(struct hci_request *req, unsigned long opt)
 
 	hci_setup_event_mask(req);
 
+	if (hdev->commands[6] & 0x20) {
+		struct hci_cp_read_stored_link_key cp;
+
+		bacpy(&cp.bdaddr, BDADDR_ANY);
+		cp.read_all = 0x01;
+		hci_req_add(req, HCI_OP_READ_STORED_LINK_KEY, sizeof(cp), &cp);
+	}
+
 	/* Some Broadcom based Bluetooth controllers do not support the
 	 * Delete Stored Link Key command. They are clearly indicating its
 	 * absence in the bit mask of supported commands.
-- 
2.1.0

