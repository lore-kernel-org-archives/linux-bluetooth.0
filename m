Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/6] android/a2dp: Fix possible NULL dereference
Date: Tue,  3 Dec 2013 17:53:08 +0200
Message-Id: <1386085993-22055-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Since a2dp_record may return NULL, check return value. This
silences static analysers tools.
---
 android/a2dp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/android/a2dp.c b/android/a2dp.c
index cee4bfa..36a0714 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -366,9 +366,10 @@ bool bt_a2dp_register(const bdaddr_t *addr)
 	}
 
 	rec = a2dp_record();
-	if (bt_adapter_add_record(rec, SVC_HINT_CAPTURING) < 0) {
+	if (!rec || bt_adapter_add_record(rec, SVC_HINT_CAPTURING) < 0) {
 		error("Failed to register on A2DP record");
-		sdp_record_free(rec);
+		if (rec)
+			sdp_record_free(rec);
 		g_io_channel_shutdown(server, TRUE, NULL);
 		g_io_channel_unref(server);
 		server = NULL;
-- 
1.8.3.2

