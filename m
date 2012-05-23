Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ 04/12] telephony-maemo5: Remove redundant D-Bus error
 initilizations
Date: Wed, 23 May 2012 21:27:24 +0530
Message-id: <1337788652-23697-5-git-send-email-s.syam@samsung.com>
In-reply-to: <1337788652-23697-1-git-send-email-s.syam@samsung.com>
References: <1337788652-23697-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/telephony-maemo5.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/audio/telephony-maemo5.c b/audio/telephony-maemo5.c
index 8a00296..18e4773 100644
--- a/audio/telephony-maemo5.c
+++ b/audio/telephony-maemo5.c
@@ -1195,7 +1195,6 @@ static void get_operator_name_reply(DBusPendingCall *pending_call,
 		goto done;
 	}
 
-	dbus_error_init(&err);
 	if (!dbus_message_get_args(reply, &err,
 					DBUS_TYPE_STRING, &name,
 					DBUS_TYPE_INT32, &net_err,
@@ -1402,7 +1401,6 @@ static void hal_battery_level_reply(DBusPendingCall *call, void *user_data)
 		goto done;
 	}
 
-	dbus_error_init(&err);
 	if (dbus_message_get_args(reply, &err,
 				DBUS_TYPE_INT32, &level,
 				DBUS_TYPE_INVALID) == FALSE) {
@@ -1590,7 +1588,6 @@ static void signal_strength_reply(DBusPendingCall *call, void *user_data)
 		goto done;
 	}
 
-	dbus_error_init(&err);
 	if (!dbus_message_get_args(reply, &err,
 					DBUS_TYPE_BYTE, &signals_bar,
 					DBUS_TYPE_BYTE, &rssi_in_dbm,
@@ -1640,7 +1637,6 @@ static void registration_status_reply(DBusPendingCall *call, void *user_data)
 		goto done;
 	}
 
-	dbus_error_init(&err);
 	if (!dbus_message_get_args(reply, &err,
 					DBUS_TYPE_BYTE, &status,
 					DBUS_TYPE_UINT16, &lac,
@@ -1787,7 +1783,6 @@ static void phonebook_read_reply(DBusPendingCall *call, void *user_data)
 		goto done;
 	}
 
-	dbus_error_init(&derr);
 	if (dbus_message_get_args(reply, &derr,
 				DBUS_TYPE_STRING, &name,
 				DBUS_TYPE_STRING, &number,
-- 
1.7.4.1

