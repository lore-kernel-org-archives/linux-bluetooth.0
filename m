Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 2/5] scanparam: Remove unnecessary assignment
Date: Mon, 29 Jul 2013 09:59:29 -0400
Message-Id: <1375106372-2255-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1375106372-2255-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1375106372-2255-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

"scan" will be g_free()'d on this same function, so no need to assign 0
to refresh_cb_id.
---
 profiles/scanparam/scan.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index 0ad2e17..0f83f8f 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -239,10 +239,8 @@ static void scan_param_remove(struct btd_service *service)
 {
 	struct scan *scan = btd_service_get_user_data(service);
 
-	if (scan->refresh_cb_id) {
+	if (scan->refresh_cb_id)
 		g_attrib_unregister(scan->attrib, scan->refresh_cb_id);
-		scan->refresh_cb_id = 0;
-	}
 
 	btd_device_remove_attio_callback(scan->device, scan->attioid);
 	btd_device_unref(scan->device);
-- 
1.7.9.5

