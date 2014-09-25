Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/6] android/tester: Style fix
Date: Thu, 25 Sep 2014 16:03:08 +0200
Message-Id: <1411653793-5254-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/tester-main.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/android/tester-main.c b/android/tester-main.c
index b65029a..081a1ce 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -440,8 +440,7 @@ static bool match_data(struct step *step)
 			return false;
 		}
 
-		if (exp->callback_result.state !=
-						step->callback_result.state) {
+		if (exp->callback_result.state != step->callback_result.state) {
 			tester_debug("Callback state don't match");
 			return false;
 		}
@@ -452,8 +451,7 @@ static bool match_data(struct step *step)
 			return false;
 		}
 
-		if (exp->callback_result.mode !=
-						step->callback_result.mode) {
+		if (exp->callback_result.mode != step->callback_result.mode) {
 			tester_debug("Callback mode don't match");
 			return false;
 		}
@@ -489,7 +487,7 @@ static bool match_data(struct step *step)
 		}
 
 		if (exp->callback_result.app_id !=
-					step->callback_result.app_id) {
+						step->callback_result.app_id) {
 			tester_debug("Callback app_id don't match");
 			return false;
 		}
@@ -874,8 +872,8 @@ static void bond_state_changed_cb(bt_status_t status,
 
 	/* Utilize property verification mechanism for bdaddr */
 	step->callback_result.num_properties = 1;
-	step->callback_result.properties = create_property(BT_PROPERTY_BDADDR,
-						remote_bd_addr,
+	step->callback_result.properties =
+			create_property(BT_PROPERTY_BDADDR, remote_bd_addr,
 						sizeof(*remote_bd_addr));
 
 	step->callback = CB_BT_BOND_STATE_CHANGED;
-- 
1.9.3

