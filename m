Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ v2 15/16] tools: Get rid of gint
Date: Wed,  1 May 2013 02:28:09 -0300
Message-Id: <1367386090-24633-15-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1367386090-24633-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1367386090-24633-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

Use plain int instead of gint. In glib gint is always a typedef to int,
so it's safe to use it even for callbacks with glib.
---
 tools/btiotest.c | 52 ++++++++++++++++++++++++++--------------------------
 1 file changed, 26 insertions(+), 26 deletions(-)

diff --git a/tools/btiotest.c b/tools/btiotest.c
index 7a77bb7..5359ace 100644
--- a/tools/btiotest.c
+++ b/tools/btiotest.c
@@ -38,14 +38,14 @@
 #include <btio/btio.h>
 
 #define DEFAULT_ACCEPT_TIMEOUT 2
-static gint opt_update_sec = 0;
+static int opt_update_sec = 0;
 
 struct io_data {
 	guint ref;
 	GIOChannel *io;
-	gint reject;
-	gint disconn;
-	gint accept;
+	int reject;
+	int disconn;
+	int accept;
 };
 
 static void io_data_unref(struct io_data *data)
@@ -67,8 +67,8 @@ static struct io_data *io_data_ref(struct io_data *data)
 	return data;
 }
 
-static struct io_data *io_data_new(GIOChannel *io, int reject, gint disconn,
-								gint accept)
+static struct io_data *io_data_new(GIOChannel *io, int reject, int disconn,
+								int accept)
 {
 	struct io_data *data;
 
@@ -251,7 +251,7 @@ static void confirm_cb(GIOChannel *io, gpointer user_data)
 			return;
 		}
 	} else {
-		gint seconds = (data->reject > 0) ?
+		int seconds = (data->reject > 0) ?
 						data->reject : data->accept;
 		g_timeout_add_seconds_full(G_PRIORITY_DEFAULT, seconds,
 					confirm_timeout, data,
@@ -260,8 +260,8 @@ static void confirm_cb(GIOChannel *io, gpointer user_data)
 }
 
 static void l2cap_connect(const char *src, const char *dst, uint8_t addr_type,
-				uint16_t psm, uint16_t cid, gint disconn,
-				gint sec, gint prio)
+				uint16_t psm, uint16_t cid, int disconn,
+				int sec, int prio)
 {
 	struct io_data *data;
 	GError *err = NULL;
@@ -301,9 +301,9 @@ static void l2cap_connect(const char *src, const char *dst, uint8_t addr_type,
 	}
 }
 
-static void l2cap_listen(const char *src, uint16_t psm, gint defer,
-				gint reject, gint disconn, gint accept,
-				gint sec, gboolean master)
+static void l2cap_listen(const char *src, uint16_t psm, int defer,
+				int reject, int disconn, int accept,
+				int sec, gboolean master)
 {
 	struct io_data *data;
 	BtIOConnect conn;
@@ -351,7 +351,7 @@ static void l2cap_listen(const char *src, uint16_t psm, gint defer,
 }
 
 static void rfcomm_connect(const char *src, const char *dst, uint8_t ch,
-						gint disconn, gint sec)
+						int disconn, int sec)
 {
 	struct io_data *data;
 	GError *err = NULL;
@@ -386,8 +386,8 @@ static void rfcomm_connect(const char *src, const char *dst, uint8_t ch,
 }
 
 static void rfcomm_listen(const char *src, uint8_t ch, gboolean defer,
-				gint reject, gint disconn, gint accept,
-				gint sec, gboolean master)
+				int reject, int disconn, int accept,
+				int sec, gboolean master)
 {
 	struct io_data *data;
 	BtIOConnect conn;
@@ -436,7 +436,7 @@ static void rfcomm_listen(const char *src, uint8_t ch, gboolean defer,
 	g_io_channel_unref(rc_srv);
 }
 
-static void sco_connect(const char *src, const char *dst, gint disconn)
+static void sco_connect(const char *src, const char *dst, int disconn)
 {
 	struct io_data *data;
 	GError *err = NULL;
@@ -466,8 +466,8 @@ static void sco_connect(const char *src, const char *dst, gint disconn)
 	}
 }
 
-static void sco_listen(const char *src, gboolean defer, gint reject,
-				gint disconn, gint accept)
+static void sco_listen(const char *src, gboolean defer, int reject,
+				int disconn, int accept)
 {
 	struct io_data *data;
 	BtIOConnect conn;
@@ -507,18 +507,18 @@ static void sco_listen(const char *src, gboolean defer, gint reject,
 	g_io_channel_unref(sco_srv);
 }
 
-static gint opt_channel = -1;
-static gint opt_psm = 0;
+static int opt_channel = -1;
+static int opt_psm = 0;
 static gboolean opt_sco = FALSE;
 static gboolean opt_defer = FALSE;
 static char *opt_dev = NULL;
-static gint opt_reject = -1;
-static gint opt_disconn = -1;
-static gint opt_accept = DEFAULT_ACCEPT_TIMEOUT;
-static gint opt_sec = 0;
+static int opt_reject = -1;
+static int opt_disconn = -1;
+static int opt_accept = DEFAULT_ACCEPT_TIMEOUT;
+static int opt_sec = 0;
 static gboolean opt_master = FALSE;
-static gint opt_priority = 0;
-static gint opt_cid = 0;
+static int opt_priority = 0;
+static int opt_cid = 0;
 static guint8 opt_addr_type = 0;
 
 static GMainLoop *main_loop;
-- 
1.8.2.2

