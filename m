Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ] shared/gatt-client: Fix memory bug in service_changed_complete
Date: Thu, 13 Nov 2014 19:23:50 -0800
Message-Id: <1415935430-23790-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes a bug that got accidentally introduced in a previous
memory leak fix, where the temporary discovery_op structure held on to
the newly discovered service pointers after passing their ownership to
the client and incorrectly free'd their memory. This was correctly fixed
in init_complete but missed in service_changed_complete.
---
 src/shared/gatt-client.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index b932e2d..389401a 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -993,6 +993,10 @@ static void service_changed_complete(struct discovery_op *op, bool success,
 	service_list_insert_services(&client->svc_head, &client->svc_tail,
 					op->result_head, op->result_tail);
 
+	/* Relinquish ownership of services, as the client now owns them */
+	op->result_head = NULL;
+	op->result_tail = NULL;
+
 next:
 	/* Notify the upper layer of changed services */
 	if (client->svc_chngd_callback)
@@ -1155,7 +1159,7 @@ static void init_complete(struct discovery_op *op, bool success,
 	client->svc_head = op->result_head;
 	client->svc_tail = op->result_tail;
 
-	/* Change owner of service list */
+	/* Relinquish ownership of services, as the client now owns them */
 	op->result_head = NULL;
 	op->result_tail = NULL;
 
-- 
2.1.0.rc2.206.gedb03e5

