Return-Path: <cyrus@holtmann.org>
From: <chen.ganir@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH v4 07/10] Battery: Read Battery level characteristic
Date: Thu, 16 Aug 2012 12:35:00 +0300
Message-ID: <1345109702-5698-8-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1345109702-5698-1-git-send-email-chen.ganir@ti.com>
References: <1345109702-5698-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Add support for reading the battery level characteristic on
connection establishment.
---
 profiles/battery/battery.c |   44 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
index 3f79c1f..6baf2db 100644
--- a/profiles/battery/battery.c
+++ b/profiles/battery/battery.c
@@ -56,6 +56,7 @@ struct characteristic {
 	GSList				*desc;	/* Descriptors */
 	uint8_t			ns;		/* Battery Namespace */
 	uint16_t		description;	/* Battery description */
+	uint8_t        level;
 };
 
 struct descriptor {
@@ -92,6 +93,40 @@ static void battery_free(gpointer user_data)
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
 static void batterylevel_presentation_format_desc_cb(guint8 status,
 						const guint8 *pdu, guint16 len,
 						gpointer user_data)
@@ -140,7 +175,6 @@ static void process_batterylevel_desc(struct descriptor *desc)
 	DBG("Ignored descriptor %s characteristic %s", uuidstr,	ch->attr.uuid);
 }
 
-
 static void discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
@@ -186,9 +220,9 @@ update_char:
 				ch->description);
 
 	device_add_battery(ch->batt->dev, ch->path);
+	process_batteryservice_char(ch);
 }
 
-
 static void configure_battery_cb(GSList *characteristics, guint8 status,
 
 							gpointer user_data)
@@ -245,6 +279,12 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
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

