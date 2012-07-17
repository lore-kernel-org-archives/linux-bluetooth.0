Return-Path: <cyrus@holtmann.org>
From: Chen Ganir <chen.ganir@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH 7/9] Battery: Read Battery level characteristic
Date: Tue, 17 Jul 2012 16:59:52 +0300
Message-ID: <1342533594-10413-8-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1342533594-10413-1-git-send-email-chen.ganir@ti.com>
References: <1342533594-10413-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add support for reading the battery level characteristic on
connection establishment.
---
 profiles/batterystate/batterystate.c |   41 ++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/profiles/batterystate/batterystate.c b/profiles/batterystate/batterystate.c
index a1b9831..152dc67 100644
--- a/profiles/batterystate/batterystate.c
+++ b/profiles/batterystate/batterystate.c
@@ -124,6 +124,40 @@ static void batterystate_free(gpointer user_data)
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
@@ -291,6 +325,7 @@ static void configure_batterystate_cb(GSList *characteristics, guint8 status,
 				continue;
 			}
 
+			process_batteryservice_char(ch);
 			batt->chars = g_slist_append(batt->chars, ch);
 
 			start = c->value_handle + 1;
@@ -321,6 +356,12 @@ static void attio_connected_cb(GAttrib *attrib, gpointer user_data)
 		gatt_discover_char(batt->attrib, batt->svc_range->start,
 					batt->svc_range->end, NULL,
 					configure_batterystate_cb, batt);
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

