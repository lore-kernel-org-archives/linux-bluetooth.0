Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH 2/2] Fix multiple phone number problem in pull vcard
Date: Mon,  9 Aug 2010 14:17:31 +0300
Message-Id: <1281352651-30943-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes problem with pull vcard when contact has more than one home or
work number defined in tracker - more than one VCARD was generated in
response for pull vcard request. This was caused by nature of the data
retrieved from tracker - contact with multiple numbers set was returned as
many entries with identical id. Previously VCARDs was generated on the fly
- now added contact-data caching and checking for contact id. VCARD is now
generated when all responses of tracker were processed - and only one vcard
is returned for one contact entry.
---
 plugins/phonebook-tracker.c |  134 ++++++++++++++++++++++++++++++++++++-------
 1 files changed, 112 insertions(+), 22 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index f2b9649..1e197d7 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -43,6 +43,9 @@
 #define TRACKER_RESOURCES_INTERFACE "org.freedesktop.Tracker1.Resources"
 
 #define TRACKER_DEFAULT_CONTACT_ME "http://www.semanticdesktop.org/ontologies/2007/03/22/nco#default-contact-me"
+#define CONTACTS_ID_COL 19
+#define PHONE_ID_HOME 0
+#define PHONE_ID_WORK 3
 
 #define CONTACTS_QUERY_ALL						\
 	"SELECT nco:phoneNumber(?h) nco:fullname(?c) "			\
@@ -275,13 +278,19 @@ struct pending_reply {
 	int num_fields;
 };
 
