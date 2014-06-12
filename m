Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/gatt: Fix wrong check
Date: Thu, 12 Jun 2014 13:40:54 +0300
Message-Id: <1402569654-27092-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/gatt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index cc3746c..8da77d0 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4133,8 +4133,8 @@ static void fill_gatt_response_by_handle(uint16_t handle, uint16_t offset,
 
 	entry = queue_find(dev->pending_requests, match_dev_request_by_handle,
 							UINT_TO_PTR(handle));
-	if (entry) {
-		DBG("No pending response found! Bogus android response?");
+	if (!entry) {
+		error("No pending response found! Bogus android response?");
 		return;
 	}
 
-- 
1.8.3.2

