Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 4/5] Fix missing reply when create device is cancelled
Date: Wed, 15 Dec 2010 16:54:11 -0300
Message-Id: <1292442852-26457-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1292442852-26457-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1292442852-26457-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When CancelDeviceCreation is called or when the device is removed for
any reason, the reply for the pending CreateDevice is not sent.
---
 src/device.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index cf3b146..a881c4c 100644
--- a/src/device.c
+++ b/src/device.c
@@ -730,8 +730,10 @@ void device_request_disconnect(struct btd_device *device, DBusMessage *msg)
 	if (device->bonding)
 		bonding_request_cancel(device->bonding);
 
-	if (device->browse)
+	if (device->browse) {
+		discover_services_reply(device->browse, -ECANCELED, NULL);
 		browse_request_cancel(device->browse);
+	}
 
 	if (msg)
 		device->disconnects = g_slist_append(device->disconnects,
@@ -1043,8 +1045,10 @@ void device_remove(struct btd_device *device, gboolean remove_stored)
 	if (device->bonding)
 		device_cancel_bonding(device, HCI_OE_USER_ENDED_CONNECTION);
 
-	if (device->browse)
+	if (device->browse) {
+		discover_services_reply(device->browse, -ECANCELED, NULL);
 		browse_request_cancel(device->browse);
+	}
 
 	if (device->handle)
 		do_disconnect(device);
-- 
1.7.3.3

