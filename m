Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 6/8] attrib-server: Add bluetooth adapter in attrib_db_del
Date: Wed, 28 Dec 2011 11:24:48 +0100
Message-Id: <1325067890-6953-7-git-send-email-sancane@gmail.com>
In-Reply-To: <1325067890-6953-6-git-send-email-sancane@gmail.com>
References: <1325067890-6953-1-git-send-email-sancane@gmail.com>
 <1325067890-6953-2-git-send-email-sancane@gmail.com>
 <1325067890-6953-3-git-send-email-sancane@gmail.com>
 <1325067890-6953-4-git-send-email-sancane@gmail.com>
 <1325067890-6953-5-git-send-email-sancane@gmail.com>
 <1325067890-6953-6-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/attrib-server.c |   10 +++++-----
 src/attrib-server.h |    2 +-
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index e01235f..56cd909 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -1371,19 +1371,19 @@ int attrib_db_update(struct btd_adapter *adapter, uint16_t handle,
 	return 0;
 }
 
-int attrib_db_del(uint16_t handle)
+int attrib_db_del(struct btd_adapter *adapter, uint16_t handle)
 {
 	struct gatt_server *server;
 	struct attribute *a;
 	GSList *l;
 	guint h = handle;
 
-	DBG("Deprecated function!");
-
-	server = get_default_gatt_server();
-	if (server == NULL)
+	l = g_slist_find_custom(servers, adapter, adapter_cmp);
+	if (l == NULL)
 		return -ENOENT;
 
+	server = l->data;
+
 	DBG("handle=0x%04x", handle);
 
 	l = g_slist_find_custom(server->database, GUINT_TO_POINTER(h),
diff --git a/src/attrib-server.h b/src/attrib-server.h
index fb7f285..becb3a8 100644
--- a/src/attrib-server.h
+++ b/src/attrib-server.h
@@ -29,7 +29,7 @@ struct attribute *attrib_db_add(struct btd_adapter *adapter, uint16_t handle,
 int attrib_db_update(struct btd_adapter *adapter, uint16_t handle,
 					bt_uuid_t *uuid, const uint8_t *value,
 					int len, struct attribute **attr);
-int attrib_db_del(uint16_t handle);
+int attrib_db_del(struct btd_adapter *adapter, uint16_t handle);
 int attrib_gap_set(struct btd_adapter *adapter, uint16_t uuid,
 						const uint8_t *value, int len);
 uint32_t attrib_create_sdp(uint16_t handle, const char *name);
-- 
1.7.8.1

