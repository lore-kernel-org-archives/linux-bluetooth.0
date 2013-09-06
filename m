Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH bluez] bnep: don't error() if kernel lacks bnep module
Date: Fri,  6 Sep 2013 16:23:07 +0200
Message-Id: <1378477387-13186-1-git-send-email-dh.herrmann@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

If a user disables bnep kernel support, they normally do that on purpose.
It's misleading to print an error during module-startup in this situation.
Therefore, only print a hint that bnep-support is missing if
EPROTONOSUPPORT is returned by the kernel.

Furthermore, allow modules to forward ENOSYS as error to bluetoothd core
to handle it as "module is not compatible with system setup" instead of an
error. ENOSYS is commonly used to signal "missing kernel infrastructure"
so it seems appropriate here.
---
 profiles/network/common.c  |  7 ++++++-
 profiles/network/manager.c | 17 ++++++++++++++---
 src/plugin.c               | 11 +++++++++--
 3 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/profiles/network/common.c b/profiles/network/common.c
index e069892..17bff30 100644
--- a/profiles/network/common.c
+++ b/profiles/network/common.c
@@ -110,8 +110,13 @@ int bnep_init(void)
 
 	if (ctl < 0) {
 		int err = -errno;
-		error("Failed to open control socket: %s (%d)",
+
+		if (err == -EPROTONOSUPPORT)
+			info("kernel lacks bnep-protocol support");
+		else
+			error("Failed to open control socket: %s (%d)",
 						strerror(-err), -err);
+
 		return err;
 	}
 
diff --git a/profiles/network/manager.c b/profiles/network/manager.c
index 03b1b3d..7697766 100644
--- a/profiles/network/manager.c
+++ b/profiles/network/manager.c
@@ -25,6 +25,7 @@
 #include <config.h>
 #endif
 
+#include <errno.h>
 #include <stdbool.h>
 
 #include <bluetooth/bluetooth.h>
@@ -169,11 +170,21 @@ static struct btd_profile nap_profile = {
 
 static int network_init(void)
 {
+	int r;
+
 	read_config(CONFIGDIR "/network.conf");
 
-	if (bnep_init()) {
-		error("Can't init bnep module");
-		return -1;
+	r = bnep_init();
+	if (r) {
+		if (r == -EPROTONOSUPPORT) {
+			info("bnep module not available, disabling plugin");
+			r = -ENOSYS;
+		} else {
+			error("Can't init bnep module");
+			r = -1;
+		}
+
+		return r;
 	}
 
 	/*
diff --git a/src/plugin.c b/src/plugin.c
index 51c98bc..396c8af 100644
--- a/src/plugin.c
+++ b/src/plugin.c
@@ -119,6 +119,7 @@ gboolean plugin_init(const char *enable, const char *disable)
 	const char *file;
 	char **cli_disabled, **cli_enabled;
 	unsigned int i;
+	int r;
 
 	/* Make a call to BtIO API so its symbols got resolved before the
 	 * plugins are loaded. */
@@ -196,8 +197,14 @@ start:
 	for (list = plugins; list; list = list->next) {
 		struct bluetooth_plugin *plugin = list->data;
 
-		if (plugin->desc->init() < 0) {
-			error("Failed to init %s plugin", plugin->desc->name);
+		r = plugin->desc->init();
+		if (r < 0) {
+			if (r == -ENOSYS)
+				info("System does not support %s plugin",
+							plugin->desc->name);
+			else
+				error("Failed to init %s plugin",
+							plugin->desc->name);
 			continue;
 		}
 
-- 
1.8.4
