Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v3 4/5] Bluetooth: Set HCI_QUIRK_SIMULTANEOUS_DISCOVERY for BTUSB_INTEL
Date: Sat, 14 Mar 2015 21:39:20 -0700
Message-Id: <1426394361-22823-4-git-send-email-jpawlowski@google.com>
In-Reply-To: <1426394361-22823-1-git-send-email-jpawlowski@google.com>
References: <1426394361-22823-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Intel controllers can do both LE and classic scan at once.
---
 drivers/bluetooth/btusb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 7c3c2a1..879b55e 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3019,6 +3019,7 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->shutdown = btusb_shutdown_intel;
 		hdev->set_bdaddr = btusb_set_bdaddr_intel;
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
+		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 	}
 
 	if (id->driver_info & BTUSB_INTEL_NEW) {
-- 
2.2.0.rc0.207.ga3a616c

