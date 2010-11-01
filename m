Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH 2/2] Add support for generating pull response in many parts
Date: Mon,  1 Nov 2010 12:54:59 +0200
Message-Id: <1288608899-23032-2-git-send-email-ext-jablonski.radoslaw@nokia.com>
In-Reply-To: <1288608899-23032-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
References: <1288608899-23032-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now data from tracker is fetched in many smaller parts (instead of one
big query before). This is needed to save memory and to not overload
dbus and tracker when generating query result.
---
 plugins/phonebook-tracker.c |   71 ++++++++++++++++++++++++++++++++++++-------
 1 files changed, 60 insertions(+), 11 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 58f52ab..46ef5fb 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -57,6 +57,8 @@
 #define COL_ANSWERED 37
 #define ADDR_FIELD_AMOUNT 7
 #define CONTACT_ID_PREFIX "contact:"
+#define QUERY_LIMIT_FORMAT "%s LIMIT %d OFFSET %d"
+#define QUERY_LIMIT 50
 
 #define CONTACTS_QUERY_ALL						\
 	"SELECT ?v nco:fullname(?c) "					\
@@ -650,6 +652,9 @@ struct phonebook_data {
 	gboolean vcardentry;
 	const struct apparam_field *params;
 	GSList *contacts;
+	char *name;
+	int offset;
+	int num_row;
 };
 
 struct cache_data {
@@ -1098,6 +1103,12 @@ static void add_affiliation(char **field, const char *value)
 	*field = g_strdup(value);
 }
 
+static char *gen_partial_query(const char *name, int limit, int offset)
+{
+	return g_strdup_printf(QUERY_LIMIT_FORMAT, name2query(name),
+				limit, offset);
+}
+
 static void pull_contacts(char **reply, int num_fields, void *user_data)
 {
 	struct phonebook_data *data = user_data;
@@ -1107,13 +1118,17 @@ static void pull_contacts(char **reply, int num_fields, void *user_data)
 	GString *vcards;
 	int last_index, i;
 	gboolean cdata_present = FALSE;
-	char *home_addr, *work_addr;
+	gboolean last_resp = FALSE;
+	char *home_addr, *work_addr, *query;
 
 	if (num_fields < 0) {
 		data->cb(NULL, 0, num_fields, 0, data->user_data);
 		goto fail;
 	}
 
+	data->num_row++;
+	last_index = params->liststartoffset + params->maxlistcount;
+
 	DBG("reply %p", reply);
 
 	if (reply == NULL)
@@ -1145,8 +1160,6 @@ static void pull_contacts(char **reply, int num_fields, void *user_data)
 
 	data->index++;
 
-	last_index = params->liststartoffset + params->maxlistcount;
-
 	if ((data->index <= params->liststartoffset ||
 						data->index > last_index) &&
 						params->maxlistcount > 0)
@@ -1222,14 +1235,46 @@ add_numbers:
 done:
 	vcards = gen_vcards(data->contacts, params);
 
-	if (num_fields == 0)
+	/* If tracker returned only empty row - all results already returned */
+	if (num_fields == 0 && data->num_row == 1)
+		last_resp = TRUE;
+
+	/* Check if tracker could return desired number of results - if coldn't,
+	 * all results are fetched already and this is last response */
+	if (data->num_row < QUERY_LIMIT)
+		last_resp = TRUE;
+
+	/* Check needed for 'maxlistcount' and 'liststartoffset' parameters */
+	if (data->index > last_index)
+		last_resp = TRUE;
+
+	/* Data won't be send if starting offset has not been achieved (unless
+	 * now handling last response from tracker) */
+	if (data->index > params->liststartoffset || last_resp)
+		/* 4th parameter of callback is used to mark if stream should be
+		 * closed or more data will be sent*/
 		data->cb(vcards->str, vcards->len,
-					g_slist_length(data->contacts), 0,
-					data->user_data);
+				g_slist_length(data->contacts), !last_resp,
+				data->user_data);
 
+	g_slist_free(data->contacts);data->contacts = NULL;
 	g_string_free(vcards, TRUE);
+	data->num_row = 0;
+
+	/* Sending query to tracker to get next part of results (only for pull
+	 * phonebook queries) */
+	if (!data->vcardentry && !last_resp) {
+		data->offset += QUERY_LIMIT;
+		query = gen_partial_query(data->name, QUERY_LIMIT,
+					data->offset);
+		query_tracker(query, PULL_QUERY_COL_AMOUNT,
+				pull_contacts, data);
+		g_free(query);
+		return;
+	}
 fail:
 	g_slist_free(data->contacts);
+	g_free(data->name);
 	g_free(data);
 }
 
@@ -1367,18 +1412,18 @@ int phonebook_pull(const char *name, const struct apparam_field *params,
 					phonebook_cb cb, void *user_data)
 {
 	struct phonebook_data *data;
-	const char *query;
+	char *query;
 	reply_list_foreach_t pull_cb;
-	int col_amount;
+	int col_amount, ret;
 
 	DBG("name %s", name);
 
 	if (params->maxlistcount == 0) {
-		query = name2count_query(name);
+		query = g_strdup(name2count_query(name));
 		col_amount = COUNT_QUERY_COL_AMOUNT;
 		pull_cb = pull_contacts_size;
 	} else {
-		query = name2query(name);
+		query = gen_partial_query(name, QUERY_LIMIT, 0);
 		col_amount = PULL_QUERY_COL_AMOUNT;
 		pull_cb = pull_contacts;
 	}
@@ -1390,8 +1435,12 @@ int phonebook_pull(const char *name, const struct apparam_field *params,
 	data->params = params;
 	data->user_data = user_data;
 	data->cb = cb;
+	data->name = g_strdup(name);
+
+	ret = query_tracker(query, col_amount, pull_cb, data);
+	g_free(query);
 
-	return query_tracker(query, col_amount, pull_cb, data);
+	return ret;
 }
 
 int phonebook_get_entry(const char *folder, const char *id,
-- 
1.7.0.4

