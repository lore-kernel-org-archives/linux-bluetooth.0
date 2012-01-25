Return-Path: <cyrus@holtmann.org>
From: Santiago Carot-Nemesio <sancane@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Santiago Carot-Nemesio <sancane@gmail.com>
Subject: [PATCH 6/8] glib-compat: Add g_list_free_full to deal with issues in old GLib versions
Date: Wed, 25 Jan 2012 11:03:08 +0100
Message-Id: <1327485790-26249-7-git-send-email-sancane@gmail.com>
In-Reply-To: <1327485790-26249-6-git-send-email-sancane@gmail.com>
References: <1327485790-26249-1-git-send-email-sancane@gmail.com>
 <1327485790-26249-2-git-send-email-sancane@gmail.com>
 <1327485790-26249-3-git-send-email-sancane@gmail.com>
 <1327485790-26249-4-git-send-email-sancane@gmail.com>
 <1327485790-26249-5-git-send-email-sancane@gmail.com>
 <1327485790-26249-6-git-send-email-sancane@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 acinclude.m4      |    3 +++
 src/glib-compat.h |    8 ++++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/acinclude.m4 b/acinclude.m4
index 57fc5e0..48a59a2 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -111,6 +111,9 @@ AC_DEFUN([AC_PATH_GLIB], [
 	AC_CHECK_LIB(glib-2.0, g_slist_free_full, dummy=yes,
 		AC_DEFINE(NEED_G_SLIST_FREE_FULL, 1,
 			[Define to 1 if you need g_slist_free_full() function.]))
+	AC_CHECK_LIB(glib-2.0, g_list_free_full, dummy=yes,
+		AC_DEFINE(NEED_G_LIST_FREE_FULL, 1,
+			[Define to 1 if you need g_list_free_full() function.]))
 	AC_SUBST(GLIB_CFLAGS)
 	AC_SUBST(GLIB_LIBS)
 ])
diff --git a/src/glib-compat.h b/src/glib-compat.h
index d50d5e9..b54d640 100644
--- a/src/glib-compat.h
+++ b/src/glib-compat.h
@@ -28,3 +28,11 @@ static inline void g_slist_free_full(GSList *list, GDestroyNotify free_func)
 	g_slist_free(list);
 }
 #endif
+
+#ifdef NEED_G_LIST_FREE_FULL
+static inline void g_list_free_full(GList *list, GDestroyNotify free_func)
+{
+	g_list_foreach(list, (GFunc) free_func, NULL);
+	g_list_free(list);
+}
+#endif
-- 
1.7.8.4

