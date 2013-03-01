Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [RFC BlueZ v0 01/10] device: Clean up the ATT Connection attempt when it is cancelled
Date: Fri,  1 Mar 2013 20:22:24 -0300
Message-Id: <1362180153-11133-2-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1362180153-11133-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1362180153-11133-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/device.c b/src/device.c
index 4320234..8c1bd73 100644
--- a/src/device.c
+++ b/src/device.c
@@ -987,6 +987,8 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
 	if (device->browse)
 		browse_request_cancel(device->browse);
 
+	attio_cleanup(device);
+
 	if (device->connect) {
 		DBusMessage *reply = btd_error_failed(device->connect,
 								"Cancelled");
-- 
1.8.1.3

