Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 2/8] client: move __obex_log_init before manager_init
Date: Fri, 12 Aug 2011 11:45:08 +0300
Message-Id: <1313138714-6443-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1313138714-6443-1-git-send-email-luiz.dentz@gmail.com>
References: <1313138714-6443-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This enables us to log target during initialization
---
 client/main.c    |    4 ++--
 client/manager.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/client/main.c b/client/main.c
index 618ad21..80f9413 100644
--- a/client/main.c
+++ b/client/main.c
@@ -87,11 +87,11 @@ int main(int argc, char *argv[])
 
 	event_loop = g_main_loop_new(NULL, FALSE);
 
+	__obex_log_init("obex-client", option_debug, !option_stderr);
+
 	if (manager_init() < 0)
 		exit(EXIT_FAILURE);
 
-	__obex_log_init("obex-client", option_debug, !option_stderr);
-
 	DBG("Entering main loop");
 
 	memset(&sa, 0, sizeof(sa));
diff --git a/client/manager.c b/client/manager.c
index b13dd78..a272a87 100644
--- a/client/manager.c
+++ b/client/manager.c
@@ -571,7 +571,7 @@ int manager_init(void)
 
 	conn = g_dbus_setup_bus(DBUS_BUS_SESSION, CLIENT_SERVICE, &derr);
 	if (dbus_error_is_set(&derr) == TRUE) {
-		g_printerr("%s: %s\n", derr.name, derr.message);
+		error("%s: %s", derr.name, derr.message);
 		dbus_error_free(&derr);
 		return -1;
 	}
@@ -579,7 +579,7 @@ int manager_init(void)
 	if (g_dbus_register_interface(conn, CLIENT_PATH, CLIENT_INTERFACE,
 						client_methods, NULL, NULL,
 							NULL, NULL) == FALSE) {
-		g_printerr("Can't register client interface\n");
+		error("Can't register client interface");
 		dbus_connection_unref(conn);
 		conn = NULL;
 		return -1;
-- 
1.7.6

