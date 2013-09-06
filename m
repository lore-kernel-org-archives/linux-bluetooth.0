Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Change __FUNCTION__ to __func__
Date: Fri,  6 Sep 2013 11:02:10 +0300
Message-Id: <1378454530-24686-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1378454530-24686-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1378454530-24686-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

checkpatch.pl recommends to use __func__ instead of __FUNCTION__.
---
 attrib/gattrib.c    | 2 +-
 gobex/gobex-debug.h | 2 +-
 obexd/src/log.h     | 2 +-
 src/log.h           | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/attrib/gattrib.c b/attrib/gattrib.c
index c662ace..609b908 100644
--- a/attrib/gattrib.c
+++ b/attrib/gattrib.c
@@ -718,7 +718,7 @@ gboolean g_attrib_unregister(GAttrib *attrib, guint id)
 	GSList *l;
 
 	if (id == 0) {
-		warn("%s: invalid id", __FUNCTION__);
+		warn("%s: invalid id", __func__);
 		return FALSE;
 	}
 
diff --git a/gobex/gobex-debug.h b/gobex/gobex-debug.h
index 688466e..a98653d 100644
--- a/gobex/gobex-debug.h
+++ b/gobex/gobex-debug.h
@@ -40,7 +40,7 @@ extern guint gobex_debug;
 #define g_obex_debug(level, format, ...) \
 	if (gobex_debug & level) \
 		g_log("gobex", G_LOG_LEVEL_DEBUG, "%s:%s() " format, __FILE__, \
-						__FUNCTION__, ## __VA_ARGS__)
+						__func__, ## __VA_ARGS__)
 
 static inline void g_obex_dump(guint level, const char *prefix,
 					const void *buf, gsize len)
diff --git a/obexd/src/log.h b/obexd/src/log.h
index 1bf1b05..d9fb867 100644
--- a/obexd/src/log.h
+++ b/obexd/src/log.h
@@ -52,5 +52,5 @@ struct obex_debug_desc {
 		.file = __FILE__, .flags = OBEX_DEBUG_FLAG_DEFAULT, \
 	}; \
 	if (__obex_debug_desc.flags & OBEX_DEBUG_FLAG_PRINT) \
-		obex_debug("%s:%s() " fmt,  __FILE__, __FUNCTION__ , ## arg); \
+		obex_debug("%s:%s() " fmt,  __FILE__, __func__ , ## arg); \
 } while (0)
diff --git a/src/log.h b/src/log.h
index 3d34fa3..bf9eac2 100644
--- a/src/log.h
+++ b/src/log.h
@@ -55,5 +55,5 @@ void __btd_enable_debug(struct btd_debug_desc *start,
 		.file = __FILE__, .flags = BTD_DEBUG_FLAG_DEFAULT, \
 	}; \
 	if (__btd_debug_desc.flags & BTD_DEBUG_FLAG_PRINT) \
-		btd_debug("%s:%s() " fmt,  __FILE__, __FUNCTION__ , ## arg); \
+		btd_debug("%s:%s() " fmt,  __FILE__, __func__ , ## arg); \
 } while (0)
-- 
1.8.1.2

