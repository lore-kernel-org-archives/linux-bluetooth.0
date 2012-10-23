Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] gdbus: Replace leading spaces with tabs
Date: Tue, 23 Oct 2012 19:27:06 +0530
Message-id: <1351000626-22632-2-git-send-email-s.syam@samsung.com>
In-reply-to: <1351000626-22632-1-git-send-email-s.syam@samsung.com>
References: <1351000626-22632-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Trivial formatting fix.
---
 gdbus/object.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 9689006..d58a1a8 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -226,7 +226,7 @@ void g_dbus_pending_success(DBusConnection *connection,
 {
 	GSList *list;
 
-        for (list = pending_security; list; list = list->next) {
+	for (list = pending_security; list; list = list->next) {
 		struct security_data *secdata = list->data;
 
 		if (secdata->pending != pending)
@@ -240,7 +240,7 @@ void g_dbus_pending_success(DBusConnection *connection,
 		dbus_message_unref(secdata->message);
 		g_free(secdata);
 		return;
-        }
+	}
 }
 
 void g_dbus_pending_error_valist(DBusConnection *connection,
@@ -249,7 +249,7 @@ void g_dbus_pending_error_valist(DBusConnection *connection,
 {
 	GSList *list;
 
-        for (list = pending_security; list; list = list->next) {
+	for (list = pending_security; list; list = list->next) {
 		struct security_data *secdata = list->data;
 		DBusMessage *reply;
 
@@ -268,7 +268,7 @@ void g_dbus_pending_error_valist(DBusConnection *connection,
 		dbus_message_unref(secdata->message);
 		g_free(secdata);
 		return;
-        }
+	}
 }
 
 void g_dbus_pending_error(DBusConnection *connection,
-- 
1.7.4.1

