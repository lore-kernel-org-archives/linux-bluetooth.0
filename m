Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 1/4] shared/gatt-server: Hold a reference to gatt-db.
Date: Wed,  3 Dec 2014 08:26:33 -0800
Message-Id: <1417623996-7158-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1417623996-7158-1-git-send-email-armansito@chromium.org>
References: <1417623996-7158-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now that gatt-db is reference counted, gatt-server should hold a
reference to it.
---
 src/shared/gatt-server.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index ef91289..3f3db56 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -129,6 +129,7 @@ static void bt_gatt_server_free(struct bt_gatt_server *server)
 
 	queue_destroy(server->prep_queue, prep_write_data_destroy);
 
+	gatt_db_unref(server->db);
 	bt_att_unref(server->att);
 	free(server);
 }
@@ -1177,14 +1178,14 @@ struct bt_gatt_server *bt_gatt_server_new(struct gatt_db *db,
 {
 	struct bt_gatt_server *server;
 
-	if (!att)
+	if (!att || !db)
 		return NULL;
 
 	server = new0(struct bt_gatt_server, 1);
 	if (!server)
 		return NULL;
 
-	server->db = db;
+	server->db = gatt_db_ref(db);
 	server->att = bt_att_ref(att);
 	server->mtu = MAX(mtu, BT_ATT_DEFAULT_LE_MTU);
 	server->max_prep_queue_len = DEFAULT_MAX_PREP_QUEUE_LEN;
-- 
2.2.0.rc0.207.ga3a616c

