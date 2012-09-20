Return-Path: <cyrus@holtmann.org>
From: <chen.ganir@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <chen.ganir@ti.com>
Subject: [PATCH v3 07/10] battery: Add Battery to device
Date: Thu, 20 Sep 2012 11:27:40 +0300
Message-ID: <1348129663-1701-8-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1348129663-1701-1-git-send-email-chen.ganir@ti.com>
References: <1348129663-1701-1-git-send-email-chen.ganir@ti.com>
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
index a3a1bb0..6a6635b 100644
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
 
@@ -216,6 +219,8 @@ static void configure_battery_cb(GSList *characteristics, guint8 status,
 
 			start = c->value_handle + 1;
 
+			ch->devbatt = btd_device_add_battery(ch->batt->dev);
+
 			if (l->next != NULL) {
 				struct gatt_char *c = l->next->data;
 				if (start == c->handle)
-- 
1.7.9.5

