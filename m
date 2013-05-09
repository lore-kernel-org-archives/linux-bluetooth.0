Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ 08/26] alert: Get rid of guint* types
Date: Thu,  9 May 2013 01:16:38 -0300
Message-Id: <1368073016-28434-8-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1368073016-28434-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1368073016-28434-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

guint -> unsigned int
guint8 -> uint8_t
guint16 -> uint16_t
guint32 -> uint32_t
guint64 -> uint64_t

Add "#include <inttypes.h>" where appropriate.
---
 profiles/alert/server.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/profiles/alert/server.c b/profiles/alert/server.c
index 58c8b03..efbb202 100644
--- a/profiles/alert/server.c
+++ b/profiles/alert/server.c
@@ -26,6 +26,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <stdbool.h>
 #include <errno.h>
 #include <gdbus/gdbus.h>
@@ -104,7 +105,7 @@ struct alert_data {
 	const char *category;
 	char *srv;
 	char *path;
-	guint watcher;
+	unsigned int watcher;
 };
 
 struct alert_adapter {
@@ -125,7 +126,7 @@ struct notify_data {
 struct notify_callback {
 	struct notify_data *notify_data;
 	struct btd_device *device;
-	guint id;
+	unsigned int id;
 };
 
 static GSList *registered_alerts = NULL;
-- 
1.8.2.2

