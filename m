Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH] unit/test-gdbus-client: Set DISPLAY=:0 for D-Bus
Date: Tue, 28 Apr 2015 14:21:11 -0700
Message-Id: <1430256071-17261-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

unit/test-gdbus-client has been failing when run without X11 with the
following error in all test cases:

  D-Bus setup failed: Unable to autolaunch a dbus-daemon without a $DISPLAY for X11

This patch fixes this by setting the DISPLAY environment variable to
":0" from within the test process. This allows the test to be run
without an X session, e.g. over ssh.
---
 unit/test-gdbus-client.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/unit/test-gdbus-client.c b/unit/test-gdbus-client.c
index 7e16d16..9d9ff16 100644
--- a/unit/test-gdbus-client.c
+++ b/unit/test-gdbus-client.c
@@ -25,6 +25,7 @@
 #include <config.h>
 #endif
 
+#include <stdlib.h>
 #include <glib.h>
 
 #include "gdbus/gdbus.h"
@@ -61,6 +62,17 @@ static struct context *create_context(void)
 	struct context *context = g_new0(struct context, 1);
 	DBusError err;
 
+	/*
+	 * Set the display variable to ":0" to allow setting up a D-Bus session
+	 * without X11.
+	 */
+	if (putenv("DISPLAY=:0")) {
+		tester_debug("Failed to set $DISPLAY environment variable");
+		g_free(context);
+		tester_test_failed();
+		return NULL;
+	}
+
 	dbus_error_init(&err);
 
 	context->dbus_conn = g_dbus_setup_private(DBUS_BUS_SESSION,
-- 
2.2.0.rc0.207.ga3a616c

