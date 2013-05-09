Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ 07/26] plugins: Get rid of guint* types
Date: Thu,  9 May 2013 01:16:37 -0300
Message-Id: <1368073016-28434-7-git-send-email-lucas.demarchi@profusion.mobi>
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
 plugins/neard.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index e4a4d71..645202d 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -25,6 +25,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <errno.h>
 #include <gdbus/gdbus.h>
 
@@ -49,7 +50,7 @@
 #define AGENT_CARRIER_TYPE "bluetooth"
 #define ERROR_INTERFACE "org.neard.HandoverAgent.Error"
 
-static guint watcher_id = 0;
+static unsigned int watcher_id = 0;
 static char *neard_service = NULL;
 static bool agent_register_postpone = false;
 
-- 
1.8.2.2

