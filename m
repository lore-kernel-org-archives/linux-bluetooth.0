Return-Path: <cyrus@holtmann.org>
From: Anchit Narang <anchit.n@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: sachin.dev@samsung.com, anupam.r@samsung.com,
	Anchit Narang <anchit.n@samsung.com>
Subject: [PATCH] android/tester-gatt.c:Fixed Memory leak
Date: Fri, 26 Jun 2015 16:13:49 +0530
Message-id: <1435315429-24836-1-git-send-email-anchit.n@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes memory leak issues in various functions
by allocating memory to  structure step only after intial
checks are performed as control was returning from these
checks without freeing memory allocated to it.
---
 android/tester-gatt.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index b8b088b..7083ac6 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -1140,13 +1140,15 @@ static void gatt_client_register_action(void)
 	struct test_data *data = tester_get_data();
 	struct step *current_data_step = queue_peek_head(data->steps);
 	bt_uuid_t *app_uuid = current_data_step->set_data;
-	struct step *step = g_new0(struct step, 1);
+	struct step *step;
 
 	if (!app_uuid) {
 		tester_warn("No app uuid provided for register action.");
 		return;
 	}
 
+	step = g_new0(struct step, 1);
+
 	step->action_status = data->if_gatt->client->register_client(app_uuid);
 
 	schedule_action_verification(step);
@@ -1392,13 +1394,15 @@ static void gatt_server_register_action(void)
 	struct test_data *data = tester_get_data();
 	struct step *current_data_step = queue_peek_head(data->steps);
 	bt_uuid_t *app_uuid = current_data_step->set_data;
-	struct step *step = g_new0(struct step, 1);
+	struct step *step;
 
 	if (!app_uuid) {
 		tester_warn("No app uuid provided for register action.");
 		return;
 	}
 
+	step = g_new0(struct step, 1);
+
 	step->action_status = data->if_gatt->server->register_server(app_uuid);
 
 	schedule_action_verification(step);
-- 
1.7.9.5

