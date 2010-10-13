Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 1/2] Disable automatic notification/indication in the attribute server
Date: Wed, 13 Oct 2010 13:32:19 -0300
Message-Id: <1286987539-25833-1-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1286459639-25194-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1286459639-25194-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Attribute server shall not send automatic indication/notification
messages if the client didn't request them. Client shall use Client
/Server Characteristic Configuration descriptors to be notified about
attribute changes. If the server doesn't support these descriptors,
the client shall implement a polling mechanism to check for attribute
value changes.
---
 TODO                |    7 ------
 src/attrib-server.c |   60 ++++----------------------------------------------
 2 files changed, 5 insertions(+), 62 deletions(-)

diff --git a/TODO b/TODO
index 3885c78..3e62518 100644
--- a/TODO
+++ b/TODO
@@ -18,13 +18,6 @@ Background
 ATT/GATT
 ========
 
-- Sample server shouldn't send any indications or notifications without
-  the client requesting them
-
-  Priority: Medium
-  Complexity: C2
-  Owner: Claudio Takahasi <claudio.takahasi@openbossa.org>
-
 - Add ATT/GATT parsing to hcidump
 
   Priority: Medium
diff --git a/src/attrib-server.c b/src/attrib-server.c
index 666b5fa..1fc1c18 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -590,54 +590,6 @@ static void confirm_event(GIOChannel *io, void *user_data)
 	return;
 }
 
-static gboolean send_notification(gpointer user_data)
-{
-	uint8_t pdu[ATT_MAX_MTU];
-	guint handle = GPOINTER_TO_UINT(user_data);
-	struct attribute *a;
-	GSList *l;
-	uint16_t length;
-
-	l = g_slist_find_custom(database, GUINT_TO_POINTER(handle), handle_cmp);
-	if (!l)
-		return FALSE;
-
-	a = l->data;
-
-	for (l = clients; l; l = l->next) {
-		struct gatt_channel *channel = l->data;
-
-		length = enc_notification(a, pdu, channel->mtu);
-		g_attrib_send(channel->attrib, pdu[0], pdu, length, NULL, NULL, NULL);
-	}
-
-	return FALSE;
-}
-
-static gboolean send_indication(gpointer user_data)
-{
-	uint8_t pdu[ATT_MAX_MTU];
-	guint handle = GPOINTER_TO_UINT(user_data);
-	struct attribute *a;
-	GSList *l;
-	uint16_t length;
-
-	l = g_slist_find_custom(database, GUINT_TO_POINTER(handle), handle_cmp);
-	if (!l)
-		return FALSE;
-
-	a = l->data;
-
-	for (l = clients; l; l = l->next) {
-		struct gatt_channel *channel = l->data;
-
-		length = enc_indication(a, pdu, channel->mtu);
-		g_attrib_send(channel->attrib, pdu[0], pdu, length, NULL, NULL, NULL);
-	}
-
-	return FALSE;
-}
-
 int attrib_server_init(void)
 {
 	GError *gerr = NULL;
@@ -757,14 +709,12 @@ int attrib_db_update(uint16_t handle, uuid_t *uuid, const uint8_t *value,
 	memcpy(a->data, value, len);
 
 	/*
-	 * Characteristic configuration descriptor is not being used yet.
-	 * If the attribute changes, all connected clients will be notified.
-	 * For testing purposes, we send a Notification and a Indication for
-	 * each update.
+	 * <<Client/Server Characteristic Configuration>> descriptors are
+	 * not supported yet. If a given attribute changes, the attribute
+	 * server shall report the new values using the mechanism selected
+	 * by the client. Notification/Indication shall not be automatically
+	 * sent if the client didn't request them.
 	 */
-	g_idle_add(send_notification, GUINT_TO_POINTER(h));
-
-	g_idle_add(send_indication, GUINT_TO_POINTER(h));
 
 	return 0;
 }
-- 
1.7.3.1

