Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH v3 02/12] Initial device found cleanup
Date: Mon, 16 May 2011 17:49:51 -0300
Message-Id: <1305579001-3019-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1305579001-3019-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1305579001-3019-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Moves EIR parsing call and stored name loading to adapter. This patch
doesn't change the implemented logic, it is only the initial step to
integrated inquiry results and LE advertises.
---
 src/adapter.c |   70 ++++++++++++++++++++++++++++++++++++++++++++++++++------
 src/adapter.h |    4 +--
 src/event.c   |   60 +------------------------------------------------
 3 files changed, 64 insertions(+), 70 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index a85980c..3188974 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -58,6 +58,7 @@
 #include "storage.h"
 #include "attrib-server.h"
 #include "att.h"
+#include "eir.h"
 
 /* Flags Descriptions */
 #define EIR_LIM_DISC                0x01 /* LE Limited Discoverable Mode */
@@ -3002,18 +3003,71 @@ void adapter_update_device_from_info(struct btd_adapter *adapter,
 }
 
 void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-				int8_t rssi, uint32_t class, const char *name,
-				const char *alias, gboolean legacy,
-				GSList *services, name_status_t name_status)
+				uint32_t class, int8_t rssi, uint8_t *data)
 {
+	char local_addr[18], peer_addr[18], filename[PATH_MAX + 1];
 	struct remote_dev_info *dev;
-	gboolean new_dev;
+	struct eir_data eir_data;
+	char *alias, *name;
+	gboolean new_dev, legacy;
+	name_status_t name_status;
+	unsigned char features[8];
+	const char *dev_name;
+	int err;
+
+	memset(&eir_data, 0, sizeof(eir_data));
+	err = eir_parse(&eir_data, data, EIR_DATA_LENGTH);
+	if (err < 0) {
+		error("Error parsing EIR data: %s (%d)", strerror(-err), -err);
+		return;
+	}
+
+	/* the inquiry result can be triggered by NON D-Bus client */
+	if (main_opts.name_resolv && adapter_has_discov_sessions(adapter))
+		name_status = NAME_REQUIRED;
+	else
+		name_status = NAME_NOT_REQUIRED;
+
+	ba2str(&adapter->bdaddr, local_addr);
+	ba2str(bdaddr, peer_addr);
+
+	create_name(filename, PATH_MAX, STORAGEDIR, local_addr, "aliases");
+	alias = textfile_get(filename, peer_addr);
+
+	create_name(filename, PATH_MAX, STORAGEDIR, local_addr, "names");
+	name = textfile_get(filename, peer_addr);
+
+	if (data)
+		legacy = FALSE;
+	else if (name == NULL)
+		legacy = TRUE;
+	else if (read_remote_features(&adapter->bdaddr, bdaddr, NULL,
+							features) == 0) {
+		if (features[0] & 0x01)
+			legacy = FALSE;
+		else
+			legacy = TRUE;
+	} else
+		legacy = TRUE;
+
+	/* Complete EIR names are always used. Shortened EIR names are only
+	 * used if there is no name already in storage. */
+	dev_name = name;
+	if (eir_data.name != NULL) {
+		if (eir_data.name_complete) {
+			write_device_name(&adapter->bdaddr, bdaddr,
+							eir_data.name);
+			name_status = NAME_NOT_REQUIRED;
+			dev_name = eir_data.name;
+		} else if (name == NULL)
+			dev_name = eir_data.name;
+	}
 
 	dev = get_found_dev(adapter, bdaddr, &new_dev);
 
 	if (new_dev) {
-		if (name)
-			dev->name = g_strdup(name);
+		if (dev_name)
+			dev->name = g_strdup(dev_name);
 
 		if (alias)
 			dev->alias = g_strdup(alias);
@@ -3030,8 +3084,8 @@ void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
 	adapter->found_devices = g_slist_sort(adapter->found_devices,
 						(GCompareFunc) dev_rssi_cmp);
 
-	g_slist_foreach(services, remove_same_uuid, dev);
-	g_slist_foreach(services, dev_prepend_uuid, dev);
+	g_slist_foreach(eir_data.services, remove_same_uuid, dev);
+	g_slist_foreach(eir_data.services, dev_prepend_uuid, dev);
 
 	adapter_emit_device_found(adapter, dev);
 }
diff --git a/src/adapter.h b/src/adapter.h
index 51e8c30..4785d5c 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -113,9 +113,7 @@ void adapter_update_device_from_info(struct btd_adapter *adapter,
 					const char *name, GSList *services,
 					int flags);
 void adapter_update_found_devices(struct btd_adapter *adapter, bdaddr_t *bdaddr,
-				int8_t rssi, uint32_t class, const char *name,
-				const char *alias, gboolean legacy,
-				GSList *services, name_status_t name_status);
+				uint32_t class, int8_t rssi, uint8_t *data);
 int adapter_remove_found_device(struct btd_adapter *adapter, bdaddr_t *bdaddr);
 void adapter_emit_device_found(struct btd_adapter *adapter,
 						struct remote_dev_info *dev);
