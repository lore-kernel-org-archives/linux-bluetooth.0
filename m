Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/avrcp: Close AVRCP channel on error
Date: Thu, 30 Jan 2014 15:23:43 +0200
Message-Id: <1391088223-2586-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This fixes resource leak.
---
 android/avrcp.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/android/avrcp.c b/android/avrcp.c
index 485b485..ef833df 100644
--- a/android/avrcp.c
+++ b/android/avrcp.c
@@ -248,13 +248,13 @@ bool bt_avrcp_register(const bdaddr_t *addr)
 	rec = avrcp_record();
 	if (!rec) {
 		error("Failed to allocate AVRCP record");
-		return false;
+		goto fail;
 	}
 
 	if (bt_adapter_add_record(rec, 0) < 0) {
 		error("Failed to register AVRCP record");
 		sdp_record_free(rec);
-		return false;
+		goto fail;
 	}
 	record_id = rec->handle;
 
@@ -262,6 +262,12 @@ bool bt_avrcp_register(const bdaddr_t *addr)
 						G_N_ELEMENTS(cmd_handlers));
 
 	return true;
+fail:
+	g_io_channel_shutdown(server, TRUE, NULL);
+	g_io_channel_unref(server);
+	server = NULL;
+
+	return false;
 }
 
 void bt_avrcp_unregister(void)
-- 
1.8.3.2

