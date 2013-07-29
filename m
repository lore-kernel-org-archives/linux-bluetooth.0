Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 3/5] scanparam: Fix missing check for valid GAttrib when removing device
Date: Mon, 29 Jul 2013 09:59:30 -0400
Message-Id: <1375106372-2255-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1375106372-2255-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1375106372-2255-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If device is removed while there is no connection, scan->attrib will be
NULL, because its reference is managed by attio connect/disconnect
callbacks. This means that on disconnect any resources owned by GAttrib
will be properly destroyed.
---
 profiles/scanparam/scan.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index 0f83f8f..5b9df86 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -239,7 +239,7 @@ static void scan_param_remove(struct btd_service *service)
 {
 	struct scan *scan = btd_service_get_user_data(service);
 
-	if (scan->refresh_cb_id)
+	if (scan->attrib != NULL && scan->refresh_cb_id)
 		g_attrib_unregister(scan->attrib, scan->refresh_cb_id);
 
 	btd_device_remove_attio_callback(scan->device, scan->attioid);
-- 
1.7.9.5

