Return-Path: <cyrus@holtmann.org>
From: <chen.ganir@ti.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <chen.ganir@ti.com>
Subject: [PATCH 07/10] battery: Add Battery to device
Date: Tue, 11 Sep 2012 10:38:18 +0300
Message-ID: <1347349100-24228-8-git-send-email-chen.ganir@ti.com>
In-Reply-To: <1347349100-24228-1-git-send-email-chen.ganir@ti.com>
References: <1347349100-24228-1-git-send-email-chen.ganir@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chen Ganir <chen.ganir@ti.com>

Add/Remove battery from device
---
 profiles/battery/battery.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/profiles/battery/battery.c b/profiles/battery/battery.c
index d1e0b6e..31f2297 100644
--- a/profiles/battery/battery.c
+++ b/profiles/battery/battery.c
@@ -49,8 +49,9 @@ struct battery {
 static GSList *servers;
 
 struct characteristic {
-	struct gatt_char	attr;	/* Characteristic */
-	struct battery		*batt;	/* Parent Battery Service */
+	struct device_battery  *devbatt;	/* device_battery pointer */
+	struct gatt_char	attr;		/* Characteristic */
+	struct battery		*batt;		/* Parent Battery Service */
 	GSList				*desc;	/* Descriptors */
 	uint8_t			ns;		/* Battery Namespace */
 	uint16_t		description;	/* Battery description */
@@ -79,6 +80,8 @@ static void char_free(gpointer user_data)
 
 	g_slist_free_full(c->desc, g_free);
 
+	btd_device_remove_battery(c->devbatt);
+
 	g_free(c);
 }
 
@@ -160,12 +163,12 @@ static void discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 	if (status != 0) {
 		error("Discover all characteristic descriptors failed [%s]: %s",
 					ch->attr.uuid, att_ecode2str(status));
-		return;
+		goto update_char;
 	}
 
 	list = dec_find_info_resp(pdu, len, &format);
 	if (list == NULL)
-		return;
+		goto update_char;
 
 	for (i = 0; i < list->num; i++) {
 		struct descriptor *desc;
@@ -186,6 +189,9 @@ static void discover_desc_cb(guint8 status, const guint8 *pdu, guint16 len,
 	}
 
 	att_data_list_free(list);
+
+update_char:
+	ch->devbatt = btd_device_add_battery(ch->batt->dev);
 }
 
 
-- 
1.7.9.5

