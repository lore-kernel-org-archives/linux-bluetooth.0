Return-Path: <cyrus@holtmann.org>
From: Paulo Borges <paulo.borges@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Chen Ganir <chen.ganir@ti.com>
Subject: [PATCH 6/9] battery: Add Battery to device
Date: Mon,  7 Jan 2013 16:41:01 -0300
Message-Id: <1357587664-16818-7-git-send-email-paulo.borges@openbossa.org>
In-Reply-To: <1357587664-16818-1-git-send-email-paulo.borges@openbossa.org>
References: <1357587664-16818-1-git-send-email-paulo.borges@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Add/Remove battery from device
---
 profiles/battery/battery.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
index 8bbfaf7..fef83d9 100644
--- a/profiles/battery/battery.c
+++ b/profiles/battery/battery.c
@@ -47,6 +47,7 @@ struct battery {
 };
 
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
 
@@ -217,6 +220,8 @@ static void configure_battery_cb(GSList *characteristics, guint8 status,
 
 		start = c->value_handle + 1;
 
+		ch->devbatt = btd_device_add_battery(ch->batt->dev);
+
 		if (l->next != NULL) {
 			struct gatt_char *c = l->next->data;
 			if (start == c->handle)
-- 
1.7.9.5

