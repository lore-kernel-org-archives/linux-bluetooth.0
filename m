Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Move debug macros
Date: Tue, 22 Nov 2011 17:14:18 -0300
Message-Id: <1321992859-12473-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1321992859-12473-1-git-send-email-andre.guedes@openbossa.org>
References: <1321992859-12473-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Move debug macros so they provide us more meaningful information
during debugging analysis.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_core.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ef0423e..8487483 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2594,11 +2594,11 @@ int hci_do_inquiry(struct hci_dev *hdev, u8 length)
 	u8 lap[3] = { 0x33, 0x8b, 0x9e };
 	struct hci_cp_inquiry cp;
 
-	BT_DBG("%s", hdev->name);
-
 	if (test_bit(HCI_INQUIRY, &hdev->flags))
 		return -EINPROGRESS;
 
+	BT_DBG("%s", hdev->name);
+
 	memset(&cp, 0, sizeof(cp));
 	memcpy(&cp.lap, lap, sizeof(cp.lap));
 	cp.length  = length;
@@ -2608,11 +2608,11 @@ int hci_do_inquiry(struct hci_dev *hdev, u8 length)
 
 int hci_cancel_inquiry(struct hci_dev *hdev)
 {
-	BT_DBG("%s", hdev->name);
-
 	if (!test_bit(HCI_INQUIRY, &hdev->flags))
 		return -EPERM;
 
+	BT_DBG("%s", hdev->name);
+
 	return hci_send_cmd(hdev, HCI_OP_INQUIRY_CANCEL, 0, NULL);
 }
 
-- 
1.7.7.1

