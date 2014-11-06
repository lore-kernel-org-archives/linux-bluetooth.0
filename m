Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/tester: Fix typo in function name
Date: Thu,  6 Nov 2014 16:29:41 +0200
Message-Id: <1415284181-11427-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/tester-main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/tester-main.c b/android/tester-main.c
index 4d22249..ec03aa1 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -1339,7 +1339,7 @@ static void hidhost_connection_state_cb(bt_bdaddr_t *bd_addr,
 	schedule_callback_verification(step);
 }
 
-static void hidhost_virual_unplug_cb(bt_bdaddr_t *bd_addr, bthh_status_t status)
+static void hidhost_virtual_unplug_cb(bt_bdaddr_t *bd_addr, bthh_status_t status)
 {
 	struct step *step = g_new0(struct step, 1);
 
@@ -1393,7 +1393,7 @@ static bthh_callbacks_t bthh_callbacks = {
 	.protocol_mode_cb = hidhost_protocol_mode_cb,
 	.idle_time_cb = NULL,
 	.get_report_cb = hidhost_get_report_cb,
-	.virtual_unplug_cb = hidhost_virual_unplug_cb
+	.virtual_unplug_cb = hidhost_virtual_unplug_cb
 };
 
 static void gattc_register_client_cb(int status, int client_if,
-- 
1.9.1

