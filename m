Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] device: Shutdown connection if ATTIO list is empty
Date: Wed,  8 Feb 2012 16:05:10 -0300
Message-Id: <1328727910-20179-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Shutdown the ongoing connection attempt if the last ATTIO callback
is removed from the list.
---
 src/device.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/src/device.c b/src/device.c
index c7c741c..b0e6adc 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2883,5 +2883,11 @@ gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id)
 		device->attrib = NULL;
 	}
 
+	if (device->att_io) {
+		g_io_channel_shutdown(device->att_io, FALSE, NULL);
+		g_io_channel_unref(device->att_io);
+		device->att_io = NULL;
+	}
+
 	return TRUE;
 }
-- 
1.7.9

