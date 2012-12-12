Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 06/11] obexd: Add support for custom records
Date: Wed, 12 Dec 2012 13:52:11 +0200
Message-Id: <1355313136-7891-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1355313136-7891-1-git-send-email-luiz.dentz@gmail.com>
References: <1355313136-7891-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Services such as pcsuite and syncml use custom records not defined by
Bluetooth SIG so they have to be registered using ServiceRecord entry.
---
 obexd/plugins/bluetooth.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/obexd/plugins/bluetooth.c b/obexd/plugins/bluetooth.c
index 8a9e190..cbc42f3 100644
--- a/obexd/plugins/bluetooth.c
+++ b/obexd/plugins/bluetooth.c
@@ -253,6 +253,7 @@ static int register_profile(struct bluetooth_profile *profile)
 	DBusMessageIter iter, opt;
 	DBusPendingCall *call;
 	dbus_bool_t auto_connect = FALSE;
+	char *xml;
 	int ret = 0;
 
 	profile->path = g_strconcat("/org/bluez/obex/", profile->uuid, NULL);
@@ -286,6 +287,20 @@ static int register_profile(struct bluetooth_profile *profile)
 					&opt);
 	dict_append_entry(&opt, "AutoConnect", DBUS_TYPE_BOOLEAN,
 								&auto_connect);
+	if (profile->driver->record) {
+		if (profile->driver->port != 0)
+			xml = g_markup_printf_escaped(profile->driver->record,
+						profile->driver->channel,
+						profile->driver->name,
+						profile->driver->port);
+		else
+			xml = g_markup_printf_escaped(profile->driver->record,
+						profile->driver->channel,
+						profile->driver->name);
+		dict_append_entry(&opt, "ServiceRecord", DBUS_TYPE_STRING,
+								&xml);
+		g_free(xml);
+	}
 	dbus_message_iter_close_container(&iter, &opt);
 
 	if (!dbus_connection_send_with_reply(connection, msg, &call, -1)) {
@@ -314,6 +329,10 @@ static const char *service2uuid(uint16_t service)
 		return OBEX_PSE_UUID;
 	case OBEX_IRMC:
 		return OBEX_SYNC_UUID;
+	case OBEX_PCSUITE:
+		return "00005005-0000-1000-8000-0002ee000001";
+	case OBEX_SYNCEVOLUTION:
+		return "00000002-0000-1000-8000-0002ee000002";
 	case OBEX_MAS:
 		return OBEX_MAS_UUID;
 	}
-- 
1.7.11.7

