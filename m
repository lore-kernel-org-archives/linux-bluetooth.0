Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 01/12] android/gatt: Change DBG() to error()
Date: Fri,  4 Jul 2014 16:43:50 +0300
Message-Id: <1404481441-734-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1404481441-734-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1404481441-734-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 95de221..5cb08ec 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4386,7 +4386,7 @@ static void fill_gatt_response_by_handle(uint16_t handle, uint16_t offset,
 	entry = queue_find(dev->pending_requests, match_dev_request_by_handle,
 							UINT_TO_PTR(handle));
 	if (!entry) {
-		DBG("No pending response found! Bogus android response?");
+		error("gatt: No pending response! Bogus android response?");
 		return;
 	}
 
-- 
1.9.1

