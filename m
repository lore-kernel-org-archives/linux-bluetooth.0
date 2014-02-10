Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 3/3] unit: Fix memory leaks in test-gdbus-client
Date: Mon, 10 Feb 2014 13:14:58 -0400
Message-Id: <1392052498-9229-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1392052498-9229-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1392052498-9229-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-gdbus-client.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/unit/test-gdbus-client.c b/unit/test-gdbus-client.c
index 685729a..ee8a760 100644
--- a/unit/test-gdbus-client.c
+++ b/unit/test-gdbus-client.c
@@ -101,6 +101,7 @@ static void destroy_context(struct context *context)
 
 	dbus_connection_flush(context->dbus_conn);
 	dbus_connection_close(context->dbus_conn);
+	dbus_connection_unref(context->dbus_conn);
 
 	g_main_loop_unref(context->main_loop);
 
@@ -956,6 +957,10 @@ static void client_force_disconnect(void)
 
 	g_main_loop_run(context->main_loop);
 
+	g_dbus_unregister_interface(conn, SERVICE_PATH, SERVICE_NAME1);
+	g_dbus_detach_object_manager(conn);
+	dbus_connection_unref(conn);
+
 	destroy_context(context);
 }
 
-- 
1.7.9.5

