Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ 18/26] network: Get rid of guint* types
Date: Thu,  9 May 2013 01:16:48 -0300
Message-Id: <1368073016-28434-18-git-send-email-lucas.demarchi@profusion.mobi>
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
 profiles/network/connection.c | 7 ++++---
 profiles/network/server.c     | 7 ++++---
 2 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index 9481072..f69d22a 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -25,6 +25,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <stdio.h>
 #include <stdbool.h>
 #include <errno.h>
@@ -71,10 +72,10 @@ struct network_conn {
 	uint16_t	id;		/* Role: Service Class Identifier */
 	conn_state	state;
 	GIOChannel	*io;
-	guint		dc_id;
+	unsigned int		dc_id;
 	struct network_peer *peer;
-	guint		attempt_cnt;
-	guint		timeout_source;
+	unsigned int		attempt_cnt;
+	unsigned int		timeout_source;
 	DBusMessage	*connect;
 };
 
diff --git a/profiles/network/server.c b/profiles/network/server.c
index de48bec..3dff8b4 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -25,6 +25,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <stdio.h>
 #include <unistd.h>
 #include <stdlib.h>
@@ -59,7 +60,7 @@ struct network_session {
 	bdaddr_t	dst;		/* Remote Bluetooth Address */
 	char		dev[16];	/* Interface name */
 	GIOChannel	*io;		/* Pending connect channel */
-	guint		watch;		/* BNEP socket watch */
+	unsigned int		watch;		/* BNEP socket watch */
 };
 
 struct network_adapter {
@@ -78,7 +79,7 @@ struct network_server {
 	uint16_t	id;		/* Service class identifier */
 	GSList		*sessions;	/* Active connections */
 	struct network_adapter *na;	/* Adapter reference */
-	guint		watch_id;	/* Client service watch */
+	unsigned int		watch_id;	/* Client service watch */
 };
 
 static GSList *adapters = NULL;
@@ -518,7 +519,7 @@ static void confirm_event(GIOChannel *chan, gpointer user_data)
 	bdaddr_t src, dst;
 	char address[18];
 	GError *err = NULL;
-	guint ret;
+	unsigned int ret;
 
 	bt_io_get(chan, &err,
 			BT_IO_OPT_SOURCE_BDADDR, &src,
-- 
1.8.2.2

