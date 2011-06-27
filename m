Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <syamsidhardh@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <syamsidhardh@gmail.com>
Subject: [PATCH obexd 4/4] Fix space after function name coding style issue for gwobex
Date: Tue, 28 Jun 2011 00:42:11 +0530
Message-Id: <1309201931-30026-1-git-send-email-syamsidhardh@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

- Corrected white space between the function name and '('
---
 gwobex/gw-obex.c |    2 +-
 gwobex/utils.c   |    6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/gwobex/gw-obex.c b/gwobex/gw-obex.c
index 4481212..0ac92a9 100644
--- a/gwobex/gw-obex.c
+++ b/gwobex/gw-obex.c
@@ -362,7 +362,7 @@ GwObex *gw_obex_setup_fd(int fd, const gchar *uuid, gint uuid_len,
     debug("Connected (Connection ID: %#x)\n", ctx->conid);
 
     ctx->gio = g_io_channel_unix_new(ctx->conn_fd);
-    ctx->gio_source = g_io_create_watch (ctx->gio,
+    ctx->gio_source = g_io_create_watch(ctx->gio,
                                          G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL);
     g_source_set_callback(ctx->gio_source, (GSourceFunc)gw_obex_cb, ctx, NULL);
     (void) g_source_attach(ctx->gio_source, context);
diff --git a/gwobex/utils.c b/gwobex/utils.c
index f47b68a..ad0e20c 100644
--- a/gwobex/utils.c
+++ b/gwobex/utils.c
@@ -134,7 +134,7 @@ time_t parse_iso8601(const gchar *str, int len) {
     time_t    time;
     time_t    tz_offset = 0;
 
-    memset (&tm, 0, sizeof(struct tm));
+    memset(&tm, 0, sizeof(struct tm));
 
     /* According to spec the time doesn't have to be null terminated */
     if (str[len - 1] != '\0') {
@@ -145,7 +145,7 @@ time_t parse_iso8601(const gchar *str, int len) {
     else
         tstr = g_strdup(str);
 
-    nr = sscanf (tstr, "%04u%02u%02uT%02u%02u%02u%c",
+    nr = sscanf(tstr, "%04u%02u%02uT%02u%02u%02u%c",
             &tm.tm_year, &tm.tm_mon, &tm.tm_mday,
             &tm.tm_hour, &tm.tm_min, &tm.tm_sec,
             &tz);
@@ -162,7 +162,7 @@ time_t parse_iso8601(const gchar *str, int len) {
         return -1;
     }
 
-    time = mktime (&tm);
+    time = mktime(&tm);
 
 #if defined(HAVE_TM_GMTOFF)
     tz_offset = tm.tm_gmtoff;
-- 
1.7.4.1

