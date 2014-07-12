Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Enable LE Long Term Key Request event only when supported
Date: Sun, 13 Jul 2014 00:29:22 +0200
Message-Id: <1405204162-64758-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The support for LE encryption is optional and with that also the
LE Long Term Key Request event. If encryption is not supported, then
do not bother enabling this event.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ff150e3c7ad1..188bfd3d7c43 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1644,7 +1644,10 @@ static void hci_init3_req(struct hci_request *req, unsigned long opt)
 		u8 events[8];
 
 		memset(events, 0, sizeof(events));
-		events[0] = 0x1f;
+		events[0] = 0x0f;
+
+		if (hdev->le_features[0] & HCI_LE_ENCRYPTION)
+			events[0] |= 0x10;	/* LE Long Term Key Request */
 
 		/* If controller supports the Connection Parameters Request
 		 * Link Layer Procedure, enable the corresponding event.
-- 
1.9.3

