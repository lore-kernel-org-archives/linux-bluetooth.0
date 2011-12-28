Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 5/8] attrib-server: Add bluetooth adapter in attrib_gap_set function
Date: Wed, 28 Dec 2011 11:24:47 +0100
Message-Id: <1325067890-6953-6-git-send-email-sancane@gmail.com>
In-Reply-To: <1325067890-6953-5-git-send-email-sancane@gmail.com>
References: <1325067890-6953-1-git-send-email-sancane@gmail.com>
 <1325067890-6953-2-git-send-email-sancane@gmail.com>
 <1325067890-6953-3-git-send-email-sancane@gmail.com>
 <1325067890-6953-4-git-send-email-sancane@gmail.com>
 <1325067890-6953-5-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/adapter.c       |    4 ++--
 src/attrib-server.c |    8 +++-----
 src/attrib-server.h |    3 ++-
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 57e4c12..6d5f63d 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -850,7 +850,7 @@ void btd_adapter_class_changed(struct btd_adapter *adapter, uint32_t new_class)
 	if (main_opts.attrib_server) {
 		/* Removes service class */
 		class[1] = class[1] & 0x1f;
-		attrib_gap_set(GATT_CHARAC_APPEARANCE, class, 2);
+		attrib_gap_set(adapter, GATT_CHARAC_APPEARANCE, class, 2);
 	}
 
 	emit_property_changed(connection, adapter->path,
@@ -872,7 +872,7 @@ void adapter_name_changed(struct btd_adapter *adapter, const char *name)
 					DBUS_TYPE_STRING, &name);
 
 	if (main_opts.attrib_server)
-		attrib_gap_set(GATT_CHARAC_DEVICE_NAME,
+		attrib_gap_set(adapter, GATT_CHARAC_DEVICE_NAME,
 				(const uint8_t *) name, strlen(name));
 }
 
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 486dd83..e01235f 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -1399,12 +1399,11 @@ int attrib_db_del(uint16_t handle)
 	return 0;
 }
 
-int attrib_gap_set(uint16_t uuid, const uint8_t *value, int len)
+int attrib_gap_set(struct btd_adapter *adapter, uint16_t uuid,
+						const uint8_t *value, int len)
 {
 	uint16_t handle;
 
-	DBG("Deprecated function!");
-
 	/* FIXME: Missing Privacy and Reconnection Address */
 
 	switch (uuid) {
@@ -1418,6 +1417,5 @@ int attrib_gap_set(uint16_t uuid, const uint8_t *value, int len)
 		return -ENOSYS;
 	}
 
-	/* FIXME: Provide the adapter in next function */
-	return attrib_db_update(NULL, handle, NULL, value, len, NULL);
+	return attrib_db_update(adapter, handle, NULL, value, len, NULL);
 }
diff --git a/src/attrib-server.h b/src/attrib-server.h
index 1265bd1..fb7f285 100644
--- a/src/attrib-server.h
+++ b/src/attrib-server.h
@@ -30,7 +30,8 @@ int attrib_db_update(struct btd_adapter *adapter, uint16_t handle,
 					bt_uuid_t *uuid, const uint8_t *value,
 					int len, struct attribute **attr);
 int attrib_db_del(uint16_t handle);
-int attrib_gap_set(uint16_t uuid, const uint8_t *value, int len);
+int attrib_gap_set(struct btd_adapter *adapter, uint16_t uuid,
+						const uint8_t *value, int len);
 uint32_t attrib_create_sdp(uint16_t handle, const char *name);
 void attrib_free_sdp(uint32_t sdp_handle);
 guint attrib_channel_attach(GAttrib *attrib, gboolean out);
-- 
1.7.8.1

