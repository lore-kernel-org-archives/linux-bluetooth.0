Return-Path: <cyrus@holtmann.org>
From: Chen Ganir <chen.ganir@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH v2 9/9] Battery: Emit property changed on first read
Date: Wed, 25 Jul 2012 08:42:27 +0300
Message-ID: <1343194947-13659-10-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1343194947-13659-1-git-send-email-chen.ganir@ti.com>
References: <1343194947-13659-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Emit battery level property changed upon connection, on first read.
---
 profiles/batterystate/batterystate.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/profiles/batterystate/batterystate.c b/profiles/batterystate/batterystate.c
index 718863b..4300f85 100644
--- a/profiles/batterystate/batterystate.c
+++ b/profiles/batterystate/batterystate.c
@@ -72,6 +72,8 @@ struct descriptor {
 	bt_uuid_t		uuid;		/* UUID */
 };
 
+static void emit_battery_level_changed(struct characteristic *c);
+
 static void char_free(gpointer user_data)
 {
 	struct characteristic *c = user_data;
@@ -161,6 +163,7 @@ static void read_batterylevel_cb(guint8 status, const guint8 *pdu, guint16 len,
 	}
 
 	ch->level = value[0];
+	emit_battery_level_changed(ch);
 }
 
 static void process_batteryservice_char(struct characteristic *ch)
-- 
1.7.9.5

