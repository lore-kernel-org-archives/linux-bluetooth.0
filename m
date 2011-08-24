Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd] Simplify counting new missed calls
Date: Wed, 24 Aug 2011 12:12:23 +0200
Message-Id: <1314180743-10067-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This replaces parsing missed calls listing that was used to get the number of
missed calls that have been unread with a simple SPARQL query.

Previous code was trying to deal with misbehaviour of commhistoryd but still
was failing in some cases. commhistoryd is now fixed.
---
 plugins/phonebook-tracker.c |  105 +++++++++----------------------------------
 1 files changed, 22 insertions(+), 83 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 875901c..1fd8c8b 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -50,7 +50,6 @@
 #define ADDR_FIELD_AMOUNT 7
 #define PULL_QUERY_COL_AMOUNT 23
 #define COUNT_QUERY_COL_AMOUNT 1
-#define NEW_MISSED_CALLS_COL_AMOUNT 3
 
 #define COL_PHONE_AFF 0 /* work/home phone numbers */
 #define COL_FULL_NAME 1
@@ -408,42 +407,16 @@ COMBINED_CONSTRAINT		\
 	"}"								\
 	"}"
 
-#define NEW_MISSED_CALLS_LIST						\
-	"SELECT ?c "							\
-	"nco:phoneNumber(?h) "						\
-	"nmo:isRead(?call) "						\
-	"WHERE { "							\
-	"{"								\
-		"?c a nco:Contact . "					\
-		"?c nco:hasPhoneNumber ?h . "				\
-		"?call a nmo:Call ; "					\
-		"nmo:from ?c ; "					\
-		"nmo:isSent false ; "					\
-		"nmo:isAnswered false ."				\
-	"}UNION{"							\
-		"?x a nco:Contact . "					\
-		"?x nco:hasPhoneNumber ?h . "				\
-		"?call a nmo:Call ; "					\
-		"nmo:from ?x ; "					\
-		"nmo:isSent false ; "					\
-		"nmo:isAnswered false ."				\
-		"?c a nco:PersonContact . "				\
-		"?c nco:hasPhoneNumber ?h . "				\
-	"} UNION { "							\
-		"?x a nco:Contact . "					\
-		"?x nco:hasPhoneNumber ?h . "				\
-		"?call a nmo:Call ; "					\
-		"nmo:from ?x ; "					\
-		"nmo:isSent false ; "					\
-		"nmo:isAnswered false ."				\
-		"?c a nco:PersonContact . "				\
-		"?c nco:hasAffiliation ?a . "				\
-		"?a nco:hasPhoneNumber ?no . "				\
-		"?h maemo:localPhoneNumber ?num . "			\
-		"?no maemo:localPhoneNumber ?num . "			\
-	"} "								\
-	"} GROUP BY ?call ORDER BY DESC(nmo:receivedDate(?call)) "	\
-	"LIMIT 40"
+#define NEW_MISSED_CALLS_COUNT_QUERY					\
+	"SELECT COUNT(?call) WHERE {"					\
+		"?c a nco:Contact ;"					\
+		"nco:hasPhoneNumber ?h ."				\
+		"?call a nmo:Call ;"					\
+		"nmo:isSent false ;"					\
+		"nmo:from ?c ;"						\
+		"nmo:isAnswered false ;"				\
+		"nmo:isRead false ."					\
+	"}"
 
 typedef int (*reply_list_foreach_t) (const char **reply, int num_fields,
 							void *user_data);
@@ -469,7 +442,6 @@ struct phonebook_data {
 	gboolean vcardentry;
 	const struct apparam_field *params;
 	GSList *contacts;
-	GSList *numbers;
 	phonebook_cache_ready_cb ready_cb;
 	phonebook_entry_cb entry_cb;
 	int newmissedcalls;
@@ -1428,30 +1400,6 @@ done:
 	return path;
 }
 
-static gboolean find_checked_number(GSList *numbers, const char *number)
-{
-	GSList *l;
-
-	for (l = numbers; l; l = l->next) {
-		GString *ph_num = l->data;
-		if (g_strcmp0(ph_num->str, number) == 0)
-			return TRUE;
-	}
-
-	return FALSE;
-}
-
-static void gstring_free_helper(gpointer data)
-{
-	g_string_free(data, TRUE);
-}
-
-static void free_data_numbers(struct phonebook_data *data)
-{
-	g_slist_free_full(data->numbers, gstring_free_helper);
-	data->numbers = NULL;
-}
-
 static int pull_newmissedcalls(const char **reply, int num_fields,
 							void *user_data)
 {
@@ -1459,29 +1407,21 @@ static int pull_newmissedcalls(const char **reply, int num_fields,
 	reply_list_foreach_t pull_cb;
 	int col_amount, err;
 	const char *query;
+	int nmissed;
 
-	if (num_fields < 0 || reply == NULL)
-		goto done;
+	if (num_fields < 0) {
+		data->cb(NULL, 0, num_fields, 0, TRUE, data->user_data);
 
-	if (!find_checked_number(data->numbers, reply[1])) {
-		if (g_strcmp0(reply[2], "false") == 0)
-			data->newmissedcalls++;
-		else {
-			GString *number = g_string_new(reply[1]);
-			data->numbers = g_slist_prepend(data->numbers,
-								number);
-		}
+		return -EINTR;
 	}
 
-	return 0;
-
-done:
-	DBG("newmissedcalls %d", data->newmissedcalls);
-	free_data_numbers(data);
+	if (reply != NULL) {
+		nmissed = atoi(reply[0]);
+		data->newmissedcalls =
+			nmissed <= UINT8_MAX ? nmissed : UINT8_MAX;
+		DBG("newmissedcalls %d", data->newmissedcalls);
 
-	if (num_fields < 0) {
-		data->cb(NULL, 0, num_fields, 0, TRUE, data->user_data);
-		return -EINTR;
+		return 0;
 	}
 
 	if (data->params->maxlistcount == 0) {
@@ -1519,7 +1459,6 @@ void phonebook_req_finalize(void *request)
 		g_object_unref(data->query_canc);
 	}
 
-	free_data_numbers(data);
 	free_data_contacts(data);
 	g_free(data->req_name);
 	g_free(data);
@@ -1563,8 +1502,8 @@ int phonebook_pull_read(void *request)
 		/* new missed calls amount should be counted only once - it
 		 * will be done during generating first part of results of
 		 * missed calls history */
-		query = NEW_MISSED_CALLS_LIST;
-		col_amount = NEW_MISSED_CALLS_COL_AMOUNT;
+		query = NEW_MISSED_CALLS_COUNT_QUERY;
+		col_amount = COUNT_QUERY_COL_AMOUNT;
 		pull_cb = pull_newmissedcalls;
 	} else if (data->params->maxlistcount == 0) {
 		query = name2count_query(data->req_name);
-- 
1.7.4.1

