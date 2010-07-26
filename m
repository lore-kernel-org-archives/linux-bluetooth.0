Return-Path: <cyrus@holtmann.org>
From: Zhenhua Zhang <zhenhua.zhang@intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] watch: Free service data in service_reply
Date: Mon, 26 Jul 2010 09:11:11 +0800
Message-Id: <1280106672-4796-1-git-send-email-zhenhua.zhang@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Avoid the memory leak of server_data.
---
 gdbus/watch.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gdbus/watch.c b/gdbus/watch.c
index 1d479fa..29f23e2 100644
--- a/gdbus/watch.c
+++ b/gdbus/watch.c
@@ -533,7 +533,7 @@ static void check_service(DBusConnection *connection, const char *name,
 		goto done;
 	}
 
-	dbus_pending_call_set_notify(call, service_reply, data, NULL);
+	dbus_pending_call_set_notify(call, service_reply, data, g_free);
 
 	dbus_pending_call_unref(call);
 
-- 
1.7.0.4

