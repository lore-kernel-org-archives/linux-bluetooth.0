Return-Path: <cyrus@holtmann.org>
From: <chen.ganir@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <chen.ganir@ti.com>
Subject: [PATCH v4 10/10] battery: Support persistent battery level
Date: Mon, 24 Sep 2012 09:15:19 +0200
Message-ID: <1348470919-25567-11-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1348470919-25567-1-git-send-email-chen.ganir@ti.com>
References: <1348470919-25567-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Store battery level when read, and use the level from storage
when connecting, to reduce GATT traffic.
---
 profiles/battery/battery.c |  106 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 104 insertions(+), 2 deletions(-)

diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
index ac0e706..4a95337 100644
--- a/profiles/battery/battery.c
+++ b/profiles/battery/battery.c
@@ -27,6 +27,8 @@
 #include <glib.h>
 #include <bluetooth/uuid.h>
 #include <stdbool.h>
+#include <sys/file.h>
+#include <stdlib.h>
 
 #include "adapter.h"
 #include "device.h"
@@ -37,6 +39,10 @@
 #include "gatt.h"
 #include "battery.h"
 #include "log.h"
+#include "storage.h"
+
+#define BATTERY_KEY_FORMAT	"%17s#%04X"
+#define BATTERY_LEVEL_FORMAT	"%03d"
 
 struct battery {
 	struct btd_device	*dev;		/* Device reference */
@@ -77,10 +83,103 @@ static gint cmp_device(gconstpointer a, gconstpointer b)
 	return -1;
 }
 
+static inline int create_filename(char *buf, size_t size,
+				const bdaddr_t *bdaddr, const char *name)
+{
+	char addr[18];
+
+	ba2str(bdaddr, addr);
+
+	return create_name(buf, size, STORAGEDIR, addr, name);
+}
+
+static int store_battery_char(struct characteristic *chr)
+{
+	char filename[PATH_MAX + 1], addr[18], key[23];
+	bdaddr_t sba, dba;
+	char level[4];
+
+	adapter_get_address(device_get_adapter(chr->batt->dev), &sba);
+	device_get_address(chr->batt->dev, &dba, NULL);
+
+	create_filename(filename, PATH_MAX, &sba, "battery_gatt_client");
+
+	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
+
+	ba2str(&dba, addr);
+
+	snprintf(key, sizeof(key), BATTERY_KEY_FORMAT, addr, chr->attr.handle);
+	snprintf(level, sizeof(level), BATTERY_LEVEL_FORMAT, chr->level);
+
+	return textfile_caseput(filename, key, level);
+}
+
+static char *read_battery_char(struct characteristic *chr)
+{
+	char filename[PATH_MAX + 1], addr[18], key[23];
+	char *str, *strnew;
+	bdaddr_t sba, dba;
+
+	adapter_get_address(device_get_adapter(chr->batt->dev), &sba);
+	device_get_address(chr->batt->dev, &dba, NULL);
+
+	create_filename(filename, PATH_MAX, &sba, "battery_gatt_client");
+
+	ba2str(&dba, addr);
+	snprintf(key, sizeof(key), BATTERY_KEY_FORMAT, addr, chr->attr.handle);
+
+	str = textfile_caseget(filename, key);
+	if (str == NULL)
+		return NULL;
+
+	strnew = g_strdup(str);
+	g_free(str);
+
+	return strnew;
+}
+
+static void del_battery_char(struct characteristic *chr)
+{
+	char filename[PATH_MAX + 1], addr[18], key[23];
+	bdaddr_t sba, dba;
+
+	adapter_get_address(device_get_adapter(chr->batt->dev), &sba);
+	device_get_address(chr->batt->dev, &dba, NULL);
+
+	create_filename(filename, PATH_MAX, &sba, "battery_gatt_client");
+
+	ba2str(&dba, addr);
+	snprintf(key, sizeof(key), BATTERY_KEY_FORMAT, addr, chr->attr.handle);
+
+	textfile_casedel(filename, key);
+}
+
+static gboolean read_battery_level_value(struct characteristic *chr)
+{
+	char *str;
+
+	if (!chr)
+		return FALSE;
+
+	str = read_battery_char(chr);
+	if (!str)
+		return FALSE;
+
+	chr->level = atoi(str);
+
+	btd_device_set_battery_opt(chr->devbatt, BATTERY_OPT_LEVEL, chr->level,
+						BATTERY_OPT_INVALID);
+
+	g_free(str);
+	return TRUE;
+}
+
 static void char_free(gpointer user_data)
 {
 	struct characteristic *c = user_data;
 
+	del_battery_char(c);
+
 	g_slist_free_full(c->desc, g_free);
 
 	btd_device_remove_battery(c->devbatt);
@@ -146,6 +245,8 @@ static void read_batterylevel_cb(guint8 status, const guint8 *pdu, guint16 len,
 	ch->level = value[0];
 	btd_device_set_battery_opt(ch->devbatt, BATTERY_OPT_LEVEL, ch->level,
 						BATTERY_OPT_INVALID);
+
+	store_battery_char(ch);
 }
 
 static void process_batteryservice_char(struct characteristic *ch)
@@ -344,7 +445,8 @@ static void configure_battery_cb(GSList *characteristics, guint8 status,
 
 		start = c->value_handle + 1;
 
-		process_batteryservice_char(ch);
+		if (!read_battery_level_value(ch))
+			process_batteryservice_char(ch);
 
 		ch->devbatt = btd_device_add_battery(ch->batt->dev);
 
@@ -423,7 +525,7 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 		GSList *l;
 		for (l = batt->chars; l; l = l->next) {
 			struct characteristic *c = l->data;
-			if (!c->can_notify)
+			if (!read_battery_level_value(c) && !c->can_notify)
 				process_batteryservice_char(c);
 		}
 	}
-- 
1.7.9.5

