Return-Path: <cyrus@holtmann.org>
From: Adam Lee <adam8157@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Marcel Holtmann <marcel@holtmann.org>
Subject: [PATCH BlueZ] core: retry connect_dbus() several times
Date: Fri, 28 Feb 2014 15:09:22 +0800
Message-Id: <1393571362-27898-1-git-send-email-adam8157@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

Sometimes the hardware, especially which needs firmware patching, is not
yet ready when connect_dbus().

Signed-off-by: Adam Lee <adam8157@gmail.com>
---
 src/main.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/src/main.c b/src/main.c
index b3136fc..cf1f8fa 100644
--- a/src/main.c
+++ b/src/main.c
@@ -491,6 +491,7 @@ int main(int argc, char *argv[])
 	GKeyFile *config;
 	guint signal, watchdog;
 	const char *watchdog_usec;
+	uint8_t reconnect_times = 3;
 
 	init_defaults();
 
@@ -527,9 +528,17 @@ int main(int argc, char *argv[])
 
 	parse_config(config);
 
-	if (connect_dbus() < 0) {
-		error("Unable to get on D-Bus");
-		exit(1);
+	/* Reconnect several times in case the hardware is not ready */
+	while (reconnect_times--) {
+		if (connect_dbus() == 0)
+			break;
+
+		if (reconnect_times != 1) {
+			usleep(500 * 1000);
+		} else {
+			error("Unable to get on D-Bus");
+			exit(1);
+		}
 	}
 
 	if (option_experimental)
-- 
1.9.0
