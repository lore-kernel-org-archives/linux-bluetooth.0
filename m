Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] android/gatt: Fix error status override
Date: Mon,  9 Jun 2014 11:26:16 +0300
Message-Id: <1402302376-22372-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/gatt.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 3fd88fa..7cf70a9 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1950,8 +1950,10 @@ static void handle_client_search_service(const void *buf, uint16_t len)
 		if (s) {
 			send_client_primary_notify(s, INT_TO_PTR(conn->id));
 		} else {
-			if (!search_dev_for_srvc(conn, &uuid))
+			if (!search_dev_for_srvc(conn, &uuid)) {
 				status = HAL_STATUS_FAILED;
+				goto reply;
+			}
 
 			status = HAL_STATUS_SUCCESS;
 			goto reply;
-- 
1.8.3.2

