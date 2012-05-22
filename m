Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v1] gdbus: Fix incorrectly discarded signals
Date: Tue, 22 May 2012 16:58:18 +0200
Message-Id: <1337698698-15471-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Signals with no arguments were incorrectly filtered out due to the NULL
inequality check.
---
 gdbus/object.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index 2dd7c0e..900e7ab 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -612,16 +612,12 @@ static gboolean check_signal(DBusConnection *conn, const char *path,
 	for (signal = iface->signals; signal && signal->name; signal++) {
 		if (!strcmp(signal->name, name)) {
 			*args = signal->args;
-			break;
+			return TRUE;
 		}
 	}
 
-	if (*args == NULL) {
-		error("No signal named %s on interface %s", name, interface);
-		return FALSE;
-	}
-
-	return TRUE;
+	error("No signal named %s on interface %s", name, interface);
+	return FALSE;
 }
 
 static dbus_bool_t emit_signal_valist(DBusConnection *conn,
-- 
1.7.7.6

