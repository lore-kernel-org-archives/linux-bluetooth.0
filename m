Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH] core/device: Fix disconnect for connect attempt
Date: Thu,  1 Oct 2015 22:18:58 -0700
Message-Id: <1443763138-23207-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Right now calling Disconnect from DBus on device that's not advertising
or out of sight will not stop the connect attempt in kernel. This patch
fixes that by making sure that att_io is properly cleaned up on
disconnect.
---
 src/device.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/device.c b/src/device.c
index 5ec8780..fd177f4 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1355,6 +1355,12 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
 	if (device->browse)
 		browse_request_cancel(device->browse);
 
+	if (device->att_io) {
+		g_io_channel_shutdown(device->att_io, FALSE, NULL);
+		g_io_channel_unref(device->att_io);
+		device->att_io = NULL;
+	}
+
 	if (device->connect) {
 		DBusMessage *reply = btd_error_failed(device->connect,
 								"Cancelled");
-- 
2.5.0

