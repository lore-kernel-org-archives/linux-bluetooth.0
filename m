Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 2/2] unit: Print D-Bus error message in verbose mode
Date: Wed,  9 Jan 2013 21:03:28 -0400
Message-Id: <1357779808-25513-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1357779808-25513-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1357779808-25513-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If g_dbus_setup_private() fails (e.g. a session bus is not available,
and there is no X11 for dbus-launch to work), the tests are silently
skipped.

With this commit, the D-Bus error message is also printed if verbose
mode is enabled. The test is still skipped as before.
---
 unit/test-gdbus-client.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/unit/test-gdbus-client.c b/unit/test-gdbus-client.c
index cfbe4e0..5821414 100644
--- a/unit/test-gdbus-client.c
+++ b/unit/test-gdbus-client.c
@@ -53,6 +53,7 @@ static const GDBusPropertyTable properties[] = {
 static struct context *create_context(void)
 {
 	struct context *context = g_new0(struct context, 1);
+	DBusError err;
 
 	context->main_loop = g_main_loop_new(NULL, FALSE);
 	if (context->main_loop == NULL) {
@@ -60,9 +61,18 @@ static struct context *create_context(void)
 		return NULL;
 	}
 
+	dbus_error_init(&err);
+
 	context->dbus_conn = g_dbus_setup_private(DBUS_BUS_SESSION,
-							SERVICE_NAME, NULL);
+							SERVICE_NAME, &err);
 	if (context->dbus_conn == NULL) {
+		if (dbus_error_is_set(&err)) {
+			if (g_test_verbose())
+				g_printerr("D-Bus setup failed: %s\n",
+								err.message);
+			dbus_error_free(&err);
+		}
+
 		g_main_loop_unref(context->main_loop);
 		g_free(context);
 		return NULL;
-- 
1.7.9.5

