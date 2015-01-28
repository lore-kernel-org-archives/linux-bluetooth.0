Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: btusb: Handle out of order firmware loading complete event
Date: Wed, 28 Jan 2015 01:44:03 -0800
Message-Id: <1422438243-15352-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When loading the Intel firmware it can happen that the firmware loading
complete vendor event arrives before the command complete event for the
last firmware fragment.

< HCI Command: Vendor (0x3f|0x0009) plen 7
        01 02 fc 03 00 00 00
> HCI Event: Vendor (0xff) plen 5
        06 00 00 00 00
> HCI Event: Command Complete (0x0e) plen 4
      Vendor (0x3f|0x0009) ncmd 31
        Status: Success (0x00)

This is mainly caused by the fact that the vendor command and its
command complete event are transported over the bulk endpoints. The
firmware loading complete event however is send over the interrupt
endpoint. So with just bad timing one event arrives before the other.

Currently the code does not account for it. There are precautions for
receiving firmware loading complete event quickly, but not for receiving
it before the command complete.

Introduce an extra flag that tracks when the firmware sending has
completed from the driver point of view and track the completion of
the firmware loading procedure with a different flag. That way the
wakeup can be handled properly.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 4fac6927ee11..25ca93d13209 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -280,8 +280,9 @@ static const struct usb_device_id blacklist_table[] = {
 #define BTUSB_DID_ISO_RESUME	4
 #define BTUSB_BOOTLOADER	5
 #define BTUSB_DOWNLOADING	6
-#define BTUSB_BOOTING		7
+#define BTUSB_FIRMWARE_LOADED	7
 #define BTUSB_FIRMWARE_FAILED	8
+#define BTUSB_BOOTING		9
 
 struct btusb_data {
 	struct hci_dev       *hdev;
@@ -1788,7 +1789,9 @@ static int btusb_recv_event_intel(struct hci_dev *hdev, struct sk_buff *skb)
 			if (skb->data[3] != 0x00)
 				test_bit(BTUSB_FIRMWARE_FAILED, &data->flags);
 
-			if (test_and_clear_bit(BTUSB_DOWNLOADING, &data->flags))
+			if (test_and_clear_bit(BTUSB_DOWNLOADING,
+					       &data->flags) &&
+			    test_bit(BTUSB_FIRMWARE_LOADED, &data->flags))
 				wake_up_interruptible(&hdev->req_wait_q);
 		}
 
@@ -2151,6 +2154,8 @@ static int btusb_setup_intel_new(struct hci_dev *hdev)
 		fw_ptr += cmd_len;
 	}
 
+	set_bit(BTUSB_FIRMWARE_LOADED, &data->flags);
+
 	/* Before switching the device into operational mode and with that
 	 * booting the loaded firmware, wait for the bootloader notification
 	 * that all fragments have been successfully received.
-- 
2.1.0

