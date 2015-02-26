Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH 3/3] Bluetooth: Set HCI_QUIRK_SIMULTAENOUS_DISCOVERY for BTUSB_ATH3012
Date: Wed, 25 Feb 2015 18:14:19 -0800
Message-Id: <1424916859-14473-3-git-send-email-jpawlowski@google.com>
In-Reply-To: <1424916859-14473-1-git-send-email-jpawlowski@google.com>
References: <1424916859-14473-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Atheros controllers can do both LE and classic scan at once.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3ca2e1b..119c77c 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2777,6 +2777,7 @@ static int btusb_probe(struct usb_interface *intf,
 
 	if (id->driver_info & BTUSB_ATH3012) {
 		hdev->set_bdaddr = btusb_set_bdaddr_ath3012;
+		set_bit(HCI_QUIRK_SIMULTAENOUS_DISCOVERY, &hdev->quirks);
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 	}
 
-- 
2.2.0.rc0.207.ga3a616c