+struct contact_data
+{
+	char *id;
+	struct phonebook_contact *contact;
+};
+
 struct phonebook_data {
-	GString *vcards;
 	phonebook_cb cb;
 	void *user_data;
 	int index;
 	gboolean vcardentry;
 	const struct apparam_field *params;
+	GSList *contacts;
 };
 
 struct cache_data {
@@ -545,20 +554,103 @@ static void set_call_type(struct phonebook_contact *contact,
 	contact->datetime = iso8601_utc_to_localtime(datetime);
 }
 
+static struct phonebook_contact *find_contact (GSList *contacts,char *id)
+{
+	GSList *it;
+	struct contact_data *c_data;
+
+	for(it = contacts; it; it = it->next) {
+		c_data = it->data;
+		if (g_strcmp0(c_data->id, id) == 0)
+			return c_data->contact;
+	}
+
+	return NULL;
+}
+
+static struct phonebook_number *find_phone(GSList *numbers, char *phone,
+		int type)
+{
+	GSList *it;
+	struct phonebook_number *pb_num;
+
+	for(it = numbers; it; it = it->next) {
+		pb_num = it->data;
+		/* Returning phonebook number if phone values and type values
+		 * are equal */
+		if (g_strcmp0(pb_num->tel, phone) == 0 && pb_num->type == type)
+			return pb_num;
+	}
+
+	return NULL;
+}
+
+static void add_phone_number(struct phonebook_contact *contact, char *phone,
+		int type)
+{
+	struct phonebook_number *number;
+
+	if (phone == NULL || strlen(phone) == 0)
+		return;
+
+	/* Not adding number if there is already added with the same value */
+	if (find_phone(contact->numbers, phone, type))
+		return;
+
+	number = g_new0(struct phonebook_number, 1);
+	number->tel = g_strdup(phone);
+	number->type = type;
+
+	contact->numbers = g_slist_append(contact->numbers, number);
+}
+
+static GString * gen_vcards(GSList *contacts,
+			const struct apparam_field *params)
+{
+	GSList *it;
+	GString *vcards;
+	struct contact_data *c_data;
+
+	vcards = g_string_new(NULL);
+
+	/* Generating VCARD string from contacts and freeing used contacts */
+	for(it = contacts; it; it = it->next) {
+		c_data = it->data;
+		phonebook_add_contact(vcards, c_data->contact,
+					params->filter, params->format);
+
+		g_free(c_data->id);
+		phonebook_contact_free(c_data->contact);
+	}
+
+	return vcards;
+}
+
 static void pull_contacts(char **reply, int num_fields, void *user_data)
 {
 	struct phonebook_data *data = user_data;
 	const struct apparam_field *params = data->params;
 	struct phonebook_contact *contact;
-	struct phonebook_number *number;
-	GString *vcards = data->vcards;
+	struct contact_data *contact_data;
+	GString *vcards;
 	int last_index, i;
+	gboolean cdata_present = FALSE;
 
 	DBG("reply %p", reply);
 
 	if (reply == NULL)
 		goto done;
 
+	/* Trying to find contact in recently added contacts. It is needed for
+	 * contacts that have more than one telephone number filled */
+	contact = find_contact(data->contacts, reply[CONTACTS_ID_COL]);
+
+	/* If contact is already created then adding only new phone numbers */
+	if (contact) {
+		cdata_present = TRUE;
+		goto add_numbers;
+	}
+
 	/* We are doing a PullvCardEntry, no need for those checks */
 	if (data->vcardentry)
 		goto add_entry;
@@ -603,33 +695,31 @@ add_entry:
 
 	set_call_type(contact, reply[16], reply[17], reply[18]);
 
-	number = g_new0(struct phonebook_number, 1);
-	number->tel = g_strdup(reply[0]);
-	number->type = 0; /* HOME */
-
-	contact->numbers = g_slist_append(contact->numbers, number);
-
-	/* Has WORK Phonenumber */
-	if (strlen(reply[8])) {
-		number = g_new0(struct phonebook_number, 1);
-		number->tel = g_strdup(reply[8]);
-		number->type = 3; /* WORK */
-
-		contact->numbers = g_slist_append(contact->numbers, number);
-	}
+add_numbers:
+	/* Adding phone numbers to contact struct */
+	add_phone_number(contact, reply[0], PHONE_ID_HOME);
+	add_phone_number(contact, reply[8], PHONE_ID_WORK);
 
 	DBG("contact %p", contact);
 
-	phonebook_add_contact(vcards, contact, params->filter, params->format);
-	phonebook_contact_free(contact);
-
+	/* Adding contacts data to wrapper struct - this data will be used to
+	 * generate vcard list */
+	if (!cdata_present) {
+		contact_data = g_new0(struct contact_data, 1);
+		contact_data->contact = contact;
+		contact_data->id = g_strdup(reply[CONTACTS_ID_COL]);
+		data->contacts = g_slist_append(data->contacts, contact_data);
+	}
 	return;
 
 done:
+	vcards = gen_vcards(data->contacts, params);
+
 	if (num_fields == 0)
 		data->cb(vcards->str, vcards->len, data->index, 0,
 							data->user_data);
 
+	g_slist_free(data->contacts);
 	g_string_free(vcards, TRUE);
 	g_free(data);
 }
@@ -775,10 +865,10 @@ int phonebook_pull(const char *name, const struct apparam_field *params,
 		return -ENOENT;
 
 	data = g_new0(struct phonebook_data, 1);
-	data->vcards = g_string_new(NULL);
 	data->params = params;
 	data->user_data = user_data;
 	data->cb = cb;
+	data->contacts = NULL;
 
 	return query_tracker(query, 20, pull_contacts, data);
 }
@@ -794,11 +884,11 @@ int phonebook_get_entry(const char *folder, const char *id,
 	DBG("folder %s id %s", folder, id);
 
 	data = g_new0(struct phonebook_data, 1);
-	data->vcards = g_string_new(NULL);
 	data->user_data = user_data;
 	data->params = params;
 	data->cb = cb;
 	data->vcardentry = TRUE;
+	data->contacts = NULL;
 
 	query = g_strdup_printf(CONTACTS_QUERY_FROM_URI, id, id, id, id, id,
 						id, id, id, id, id, id, id);
-- 
1.7.0.4

