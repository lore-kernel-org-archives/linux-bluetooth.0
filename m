Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 07/12] android/gatt: Add missing error check
Date: Fri,  4 Jul 2014 16:43:56 +0300
Message-Id: <1404481441-734-8-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1404481441-734-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1404481441-734-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fixes clang warning:
...
android/gatt.c:2097:4: warning: Value stored to 'srvc_search_success' is
never read
       srvc_search_success = search_dev_for_srvc(conn, NULL);
...
---
 android/gatt.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index b47ba83..fa7e1c3 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -2093,9 +2093,13 @@ static void handle_client_search_service(const void *buf, uint16_t len)
 		}
 	} else {
 		/* Refresh service cache if only partial search was performed */
-		if (conn->device->partial_srvc_search)
+		if (conn->device->partial_srvc_search) {
 			srvc_search_success = search_dev_for_srvc(conn, NULL);
-		else
+			if (!srvc_search_success) {
+				status = HAL_STATUS_FAILED;
+				goto reply;
+			}
+		} else
 			queue_foreach(conn->device->services,
 						send_client_primary_notify,
 						INT_TO_PTR(cmd->conn_id));
-- 
1.9.1

