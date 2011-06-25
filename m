Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <syamsidhardh@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <syamsidhardh@gmail.com>
Subject: [PATCH obexd] Remove redundant copy of GSlist* from functions
Date: Sat, 25 Jun 2011 05:44:30 +0530
Message-Id: <1308960870-17615-1-git-send-email-syamsidhardh@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Local copy of the pointer to list is not required, because these
functions already has a copy, through the arguments.
---
 gdbus/object.c              |    6 ++----
 plugins/phonebook-tracker.c |   23 ++++++++---------------
 src/service.c               |    6 ++----
 3 files changed, 12 insertions(+), 23 deletions(-)

diff --git a/gdbus/object.c b/gdbus/object.c
index d17a101..55cdc5f 100644
--- a/gdbus/object.c
+++ b/gdbus/object.c
@@ -402,13 +402,11 @@ static void generic_unregister(DBusConnection *connection, void *user_data)
 static struct interface_data *find_interface(GSList *interfaces,
 						const char *name)
 {
-	GSList *list;
-
 	if (name == NULL)
 		return NULL;
 
-	for (list = interfaces; list; list = list->next) {
-		struct interface_data *iface = list->data;
+	for (; interfaces; interfaces = interfaces->next) {
+		struct interface_data *iface = interfaces->data;
 		if (!strcmp(name, iface->name))
 			return iface;
 	}
diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index d396203..8f93242 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -781,10 +781,8 @@ static gboolean contact_matches(struct contact_data *c_data, const char *id,
 static struct phonebook_contact *find_contact(GSList *contacts, const char *id,
 							const char *datetime)
 {
-	GSList *l;
-
-	for (l = contacts; l; l = l->next) {
-		struct contact_data *c_data = l->data;
+	for (; contacts; contacts = contacts->next) {
+		struct contact_data *c_data = contacts->data;
 
 		if (contact_matches(c_data, id, datetime))
 			return c_data->contact;
@@ -796,10 +794,8 @@ static struct phonebook_contact *find_contact(GSList *contacts, const char *id,
 static struct phonebook_field *find_field(GSList *fields, const char *value,
 								int type)
 {
-	GSList *l;
-
-	for (l = fields; l; l = l->next) {
-		struct phonebook_field *field = l->data;
+	for (; fields; fields = fields->next) {
+		struct phonebook_field *field = fields->data;
 		/* Returning phonebook number if phone values and type values
 		 * are equal */
 		if (g_strcmp0(field->text, value) == 0 && field->type == type)
@@ -890,14 +886,13 @@ static void add_url(struct phonebook_contact *contact, const char *url_val,
 static GString *gen_vcards(GSList *contacts,
 					const struct apparam_field *params)
 {
-	GSList *l;
 	GString *vcards;
 
 	vcards = g_string_new(NULL);
 
 	/* Generating VCARD string from contacts and freeing used contacts */
-	for (l = contacts; l; l = l->next) {
-		struct contact_data *c_data = l->data;
+	for (; contacts; contacts = contacts->next) {
+		struct contact_data *c_data = contacts->data;
 		phonebook_add_contact(vcards, c_data->contact,
 					params->filter, params->format);
 	}
@@ -1424,10 +1419,8 @@ done:
 
 static gboolean find_checked_number(GSList *numbers, const char *number)
 {
-	GSList *l;
-
-	for (l = numbers; l; l = l->next) {
-		GString *ph_num = l->data;
+	for (; numbers; numbers = numbers->next) {
+		GString *ph_num = numbers->data;
 		if (g_strcmp0(ph_num->str, number) == 0)
 			return TRUE;
 	}
diff --git a/src/service.c b/src/service.c
index f7c5a61..a45c303 100644
--- a/src/service.c
+++ b/src/service.c
@@ -41,10 +41,8 @@ struct obex_service_driver *obex_service_driver_find(GSList *drivers,
 			const uint8_t *target, unsigned int target_size,
 			const uint8_t *who, unsigned int who_size)
 {
-	GSList *l;
-
-	for (l = drivers; l; l = l->next) {
-		struct obex_service_driver *driver = l->data;
+	for (; drivers; drivers = drivers->next) {
+		struct obex_service_driver *driver = drivers->data;
 
 		/* who is optional, so only check for it if not NULL */
 		if (who != NULL && memncmp0(who, who_size, driver->who,
-- 
1.7.4.1

