Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Dieb Martins <andre.dieb@signove.com>
Subject: [PATCH 4/5] Implement server-side ATT handle notification
Date: Mon, 21 Feb 2011 18:30:42 -0300
Message-Id: <1298323843-31106-4-git-send-email-anderson.lizardo@openbossa.org>
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
 src/attrib-server.c |   29 +++++++++++++++++++++++++++++
 1 files changed, 29 insertions(+), 0 deletions(-)

diff --git a/src/attrib-server.c b/src/attrib-server.c
index 5675a1b..585e1f3 100644
--- a/src/attrib-server.c
+++ b/src/attrib-server.c
@@ -961,6 +961,33 @@ static void confirm_event(GIOChannel *io, void *user_data)
 	return;
 }
 
+static void attrib_notify_clients(struct attribute *attr)
+{
+	uint8_t pdu[ATT_MAX_MTU];
+	guint mtu, handle = attr->handle;
+	uint16_t len;
+	GSList *l;
+
+	for (l = clients, mtu = 0, len = 0; l; l = l->next) {
+		struct gatt_channel *channel = l->data;
+
+		mtu = channel->mtu;
+		if (mtu == 0)
+			continue;
+
+		/* Notification */
+		if (g_slist_find_custom(channel->notify,
+					GUINT_TO_POINTER(handle), handle_cmp)) {
+			len = enc_notification(attr, pdu, mtu);
+			if (len == 0)
+				return;
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
@@ -1205,6 +1232,8 @@ int attrib_db_update(uint16_t handle, uuid_t *uuid, const uint8_t *value,
 	a->len = len;
 	memcpy(a->data, value, len);
 
+	attrib_notify_clients(a);
+
 	return 0;
 }
 
-- 
1.7.0.4

