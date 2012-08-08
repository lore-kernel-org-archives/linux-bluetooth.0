Return-Path: <cyrus@holtmann.org>
From: <chen.ganir@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <jprvita@openbossa.org>, Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH v3 9/9] Battery: Emit property changed on first read
Date: Wed, 8 Aug 2012 17:26:20 +0300
Message-ID: <1344435980-9866-10-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1344435980-9866-1-git-send-email-chen.ganir@ti.com>
References: <1344435980-9866-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Emit battery level property changed upon connection, on first read.
---
 profiles/battery/battery.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
index c5274bb..2874fb2 100644
--- a/profiles/battery/battery.c
+++ b/profiles/battery/battery.c
@@ -138,6 +138,12 @@ static void battery_free(gpointer user_data)
 	g_free(batt);
 }
 
+static void emit_battery_level_changed(struct characteristic *c)
+{
+	emit_property_changed(c->batt->conn, c->path, BATTERY_INTERFACE,
+					"Level", DBUS_TYPE_BYTE, &c->level);
+}
+
 static void read_batterylevel_cb(guint8 status, const guint8 *pdu, guint16 len,
 							gpointer user_data)
 {
@@ -162,6 +168,7 @@ static void read_batterylevel_cb(guint8 status, const guint8 *pdu, guint16 len,
 	}
 
 	ch->level = value[0];
+	emit_battery_level_changed(ch);
 }
 
 static void process_batteryservice_char(struct characteristic *ch)
@@ -349,12 +356,6 @@ update_char:
 	process_batteryservice_char(ch);
 }
 
-static void emit_battery_level_changed(struct characteristic *c)
-{
-	emit_property_changed(c->batt->conn, c->path, BATTERY_INTERFACE,
-					"Level", DBUS_TYPE_BYTE, &c->level);
-}
-
 static void configure_battery_cb(GSList *characteristics, guint8 status,
 
 							gpointer user_data)
-- 
1.7.9.5

