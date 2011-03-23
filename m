Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH] Remove unregister interface in telephony-maemo6
Date: Wed, 23 Mar 2011 15:14:57 +0200
Message-Id: <1300886097-18032-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

g_dbus_unregister_interface is removed from maemo6 telephony driver.
Interface com.nokia.MaemoTelephony is not used as result of changes
in csd back-end. CreateWith was replaced by Create and CreateFromLast
method calls, and set last number is implemented directly in csd.

Registration of this interface was removed due to these changes.
---
 audio/telephony-maemo6.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index e727955..53bbccc 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -66,10 +66,6 @@ enum net_registration_status {
 	NETWORK_REG_STATUS_UNKOWN
 };
 
-/* Driver definitions */
-#define TELEPHONY_MAEMO_PATH		"/com/nokia/MaemoTelephony"
-#define TELEPHONY_MAEMO_INTERFACE	"com.nokia.MaemoTelephony"
-
 /* CSD CALL plugin D-Bus definitions */
 #define CSD_CALL_BUS_NAME	"com.nokia.csd.Call"
 #define CSD_CALL_INTERFACE	"com.nokia.csd.Call"
@@ -1990,9 +1986,6 @@ void telephony_exit(void)
 	g_slist_free(watches);
 	watches = NULL;
 
-	g_dbus_unregister_interface(connection, TELEPHONY_MAEMO_PATH,
-						TELEPHONY_MAEMO_INTERFACE);
-
 	dbus_connection_unref(connection);
 	connection = NULL;
 
-- 
1.7.1

