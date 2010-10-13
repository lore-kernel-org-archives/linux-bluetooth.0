Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] gdbus: fix not handling bus disconnects
Date: Wed, 13 Oct 2010 15:06:46 +0300
Message-Id: <1286971606-11790-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

We where not dispatching data when a bus disconnects which cause
Disconnected signal to not be processed and thus causing the process to
either not exit or to not trigger callbacks registered with
g_dbus_set_disconnect_function.

To fix this now we always schedule a dispatch which will make sure data
still not processed will make its way to the proper handlers even if
disconnected.
---
 gdbus/mainloop.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/gdbus/mainloop.c b/gdbus/mainloop.c
index ec10ab0..862c434 100644
--- a/gdbus/mainloop.c
+++ b/gdbus/mainloop.c
@@ -95,6 +95,7 @@ static gboolean watch_func(GIOChannel *chan, GIOCondition cond, gpointer data)
 {
 	struct watch_info *info = data;
 	unsigned int flags = 0;
+	DBusDispatchStatus status;
 
 	dbus_connection_ref(info->conn);
 
@@ -105,6 +106,9 @@ static gboolean watch_func(GIOChannel *chan, GIOCondition cond, gpointer data)
 
 	dbus_watch_handle(info->watch, flags);
 
+	status = dbus_connection_get_dispatch_status(info->conn);
+	queue_dispatch(info->conn, status);
+
 	dbus_connection_unref(info->conn);
 
 	return TRUE;
-- 
1.7.1

