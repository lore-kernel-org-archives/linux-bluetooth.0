Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH 7/7 v2] Support for multipart response sending from phonebook-tracker
Date: Fri, 11 Feb 2011 16:05:39 +0200
Message-Id: <1297433139-10923-7-git-send-email-ext-jablonski.radoslaw@nokia.com>
In-Reply-To: <1297433139-10923-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
References: <1297433139-10923-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now data are being sent with smaller parts - vcard amount for
one part is defined in VCARDS_PART_COUNT. When one part of
data is sent, then data download from tracker is stopped.
It will be resumed when phonebook_pull_read will be called again.
This is needed to start sending data from PBAP quicker - now
transfer can be started when first part of data is processed.
Previously transfer was started when all results for response
were downloaded, and (for large responses) some PBAP clients
were disconnecting due to timeout.
---
 plugins/phonebook-tracker.c |   81 +++++++++++++++++++++++++++++++++---------
 1 files changed, 63 insertions(+), 18 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 48748f3..ab8d428 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -81,6 +81,8 @@
 #define MAIN_DELIM "\30" /* Main delimiter between phones, addresses, emails*/
 #define SUB_DELIM "\31" /* Delimiter used in telephone number strings*/
 #define MAX_FIELDS 100 /* Max amount of fields to be concatenated at once*/
+#define VCARDS_PART_COUNT 50 /* amount of vcards sent at once to PBAP core */
+#define QUERY_OFFSET_FORMAT "%s OFFSET %d"
 
 #define CONTACTS_QUERY_ALL						\
 "SELECT "								\
@@ -919,6 +921,8 @@ struct phonebook_data {
 	int newmissedcalls;
 	GCancellable *query_canc;
 	char *req_name;
+	int vcard_part_count;
+	int tracker_index;
 };
 
 struct phonebook_index {
@@ -1551,15 +1555,45 @@ static void contact_add_organization(struct phonebook_contact *contact,
 	add_affiliation(&contact->role, reply[COL_ORG_ROLE]);
 }
 
+static void free_data_contacts(struct phonebook_data *data)
+{
+	GSList *l;
+
+	/* freeing contacts */
+	for (l = data->contacts; l; l = l->next) {
+		struct contact_data *c_data = l->data;
+
+		g_free(c_data->id);
+		phonebook_contact_free(c_data->contact);
+		g_free(c_data);
+	}
+
+	g_slist_free(data->contacts);
+	data->contacts = NULL;
+}
+
+static void send_pull_part(struct phonebook_data *data,
+			const struct apparam_field *params, gboolean lastpart)
+{
+	GString *vcards;
+
+	DBG("");
+	vcards = gen_vcards(data->contacts, params);
+	data->cb(vcards->str, vcards->len, g_slist_length(data->contacts),
+			data->newmissedcalls, lastpart, data->user_data);
+
+	free_data_contacts(data);
+	g_string_free(vcards, TRUE);
+}
+
 static int pull_contacts(const char **reply, int num_fields, void *user_data)
 {
 	struct phonebook_data *data = user_data;
 	const struct apparam_field *params = data->params;
 	struct phonebook_contact *contact;
 	struct contact_data *contact_data;
-	GString *vcards;
 	int last_index, i;
-	gboolean cdata_present = FALSE;
+	gboolean cdata_present = FALSE, part_sent = FALSE;
 	static char *temp_id = NULL;
 
 	if (num_fields < 0) {
@@ -1568,6 +1602,7 @@ static int pull_contacts(const char **reply, int num_fields, void *user_data)
 	}
 
 	DBG("reply %p", reply);
+	data->tracker_index++;
 
 	if (reply == NULL)
 		goto done;
@@ -1600,6 +1635,25 @@ static int pull_contacts(const char **reply, int num_fields, void *user_data)
 		data->index++;
 		g_free(temp_id);
 		temp_id = g_strdup(reply[CONTACTS_ID_COL]);
+
+		/* Incrementing counter for vcards in current part of data,
+		 * but only if liststartoffset has been already reached */
+		if (data->index > params->liststartoffset)
+			data->vcard_part_count++;
+	}
+
+	if (data->vcard_part_count > VCARDS_PART_COUNT) {
+		DBG("Part of vcard data ready for sending...");
+		data->vcard_part_count = 0;
+		/* Sending part of data to PBAP core - more data can be still
+		 * fetched, so marking lastpart as FALSE */
+		send_pull_part(data, params, FALSE);
+
+		/* Later, after adding contact data, need to return -EINTR to
+		 * stop fetching more data for this request. Data will be
+		 * downloaded again from this point, when phonebook_pull_read
+		 * will be called again with current request as a parameter*/
+		part_sent = TRUE;
 	}
 
 	last_index = params->liststartoffset + params->maxlistcount;
@@ -1637,15 +1691,16 @@ add_numbers:
 		data->contacts = g_slist_append(data->contacts, contact_data);
 	}
 
+	if (part_sent)
+		return -EINTR;
+
 	return 0;
 
 done:
-	vcards = gen_vcards(data->contacts, params);
+	/* Processing is end, this is definitely last part of transmission
+	 * (marking lastpart as TRUE) */
+	send_pull_part(data, params, TRUE);
 
-	data->cb(vcards->str, vcards->len, g_slist_length(data->contacts),
-				data->newmissedcalls, TRUE, data->user_data);
-
-	g_string_free(vcards, TRUE);
 fail:
 	g_free(temp_id);
 	temp_id = NULL;
@@ -1797,7 +1852,6 @@ done:
 void phonebook_req_finalize(void *request)
 {
 	struct phonebook_data *data = request;
-	GSList *l;
 
 	DBG("");
 
@@ -1810,16 +1864,7 @@ void phonebook_req_finalize(void *request)
 		g_object_unref(data->query_canc);
 	}
 
-	/* freeing contacts */
-	for (l = data->contacts; l; l = l->next) {
-		struct contact_data *c_data = l->data;
-
-		g_free(c_data->id);
-		phonebook_contact_free(c_data->contact);
-		g_free(c_data);
-	}
-
-	g_slist_free(data->contacts);
+	free_data_contacts(data);
 	g_free(data->req_name);
 	g_free(data);
 }
-- 
1.7.0.4

