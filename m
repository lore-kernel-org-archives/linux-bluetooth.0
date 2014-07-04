Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Support HCI_QUIRK_EXTERNAL_CONFIG for hci_vhci driver
Date: Fri,  4 Jul 2014 17:23:35 +0200
Message-Id: <1404487415-15089-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds support for configuring the hci_vhci virtual controllers
to require a setup stage using HCI_QUIRK_EXTERNAL_CONFIG. With this
option the virtual controller will start out as unconfigured.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_vhci.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index aa446c7eb7e5..5bb5872ffee6 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -107,8 +107,8 @@ static int vhci_create_device(struct vhci_data *data, __u8 opcode)
 	if (dev_type != HCI_BREDR && dev_type != HCI_AMP)
 		return -EINVAL;
 
-	/* bits 2-6 are reserved (must be zero) */
-	if (opcode & 0x7c)
+	/* bits 2-5 are reserved (must be zero) */
+	if (opcode & 0x3c)
 		return -EINVAL;
 
 	skb = bt_skb_alloc(4, GFP_KERNEL);
@@ -132,6 +132,10 @@ static int vhci_create_device(struct vhci_data *data, __u8 opcode)
 	hdev->flush = vhci_flush;
 	hdev->send  = vhci_send_frame;
 
+	/* bit 6 is for external configuration */
+	if (opcode & 0x40)
+		set_bit(HCI_QUIRK_EXTERNAL_CONFIG, &hdev->quirks);
+
 	/* bit 7 is for raw device */
 	if (opcode & 0x80)
 		set_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks);
-- 
1.9.3

