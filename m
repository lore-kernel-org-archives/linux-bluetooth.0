Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 BlueZ 4/5] audio/transport: Fix not emitting Volume changes
Date: Tue, 15 Sep 2015 15:41:32 +0300
Message-Id: <1442320893-31536-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1442320893-31536-1-git-send-email-luiz.dentz@gmail.com>
References: <1442320893-31536-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If Volume is changed locally the change should be propagated using
PropertiesChanged.
---
 profiles/audio/transport.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index f5c829f..7e3d1e6 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -653,6 +653,7 @@ static void set_volume(const GDBusPropertyTable *property,
 	struct media_transport *transport = data;
 	struct a2dp_transport *a2dp = transport->data;
 	uint16_t volume;
+	bool notify;
 
 	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_UINT16) {
 		g_dbus_pending_property_error(id,
@@ -670,13 +671,21 @@ static void set_volume(const GDBusPropertyTable *property,
 		return;
 	}
 
-	if (a2dp->volume != volume)
-		avrcp_set_volume(transport->device, volume,
-				transport->source_watch ? true : false);
+	g_dbus_pending_property_success(id);
+
+	if (a2dp->volume == volume)
+		return;
 
 	a2dp->volume = volume;
 
-	g_dbus_pending_property_success(id);
+	notify = transport->source_watch ? true : false;
+	if (notify)
+		g_dbus_emit_property_changed(btd_get_dbus_connection(),
+						transport->path,
+						MEDIA_TRANSPORT_INTERFACE,
+						"Volume");
+
+	avrcp_set_volume(transport->device, volume, notify);
 }
 
 static const GDBusMethodTable transport_methods[] = {
-- 
2.4.3

