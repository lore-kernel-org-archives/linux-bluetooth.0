Return-Path: <cyrus@holtmann.org>
Subject: [PATCHes] More osso-gwobex cleanups
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-7UOTf67b7nibm+i3e2ij"
Date: Wed, 10 Feb 2010 13:32:56 +0000
Message-ID: <1265808777.2383.8684.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-7UOTf67b7nibm+i3e2ij
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Let me know what you think.

Cheers

--=-7UOTf67b7nibm+i3e2ij
Content-Disposition: attachment; filename="0001-Require-threads-to-be-enabled.patch"
Content-Type: text/x-patch; name="0001-Require-threads-to-be-enabled.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 55a7ac19f279dfa159f4bac662b55233d528469f Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Wed, 10 Feb 2010 13:20:40 +0000
Subject: [PATCH 1/4] Require threads to be enabled

If we're going to ship osso-gwobex as a shared library, then
threading should not be optional, but required.
---
 src/gw-obex.c   |    9 +++------
 src/obex-priv.h |    7 -------
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/src/gw-obex.c b/src/gw-obex.c
index e656692..8352782 100644
--- a/src/gw-obex.c
+++ b/src/gw-obex.c
@@ -314,10 +314,10 @@ void gw_obex_close(GwObex *ctx) {
         ctx->gio_source = NULL;
     }
     GW_OBEX_UNLOCK(ctx);
-#ifdef GW_OBEX_THREADS_ENABLED
+
     g_mutex_free(ctx->mutex);
     ctx->mutex = NULL;
-#endif
+
     g_free(ctx);
 }
 
