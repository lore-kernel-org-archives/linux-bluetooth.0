Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2 v2] thermometer: Fix crash while unregistering adapter
Date: Thu, 31 Jan 2013 09:33:51 -0600
Message-Id: <1359646436-8113-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1359646436-8113-1-git-send-email-luiz.dentz@gmail.com>
References: <1359646436-8113-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Invalid read of size 8
   at 0x448200: g_attrib_unregister (gattrib.c:722)
   by 0x440476: destroy_thermometer (thermometer.c:167)
   by 0x40D849: remove_interface (object.c:656)
   by 0x40DAA9: g_dbus_unregister_interface (object.c:1413)
   by 0x3DF7A63C9C: g_slist_foreach (gslist.c:894)
   by 0x469656: device_remove (device.c:2200)
   by 0x45CDC1: adapter_remove (adapter.c:3884)
   by 0x45F146: index_removed (adapter.c:5442)
   by 0x46BC17: received_data (mgmt.c:252)
   by 0x3DF7A47A74: g_main_context_dispatch (gmain.c:2715)
   by 0x3DF7A47DA7: g_main_context_iterate.isra.24 (gmain.c:3290)
   by 0x3DF7A481A1: g_main_loop_run (gmain.c:3484)
 Address 0x40 is not stack'd, malloc'd or (recently) free'd
---
v2: Print a warning if invalid id is passed to g_attrib_unregister

 profiles/thermometer/thermometer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/profiles/thermometer/thermometer.c b/profiles/thermometer/thermometer.c
index 0cf14e6..1b299e7 100644
--- a/profiles/thermometer/thermometer.c
+++ b/profiles/thermometer/thermometer.c
@@ -164,12 +164,12 @@ static void destroy_thermometer(gpointer user_data)
 	if (t->attioid > 0)
 		btd_device_remove_attio_callback(t->dev, t->attioid);
 
-	g_attrib_unregister(t->attrib, t->attio_measurement_id);
-	g_attrib_unregister(t->attrib, t->attio_intermediate_id);
-	g_attrib_unregister(t->attrib, t->attio_interval_id);
-
-	if (t->attrib != NULL)
+	if (t->attrib != NULL) {
+		g_attrib_unregister(t->attrib, t->attio_measurement_id);
+		g_attrib_unregister(t->attrib, t->attio_intermediate_id);
+		g_attrib_unregister(t->attrib, t->attio_interval_id);
 		g_attrib_unref(t->attrib);
+	}
 
 	btd_device_unref(t->dev);
 	g_free(t->svc_range);
-- 
1.8.1

