Return-Path: <cyrus@holtmann.org>
From: Paulo Borges <paulo.borges@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Paulo Borges <paulo.borges@openbossa.org>
Subject: [PATCH 9/9] battery: Support persistent battery level
Date: Mon,  7 Jan 2013 16:41:04 -0300
Message-Id: <1357587664-16818-10-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1357587664-16818-1-git-send-email-paulo.borges@openbossa.org>
References: <1357587664-16818-1-git-send-email-paulo.borges@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Store battery level when read, and use the level from storage
when connecting, to reduce GATT traffic.
---
 profiles/battery/battery.c |  137 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 135 insertions(+), 2 deletions(-)

diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
index 2ef4f6b..e4a6e53 100644
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
@@ -37,6 +39,11 @@
 #include "attrib/gatt.h"
 #include "attio.h"
 #include "log.h"
+#include "storage.h"
+
+#define BATTERY_FILE		"batteries"
+#define BATTERY_GROUP_FORMAT	"%04X"
+#define BATTERY_KEY_LEVEL	"Level"
 
 struct battery {
 	struct btd_device	*dev;		/* Device reference */
@@ -77,10 +84,133 @@ static gint cmp_device(gconstpointer a, gconstpointer b)
 	return -1;
 }
 
+static gboolean store_battery_char(struct characteristic *chr)
+{
+	GKeyFile *key_file;
+	char filename[PATH_MAX + 1];
+	char adapter_addr[18];
+	char device_addr[18];
+	char group[5];
+	char *str;
+	gsize length = 0;
+
+	ba2str(adapter_get_address(device_get_adapter(chr->batt->dev)),
+								adapter_addr);
+	ba2str(device_get_address(chr->batt->dev), device_addr);
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/" BATTERY_FILE,
+						adapter_addr, device_addr);
+
+	snprintf(group, sizeof(group), BATTERY_GROUP_FORMAT, chr->attr.handle);
+
+	key_file = g_key_file_new();
+	g_key_file_load_from_file(key_file, filename, 0, NULL);
+
+	g_key_file_set_integer(key_file, group, BATTERY_KEY_LEVEL, chr->level);
+
+	create_file(filename, S_IRUSR | S_IWUSR);
+
+	str = g_key_file_to_data(key_file, &length, NULL);
+	g_file_set_contents(filename, str, length, NULL);
+
+	g_free(str);
+	g_key_file_free(key_file);
+
+	return TRUE;
+}
+
+static int read_battery_char(struct characteristic *chr)
+{
+	GKeyFile *key_file;
+	char filename[PATH_MAX + 1];
+	char adapter_addr[18];
+	char device_addr[18];
+	char group[5];
+	int chr_value;
+
+	ba2str(adapter_get_address(device_get_adapter(chr->batt->dev)),
+								adapter_addr);
+	ba2str(device_get_address(chr->batt->dev), device_addr);
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/" BATTERY_FILE,
+						adapter_addr, device_addr);
+
+	snprintf(group, sizeof(group), BATTERY_GROUP_FORMAT, chr->attr.handle);
+
+	key_file = g_key_file_new();
+	if (!g_key_file_load_from_file(key_file, filename, 0, NULL)) {
+		g_key_file_free(key_file);
+		return 0;
+	}
+
+	chr_value = g_key_file_get_integer(key_file, group, BATTERY_KEY_LEVEL,
+									NULL);
+	g_key_file_free(key_file);
+
+	return chr_value;
+}
+
+static void del_battery_char(struct characteristic *chr)
+{
+	GKeyFile *key_file;
+	char filename[PATH_MAX + 1];
+	char adapter_addr[18];
+	char device_addr[18];
+	char group[5];
+	char *str;
+	gsize length = 0;
+
+	ba2str(adapter_get_address(device_get_adapter(chr->batt->dev)),
+								adapter_addr);
+	ba2str(device_get_address(chr->batt->dev), device_addr);
+
+	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/%s/" BATTERY_FILE,
+						adapter_addr, device_addr);
+
+	snprintf(group, sizeof(group), BATTERY_GROUP_FORMAT, chr->attr.handle);
+
+	key_file = g_key_file_new();
+	if (!g_key_file_load_from_file(key_file, filename, 0, NULL)) {
+		g_key_file_free(key_file);
+		return;
+	}
+
+	g_key_file_remove_key(key_file, group, BATTERY_KEY_LEVEL, NULL);
+
+	create_file(filename, S_IRUSR | S_IWUSR);
+
+	str = g_key_file_to_data(key_file, &length, NULL);
+	g_file_set_contents(filename, str, length, NULL);
+
+	g_free(str);
+	g_key_file_free(key_file);
+}
+
+static gboolean read_battery_level_value(struct characteristic *chr)
+{
+	int level;
+
+	if (!chr)
+		return FALSE;
+
+	level = read_battery_char(chr);
+	if (!level)
+		return FALSE;
+
+	chr->level = level;
+
+	btd_device_set_battery_opt(chr->devbatt, BATTERY_OPT_LEVEL, chr->level,
+						BATTERY_OPT_INVALID);
+
+	return TRUE;
+}
+
 static void char_free(gpointer user_data)
 {
 	struct characteristic *c = user_data;
 
+	del_battery_char(c);
+
 	if (c->notifyid && c->batt->attrib != NULL)
 		g_attrib_unregister(c->batt->attrib, c->notifyid);
 
@@ -135,6 +265,8 @@ static void read_batterylevel_cb(guint8 status, const guint8 *pdu, guint16 len,
 	ch->level = value[0];
 	btd_device_set_battery_opt(ch->devbatt, BATTERY_OPT_LEVEL, ch->level,
 						BATTERY_OPT_INVALID);
+
+	store_battery_char(ch);
 }
 
 static void process_batteryservice_char(struct characteristic *ch)
@@ -359,7 +491,8 @@ static void configure_battery_cb(GSList *characteristics, guint8 status,
 
 		start = c->value_handle + 1;
 
-		process_batteryservice_char(ch);
+		if (!read_battery_level_value(ch))
+			process_batteryservice_char(ch);
 
 		ch->devbatt = btd_device_add_battery(ch->batt->dev);
 
@@ -396,7 +529,7 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
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

