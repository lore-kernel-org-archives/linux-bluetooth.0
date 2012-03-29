Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 2/2] sap-dummy: Remove DisconnectImmediate method
Date: Thu, 29 Mar 2012 16:27:04 +0200
Message-ID: <1333031224-26358-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1333031224-26358-1-git-send-email-szymon.janc@tieto.com>
References: <1333031224-26358-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function is now available as Terminate method in
org.bluez.SimAccess interface and is available with all sap drivers.
---
 sap/sap-dummy.c |   14 --------------
 1 file changed, 14 deletions(-)

diff --git a/sap/sap-dummy.c b/sap/sap-dummy.c
index acdec77..c129b72 100644
--- a/sap/sap-dummy.c
+++ b/sap/sap-dummy.c
@@ -258,19 +258,6 @@ static DBusMessage *max_msg_size(DBusConnection *conn, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
-static DBusMessage *disconnect_immediate(DBusConnection *conn, DBusMessage *msg,
-						void *data)
-{
-	if (sim_card_conn_status == SIM_DISCONNECTED)
-		return g_dbus_create_error(msg, "org.bluez.Error.Failed",
-				"Already disconnected.");
-
-	sim_card_conn_status = SIM_DISCONNECTED;
-	sap_disconnect_ind(sap_data, SAP_DISCONNECTION_TYPE_IMMEDIATE);
-
-	return dbus_message_new_method_return(msg);
-}
-
 static DBusMessage *card_status(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
@@ -318,7 +305,6 @@ static DBusMessage *card_status(DBusConnection *conn, DBusMessage *msg,
 static GDBusMethodTable dummy_methods[] = {
 	{ "OngoingCall", "b", "", ongoing_call},
 	{ "MaxMessageSize", "u", "", max_msg_size},
-	{ "DisconnectImmediate", "", "", disconnect_immediate},
 	{ "CardStatus", "u", "", card_status},
 	{ }
 };
-- 
on behalf of ST-Ericsson

