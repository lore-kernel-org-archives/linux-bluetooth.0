Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ 20/26] sap: Get rid of guint* types
Date: Thu,  9 May 2013 01:16:50 -0300
Message-Id: <1368073016-28434-20-git-send-email-lucas.demarchi@profusion.mobi>
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
 profiles/sap/sap-dummy.c | 2 +-
 profiles/sap/sap.h       | 2 +-
 profiles/sap/server.c    | 9 +++++----
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/profiles/sap/sap-dummy.c b/profiles/sap/sap-dummy.c
index 47dedf7..a62dbcc 100644
--- a/profiles/sap/sap-dummy.c
+++ b/profiles/sap/sap-dummy.c
@@ -28,7 +28,7 @@
 
 #include <glib.h>
 #include <gdbus/gdbus.h>
-#include <stdint.h>
+#include <inttypes.h>
 
 #include "dbus-common.h"
 #include "error.h"
diff --git a/profiles/sap/sap.h b/profiles/sap/sap.h
index 16c333a..88e328e 100644
--- a/profiles/sap/sap.h
+++ b/profiles/sap/sap.h
@@ -23,7 +23,7 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
-#include <stdint.h>
+#include <inttypes.h>
 #include <glib.h>
 
 #ifdef SAP_DEBUG
diff --git a/profiles/sap/server.c b/profiles/sap/server.c
index dfcf0f1..da5d494 100644
--- a/profiles/sap/server.c
+++ b/profiles/sap/server.c
@@ -28,6 +28,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <errno.h>
 #include <glib.h>
 #include <bluetooth/sdp.h>
@@ -69,7 +70,7 @@ struct sap_connection {
 	GIOChannel *io;
 	uint32_t state;
 	uint8_t processing_req;
-	guint timer_id;
+	unsigned int timer_id;
 };
 
 struct sap_server {
@@ -79,7 +80,7 @@ struct sap_server {
 	struct sap_connection *conn;
 };
 
-static void start_guard_timer(struct sap_server *server, guint interval);
+static void start_guard_timer(struct sap_server *server, unsigned int interval);
 static void stop_guard_timer(struct sap_server *server);
 static gboolean guard_timeout(gpointer data);
 
@@ -553,7 +554,7 @@ error_rsp:
 	sap_error_rsp(conn);
 }
 
-static void start_guard_timer(struct sap_server *server, guint interval)
+static void start_guard_timer(struct sap_server *server, unsigned int interval)
 {
 	struct sap_connection *conn = server->conn;
 
@@ -1209,7 +1210,7 @@ static void connect_confirm_cb(GIOChannel *io, gpointer data)
 	GError *gerr = NULL;
 	bdaddr_t src, dst;
 	char dstaddr[18];
-	guint ret;
+	unsigned int ret;
 
 	DBG("conn %p io %p", conn, io);
 
-- 
1.8.2.2

