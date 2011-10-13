Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ 5/7] Remove notification and indication from server
Date: Thu, 13 Oct 2011 11:43:22 -0300
Message-Id: <1318517004-17003-6-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1318517004-17003-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1318517004-17003-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Upper layer should handle notification and indication since there are
profiles especific constraints including timeouts and attributes values
that should read only before sending it.
---
 src/attrib-server.c |   46 ----------------------------------------------
 1 files changed, 0 insertions(+), 46 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index fbd9944..523a835 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -53,8 +53,6 @@ static GSList *database = NULL;
 struct gatt_channel {
 	bdaddr_t src;
 	bdaddr_t dst;
-	GSList *notify;
-	GSList *indicate;
 	GAttrib *attrib;
 	guint mtu;
 	gboolean le;
@@ -697,8 +695,6 @@ static void attrib_free(void *data)
 
 static void channel_free(struct gatt_channel *channel)
 {
-	g_slist_free(channel->notify);
-	g_slist_free(channel->indicate);
 	g_attrib_unref(channel->attrib);
 
 	g_free(channel);
@@ -937,46 +933,6 @@ static void confirm_event(GIOChannel *io, void *user_data)
 	return;
 }
 
-static void attrib_notify_clients(struct attribute *attr)
-{
-	guint handle = attr->handle;
-	GSList *l;
-
-	for (l = clients; l; l = l->next) {
-		struct gatt_channel *channel = l->data;
-
-		/* Notification */
-		if (g_slist_find_custom(channel->notify,
-					GUINT_TO_POINTER(handle), handle_cmp)) {
-			uint8_t pdu[ATT_MAX_MTU];
-			uint16_t len;
-
-			len = enc_notification(attr->handle, attr->data,
-						attr->len, pdu, channel->mtu);
-			if (len == 0)
-				continue;
-
-			g_attrib_send(channel->attrib, 0, pdu[0], pdu, len,
-							NULL, NULL, NULL);
-		}
-
-		/* Indication */
-		if (g_slist_find_custom(channel->indicate,
-					GUINT_TO_POINTER(handle), handle_cmp)) {
-			uint8_t pdu[ATT_MAX_MTU];
-			uint16_t len;
-
-			len = enc_indication(attr->handle, attr->data,
-						attr->len, pdu, channel->mtu);
-			if (len == 0)
-				return;
-
-			g_attrib_send(channel->attrib, 0, pdu[0], pdu, len,
-							NULL, NULL, NULL);
-		}
-	}
-}
-
 static gboolean register_core_services(void)
 {
 	uint8_t atval[256];
@@ -1237,8 +1193,6 @@ int attrib_db_update(uint16_t handle, bt_uuid_t *uuid, const uint8_t *value,
 	if (attr)
 		*attr = a;
 
-	attrib_notify_clients(a);
-
 	return 0;
 }
 
-- 
1.7.7

