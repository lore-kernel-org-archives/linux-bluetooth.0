Return-Path: <cyrus@holtmann.org>
From: <chen.ganir@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <chen.ganir@ti.com>
Subject: [PATCH v2 08/10] battery: Read Battery level characteristic
Date: Thu, 13 Sep 2012 16:03:21 +0300
Message-ID: <1347541403-11780-9-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1347541403-11780-1-git-send-email-chen.ganir@ti.com>
References: <1347541403-11780-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Implement support for reading the battery level characteristic on
connection establishment.
---
 profiles/battery/battery.c |   87 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
index 3a2e604..b2850e4 100644
--- a/profiles/battery/battery.c
+++ b/profiles/battery/battery.c
@@ -55,6 +55,7 @@ struct characteristic {
 	GSList			*desc;		/* Descriptors */
 	uint8_t			ns;		/* Battery Namespace */
 	uint16_t		description;	/* Battery description */
+	uint8_t			level;		/* Battery level */
 };
 
 struct descriptor {
@@ -103,6 +104,80 @@ static void battery_free(gpointer user_data)
 	g_free(batt);
 }
 
+static void read_batterylevel_cb(guint8 status, const guint8 *pdu, guint16 len,
+							gpointer user_data)
+{
+	struct characteristic *ch = user_data;
+	uint8_t value[ATT_MAX_MTU];
+	int vlen;
+
+	if (status != 0) {
+		error("Failed to read Battery Level:%s", att_ecode2str(status));
+		return;
+	}
+
+	vlen = dec_read_resp(pdu, len, value, sizeof(value));
+	if (!vlen) {
+		error("Failed to read Battery Level: Protocol error\n");
+		return;
+	}
+
+	if (vlen < 1) {
+		error("Failed to read Battery Level: Wrong pdu len");
+		return;
+	}
+
+	ch->level = value[0];
+	btd_device_set_battery_opt(ch->devbatt, BATTERY_OPT_LEVEL, ch->level,
+						BATTERY_OPT_INVALID);
+}
+
+static void process_batteryservice_char(struct characteristic *ch)
+{
+	if (g_strcmp0(ch->attr.uuid, BATTERY_LEVEL_UUID) == 0) {
+		gatt_read_char(ch->batt->attrib, ch->attr.value_handle, 0,
+						read_batterylevel_cb, ch);
+	}
+}
+
+static gint device_battery_cmp(gconstpointer a, gconstpointer b)
+{
+	const struct characteristic *ch = a;
+	const struct btd_battery *batt = b;
+
+	if (batt == ch->devbatt)
+		return 0;
+
+	return -1;
+}
+
+static struct characteristic *find_battery_char(struct btd_battery *db)
+{
+	GSList *l, *b;
+
+	for (l = servers; l != NULL; l = g_slist_next(l)) {
+		struct battery *batt = l->data;
+
+		b = g_slist_find_custom(batt->chars, db, device_battery_cmp);
+		if (!b)
+			return NULL;
+
+		return b->data;
+	}
+
+	return NULL;
+}
+
+static void batterylevel_refresh_cb(struct btd_battery *batt)
+{
+	struct characteristic *ch;
+
+	ch = find_battery_char(batt);
+
+	if (ch)
+		process_batteryservice_char(ch);
+}
+
 static void batterylevel_presentation_format_desc_cb(guint8 status,
 						const guint8 *pdu, guint16 len,
 						gpointer user_data)
@@ -233,6 +308,12 @@ static void configure_battery_cb(GSList *characteristics, guint8 status,
 							discover_desc_cb, ch);
 
 			ch->devbatt = btd_device_add_battery(ch->batt->dev);
+			btd_device_set_battery_opt(ch->devbatt,
+						   BATTERY_OPT_REFRESH_FUNC,
+						   batterylevel_refresh_cb,
+						   BATTERY_OPT_INVALID);
+
+			process_batteryservice_char(ch);
 		}
 	}
 }
@@ -247,6 +328,12 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 		gatt_discover_char(batt->attrib, batt->svc_range->start,
 					batt->svc_range->end, NULL,
 					configure_battery_cb, batt);
+	} else {
+		GSList *l;
+		for (l = batt->chars; l; l = l->next) {
+			struct characteristic *c = l->data;
+			process_batteryservice_char(c);
+		}
 	}
 }
 
-- 
1.7.9.5

