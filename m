Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd 1/2] Revert handling CALL-DATETIME in PullvCardEntry
Date: Wed, 13 Jul 2011 16:20:03 +0200
Message-Id: <1310566804-26748-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This reverts commit 02d8dea9490b8852b837e143a09891817a4965f9.
The constraints for pulling single vCard are to loose and causes other
numbers to be merged into same vCard. Also there is more elegant way of
applying the new changes.
---
 plugins/phonebook-tracker.c |   30 +++++++-----------------------
 1 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 4f0bc12..cab3822 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -75,7 +75,6 @@
 #define COL_ANSWERED 21
 #define CONTACTS_ID_COL 22
 #define CONTACT_ID_PREFIX "urn:uuid:"
-#define CALL_ID_PREFIX "message:"
 
 #define FAX_NUM_TYPE "http://www.semanticdesktop.org/ontologies/2007/03/22/nco#FaxNumber"
 #define MOBILE_NUM_TYPE "http://www.semanticdesktop.org/ontologies/2007/03/22/nco#CellPhoneNumber"
@@ -147,7 +146,7 @@
 	"SELECT ?c nco:nameFamily(?c) "					\
 	"nco:nameGiven(?c) nco:nameAdditional(?c) "			\
 	"nco:nameHonorificPrefix(?c) nco:nameHonorificSuffix(?c) "	\
-	"nco:phoneNumber(?h) \"NOTACALL\" "				\
+	"nco:phoneNumber(?h) "						\
 	"WHERE { "							\
 		"?c a nco:PersonContact . "				\
 	"OPTIONAL { ?c nco:hasPhoneNumber ?h . } "			\
@@ -186,7 +185,7 @@ CONSTRAINT								\
 	"nco:nameGiven(?_contact) nco:nameAdditional(?_contact) "	\
 	"nco:nameHonorificPrefix(?_contact) "				\
 	"nco:nameHonorificSuffix(?_contact) "				\
-	"nco:phoneNumber(?_cpn) ?_call"					\
+	"nco:phoneNumber(?_cpn) "					\
 CALLS_CONSTRAINTS(CONSTRAINT)						\
 "ORDER BY DESC(nmo:sentDate(?_call)) "
 
@@ -278,9 +277,6 @@ CALLS_CONSTRAINTS(CONSTRAINT)						\
 "	?_call nmo:isSent true "		\
 "} "
 
-#define CALL_URI_CONSTRAINT		\
-"FILTER (?_call = <%s>)	"
-
 #define MISSED_CALLS_QUERY CALLS_QUERY(MISSED_CONSTRAINT)
 #define MISSED_CALLS_LIST CALLS_LIST(MISSED_CONSTRAINT)
 #define INCOMING_CALLS_QUERY CALLS_QUERY(INCOMING_CONSTRAINT)
@@ -289,7 +285,6 @@ CALLS_CONSTRAINTS(CONSTRAINT)						\
 #define OUTGOING_CALLS_LIST CALLS_LIST(OUTGOING_CONSTRAINT)
 #define COMBINED_CALLS_QUERY CALLS_QUERY(COMBINED_CONSTRAINT)
 #define COMBINED_CALLS_LIST CALLS_LIST(COMBINED_CONSTRAINT)
-#define CONTACT_FROM_CALL_QUERY CALLS_QUERY(CALL_URI_CONSTRAINT)
 
 #define CONTACTS_QUERY_FROM_URI						\
 "SELECT "								\
@@ -477,7 +472,6 @@ struct phonebook_data {
 	char *req_name;
 	int vcard_part_count;
 	int tracker_index;
-	char *name;
 };
 
 struct phonebook_index {
@@ -1296,7 +1290,6 @@ static int add_to_cache(const char **reply, int num_fields, void *user_data)
 {
 	struct phonebook_data *data = user_data;
 	char *formatted;
-	const char *id;
 	int i;
 
 	if (reply == NULL || num_fields < 0)
@@ -1319,18 +1312,13 @@ static int add_to_cache(const char **reply, int num_fields, void *user_data)
 					reply[1], reply[2], reply[3], reply[4],
 					reply[5]);
 
-	if (g_str_equal(data->name, "/telecom/pb"))
-		id = reply[0];
-	else
-		id = reply[7];
-
 	/* The owner vCard must have the 0 handle */
 	if (strcmp(reply[0], TRACKER_DEFAULT_CONTACT_ME) == 0)
-		data->entry_cb(reply[0], 0, formatted, "", reply[6],
-							data->user_data);
+		data->entry_cb(reply[0], 0, formatted, "",
+						reply[6], data->user_data);
 	else
-		data->entry_cb(id, PHONEBOOK_INVALID_HANDLE, formatted,
-						"", reply[6], data->user_data);
+		data->entry_cb(reply[0], PHONEBOOK_INVALID_HANDLE, formatted,
+					"", reply[6], data->user_data);
 
 	g_free(formatted);
 
@@ -1530,7 +1518,6 @@ void phonebook_req_finalize(void *request)
 	free_data_numbers(data);
 	free_data_contacts(data);
 	g_free(data->req_name);
-	g_free(data->name);
 	g_free(data);
 }
 
@@ -1624,8 +1611,6 @@ void *phonebook_get_entry(const char *folder, const char *id,
 				g_strcmp0(id, TRACKER_DEFAULT_CONTACT_ME) == 0)
 		query = g_strdup_printf(CONTACTS_QUERY_FROM_URI, id, id, id, id,
 					id, id, id, id, id, id, id, id, id);
-	else if (g_str_has_prefix(id, CALL_ID_PREFIX) == TRUE)
-		query = g_strdup_printf(CONTACT_FROM_CALL_QUERY, id);
 	else
 		query = g_strdup_printf(CONTACTS_OTHER_QUERY_FROM_URI,
 								id, id, id);
@@ -1659,9 +1644,8 @@ void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 	data->entry_cb = entry_cb;
 	data->ready_cb = ready_cb;
 	data->user_data = user_data;
-	data->name = g_strdup(name);
 
-	ret = query_tracker(query, 8, add_to_cache, data);
+	ret = query_tracker(query, 7, add_to_cache, data);
 	if (err)
 		*err = ret;
 
-- 
1.7.4.1

