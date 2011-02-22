Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Dieb Martins <andre.dieb@signove.com>
Subject: [PATCHv2 4/5] Implement server-side ATT handle notification
Date: Tue, 22 Feb 2011 18:01:30 -0300
Message-Id: <1298408491-11154-4-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1298323843-31106-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1298323843-31106-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andre Dieb Martins <andre.dieb@signove.com>

Adds an initial version of ATT handle notification. Notifications are sent to
interested clients (based on the Client Characteristic Configuration) always
when the attribute is updated.

This enables services to call db_attrib_update() and send notifications on their
own terms.
---
 src/attrib-server.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index aa24985..8fcfa89 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -964,6 +964,30 @@ static void confirm_event(GIOChannel *io, void *user_data)
 	return;
 }
 
+static void attrib_notify_clients(struct attribute *attr)
+{
+	guint handle = attr->handle;
+	GSList *l;
+
+	for (l = clients; l; l = l->next) {
+		struct gatt_channel *channel = l->data;
+
+		/* Notification */
+		if (g_slist_find_custom(channel->notify,
+					GUINT_TO_POINTER(handle), handle_cmp)) {
+			uint8_t pdu[ATT_MAX_MTU];
+			uint16_t len;
+
+			len = enc_notification(attr, pdu, channel->mtu);
+			if (len == 0)
+				continue;
+
+			g_attrib_send(channel->attrib, 0, pdu[0], pdu, len,
+							NULL, NULL, NULL);
+		}
+	}
+}
+
 static gboolean register_core_services(void)
 {
 	uint8_t atval[256];
@@ -1208,6 +1232,8 @@ int attrib_db_update(uint16_t handle, uuid_t *uuid, const uint8_t *value,
 	a->len = len;
 	memcpy(a->data, value, len);
 
+	attrib_notify_clients(a);
+
 	return 0;
 }
 
-- 
1.7.0.4