@@ -337,21 +337,18 @@ GwObex *gw_obex_setup_fd(int fd, const gchar *uuid, gint uuid_len,
 
     ctx = make_context(handle);
 
-#ifdef GW_OBEX_THREADS_ENABLED
     if (!g_thread_supported())
         g_thread_init(NULL);
     ctx->mutex = g_mutex_new();
-#endif
 
     OBEX_SetCustomData(handle, ctx);
 
     debug("Connecting to OBEX service\n");
     if (!gw_obex_connect(ctx, uuid, uuid_len)) {
         debug("Unable to connect to OBEX service\n");
-#ifdef GW_OBEX_THREADS_ENABLED
         g_mutex_free(ctx->mutex);
         ctx->mutex = NULL;
-#endif
+
         g_free(ctx);
         OBEX_Cleanup(handle);
         if (error)
diff --git a/src/obex-priv.h b/src/obex-priv.h
index 01d7b8b..ce7748c 100644
--- a/src/obex-priv.h
+++ b/src/obex-priv.h
@@ -72,7 +72,6 @@
 #define OBP_TYPE "x-obex/object-profile"
 #define LST_TYPE "x-obex/folder-listing"
 
-#ifdef GW_OBEX_THREADS_ENABLED
 # ifdef DEBUG
 #  define GW_OBEX_LOCK(ctx) do { \
       debug("Attempting GW_OBEX_LOCK at %s:%d (%s)...", __FILE__, __LINE__, __PRETTY_FUNCTION__); \
@@ -88,10 +87,6 @@
 #  define GW_OBEX_LOCK(ctx)   g_mutex_lock((ctx)->mutex)
 #  define GW_OBEX_UNLOCK(ctx) g_mutex_unlock((ctx)->mutex)
 # endif
-#else
-# define GW_OBEX_LOCK(ctx)   ((void)(0))
-# define GW_OBEX_UNLOCK(ctx) ((void)(0))
-#endif
 
 typedef struct obex_setpath_hdr {
     uint8_t  flags;
@@ -105,10 +100,8 @@ typedef struct obex_connect_hdr {
 } __attribute__ ((packed)) obex_connect_hdr_t;
 
 struct gw_obex {
-#ifdef GW_OBEX_THREADS_ENABLED
     /* To get rid of race conditions in multithreaded apps */
     GMutex                  *mutex;
-#endif
 
     /* Main OpenOBEX handle */
     obex_t                  *handle;
-- 
1.6.6


--=-7UOTf67b7nibm+i3e2ij
Content-Disposition: attachment; filename="0002-Use-glib-functions-for-make_iso8601.patch"
Content-Type: text/x-patch; name="0002-Use-glib-functions-for-make_iso8601.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 29a8e59d8ced6f2bbc67bd4627b6bbc78c8f2bd3 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Wed, 10 Feb 2010 13:27:07 +0000
Subject: [PATCH 2/4] Use glib functions for make_iso8601()

Instead of using home-grown helpers.
---
 configure.ac    |    2 +-
 src/obex-priv.c |   10 +++++-----
 src/utils.c     |   28 +++++-----------------------
 src/utils.h     |    6 ++----
 4 files changed, 13 insertions(+), 33 deletions(-)

diff --git a/configure.ac b/configure.ac
index 2b2b12a..14f4098 100644
--- a/configure.ac
+++ b/configure.ac
@@ -50,7 +50,7 @@ fi
 
 dnl Check for glib
 PKG_CHECK_MODULES(GW_OBEX, [
-			    glib-2.0 >= 2.6.0
+			    glib-2.0 >= 2.12.0
 			    gthread-2.0 >= 2.6.0
 			    openobex >= 1.2
 	          ])
diff --git a/src/obex-priv.c b/src/obex-priv.c
index 86e9dd9..a8b12ea 100644
--- a/src/obex-priv.c
+++ b/src/obex-priv.c
@@ -1049,15 +1049,15 @@ gboolean gw_obex_put(GwObex *ctx,
 
     /* Add a time header if possible */
     if (object_time >= 0) {
-        char tstr[17];
-        int len;
+        char *tstr;
 
-        len = make_iso8601(object_time, tstr, sizeof(tstr));
+        tstr = make_iso8601(object_time);
 
-        if (len >= 0) {
+        if (tstr != NULL) {
             debug("Adding time header: %s\n", tstr);
             hv.bs = (unsigned char *)tstr;
-            OBEX_ObjectAddHeader(ctx->handle, object, OBEX_HDR_TIME, hv, len, 0);
+            OBEX_ObjectAddHeader(ctx->handle, object, OBEX_HDR_TIME, hv, strlen(tstr), 0);
+            free(tstr);
         }
     }
 
diff --git a/src/utils.c b/src/utils.c
index 02afa2e..628b832 100644
--- a/src/utils.c
+++ b/src/utils.c
@@ -98,31 +98,13 @@ glong get_uname(gunichar2 **uname, const gchar *name) {
     return uname_len;
 }
 
-int make_iso8601(time_t time, char *str, int len) {
-    struct tm tm;
-#if defined(HAVE_TIMEZONE) && defined(USE_LOCALTIME)
-    time_t tz_offset = 0;
-
-    tz_offset = -timezone;
-    if (daylight > 0)
-        tz_offset += 3600;
-    time += tz_offset;
-#endif
-
-    if (gmtime_r(&time, &tm) == NULL)
-        return -1;
+char * make_iso8601(time_t time) {
+    GTimeVal tv;
 
-    tm.tm_year += 1900;
-    tm.tm_mon++;
+    tv.tv_sec = time;
+    tv.tv_usec = 0;
 
-    return snprintf(str, len,
-#ifdef USE_LOCALTIME
-                    "%04u%02u%02uT%02u%02u%02u",
-#else
-                    "%04u%02u%02uT%02u%02u%02uZ",
-#endif
-                    tm.tm_year, tm.tm_mon, tm.tm_mday,
-                    tm.tm_hour, tm.tm_min, tm.tm_sec);
+    return g_time_val_to_iso8601(&tv);
 }
 
 /* From Imendio's GnomeVFS OBEX module (om-utils.c) */
diff --git a/src/utils.h b/src/utils.h
index de1ba05..e94f3d6 100644
--- a/src/utils.h
+++ b/src/utils.h
@@ -31,11 +31,9 @@
 
 /** Create ISO8601 time format string from time_t
  * @param time Time to convert
- * @param str  Pointer where result is stored
- * @param len  Maximum amount of chars written
- * @returns length of created string.
+ * @returns a newly allocated string representing the time in ISO8601 format
  */
-int make_iso8601(time_t time, char *str, int len);
+char *make_iso8601(time_t time);
 
 /** Convert a time string in ISO8601 format to time_t
  * @param str Time string in ISO8601 format
-- 
1.6.6


--=-7UOTf67b7nibm+i3e2ij
Content-Disposition: attachment; filename="0003-Use-glib-functions-for-parse_iso8601.patch"
Content-Type: text/x-patch; name="0003-Use-glib-functions-for-parse_iso8601.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 10a07bf30ee42952789a6d7951abf46affce0c57 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Wed, 10 Feb 2010 13:31:21 +0000
Subject: [PATCH 3/4] Use glib functions for parse_iso8601()

Instead of this fragile home-grown function
---
 src/utils.c |   53 +++++++----------------------------------------------
 1 files changed, 7 insertions(+), 46 deletions(-)

diff --git a/src/utils.c b/src/utils.c
index 628b832..c75c2d6 100644
--- a/src/utils.c
+++ b/src/utils.c
@@ -107,61 +107,22 @@ char * make_iso8601(time_t time) {
     return g_time_val_to_iso8601(&tv);
 }
 
-/* From Imendio's GnomeVFS OBEX module (om-utils.c) */
 time_t parse_iso8601(const gchar *str, int len) {
     gchar    *tstr;
-    struct tm tm;
-    gint      nr;
-    gchar     tz;
-    time_t    time;
-    time_t    tz_offset = 0;
-
-    memset (&tm, 0, sizeof (struct tm));
+    GTimeVal  tv;
 
     /* According to spec the time doesn't have to be null terminated */
-    if (str[len - 1] != '\0') {
-        tstr = g_malloc(len + 1);
-        strncpy(tstr, str, len);
-        tstr[len] = '\0';
-    }
+    if (str[len - 1] != '\0')
+        tstr = g_strndup(str, len);
     else
         tstr = g_strdup(str);
 
-    nr = sscanf (tstr, "%04u%02u%02uT%02u%02u%02u%c",
-            &tm.tm_year, &tm.tm_mon, &tm.tm_mday,
-            &tm.tm_hour, &tm.tm_min, &tm.tm_sec,
-            &tz);
-
-    g_free(tstr);
-
-    /* Fixup the tm values */
-    tm.tm_year -= 1900;       /* Year since 1900 */
-    tm.tm_mon--;              /* Months since January, values 0-11 */
-    tm.tm_isdst = -1;         /* Daylight savings information not avail */
-
-    if (nr < 6) {
-        /* Invalid time format */
+    if (g_time_val_from_iso8601(tstr, &tv) == FALSE) {
+        g_free (tstr);
         return -1;
     }
 
-    time = mktime (&tm);
-
-#if defined(HAVE_TM_GMTOFF)
-    tz_offset = tm.tm_gmtoff;
-#elif defined(HAVE_TIMEZONE)
-    tz_offset = -timezone;
-    if (tm.tm_isdst > 0) {
-        tz_offset += 3600;
-    }
-#endif
-
-    if (nr == 7) { /* Date/Time was in localtime (to remote device)
-                    * already. Since we don't know anything about the
-                    * timezone on that one we won't try to apply UTC offset
-                    */
-        time += tz_offset;
-    }
-
-    return time;
+    g_free (tstr);
+    return tv.tv_sec;
 }
 
-- 
1.6.6


--=-7UOTf67b7nibm+i3e2ij
Content-Disposition: attachment; filename="0004-Remove-unused-GWOBEX_CHECK_TIMEZONE-macro.patch"
Content-Type: text/x-patch; name="0004-Remove-unused-GWOBEX_CHECK_TIMEZONE-macro.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From 880287a7258ecb1e3c3fc69b322be5afba946db3 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Wed, 10 Feb 2010 13:31:54 +0000
Subject: [PATCH 4/4] Remove unused GWOBEX_CHECK_TIMEZONE macro

---
 configure.ac |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index 14f4098..7688054 100644
--- a/configure.ac
+++ b/configure.ac
@@ -11,7 +11,6 @@ AC_HEADER_STDC
 AC_PROG_LIBTOOL
 
 GWOBEX_COMPILE_WARNINGS
-GWOBEX_CHECK_TIMEZONE
 
 # Before making a release, the CHEESE_LT_VERSION string should be modified.
 # The string is of the form C:R:A.
-- 
1.6.6


--=-7UOTf67b7nibm+i3e2ij--

