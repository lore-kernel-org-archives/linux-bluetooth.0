Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [PATCH v2 6/7] Extract service UUIDs from advertising data
Date: Thu, 11 Nov 2010 15:52:00 -0300
Message-Id: <1289501521-21825-6-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1289501521-21825-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1289501521-21825-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Bruna Moreira <bruna.moreira@openbossa.org>

Make get_eir_uuids() return a GSList of strings, so it can be reused to
extract UUIDs from LE advertising data. The bt_strlist2array() helper
function was created to convert a GSList into a plain array of strings
(needed to send through D-Bus).
---
 src/adapter.c |   64 ++++++++++++++++++++++++++++++++++++++++++--------------
 src/adapter.h |    1 +
 2 files changed, 49 insertions(+), 16 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 7488322..cd2d8d5 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -202,6 +202,8 @@ static void dev_info_free(struct remote_dev_info *dev)
 {
 	g_free(dev->name);
 	g_free(dev->alias);
+	g_slist_foreach(dev->services, (GFunc) g_free, NULL);
+	g_slist_free(dev->services);
 	g_free(dev);
 }
 
@@ -2962,11 +2964,20 @@ static void emit_device_found(const char *path, const char *address,
 	g_dbus_send_message(connection, signal);
 }
 
-static char **get_eir_uuids(uint8_t *eir_data, size_t eir_length,
-							size_t *uuid_count)
+static char **strlist2array(GSList *list)
+{
+	char *tmp, **array;
+
+	tmp = bt_list2string(list);
+	array = g_strsplit(tmp, " ", 0);
+	g_free(tmp);
+
+	return array;
+}
+
+static GSList *get_eir_uuids(uint8_t *eir_data, size_t eir_length, GSList *list)
 {
 	uint16_t len = 0;
-	char **uuids;
 	size_t total;
 	size_t uuid16_count = 0;
 	size_t uuid32_count = 0;
@@ -2975,10 +2986,11 @@ static char **get_eir_uuids(uint8_t *eir_data, size_t eir_length,
 	uint8_t *uuid32;
 	uint8_t *uuid128;
 	uuid_t service;
+	char *uuid_str;
 	unsigned int i;
 
 	if (eir_data == NULL || eir_length == 0)
-		return NULL;
+		return list;
 
 	while (len < eir_length - 1) {
 		uint8_t field_len = eir_data[0];
@@ -3011,15 +3023,12 @@ static char **get_eir_uuids(uint8_t *eir_data, size_t eir_length,
 
 	/* Bail out if got incorrect length */
 	if (len > eir_length)
-		return NULL;
+		return list;
 
 	total = uuid16_count + uuid32_count + uuid128_count;
-	*uuid_count = total;
 
 	if (!total)
-		return NULL;
-
-	uuids = g_new0(char *, total + 1);
+		return list;
 
 	/* Generate uuids in SDP format (EIR data is Little Endian) */
 	service.type = SDP_UUID16;
@@ -3028,7 +3037,12 @@ static char **get_eir_uuids(uint8_t *eir_data, size_t eir_length,
 
 		val16 = (val16 << 8) + uuid16[0];
 		service.value.uuid16 = val16;
-		uuids[i] = bt_uuid2string(&service);
+		uuid_str = bt_uuid2string(&service);
+		if (g_slist_find_custom(list, uuid_str,
+						(GCompareFunc) strcmp) == NULL)
+			list = g_slist_append(list, uuid_str);
+		else
+			g_free(uuid_str);
 		uuid16 += 2;
 	}
 
@@ -3041,7 +3055,12 @@ static char **get_eir_uuids(uint8_t *eir_data, size_t eir_length,
 			val32 = (val32 << 8) + uuid32[k];
 
 		service.value.uuid32 = val32;
-		uuids[i] = bt_uuid2string(&service);
+		uuid_str = bt_uuid2string(&service);
+		if (g_slist_find_custom(list, uuid_str,
+						(GCompareFunc) strcmp) == NULL)
+			list = g_slist_append(list, uuid_str);
+		else
+			g_free(uuid_str);
 		uuid32 += 4;
 	}
 
@@ -3052,11 +3071,16 @@ static char **get_eir_uuids(uint8_t *eir_data, size_t eir_length,
 		for (k = 0; k < 16; k++)
 			service.value.uuid128.data[k] = uuid128[16 - k - 1];
 
-		uuids[i] = bt_uuid2string(&service);
+		uuid_str = bt_uuid2string(&service);
+		if (g_slist_find_custom(list, uuid_str,
+						(GCompareFunc) strcmp) == NULL)
+			list = g_slist_append(list, uuid_str);
+		else
+			g_free(uuid_str);
 		uuid128 += 16;
 	}
 
-	return uuids;
+	return list;
 }
 
 void adapter_emit_device_found(struct btd_adapter *adapter,
@@ -3069,7 +3093,7 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 	dbus_int16_t rssi = dev->rssi;
 	char *alias;
 	char **uuids = NULL;
-	size_t uuid_count = 0;
+	size_t uuid_count;
 
 	ba2str(&dev->bdaddr, peer_addr);
 	ba2str(&adapter->bdaddr, local_addr);
@@ -3089,8 +3113,16 @@ void adapter_emit_device_found(struct btd_adapter *adapter,
 	} else
 		alias = g_strdup(dev->alias);
 
-	/* Extract UUIDs from extended inquiry response if any*/
-	uuids = get_eir_uuids(eir_data, eir_length, &uuid_count);
+	/* Extract UUIDs from extended inquiry response if any */
+	dev->services = get_eir_uuids(eir_data, eir_length, dev->services);
+	uuid_count = g_slist_length(dev->services);
+
+	if (dev->services) {
+		uuids = strlist2array(dev->services);
+		g_slist_foreach(dev->services, (GFunc) g_free, NULL);
+		g_slist_free(dev->services);
+		dev->services = NULL;
+	}
 
 	emit_device_found(adapter->path, paddr,
 			"Address", DBUS_TYPE_STRING, &paddr,
diff --git a/src/adapter.h b/src/adapter.h
index 766b079..84d691b 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -71,6 +71,7 @@ struct remote_dev_info {
 	name_status_t name_status;
 	gboolean le;
 	/* LE adv data */
+	GSList *services;
 	uint8_t evt_type;
 	uint8_t bdaddr_type;
 };
-- 
1.7.3.2

