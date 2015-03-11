Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v2 3/5] Bluetooth: Set HCI_QUIRK_SIMULTANEOUS_DISCOVERY for BTUSB_ATH3012
Date: Tue, 10 Mar 2015 22:53:35 -0700
Message-Id: <1426053217-9011-3-git-send-email-jpawlowski@google.com>
In-Reply-To: <1426053217-9011-1-git-send-email-jpawlowski@google.com>
References: <1426053217-9011-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Atheros controllers can do both LE and classic scan at once.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index c34a875..11bebf5 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3045,6 +3045,7 @@ static int btusb_probe(struct usb_interface *intf,
 
 	if (id->driver_info & BTUSB_ATH3012) {
 		hdev->set_bdaddr = btusb_set_bdaddr_ath3012;
+		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 	}
 
-- 
2.2.0.rc0.207.ga3a616c

