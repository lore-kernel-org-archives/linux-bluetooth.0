Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] android/tester: initialize unused callback to NULL
Date: Mon, 10 Nov 2014 11:04:47 +0200
Message-Id: <1415610288-2035-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/tester-main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/tester-main.c b/android/tester-main.c
index 44a2726..33ef3ce 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -1394,7 +1394,8 @@ static bthh_callbacks_t bthh_callbacks = {
 	.protocol_mode_cb = hidhost_protocol_mode_cb,
 	.idle_time_cb = NULL,
 	.get_report_cb = hidhost_get_report_cb,
-	.virtual_unplug_cb = hidhost_virtual_unplug_cb
+	.virtual_unplug_cb = hidhost_virtual_unplug_cb,
+	.handshake_cb = NULL,
 };
 
 static void gattc_register_client_cb(int status, int client_if,
-- 
1.9.1

