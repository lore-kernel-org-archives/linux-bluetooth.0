Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/8] android/tester: Fix hardcoded length values
Date: Fri, 17 Oct 2014 15:38:14 +0200
Message-Id: <1413553099-19689-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1413553099-19689-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1413553099-19689-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Lenght variable shouldn't be hardcoded in test case structs.
---
 android/tester-gatt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 38dd0ee..97fe0f0 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -596,7 +596,7 @@ static struct set_read_params set_read_param_1 = {
 	.srvc_id = &service_1,
 	.char_id = &characteristic_1,
 	.value = value_1,
-	.len = 1,
+	.len = sizeof(value_1),
 	.status = BT_STATUS_SUCCESS
 };
 
@@ -620,7 +620,7 @@ static struct set_read_params set_read_param_4 = {
 	.char_id = &characteristic_1,
 	.descr_id = &desc_1,
 	.value = value_1,
-	.len = 1,
+	.len = sizeof(value_1),
 	.status = BT_STATUS_SUCCESS
 };
 
-- 
1.9.3

