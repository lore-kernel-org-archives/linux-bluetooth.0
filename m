Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 06/10 v3] gdbus: Fix emitting PropertiesChanged twice
Date: Tue,  3 Sep 2013 14:21:15 +0300
Message-Id: <1378207279-14557-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1378207279-14557-1-git-send-email-luiz.dentz@gmail.com>
References: <1378207279-14557-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes double emission of PropertiesChanged introduced by flushing
changes, the flushing can happen during the pending processing so the
pending_prop flag needs to be updated in the beginning and the list of
properties can be freed before g_dbus_send_message as it is not required
anymore.
---
 gdbus/object.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index c4cf724..0822fe8 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -1642,6 +1642,8 @@ static void process_properties_from_interface(struct generic_data *data,
 	DBusMessageIter iter, dict, array;
 	GSList *invalidated;
 
+	data->pending_prop = FALSE;
+
 	if (iface->pending_prop == NULL)
 		return;
 
@@ -1708,8 +1710,6 @@ static void process_property_changes(struct generic_data *data)
 
 		process_properties_from_interface(data, iface);
 	}
-
-	data->pending_prop = FALSE;
 }
 
 void g_dbus_emit_property_changed(DBusConnection *connection,
-- 
1.8.3.1

