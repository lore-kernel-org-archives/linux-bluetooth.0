Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <syamsidhardh@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <syamsidhardh@gmail.com>
Subject: [PATCH obexd 1/3] Remove redundant copy of GSlist* from functions
Date: Thu, 11 Aug 2011 00:13:26 +0530
Message-Id: <1313001808-29597-1-git-send-email-syamsidhardh@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Local copy of the pointer to list is not required, because these
functions already has a copy, through the arguments.
---
 plugins/phonebook-tracker.c |   31 ++++++++++++-------------------
 src/service.c               |    8 +++-----
 src/service.h               |    2 +-
 3 files changed, 16 insertions(+), 25 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 8bc070f..79458a3 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -783,13 +783,11 @@ static gboolean contact_matches(struct contact_data *c_data, const char *id,
 	return (cmp_ret == 0) ? TRUE : FALSE;
 }
 
-static struct phonebook_contact *find_contact(GSList *contacts, const char *id,
+static struct phonebook_contact *find_contact(GSList *list, const char *id,
 							const char *datetime)
 {
-	GSList *l;
-
-	for (l = contacts; l; l = l->next) {
-		struct contact_data *c_data = l->data;
+	for (; list; list = list->next) {
+		struct contact_data *c_data = list->data;
 
 		if (contact_matches(c_data, id, datetime))
 			return c_data->contact;
@@ -798,13 +796,11 @@ static struct phonebook_contact *find_contact(GSList *contacts, const char *id,
 	return NULL;
 }
 
-static struct phonebook_field *find_field(GSList *fields, const char *value,
+static struct phonebook_field *find_field(GSList *list, const char *value,
 								int type)
 {
-	GSList *l;
-
-	for (l = fields; l; l = l->next) {
-		struct phonebook_field *field = l->data;
+	for (; list; list = list->next) {
+		struct phonebook_field *field = list->data;
 		/* Returning phonebook number if phone values and type values
 		 * are equal */
 		if (g_strcmp0(field->text, value) == 0 && field->type == type)
@@ -892,17 +888,16 @@ static void add_url(struct phonebook_contact *contact, const char *url_val,
 	contact->urls = g_slist_append(contact->urls, url);
 }
 
-static GString *gen_vcards(GSList *contacts,
+static GString *gen_vcards(GSList *list,
 					const struct apparam_field *params)
 {
-	GSList *l;
 	GString *vcards;
 
 	vcards = g_string_new(NULL);
 
 	/* Generating VCARD string from contacts and freeing used contacts */
-	for (l = contacts; l; l = l->next) {
-		struct contact_data *c_data = l->data;
+	for (; list; list = list->next) {
+		struct contact_data *c_data = list->data;
 		phonebook_add_contact(vcards, c_data->contact,
 					params->filter, params->format);
 	}
@@ -1428,12 +1423,10 @@ done:
 	return path;
 }
 
-static gboolean find_checked_number(GSList *numbers, const char *number)
+static gboolean find_checked_number(GSList *list, const char *number)
 {
-	GSList *l;
-
-	for (l = numbers; l; l = l->next) {
-		GString *ph_num = l->data;
+	for (; list; list = list->next) {
+		GString *ph_num = list->data;
 		if (g_strcmp0(ph_num->str, number) == 0)
 			return TRUE;
 	}
diff --git a/src/service.c b/src/service.c
index f7c5a61..8cf5b27 100644
--- a/src/service.c
+++ b/src/service.c
@@ -37,14 +37,12 @@
 
 static GSList *drivers = NULL;
 
-struct obex_service_driver *obex_service_driver_find(GSList *drivers,
+struct obex_service_driver *obex_service_driver_find(GSList *list,
 			const uint8_t *target, unsigned int target_size,
 			const uint8_t *who, unsigned int who_size)
 {
-	GSList *l;
-
-	for (l = drivers; l; l = l->next) {
-		struct obex_service_driver *driver = l->data;
+	for (; list; list = list->next) {
+		struct obex_service_driver *driver = list->data;
 
 		/* who is optional, so only check for it if not NULL */
 		if (who != NULL && memncmp0(who, who_size, driver->who,
diff --git a/src/service.h b/src/service.h
index 6633be3..3906cfd 100644
--- a/src/service.h
+++ b/src/service.h
@@ -48,6 +48,6 @@ struct obex_service_driver {
 int obex_service_driver_register(struct obex_service_driver *driver);
 void obex_service_driver_unregister(struct obex_service_driver *driver);
 GSList *obex_service_driver_list(uint16_t services);
-struct obex_service_driver *obex_service_driver_find(GSList *drivers,
+struct obex_service_driver *obex_service_driver_find(GSList *list,
 			const uint8_t *target, unsigned int target_size,
 			const uint8_t *who, unsigned int who_size);
-- 
1.7.4.1

