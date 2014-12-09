Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 03/12] shared/gatt-client: Set op->success correctly
Date: Tue,  9 Dec 2014 15:00:56 -0800
Message-Id: <1418166065-21055-4-git-send-email-armansito@chromium.org>
In-Reply-To: <1418166065-21055-1-git-send-email-armansito@chromium.org>
References: <1418166065-21055-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes a bug where not correctly setting the success field of
the discovery_op instance when gatt-client is initialized with a
non-empty db caused the db to get cleared by the init_failure handler.
---
 src/shared/gatt-client.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 33ed633..d7c5ca7 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -928,6 +928,8 @@ static void exchange_mtu_cb(bool success, uint8_t att_ecode, void *user_data)
 	struct discovery_op *op = user_data;
 	struct bt_gatt_client *client = op->client;
 
+	op->success = success;
+
 	if (!success) {
 		util_debug(client->debug_callback, client->debug_data,
 				"MTU Exchange failed. ATT ECODE: 0x%02x",
@@ -1223,6 +1225,8 @@ fail:
 	util_debug(client->debug_callback, client->debug_data,
 			"Failed to initialize gatt-client");
 
+	op->success = false;
+
 done:
 	if (client->ready_callback)
 		client->ready_callback(success, att_ecode, client->ready_data);
-- 
2.2.0.rc0.207.ga3a616c

