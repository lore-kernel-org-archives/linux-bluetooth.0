Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 1/8] client: add target module vtable
Date: Fri, 12 Aug 2011 11:45:07 +0300
Message-Id: <1313138714-6443-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1313138714-6443-1-git-send-email-luiz.dentz@gmail.com>
References: <1313138714-6443-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

New targets/profiles can be introduced by just adding an entry to the
table and register their drivers similarly to a plugin.
---
 client/manager.c |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/client/manager.c b/client/manager.c
index e7eb70d..b13dd78 100644
--- a/client/manager.c
+++ b/client/manager.c
@@ -554,9 +554,18 @@ static GDBusMethodTable client_methods[] = {
 
 static DBusConnection *conn = NULL;
 
+static struct target_module {
+	const char *name;
+	int (*init) (void);
+	void (*exit) (void);
+} targets[] = {
+	{ }
+};
+
 int manager_init(void)
 {
 	DBusError derr;
+	struct target_module *target;
 
 	dbus_error_init(&derr);
 
@@ -576,14 +585,26 @@ int manager_init(void)
 		return -1;
 	}
 
+	for (target = targets; target && target->init; target++) {
+		if (target->init() < 0)
+			continue;
+
+		DBG("Target %s loaded", target->name);
+	}
+
 	return 0;
 }
 
 void manager_exit(void)
 {
+	struct target_module *target;
+
 	if (conn == NULL)
 		return;
 
+	for (target = targets; target && target->exit; target++)
+		target->exit();
+
 	g_dbus_unregister_interface(conn, CLIENT_PATH, CLIENT_INTERFACE);
 	dbus_connection_unref(conn);
 }
-- 
1.7.6

