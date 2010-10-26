Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH] Add separate queries for listing size in PBAP
Date: Tue, 26 Oct 2010 10:42:12 +0300
Message-Id: <1288078932-9547-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previosly to get phonebook-size or call history size, full phonebook
query was used and a lot of unnecessary operations need to be done on
that returned data.  Now separate query is used to get size of each
listing so performance for "getPhonebookSize" operations improved a lot.
---
 plugins/phonebook-tracker.c |  107 ++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 105 insertions(+), 2 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index a6e21f8..1919698 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -45,6 +45,7 @@
 #define TRACKER_DEFAULT_CONTACT_ME "http://www.semanticdesktop.org/ontologies/2007/03/22/nco#default-contact-me"
 #define CONTACTS_ID_COL 38
 #define PULL_QUERY_COL_AMOUNT 39
+#define COUNT_QUERY_COL_AMOUNT 1
 #define COL_HOME_NUMBER 0
 #define COL_HOME_EMAIL 7
 #define COL_WORK_NUMBER 8
@@ -580,6 +581,61 @@
 		"<%s> nco:hasPhoneNumber ?t . "				\
 	"} "
 
+#define CONTACTS_COUNT_QUERY						\
+	"SELECT COUNT(?c) "						\
+	"WHERE {"							\
+		"?c a nco:PersonContact ."				\
+		"FILTER (regex(str(?c), \"contact:\") || "		\
+		"regex(str(?c), \"nco#default-contact-me\"))"		\
+	"}"
+
+#define MISSED_CALLS_COUNT_QUERY					\
+	"SELECT COUNT(?call) WHERE {"					\
+		"?c a nco:Contact ;"					\
+		"nco:hasPhoneNumber ?h ."				\
+		"?call a nmo:Call ;"					\
+		"nmo:isSent false ;"					\
+		"nmo:from ?c ;"						\
+		"nmo:isAnswered false ."				\
+	"}"
+
+
+#define INCOMING_CALLS_COUNT_QUERY					\
+	"SELECT COUNT(?call) WHERE {"					\
+		"?c a nco:Contact ;"					\
+		"nco:hasPhoneNumber ?h ."				\
+		"?call a nmo:Call ;"					\
+		"nmo:isSent false ;"					\
+		"nmo:from ?c ;"						\
+		"nmo:isAnswered true ."					\
+	"}"
+
+#define OUTGOING_CALLS_COUNT_QUERY					\
+	"SELECT COUNT(?call) WHERE {"					\
+		"?c a nco:Contact ;"					\
+		"nco:hasPhoneNumber ?h ."				\
+		"?call a nmo:Call ;"					\
+		"nmo:isSent true ;"					\
+		"nmo:to ?c ."						\
+	"}"
+
+
+#define COMBINED_CALLS_COUNT_QUERY					\
+	"SELECT COUNT(?call) WHERE {"					\
+	"{"								\
+		"?c a nco:Contact ;"					\
+		"nco:hasPhoneNumber ?h ."				\
+		"?call a nmo:Call ;"					\
+		"nmo:isSent true ;"					\
+		"nmo:to ?c ."						\
+	"}UNION {"							\
+		"?c a nco:Contact ;"					\
+		"nco:hasPhoneNumber ?h ."				\
+		"?call a nmo:Call ;"					\
+		"nmo:from ?c ."						\
+	"}"								\
+	"}"
+
 typedef void (*reply_list_foreach_t) (char **reply, int num_fields,
 		void *user_data);
 
@@ -634,6 +690,22 @@ static const char *name2query(const char *name)
 	return NULL;
 }
 
+static const char *name2count_query(const char *name)
+{
+	if (g_str_equal(name, "telecom/pb.vcf"))
+		return CONTACTS_COUNT_QUERY;
+	else if (g_str_equal(name, "telecom/ich.vcf"))
+		return INCOMING_CALLS_COUNT_QUERY;
+	else if (g_str_equal(name, "telecom/och.vcf"))
+		return OUTGOING_CALLS_COUNT_QUERY;
+	else if (g_str_equal(name, "telecom/mch.vcf"))
+		return MISSED_CALLS_COUNT_QUERY;
+	else if (g_str_equal(name, "telecom/cch.vcf"))
+		return COMBINED_CALLS_COUNT_QUERY;
+
+	return NULL;
+}
+
 static gboolean folder_is_valid(const char *folder)
 {
 	if (folder == NULL)
@@ -1023,6 +1095,26 @@ static GString *gen_vcards(GSList *contacts,
 	return vcards;
 }
 
+static void pull_contacts_size (char **reply, int num_fields, void *user_data)
+{
+	struct phonebook_data *data = user_data;
+
+	if (num_fields < 0) {
+		data->cb(NULL, 0, num_fields, 0, data->user_data);
+		goto fail;
+	}
+
+	if (reply != NULL) {
+		data->index = atoi(reply[0]);
+		return;
+	}
+
+	data->cb(NULL, 0, data->index, 0, data->user_data);
+
+fail:
+	g_free(data);
+}
+
 static void pull_contacts(char **reply, int num_fields, void *user_data)
 {
 	struct phonebook_data *data = user_data;
@@ -1285,10 +1377,21 @@ int phonebook_pull(const char *name, const struct apparam_field *params,
 {
 	struct phonebook_data *data;
 	const char *query;
+	reply_list_foreach_t pull_cb;
+	int col_amount;
 
 	DBG("name %s", name);
 
-	query = name2query(name);
+	if (params->maxlistcount == 0) {
+		query = name2count_query(name);
+		col_amount = COUNT_QUERY_COL_AMOUNT;
+		pull_cb = pull_contacts_size;
+	} else {
+		query = name2query(name);
+		col_amount = PULL_QUERY_COL_AMOUNT;
+		pull_cb = pull_contacts;
+	}
+
 	if (query == NULL)
 		return -ENOENT;
 
@@ -1297,7 +1400,7 @@ int phonebook_pull(const char *name, const struct apparam_field *params,
 	data->user_data = user_data;
 	data->cb = cb;
 
-	return query_tracker(query, PULL_QUERY_COL_AMOUNT, pull_contacts, data);
+	return query_tracker(query, col_amount, pull_cb, data);
 }
 
 int phonebook_get_entry(const char *folder, const char *id,
-- 
1.7.0.4

