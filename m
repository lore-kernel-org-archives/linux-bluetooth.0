Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 1/6] Make use of g_slist_free_full when elements are dynamically-allocated
Date: Mon, 18 Jul 2011 13:35:11 +0300
Message-Id: <1310985316-2197-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This avoid having to iterate twice in the list to free its elements.
---
 plugins/bluetooth.c         |    8 +++-----
 plugins/pbap.c              |    7 ++++---
 plugins/phonebook-dummy.c   |    3 +--
 plugins/phonebook-tracker.c |    5 ++---
 plugins/vcard.c             |   17 +++++------------
 5 files changed, 15 insertions(+), 25 deletions(-)

diff --git a/plugins/bluetooth.c b/plugins/bluetooth.c
index b126717..0c50a54 100644
--- a/plugins/bluetooth.c
+++ b/plugins/bluetooth.c
@@ -546,7 +546,7 @@ static void *bluetooth_start(struct obex_server *server, int *err)
 	return ios;
 }
 
-static void stop(gpointer data, gpointer user_data)
+static void stop(gpointer data)
 {
 	GIOChannel *io = data;
 
@@ -558,8 +558,7 @@ static void bluetooth_stop(void *data)
 {
 	GSList *ios = data;
 
-	g_slist_foreach(ios, stop, NULL);
-	g_slist_free(ios);
+	g_slist_free_full(ios, stop);
 }
 
 static struct obex_transport_driver driver = {
@@ -589,8 +588,7 @@ static void bluetooth_exit(void)
 	g_dbus_remove_watch(connection, listener_id);
 
 	if (any) {
-		g_slist_foreach(any->services, (GFunc) g_free, NULL);
-		g_slist_free(any->services);
+		g_slist_free_full(any->services, g_free);
 		g_free(any->path);
 		g_free(any);
 	}
diff --git a/plugins/pbap.c b/plugins/pbap.c
index 5455cce..1925b5f 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -160,8 +160,10 @@ static const uint8_t PBAP_TARGET[TARGET_SIZE] = {
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
@@ -222,8 +224,7 @@ static const char *cache_find(struct cache *cache, uint32_t handle)
 
 static void cache_clear(struct cache *cache)
 {
-	g_slist_foreach(cache->entries, (GFunc) cache_entry_free, NULL);
-	g_slist_free(cache->entries);
+	g_slist_free_full(cache->entries, cache_entry_free);
 	cache->entries = NULL;
 }
 
diff --git a/plugins/phonebook-dummy.c b/plugins/phonebook-dummy.c
index ede4643..035ec35 100644
--- a/plugins/phonebook-dummy.c
+++ b/plugins/phonebook-dummy.c
@@ -186,8 +186,7 @@ static int foreach_vcard(DIR *dp, vcard_func_t func, uint16_t offset,
 		close(fd);
 	}
 
-	g_slist_foreach(sorted, (GFunc) g_free, NULL);
-	g_slist_free(sorted);
+	g_slist_free_full(sorted, g_free);
 
 	if (count)
 		*count = n;
diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index d1f4cd7..2ff2056 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -1442,15 +1442,14 @@ static gboolean find_checked_number(GSList *numbers, const char *number)
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
index b997fc4..490d258 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -599,7 +599,7 @@ void phonebook_add_contact(GString *vcards, struct phonebook_contact *contact,
 }
 
 
-static void field_free(gpointer data, gpointer user_data)
+static void field_free(gpointer data)
 {
 	struct phonebook_field *field = data;
 
@@ -612,17 +612,10 @@ void phonebook_contact_free(struct phonebook_contact *contact)
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
-- 
1.7.6

