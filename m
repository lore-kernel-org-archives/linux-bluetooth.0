Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ] gdbus: Fix missing PropertiesChanged signal
Date: Thu,  7 Feb 2013 14:40:31 -0300
Message-Id: <1360258831-18243-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If D-Bus ObjectManager is not supported, InterfacesAdded signal
checking needs to be ignored otherwise PropertiesChanged signal
will never be sent.
---
 gdbus/object.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 0c11246..43fb1f0 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -1701,8 +1701,11 @@ void g_dbus_emit_property_changed(DBusConnection *connection,
 	if (iface == NULL)
 		return;
 
-	/* Don't emit property changed if interface is not yet published */
-	if (g_slist_find(data->added, iface))
+	/*
+	 * If ObjectManager is attached, don't emit property changed if
+	 * interface is not yet published
+	 */
+	if (root && g_slist_find(data->added, iface))
 		return;
 
 	property = find_property(iface->properties, name);
-- 
1.8.1.2

