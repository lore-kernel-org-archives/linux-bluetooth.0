Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH] Fix multiple phone number problem in pull vcard
Date: Tue, 10 Aug 2010 10:23:20 +0300
Message-Id: <1281425000-2029-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
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
 plugins/phonebook-tracker.c |  130 ++++++++++++++++++++++++++++++++++++-------
 1 files changed, 109 insertions(+), 21 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index f2b9649..3a90d30 100644
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
@@ -275,13 +278,18 @@ struct pending_reply {
 	int num_fields;
 };
 
+struct contact_data {
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
@@ -545,20 +553,103 @@ static void set_call_type(struct phonebook_contact *contact,
 	contact->datetime = iso8601_utc_to_localtime(datetime);
 }
 
+static struct phonebook_contact *find_contact(GSList *contacts, const char *id)
+{
+	GSList *l;
+	struct contact_data *c_data;
+
+	for (l = contacts; l; l = l->next) {
+		c_data = l->data;
+		if (g_strcmp0(c_data->id, id) == 0)
+			return c_data->contact;
+	}
+
+	return NULL;
+}
+
+static struct phonebook_number *find_phone(GSList *numbers, const char *phone,
+		int type)
+{
+	GSList *l;
+	struct phonebook_number *pb_num;
+
+	for (l = numbers; l; l = l->next) {
+		pb_num = l->data;
+		/* Returning phonebook number if phone values and type values
+		 * are equal */
+		if (g_strcmp0(pb_num->tel, phone) == 0 && pb_num->type == type)
+			return pb_num;
+	}
+
+	return NULL;
+}
+
+static void add_phone_number(struct phonebook_contact *contact,
+		const char *phone, int type)
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
+static GString *gen_vcards(GSList *contacts,
+		const struct apparam_field *params)
+{
+	GSList *l;
+	GString *vcards;
+	struct contact_data *c_data;
+
+	vcards = g_string_new(NULL);
+
+	/* Generating VCARD string from contacts and freeing used contacts */
+	for (l = contacts; l; l = l->next) {
+		c_data = l->data;
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
@@ -603,33 +694,32 @@ add_entry:
 
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
@@ -775,7 +865,6 @@ int phonebook_pull(const char *name, const struct apparam_field *params,
 		return -ENOENT;
 
 	data = g_new0(struct phonebook_data, 1);
-	data->vcards = g_string_new(NULL);
 	data->params = params;
 	data->user_data = user_data;
 	data->cb = cb;
@@ -794,7 +883,6 @@ int phonebook_get_entry(const char *folder, const char *id,
 	DBG("folder %s id %s", folder, id);
 
 	data = g_new0(struct phonebook_data, 1);
-	data->vcards = g_string_new(NULL);
 	data->user_data = user_data;
 	data->params = params;
 	data->cb = cb;
-- 
1.7.0.4

