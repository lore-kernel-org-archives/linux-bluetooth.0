Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] Bluetooth: Rename HCI_QUIRK_NO_RESET to HCI_QUIRK_RESET_ON_CLOSE
Date: Wed, 23 May 2012 12:35:46 +0200
Message-ID: <1337769346-16306-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HCI_QUIRK_NO_RESET name is misleading - purpose of this quirk is to
reset device on close instead of init, not to not reset at all.
Rename it to HCI_QUIRK_RESET_ON_CLOSE to avoid confusion.

Signed-off-by: Szymon Janc <szymon.janc@tieto.com>
---
 drivers/bluetooth/bpa10x.c    |    2 +-
 drivers/bluetooth/btusb.c     |    6 +++---
 drivers/bluetooth/hci_ldisc.c |    2 +-
 include/net/bluetooth/hci.h   |    2 +-
 net/bluetooth/hci_core.c      |    4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/bluetooth/bpa10x.c b/drivers/bluetooth/bpa10x.c
index d894340..457f4e6 100644
--- a/drivers/bluetooth/bpa10x.c
+++ b/drivers/bluetooth/bpa10x.c
@@ -470,7 +470,7 @@ static int bpa10x_probe(struct usb_interface *intf, const struct usb_device_id *
 	hdev->flush    = bpa10x_flush;
 	hdev->send     = bpa10x_send_frame;
 
-	set_bit(HCI_QUIRK_NO_RESET, &hdev->quirks);
+	set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
 
 	err = hci_register_dev(hdev);
 	if (err < 0) {
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index cb480f1..de87b12 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1026,7 +1026,7 @@ static int btusb_probe(struct usb_interface *intf,
 	data->isoc = usb_ifnum_to_if(data->udev, 1);
 
 	if (!reset)
-		set_bit(HCI_QUIRK_NO_RESET, &hdev->quirks);
+		set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
 
 	if (force_scofix || id->driver_info & BTUSB_WRONG_SCO_MTU) {
 		if (!disable_scofix)
@@ -1038,7 +1038,7 @@ static int btusb_probe(struct usb_interface *intf,
 
 	if (id->driver_info & BTUSB_DIGIANSWER) {
 		data->cmdreq_type = USB_TYPE_VENDOR;
-		set_bit(HCI_QUIRK_NO_RESET, &hdev->quirks);
+		set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
 	}
 
 	if (id->driver_info & BTUSB_CSR) {
@@ -1046,7 +1046,7 @@ static int btusb_probe(struct usb_interface *intf,
 
 		/* Old firmware would otherwise execute USB reset */
 		if (le16_to_cpu(udev->descriptor.bcdDevice) < 0x117)
-			set_bit(HCI_QUIRK_NO_RESET, &hdev->quirks);
+			set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
 	}
 
 	if (id->driver_info & BTUSB_SNIFFER) {
diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index e564579..2f9b796 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -394,7 +394,7 @@ static int hci_uart_register_dev(struct hci_uart *hu)
 		set_bit(HCI_QUIRK_RAW_DEVICE, &hdev->quirks);
 
 	if (!test_bit(HCI_UART_RESET_ON_INIT, &hu->hdev_flags))
-		set_bit(HCI_QUIRK_NO_RESET, &hdev->quirks);
+		set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
 
 	if (test_bit(HCI_UART_CREATE_AMP, &hu->hdev_flags))
 		hdev->dev_type = HCI_AMP;
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 66a7b57..97c57aa 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -58,7 +58,7 @@
 
 /* HCI device quirks */
 enum {
-	HCI_QUIRK_NO_RESET,
+	HCI_QUIRK_RESET_ON_CLOSE,
 	HCI_QUIRK_RAW_DEVICE,
 	HCI_QUIRK_FIXUP_BUFFER_SIZE
 };
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d0a960d..0ed4edf 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -203,7 +203,7 @@ static void bredr_init(struct hci_dev *hdev)
 	/* Mandatory initialization */
 
 	/* Reset */
-	if (!test_bit(HCI_QUIRK_NO_RESET, &hdev->quirks)) {
+	if (!test_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks)) {
 		set_bit(HCI_RESET, &hdev->flags);
 		hci_send_cmd(hdev, HCI_OP_RESET, 0, NULL);
 	}
@@ -792,7 +792,7 @@ static int hci_dev_do_close(struct hci_dev *hdev)
 	skb_queue_purge(&hdev->cmd_q);
 	atomic_set(&hdev->cmd_cnt, 1);
 	if (!test_bit(HCI_RAW, &hdev->flags) &&
-	    test_bit(HCI_QUIRK_NO_RESET, &hdev->quirks)) {
+	    test_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks)) {
 		set_bit(HCI_INIT, &hdev->flags);
 		__hci_request(hdev, hci_reset_req, 0,
 			      msecs_to_jiffies(250));
-- 
on behalf of ST-Ericsson

