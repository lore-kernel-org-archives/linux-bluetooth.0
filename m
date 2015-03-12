Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCHv2 1/2] android/hog: Fix double queue_destroy
Date: Thu, 12 Mar 2015 15:48:11 +0100
Message-Id: <1426171691-20096-1-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <8751350.UbEOeYCG5L@leonov>
References: <8751350.UbEOeYCG5L@leonov>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no need to destroy these queues here, there are destroyed in
hog_free. Prevents from memory violation.
---
 android/hog.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/android/hog.c b/android/hog.c
index 88a5460..8133303 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -1180,23 +1180,11 @@ struct bt_hog *bt_hog_new(const char *name, uint16_t vendor, uint16_t product,
 		return NULL;
 
 	hog->gatt_op = queue_new();
-	if (!hog->gatt_op) {
-		hog_free(hog);
-		return NULL;
-	}
-
 	hog->bas = queue_new();
-	if (!hog->bas) {
-		queue_destroy(hog->gatt_op, NULL);
-		hog_free(hog);
-		return NULL;
-	}
-
 	hog->uhid = bt_uhid_new_default();
-	if (!hog->uhid) {
+
+	if (!hog->gatt_op || !hog->bas || !hog->uhid) {
 		hog_free(hog);
-		queue_destroy(hog->gatt_op, NULL);
-		queue_destroy(hog->bas, NULL);
 		return NULL;
 	}
 
-- 
1.9.1

