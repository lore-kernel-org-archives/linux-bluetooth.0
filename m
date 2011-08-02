Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 1/6 v3] Make use of g_slist_free_full when elements are dynamically-allocated
Date: Tue,  2 Aug 2011 13:00:06 +0300
Message-Id: <1312279206-15500-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This avoid having to iterate twice in the list to free its elements.
---
 Makefile.am                 |    2 +-
 configure.ac                |    4 ++++
 plugins/bluetooth.c         |    9 ++++-----
 plugins/pbap.c              |    8 +++++---
 plugins/phonebook-dummy.c   |    4 ++--
 plugins/phonebook-ebook.c   |    1 +
 plugins/phonebook-tracker.c |    6 +++---
 plugins/vcard.c             |   22 ++++++++++------------
 src/glib-helper.h           |   30 ++++++++++++++++++++++++++++++
 tools/test-server.c         |    2 ++
 10 files changed, 62 insertions(+), 26 deletions(-)
 create mode 100644 src/glib-helper.h

diff --git a/Makefile.am b/Makefile.am
index 049fc10..d47a6bc 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -81,7 +81,7 @@ libexec_PROGRAMS += src/obexd
 
 src_obexd_SOURCES = $(gdbus_sources) $(builtin_sources) $(btio_sources) \
 			$(gobex_sources) src/main.c src/obexd.h \
-			src/plugin.h src/plugin.c \
+			src/glib-helper.h src/plugin.h src/plugin.c \
 			src/log.h src/log.c src/dbus.h src/manager.c \
 			src/obex.h src/obex.c src/obex-priv.h \
 			src/mimetype.h src/mimetype.c \
diff --git a/configure.ac b/configure.ac
index 708e40b..962e2e7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -71,6 +71,10 @@ AC_CHECK_LIB(dl, dlopen, dummy=yes,
 
 PKG_CHECK_MODULES(GLIB, glib-2.0 >= 2.16, dummy=yes,
 				AC_MSG_ERROR(libglib 2.16 or later is required))
+AC_CHECK_LIB(glib-2.0, g_slist_free_full, dummy=yes,
+		AC_DEFINE(NEED_G_SLIST_FREE_FULL, 1,
+			[Define to 1 if you need g_slist_free_full()
+			function.]))
 AC_SUBST(GLIB_CFLAGS)
 AC_SUBST(GLIB_LIBS)
 
diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index b126717..1fccf3e 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -42,6 +42,7 @@
 #include "service.h"
 #include "log.h"
 #include "btio.h"
+#include "glib-helper.h"
 
 #define BT_RX_MTU 32767
 #define BT_TX_MTU 32767
@@ -546,7 +547,7 @@ static void *bluetooth_start(struct obex_server *server, int *err)
 	return ios;
 }
 
