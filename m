Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v5 5/6] Bluetooth: Set HCI_QUIRK_SIMULTANEOUS_DISCOVERY for BTUSB_INTEL
Date: Mon, 16 Mar 2015 21:19:32 -0700
Message-Id: <1426565973-27545-5-git-send-email-jpawlowski@google.com>
In-Reply-To: <1426565973-27545-1-git-send-email-jpawlowski@google.com>
References: <1426565973-27545-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Intel controllers can do both LE scan and BR/EDR inquiry at once.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
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

