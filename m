Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 04/10] shared/gatt-server: Add bt_gatt_server_get_mtu
Date: Mon, 18 Sep 2017 15:39:55 +0300
Message-Id: <20170918124001.2617-5-luiz.dentz@gmail.com>
In-Reply-To: <20170918124001.2617-1-luiz.dentz@gmail.com>
References: <20170918124001.2617-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds bt_gatt_server_get_mtu which can be used to read the current
MTU.
---
 src/shared/gatt-db.h     | 2 ++
 src/shared/gatt-server.c | 8 ++++++++
 src/shared/gatt-server.h | 1 +
 3 files changed, 11 insertions(+)

diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index f4ec51cff..e2ac645f3 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -265,3 +265,5 @@ bool gatt_db_attribute_write_result(struct gatt_db_attribute *attrib,
 						unsigned int id, int err);
 
 bool gatt_db_attribute_reset(struct gatt_db_attribute *attrib);
+
+void *gatt_db_attribute_get_user_data(struct gatt_db_attribute *attrib);
diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index dc3bb8ee9..a986c5295 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -1503,6 +1503,14 @@ struct bt_gatt_server *bt_gatt_server_new(struct gatt_db *db,
 	return bt_gatt_server_ref(server);
 }
 
+uint16_t bt_gatt_server_get_mtu(struct bt_gatt_server *server)
+{
+	if (!server || !server->att)
+		return 0;
+
+	return bt_att_get_mtu(server->att);
+}
+
 struct bt_gatt_server *bt_gatt_server_ref(struct bt_gatt_server *server)
 {
 	if (!server)
diff --git a/src/shared/gatt-server.h b/src/shared/gatt-server.h
index 0e480e1b3..74a6c721e 100644
--- a/src/shared/gatt-server.h
+++ b/src/shared/gatt-server.h
@@ -27,6 +27,7 @@ struct bt_gatt_server;
 
 struct bt_gatt_server *bt_gatt_server_new(struct gatt_db *db,
 					struct bt_att *att, uint16_t mtu);
+uint16_t bt_gatt_server_get_mtu(struct bt_gatt_server *server);
 
 struct bt_gatt_server *bt_gatt_server_ref(struct bt_gatt_server *server);
 void bt_gatt_server_unref(struct bt_gatt_server *server);
-- 
2.13.5

