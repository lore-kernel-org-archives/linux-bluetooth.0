Return-Path: <cyrus@holtmann.org>
From: David Herrmann <dh.herrmann@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	David Herrmann <dh.herrmann@gmail.com>
Subject: [PATCH bluez v2 1/2] plugin: handle ENOSYS as not-supported
Date: Wed,  2 Oct 2013 17:57:30 +0200
Message-Id: <1380729451-2266-1-git-send-email-dh.herrmann@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Allow plugins to return -ENOSYS during registration and handle it as
"not-supported" error. It makes the error messages slightly more useful in
case kernel-support is missing for a particular subsystem.
---
 src/plugin.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/src/plugin.c b/src/plugin.c
index 51c98bc..9c3225e 100644
--- a/src/plugin.c
+++ b/src/plugin.c
@@ -119,6 +119,7 @@ gboolean plugin_init(const char *enable, const char *disable)
 	const char *file;
 	char **cli_disabled, **cli_enabled;
 	unsigned int i;
+	int err;
 
 	/* Make a call to BtIO API so its symbols got resolved before the
 	 * plugins are loaded. */
@@ -196,8 +197,14 @@ start:
 	for (list = plugins; list; list = list->next) {
 		struct bluetooth_plugin *plugin = list->data;
 
-		if (plugin->desc->init() < 0) {
-			error("Failed to init %s plugin", plugin->desc->name);
+		err = plugin->desc->init();
+		if (err < 0) {
+			if (err == -ENOSYS)
+				warn("System does not support %s plugin",
+							plugin->desc->name);
+			else
+				error("Failed to init %s plugin",
+							plugin->desc->name);
 			continue;
 		}
 
-- 
1.8.4
