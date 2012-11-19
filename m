Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/5] device: Remove not really used auto_id member from btd_device
Date: Mon, 19 Nov 2012 16:02:45 +0100
Message-ID: <1353337366-21590-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1353337366-21590-1-git-send-email-szymon.janc@tieto.com>
References: <1353337366-21590-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

auto_id is not used anymore as LE device connect is now done by
adapter autoconnect list.
---
 src/device.c |    9 ---------
 1 file changed, 9 deletions(-)

diff --git a/src/device.c b/src/device.c
index bc78fa7..44e58ac 100644
--- a/src/device.c
+++ b/src/device.c
@@ -174,7 +174,6 @@ struct btd_device {
 	GSList		*attios;
 	GSList		*attios_offline;
 	guint		attachid;		/* Attrib server attach */
-	guint		auto_id;		/* Auto connect source id */
 
 	gboolean	connected;
 	gboolean	profiles_connected;	/* Profile level connected */
@@ -346,9 +345,6 @@ static void device_free(gpointer user_data)
 	if (device->discov_timer)
 		g_source_remove(device->discov_timer);
 
-	if (device->auto_id)
-		g_source_remove(device->auto_id);
-
 	DBG("%p", device);
 
 	if (device->authr)
@@ -4027,11 +4023,6 @@ gboolean btd_device_remove_attio_callback(struct btd_device *device, guint id)
 	if (device->attios != NULL || device->attios_offline != NULL)
 		return TRUE;
 
-	if (device->auto_id) {
-		g_source_remove(device->auto_id);
-		device->auto_id = 0;
-	}
-
 	attio_cleanup(device);
 
 	return TRUE;
-- 
1.7.9.5

