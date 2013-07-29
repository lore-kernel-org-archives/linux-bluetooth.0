Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 4/5] scanparam: Apply convention for "GSource id" like variable
Date: Mon, 29 Jul 2013 09:59:31 -0400
Message-Id: <1375106372-2255-4-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1375106372-2255-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1375106372-2255-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

By convention, BlueZ code checks for "Gsource id" like variables using:

if (source_id > 0)
...

Also fix the variable type to match that returned by
g_attrib_unregister().
---
 profiles/scanparam/scan.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index 5b9df86..ebdb7b8 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -61,7 +61,7 @@ struct scan {
 	uint16_t window;
 	uint16_t iwhandle;
 	uint16_t refresh_handle;
-	uint16_t refresh_cb_id;
+	guint refresh_cb_id;
 };
 
 static void write_scan_params(GAttrib *attrib, uint16_t handle)
@@ -239,7 +239,7 @@ static void scan_param_remove(struct btd_service *service)
 {
 	struct scan *scan = btd_service_get_user_data(service);
 
-	if (scan->attrib != NULL && scan->refresh_cb_id)
+	if (scan->attrib != NULL && scan->refresh_cb_id > 0)
 		g_attrib_unregister(scan->attrib, scan->refresh_cb_id);
 
 	btd_device_remove_attio_callback(scan->device, scan->attioid);
-- 
1.7.9.5

