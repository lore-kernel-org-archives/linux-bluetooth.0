Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/8] android/tester: Use BT_STATUS defines instead of hardcoded values
Date: Fri, 17 Oct 2014 15:38:15 +0200
Message-Id: <1413553099-19689-4-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1413553099-19689-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1413553099-19689-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Status value in test case structs should use defined BT_STATUS types.
---
 android/tester-gatt.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 97fe0f0..d123619 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -611,7 +611,7 @@ static struct set_read_params set_read_param_3 = {
 	.params = &read_params_1,
 	.srvc_id = &service_2,
 	.char_id = &characteristic_1,
-	.status = 0x01,
+	.status = BT_STATUS_FAIL
 };
 
 static struct set_read_params set_read_param_4 = {
@@ -637,7 +637,7 @@ static struct set_read_params set_read_param_6 = {
 	.srvc_id = &service_1,
 	.char_id = &characteristic_1,
 	.descr_id = &desc_2,
-	.status = 0x01
+	.status = BT_STATUS_FAIL
 };
 
 static struct set_write_params set_write_param_1 = {
@@ -658,7 +658,7 @@ static struct set_write_params set_write_param_3 = {
 	.params = &write_params_1,
 	.srvc_id = &service_1,
 	.char_id = &characteristic_1,
-	.status = 0x01
+	.status = BT_STATUS_FAIL
 };
 
 static struct set_write_params set_write_param_4 = {
@@ -674,7 +674,7 @@ static struct set_write_params set_write_param_5 = {
 	.srvc_id = &service_1,
 	.char_id = &characteristic_1,
 	.descr_id = &desc_2,
-	.status = 0x01
+	.status = BT_STATUS_FAIL
 };
 
 static struct set_write_params set_write_param_6 = {
-- 
1.9.3