diff --git a/src/event.c b/src/event.c
index dc1b659..2c893f0 100644
--- a/src/event.c
+++ b/src/event.c
@@ -341,18 +341,7 @@ static void update_lastused(bdaddr_t *sba, bdaddr_t *dba)
 void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 				int8_t rssi, uint8_t *data)
 {
-	char filename[PATH_MAX + 1];
 	struct btd_adapter *adapter;
-	char local_addr[18], peer_addr[18], *alias, *name;
-	name_status_t name_status;
-	struct eir_data eir_data;
-	int err;
-	dbus_bool_t legacy;
-	unsigned char features[8];
-	const char *dev_name;
-
-	ba2str(local, local_addr);
-	ba2str(peer, peer_addr);
 
 	adapter = manager_find_adapter(local);
 	if (!adapter) {
@@ -366,54 +355,7 @@ void btd_event_device_found(bdaddr_t *local, bdaddr_t *peer, uint32_t class,
 	if (data)
 		write_remote_eir(local, peer, data);
 
-	/* the inquiry result can be triggered by NON D-Bus client */
-	if (main_opts.name_resolv && adapter_has_discov_sessions(adapter))
-		name_status = NAME_REQUIRED;
-	else
-		name_status = NAME_NOT_REQUIRED;
-
-	create_name(filename, PATH_MAX, STORAGEDIR, local_addr, "aliases");
-	alias = textfile_get(filename, peer_addr);
-
-	create_name(filename, PATH_MAX, STORAGEDIR, local_addr, "names");
-	name = textfile_get(filename, peer_addr);
-
-	if (data)
-		legacy = FALSE;
-	else if (name == NULL)
-		legacy = TRUE;
-	else if (read_remote_features(local, peer, NULL, features) == 0) {
-		if (features[0] & 0x01)
-			legacy = FALSE;
-		else
-			legacy = TRUE;
-	} else
-		legacy = TRUE;
-
-	memset(&eir_data, 0, sizeof(eir_data));
-	err = eir_parse(&eir_data, data, EIR_DATA_LENGTH);
-	if (err < 0)
-		error("Error parsing EIR data: %s (%d)", strerror(-err), -err);
-
-	/* Complete EIR names are always used. Shortened EIR names are only
-	 * used if there is no name already in storage. */
-	dev_name = name;
-	if (eir_data.name != NULL) {
-		if (eir_data.name_complete) {
-			write_device_name(local, peer, eir_data.name);
-			name_status = NAME_NOT_REQUIRED;
-			dev_name = eir_data.name;
-		} else if (name == NULL)
-			dev_name = eir_data.name;
-	}
-
-	adapter_update_found_devices(adapter, peer, rssi, class, dev_name,
-					alias, legacy, eir_data.services,
-					name_status);
-
-	free_eir_data(&eir_data);
-	free(name);
-	free(alias);
+	adapter_update_found_devices(adapter, peer, class, rssi, data);
 }
 
 void btd_event_set_legacy_pairing(bdaddr_t *local, bdaddr_t *peer,
-- 
1.7.5.rc3

