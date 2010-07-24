Return-Path: <cyrus@holtmann.org>
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] watch: Free service data in service_reply
Date: Sat, 24 Jul 2010 17:46:27 +0800
Message-Id: <1279964787-3989-1-git-send-email-zhenhua.zhang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Avoid the memory leak of server_data.
---
 gdbus/watch.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/gdbus/watch.c b/gdbus/watch.c
index 1d479fa..ccdbb64 100644
--- a/gdbus/watch.c
+++ b/gdbus/watch.c
@@ -468,8 +468,10 @@ static void service_reply(DBusPendingCall *call, void *user_data)
 	dbus_bool_t has_owner;
 
 	reply = dbus_pending_call_steal_reply(call);
-	if (reply == NULL)
+	if (reply == NULL) {
+		g_free(data);
 		return;
+	}
 
 	dbus_error_init(&error);
 
@@ -490,6 +492,7 @@ static void service_reply(DBusPendingCall *call, void *user_data)
 
 done:
 	dbus_message_unref(reply);
+	g_free(data);
 }
 
 static void check_service(DBusConnection *connection, const char *name,
-- 
1.7.0.4

