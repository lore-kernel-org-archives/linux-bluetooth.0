Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Fix telephony maemo6 driver deinitialization
Date: Tue, 23 Nov 2010 13:33:44 +0200
Message-Id: <1290512024-24547-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1290512024-24547-1-git-send-email-luiz.dentz@gmail.com>
References: <1290512024-24547-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

Remove all match rules and unregister its interface when telephony_exit
is called.
---
 audio/telephony-maemo6.c |   26 ++++++++++++++++++++++++++
 1 files changed, 26 insertions(+), 0 deletions(-)

diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index 72c8e36..47b0bee 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -1948,6 +1948,8 @@ int telephony_init(void)
 				AG_FEATURE_EXTENDED_ERROR_RESULT_CODES |
 				AG_FEATURE_THREE_WAY_CALLING;
 
+	DBG("");
+
 	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
 
 	if (!dbus_connection_add_filter(connection, signal_filter,
@@ -2007,6 +2009,8 @@ int telephony_init(void)
 
 void telephony_exit(void)
 {
+	DBG("");
+
 	g_free(net.operator_name);
 	net.operator_name = NULL;
 
@@ -2017,8 +2021,30 @@ void telephony_exit(void)
 	g_slist_free(calls);
 	calls = NULL;
 
+	dbus_bus_remove_match(connection,
+			"type=signal,interface=" CSD_CALL_INTERFACE, NULL);
+	dbus_bus_remove_match(connection,
+			"type=signal,interface=" CSD_CALL_INSTANCE, NULL);
+	dbus_bus_remove_match(connection,
+			"type=signal,interface=" CSD_CALL_CONFERENCE, NULL);
+	dbus_bus_remove_match(connection,
+			"type=signal,interface=" CSD_CSNET_REGISTRATION,
+			NULL);
+	dbus_bus_remove_match(connection,
+			"type=signal,interface=" CSD_CSNET_OPERATOR,
+			NULL);
+	dbus_bus_remove_match(connection,
+			"type=signal,interface=" CSD_CSNET_SIGNAL,
+			NULL);
+	dbus_bus_remove_match(connection,
+				"type=signal,interface=" SSC_DBUS_IFACE
+				",member=modem_state_changed_ind", NULL);
+
 	dbus_connection_remove_filter(connection, signal_filter, NULL);
 
+	g_dbus_unregister_interface(connection, TELEPHONY_MAEMO_PATH,
+						TELEPHONY_MAEMO_INTERFACE);
+
 	dbus_connection_unref(connection);
 	connection = NULL;
 }
-- 
1.7.1

