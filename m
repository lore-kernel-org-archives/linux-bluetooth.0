Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, cpgs@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [PATCH v1 2/3] shared/gatt-client: Fix usage of freed memory
Date: Tue, 27 Jan 2015 14:23:19 +0530
Message-id: <1422348800-5668-3-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1422348800-5668-1-git-send-email-gowtham.ab@samsung.com>
References: <1422348800-5668-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

src/shared/gatt-client.c:534:14: warning: Use of memory after it is freed
        op->success = false;
        ~~~~~~~~~~~ ^
src/shared/gatt-client.c:689:14: warning: Use of memory after it is freed
        op->success = success;
        ~~~~~~~~~~~ ^
src/shared/gatt-client.c:790:14: warning: Use of memory after it is freed
        op->success = success;
        ~~~~~~~~~~~ ^
src/shared/gatt-client.c:882:14: warning: Use of memory after it is freed
        op->success = success;
        ~~~~~~~~~~~ ^
src/shared/gatt-client.c:950:14: warning: Use of memory after it is freed
        op->success = success;
        ~~~~~~~~~~~ ^
---
 src/shared/gatt-client.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 1acd34f..12c9b2f 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -511,7 +511,6 @@ next:
 
 		util_debug(client->debug_callback, client->debug_data,
 				"Failed to start characteristic discovery");
-		discovery_op_unref(op);
 		goto failed;
 	}
 
@@ -528,11 +527,11 @@ next:
 
 	util_debug(client->debug_callback, client->debug_data,
 					"Failed to start included discovery");
-	discovery_op_unref(op);
 
 failed:
 	op->success = false;
 	op->complete_func(op, false, att_ecode);
+	discovery_op_unref(op);
 }
 
 struct chrc {
@@ -587,8 +586,11 @@ static bool discover_descs(struct discovery_op *op, bool *discovering)
 
 		util_debug(client->debug_callback, client->debug_data,
 					"Failed to start descriptor discovery");
-		discovery_op_unref(op);
 
+		/*
+		 * discovery_op_unref done in discover_chrcs_cb
+		 * and discover_descs_cb functions
+		 */
 		goto failed;
 	}
 
@@ -680,7 +682,6 @@ next:
 
 	util_debug(client->debug_callback, client->debug_data,
 				"Failed to start characteristic discovery");
-	discovery_op_unref(op);
 
 failed:
 	success = false;
@@ -688,6 +689,7 @@ failed:
 done:
 	op->success = success;
 	op->complete_func(op, success, att_ecode);
+	discovery_op_unref(op);
 }
 
 static void discover_chrcs_cb(bool success, uint8_t att_ecode,
@@ -781,7 +783,6 @@ next:
 
 	util_debug(client->debug_callback, client->debug_data,
 				"Failed to start characteristic discovery");
-	discovery_op_unref(op);
 
 failed:
 	success = false;
@@ -789,6 +790,7 @@ failed:
 done:
 	op->success = success;
 	op->complete_func(op, success, att_ecode);
+	discovery_op_unref(op);
 }
 
 static void discover_secondary_cb(bool success, uint8_t att_ecode,
@@ -876,11 +878,11 @@ next:
 
 	util_debug(client->debug_callback, client->debug_data,
 				"Failed to start included services discovery");
-	discovery_op_unref(op);
 
 done:
 	op->success = success;
 	op->complete_func(op, success, att_ecode);
+	discovery_op_unref(op);
 }
 
 static void discover_primary_cb(bool success, uint8_t att_ecode,
@@ -943,12 +945,12 @@ static void discover_primary_cb(bool success, uint8_t att_ecode,
 
 	util_debug(client->debug_callback, client->debug_data,
 				"Failed to start secondary service discovery");
-	discovery_op_unref(op);
 	success = false;
 
 done:
 	op->success = success;
 	op->complete_func(op, success, att_ecode);
+	discovery_op_unref(op);
 }
 
 static void notify_client_ready(struct bt_gatt_client *client, bool success,
-- 
1.9.1

