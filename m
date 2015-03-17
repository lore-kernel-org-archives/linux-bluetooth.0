Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v6 6/6] Bluetooth: Set HCI_QUIRK_SIMULTANEOUS_DISCOVERY for BTUSB_CSR
Date: Tue, 17 Mar 2015 09:04:17 -0700
Message-Id: <1426608257-20332-6-git-send-email-jpawlowski@google.com>
In-Reply-To: <1426608257-20332-1-git-send-email-jpawlowski@google.com>
References: <1426608257-20332-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

CSR controllers can do both LE scan and BR/EDR inquiry at once.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 drivers/bluetooth/btusb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 21df7b2..708b657 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3087,6 +3087,8 @@ static int btusb_probe(struct usb_interface *intf,
 		/* Fake CSR devices with broken commands */
 		if (bcdDevice <= 0x100)
 			hdev->setup = btusb_setup_csr;
+
+		set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
 	}
 
 	if (id->driver_info & BTUSB_SNIFFER) {
-- 
2.2.0.rc0.207.ga3a616c

