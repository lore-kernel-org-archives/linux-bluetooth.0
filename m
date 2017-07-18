Return-Path: <jeffy.chen@rock-chips.com>
From: Jeffy Chen <jeffy.chen@rock-chips.com>
To: linux-kernel@vger.kernel.org
Cc: xiyou.wangcong@gmail.com,
	briannorris@chromium.org,
	dianders@chromium.org,
	Jeffy Chen <jeffy.chen@rock-chips.com>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	linux-bluetooth@vger.kernel.org
Subject: [RFC PATCH v2] Bluetooth: btusb: Fix memory leak in play_deferred
Date: Tue, 18 Jul 2017 10:06:19 +0800
Message-Id: <1500343579-9831-1-git-send-email-jeffy.chen@rock-chips.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Currently we are calling usb_submit_urb directly to submit deferred tx
urbs after unanchor them.

So the usb_giveback_urb_bh would failed to unref it in usb_unanchor_urb
and cause memory leak:
unreferenced object 0xffffffc0ce0fa400 (size 256):
...
  backtrace:
    [<ffffffc00034a9a8>] __save_stack_trace+0x48/0x6c
    [<ffffffc00034b088>] create_object+0x138/0x254
    [<ffffffc0009d5504>] kmemleak_alloc+0x58/0x8c
    [<ffffffc000345f78>] __kmalloc+0x1d4/0x2a0
    [<ffffffc0006765bc>] usb_alloc_urb+0x30/0x60
    [<ffffffbffc128598>] alloc_ctrl_urb+0x38/0x120 [btusb]
    [<ffffffbffc129e7c>] btusb_send_frame+0x64/0xf8 [btusb]

Free those urbs after completed to avoid the leak, and also fix the
error handling.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

Changes in v2:
Call usb_free_urb instead of reusing submit_tx_urb.

 drivers/bluetooth/btusb.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 0d533b2..a22a08b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3260,19 +3260,33 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 	return 0;
 }
 
+static void btusb_deferred_tx_complete(struct urb *urb)
+{
+	btusb_tx_complete(urb);
+	usb_free_urb(urb);
+}
+
 static void play_deferred(struct btusb_data *data)
 {
 	struct urb *urb;
 	int err;
 
 	while ((urb = usb_get_from_anchor(&data->deferred))) {
+		/* Add a hook to free urb after completed */
+		urb->complete = btusb_deferred_tx_complete;
+
 		err = usb_submit_urb(urb, GFP_ATOMIC);
-		if (err < 0)
-			break;
+		if (err < 0) {
+			if (err != -EPERM && err != -ENODEV)
+				BT_ERR("%s urb %p submission failed (%d)",
+				       data->hdev->name, urb, -err);
+			kfree(urb->setup_packet);
+			usb_free_urb(urb);
+			continue;
+		}
 
 		data->tx_in_flight++;
 	}
-	usb_scuttle_anchored_urbs(&data->deferred);
 }
 
 static int btusb_resume(struct usb_interface *intf)
-- 
2.1.4
