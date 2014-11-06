Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/9] shared/gatt: Fix memory leak in discovery_op_unref
Date: Thu,  6 Nov 2014 13:47:08 +0100
Message-Id: <1415278034-19223-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1415278034-19223-1-git-send-email-marcin.kraglak@tieto.com>
References: <1415278034-19223-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Free services list in discovery_op_unref. If discovery has been
interrupted, services from discovery_op were not pushed to
gatt_client service list, and it caused memory leak.
---
 src/shared/gatt-client.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index 8689368..b4f28b2 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -411,6 +411,8 @@ static void discovery_op_unref(void *data)
 	if (__sync_sub_and_fetch(&op->ref_count, 1))
 		return;
 
+	service_list_clear(&op->result_head, &op->result_tail);
+
 	free(data);
 }
 
@@ -1140,6 +1142,10 @@ static void init_complete(struct discovery_op *op, bool success,
 	client->svc_head = op->result_head;
 	client->svc_tail = op->result_tail;
 
+	/* Change owner of service list */
+	op->result_head = NULL;
+	op->result_tail = NULL;
+
 	if (!client->svc_chngd_val_handle) {
 		client->ready = true;
 		goto done;
@@ -1164,12 +1170,10 @@ static void init_complete(struct discovery_op *op, bool success,
 	util_debug(client->debug_callback, client->debug_data,
 			"Failed to register handler for \"Service Changed\"");
 
-	client->svc_head = client->svc_tail = NULL;
-
 fail:
 	util_debug(client->debug_callback, client->debug_data,
 			"Failed to initialize gatt-client");
-	service_list_clear(&op->result_head, &op->result_tail);
+	service_list_clear(&client->svc_head, &client->svc_head);
 
 done:
 	if (client->ready_callback)
-- 
1.9.3

