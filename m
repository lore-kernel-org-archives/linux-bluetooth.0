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
Subject: [RFC PATCH] Bluetooth: btusb: Fix memory leak in play_deferred
Date: Thu, 22 Jun 2017 18:10:42 +0800
Message-Id: <1498126243-4771-1-git-send-email-jeffy.chen@rock-chips.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Currently in play_deferred, we are calling usb_submit_urb directly to
submit deferred tx urb after unanchor it.

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

Use submit_tx_urb instead for better error handling and avoid the leak.

Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
---

 drivers/bluetooth/btusb.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 278e811..b469f9b 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3254,11 +3254,12 @@ static int btusb_suspend(struct usb_interface *intf, pm_message_t message)
 
 static void play_deferred(struct btusb_data *data)
 {
+	struct hci_dev *hdev = data->hdev;
 	struct urb *urb;
 	int err;
 
 	while ((urb = usb_get_from_anchor(&data->deferred))) {
-		err = usb_submit_urb(urb, GFP_ATOMIC);
+		err = submit_tx_urb(hdev, urb);
 		if (err < 0)
 			break;
 
-- 
2.1.4
