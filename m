Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [RFC 03/13] android/gatt: Dont process pending requests if queue is empty
Date: Fri,  6 Jun 2014 15:46:16 +0200
Message-Id: <1402062386-4632-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1402062386-4632-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1402062386-4632-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Processing empty queue can result with crash:

bluetoothd[1670]:
    external/bluetooth/bluez/attrib/gattrib.c:g_attrib_ref() 0x6035878:
    ref=2
    02-23 21:36:05.650 I/bluetoothd( 1669): ==1670== Invalid
    read of size 1
    02-23 21:36:05.650 I/bluetoothd( 1669): ==1670==    at 0x12151E:
    send_dev_pending_response (gatt.c:3914)
    02-23 21:36:05.650 I/bluetoothd( 1669): ==1670==    by 0x121B33:
    process_dev_pending_requests (gatt.c:4228)
    02-23 21:36:05.650 I/bluetoothd( 1669): ==1670==    by 0x123955:
    att_handler (gatt.c:5049)
---
 android/gatt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/gatt.c b/android/gatt.c
index c173b89..c3dc41c 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4175,6 +4175,9 @@ static void process_dev_pending_requests(struct gatt_device *device,
 {
 	struct request_processing_data process_data;
 
+	if (queue_isempty(device->pending_requests))
+		return;
+
 	process_data.device = device;
 	process_data.opcode = att_opcode;
 
-- 
2.0.0

