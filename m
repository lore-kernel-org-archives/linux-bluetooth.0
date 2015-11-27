Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
	<lukasz.rymanowski@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?=C5=81ukasz=20Rymanowski?=
	<lukasz.rymanowski@codecoup.pl>
Subject: [PATCH v2 05/11] shared/gatt-client: Minor variable rename
Date: Fri, 27 Nov 2015 12:11:44 +0100
Message-Id: <1448622711-17562-6-git-send-email-lukasz.rymanowski@codecoup.pl>
In-Reply-To: <1448622711-17562-1-git-send-email-lukasz.rymanowski@codecoup.pl>
References: <1448622711-17562-1-git-send-email-lukasz.rymanowski@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use success instead of status to make it easy to read
---
 src/shared/gatt-server.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index ba668e3..a32aeb1 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -1172,7 +1172,7 @@ static void exec_next_prep_write(struct bt_gatt_server *server,
 {
 	struct prep_write_data *next = NULL;
 	struct gatt_db_attribute *attr;
-	bool status;
+	bool success;
 
 	if (err)
 		goto error;
@@ -1190,7 +1190,7 @@ static void exec_next_prep_write(struct bt_gatt_server *server,
 		goto error;
 	}
 
-	status = gatt_db_attribute_write(attr, next->offset,
+	success = gatt_db_attribute_write(attr, next->offset,
 						next->value, next->length,
 						BT_ATT_OP_EXEC_WRITE_REQ,
 						server->att,
@@ -1198,7 +1198,7 @@ static void exec_next_prep_write(struct bt_gatt_server *server,
 
 	prep_write_data_destroy(next);
 
-	if (status)
+	if (success)
 		return;
 
 	err = BT_ATT_ERROR_UNLIKELY;
-- 
2.5.0

