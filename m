Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [RFC BlueZ 09/12] Try to connect when registering the first callback
Date: Tue,  5 Jul 2011 10:56:05 -0300
Message-Id: <1309874168-32716-10-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1309874168-32716-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1309874168-32716-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If the device is disconnected and the first ATT connection callback is
registered, the first connection attempt can be triggered instead of
waiting the timer.
---
 src/device.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/src/device.c b/src/device.c
index 3d092e2..184252d 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2573,10 +2573,12 @@ guint btd_device_add_attio_callback(struct btd_device *device,
 	if (device->attrib && cfunc)
 		cfunc(device->attrib, user_data);
 
-	if (device->attioid == 0 && device->attrib == NULL)
+	if (device->attioid == 0 && device->attrib == NULL) {
+		att_auto_connect(device);
 		device->attioid = g_timeout_add_seconds(AUTOCONNECT_INTERVAL,
 							att_auto_connect,
 							device);
+	}
 
 	return attio->id;
 }
-- 
1.7.6

