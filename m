Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix issue with HCI_QUIRK_FIXUP_INQUIRY_MODE and event mask
Date: Sun,  1 Nov 2015 09:45:22 +0100
Message-Id: <1446367522-70459-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When setting the event mask, the HCI_QUIRK_FIXUP_INQUIRY_MODE quirk is
required to be checked so that the Inquiry Result with RSSI event gets
actually enabled.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 41a70138a770..0e46457f5e02 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -555,7 +555,8 @@ static void hci_setup_event_mask(struct hci_request *req)
 		}
 	}
 
-	if (lmp_inq_rssi_capable(hdev))
+	if (lmp_inq_rssi_capable(hdev) ||
+	    test_bit(HCI_QUIRK_FIXUP_INQUIRY_MODE, &hdev->quirks))
 		events[4] |= 0x02; /* Inquiry Result with RSSI */
 
 	if (lmp_ext_feat_capable(hdev))
-- 
2.4.3