-static void stop(gpointer data, gpointer user_data)
+static void stop(gpointer data)
 {
 	GIOChannel *io = data;
 
@@ -558,8 +559,7 @@ static void bluetooth_stop(void *data)
 {
 	GSList *ios = data;
 
-	g_slist_foreach(ios, stop, NULL);
-	g_slist_free(ios);
+	g_slist_free_full(ios, stop);
 }
 
 static struct obex_transport_driver driver = {
@@ -589,8 +589,7 @@ static void bluetooth_exit(void)
 	g_dbus_remove_watch(connection, listener_id);
 
 	if (any) {
-		g_slist_foreach(any->services, (GFunc) g_free, NULL);
-		g_slist_free(any->services);
+		g_slist_free_full(any->services, g_free);
 		g_free(any->path);
 		g_free(any);
 	}
diff --git a/plugins/pbap.c b/plugins/pbap.c
index 4892d7a..e10fa8c 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -48,6 +48,7 @@
 #include "mimetype.h"
 #include "filesystem.h"
 #include "dbus.h"
+#include "glib-helper.h"
 
 #define PHONEBOOK_TYPE		"x-bt/phonebook"
 #define VCARDLISTING_TYPE	"x-bt/vcard-listing"
@@ -160,8 +161,10 @@ static const uint8_t PBAP_TARGET[TARGET_SIZE] = {
 typedef int (*cache_entry_find_f) (const struct cache_entry *entry,
 			const char *value);
 
-static void cache_entry_free(struct cache_entry *entry)
+static void cache_entry_free(void *data)
 {
+	struct cache_entry *entry = data;
+
 	g_free(entry->id);
 	g_free(entry->name);
 	g_free(entry->sound);
@@ -222,8 +225,7 @@ static const char *cache_find(struct cache *cache, uint32_t handle)
 
 static void cache_clear(struct cache *cache)
 {
-	g_slist_foreach(cache->entries, (GFunc) cache_entry_free, NULL);
-	g_slist_free(cache->entries);
+	g_slist_free_full(cache->entries, cache_entry_free);
 	cache->entries = NULL;
 }
 
diff --git a/plugins/phonebook-dummy.c b/plugins/phonebook-dummy.c
index ede4643..d026c5a 100644
--- a/plugins/phonebook-dummy.c
+++ b/plugins/phonebook-dummy.c
@@ -43,6 +43,7 @@
 
 #include "log.h"
 #include "phonebook.h"
+#include "glib-helper.h"
 
 typedef void (*vcard_func_t) (const char *file, VObject *vo, void *user_data);
 
@@ -186,8 +187,7 @@ static int foreach_vcard(DIR *dp, vcard_func_t func, uint16_t offset,
 		close(fd);
 	}
 
-	g_slist_foreach(sorted, (GFunc) g_free, NULL);
-	g_slist_free(sorted);
+	g_slist_free_full(sorted, g_free);
 
 	if (count)
 		*count = n;
diff --git a/plugins/phonebook-ebook.c b/plugins/phonebook-ebook.c
index 683037a..e53da12 100644
--- a/plugins/phonebook-ebook.c
+++ b/plugins/phonebook-ebook.c
@@ -40,6 +40,7 @@
 #include "obex.h"
 #include "service.h"
 #include "phonebook.h"
+#include "glib-helper.h"
 
 #define QUERY_FN "(contains \"family_name\" \"%s\")"
 #define QUERY_NAME "(contains \"given_name\" \"%s\")"
diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 29dd05c..3ac1c44 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -38,6 +38,7 @@
 #include "phonebook.h"
 #include "dbus.h"
 #include "vcard.h"
+#include "glib-helper.h"
 
 #define TRACKER_SERVICE "org.freedesktop.Tracker1"
 #define TRACKER_RESOURCES_PATH "/org/freedesktop/Tracker1/Resources"
@@ -1440,15 +1441,14 @@ static gboolean find_checked_number(GSList *numbers, const char *number)
 	return FALSE;
 }
 
-static void gstring_free_helper(gpointer data, gpointer user_data)
+static void gstring_free_helper(gpointer data)
 {
 	g_string_free(data, TRUE);
 }
 
 static void free_data_numbers(struct phonebook_data *data)
 {
-	g_slist_foreach(data->numbers, gstring_free_helper, NULL);
-	g_slist_free(data->numbers);
+	g_slist_free_full(data->numbers, gstring_free_helper);
 	data->numbers = NULL;
 }
 
diff --git a/plugins/vcard.c b/plugins/vcard.c
index 30841b7..4d12687 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -19,6 +19,10 @@
  *
  */
 
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
 #include <string.h>
 #include <stdio.h>
 #include <stdlib.h>
@@ -30,6 +34,7 @@
 #include <gdbus.h>
 
 #include "vcard.h"
+#include "glib-helper.h"
 
 #define ADDR_FIELD_AMOUNT 7
 #define LEN_MAX 128
@@ -614,7 +619,7 @@ void phonebook_add_contact(GString *vcards, struct phonebook_contact *contact,
 }
 
 
-static void field_free(gpointer data, gpointer user_data)
+static void field_free(gpointer data)
 {
 	struct phonebook_field *field = data;
 
@@ -627,17 +632,10 @@ void phonebook_contact_free(struct phonebook_contact *contact)
 	if (contact == NULL)
 		return;
 
-	g_slist_foreach(contact->numbers, field_free, NULL);
-	g_slist_free(contact->numbers);
-
-	g_slist_foreach(contact->emails, field_free, NULL);
-	g_slist_free(contact->emails);
-
-	g_slist_foreach(contact->addresses, field_free, NULL);
-	g_slist_free(contact->addresses);
-
-	g_slist_foreach(contact->urls, field_free, NULL);
-	g_slist_free(contact->urls);
+	g_slist_free_full(contact->numbers, field_free);
+	g_slist_free_full(contact->emails, field_free);
+	g_slist_free_full(contact->addresses, field_free);
+	g_slist_free_full(contact->urls, field_free);
 
 	g_free(contact->uid);
 	g_free(contact->fullname);
diff --git a/src/glib-helper.h b/src/glib-helper.h
new file mode 100644
index 0000000..695d719
--- /dev/null
+++ b/src/glib-helper.h
@@ -0,0 +1,30 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef NEED_G_SLIST_FREE_FULL
+static inline void g_slist_free_full(GSList *list, GDestroyNotify free_func)
+{
+	g_slist_foreach(list, (GFunc) free_func, NULL);
+	g_slist_free(list);
+}
+#endif
diff --git a/tools/test-server.c b/tools/test-server.c
index 3b71ac0..87742ec 100644
--- a/tools/test-server.c
+++ b/tools/test-server.c
@@ -30,6 +30,8 @@
 
 #include <gobex/gobex.h>
 
+#include "glib-helper.h"
+
 static GMainLoop *main_loop = NULL;
 
 static GSList *clients = NULL;
-- 
1.7.6

