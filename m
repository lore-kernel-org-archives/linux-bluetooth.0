Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/2] android/client: Fix service search command
Date: Fri, 14 Mar 2014 15:07:30 +0100
Message-ID: <1394806051-8160-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

We should be able to send NULL in case we want all the primary seavices
---
 android/client/if-gatt.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/android/client/if-gatt.c b/android/client/if-gatt.c
index e8837ff..d58fc4b 100644
--- a/android/client/if-gatt.c
+++ b/android/client/if-gatt.c
@@ -961,19 +961,21 @@ static void search_service_c(int argc, const char **argv, enum_func *enum_func,
 static void search_service_p(int argc, const char **argv)
 {
 	int conn_id;
-	bt_uuid_t filter_uuid;
 
 	RETURN_IF_NULL(if_gatt);
 
 	VERIFY_CONN_ID(2, conn_id);
 
 	/* uuid */
-	if (argc <= 3)
-		memset(&filter_uuid, 0, sizeof(bt_uuid_t));
-	else
-		gatt_str2bt_uuid_t(argv[3], -1, &filter_uuid);
+	if (argc <= 3) {
+		EXEC(if_gatt->client->search_service, conn_id, NULL);
 
-	EXEC(if_gatt->client->search_service, conn_id, &filter_uuid);
+	} else {
+		bt_uuid_t filter_uuid;
+
+		gatt_str2bt_uuid_t(argv[3], -1, &filter_uuid);
+		EXEC(if_gatt->client->search_service, conn_id, &filter_uuid);
+	}
 }
 
 /* get_included_service */
-- 
1.8.4

