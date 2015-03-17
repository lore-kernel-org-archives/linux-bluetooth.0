Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v4 5/7] Bluetooth: Set HCI_QUIRK_SIMULTANEOUS_DISCOVERY for BTUSB_ATH3012
Date: Mon, 16 Mar 2015 18:37:32 -0700
Message-Id: <1426556254-1480-5-git-send-email-jpawlowski@google.com>
In-Reply-To: <1426556254-1480-1-git-send-email-jpawlowski@google.com>
References: <1426556254-1480-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Atheros controllers can do both LE and classic scan at once.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 6fa9338..7c3c2a1 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3042,6 +3042,7 @@ static int btusb_probe(struct usb_interface *intf,
 
 	if (id->driver_info & BTUSB_ATH3012) {
 		hdev->set_bdaddr = btusb_set_bdaddr_ath3012;
+		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 	}
 
-- 
2.2.0.rc0.207.ga3a616c

