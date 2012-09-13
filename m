Return-Path: <cyrus@holtmann.org>
From: <chen.ganir@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <chen.ganir@ti.com>
Subject: [PATCH v2 07/10] battery: Add Battery to device
Date: Thu, 13 Sep 2012 16:03:20 +0300
Message-ID: <1347541403-11780-8-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1347541403-11780-1-git-send-email-chen.ganir@ti.com>
References: <1347541403-11780-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Add/Remove battery from device
---
 profiles/battery/battery.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
index c368768..3a2e604 100644
--- a/profiles/battery/battery.c
+++ b/profiles/battery/battery.c
@@ -49,6 +49,7 @@ struct battery {
 static GSList *servers;
 
 struct characteristic {
+	struct btd_battery	*devbatt;	/* device_battery pointer */
 	struct gatt_char	attr;		/* Characteristic */
 	struct battery		*batt;		/* Parent Battery Service */
 	GSList			*desc;		/* Descriptors */
@@ -79,6 +80,8 @@ static void char_free(gpointer user_data)
 
 	g_slist_free_full(c->desc, g_free);
 
+	btd_device_remove_battery(c->devbatt);
+
 	g_free(c);
 }
 
@@ -228,6 +231,8 @@ static void configure_battery_cb(GSList *characteristics, guint8 status,
 
 			gatt_find_info(batt->attrib, start, end,
 							discover_desc_cb, ch);
+
+			ch->devbatt = btd_device_add_battery(ch->batt->dev);
 		}
 	}
 }
-- 
1.7.9.5

