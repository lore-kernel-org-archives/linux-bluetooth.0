Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Fix telephony dummy driver
Date: Thu, 25 Nov 2010 17:22:30 +0200
Message-Id: <1290698551-8706-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1290698551-8706-1-git-send-email-luiz.dentz@gmail.com>
References: <1290698551-8706-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

Make it unregister its interface on telephony_exit
---
 audio/telephony-dummy.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/audio/telephony-dummy.c b/audio/telephony-dummy.c
index 06cb798..54b1857 100644
--- a/audio/telephony-dummy.c
+++ b/audio/telephony-dummy.c
@@ -417,6 +417,8 @@ int telephony_init(void)
 				AG_FEATURE_ENHANCED_CALL_STATUS |
 				AG_FEATURE_EXTENDED_ERROR_RESULT_CODES;
 
+	DBG("");
+
 	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
 
 	if (g_dbus_register_interface(connection, TELEPHONY_DUMMY_PATH,
@@ -436,6 +438,10 @@ int telephony_init(void)
 
 void telephony_exit(void)
 {
+	DBG("");
+
+	g_dbus_unregister_interface(connection, TELEPHONY_DUMMY_PATH,
+						TELEPHONY_DUMMY_IFACE);
 	dbus_connection_unref(connection);
 	connection = NULL;
 }
-- 
1.7.1

