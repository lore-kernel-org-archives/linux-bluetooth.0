Return-Path: <cyrus@holtmann.org>
From: Harald Schmitt <linux@hschmitt.de>
To: linux-bluetooth@vger.kernel.org
Cc: Harald Schmitt <linux@hschmitt.de>
Subject: [PATCH 2/2] phonebook: Replace magic strings for phonebook names and folders
Date: Wed, 18 Jul 2012 16:53:08 +0200
Message-Id: <1342623188-10796-3-git-send-email-linux@hschmitt.de>
In-Reply-To: <1342623188-10796-1-git-send-email-linux@hschmitt.de>
References: <1342623188-10796-1-git-send-email-linux@hschmitt.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/irmc.c              |    4 ++--
 plugins/phonebook-ebook.c   |   14 ++++++-------
 plugins/phonebook-tracker.c |   48 +++++++++++++++++++++----------------------
 plugins/phonebook.h         |   13 ++++++++++++
 4 files changed, 46 insertions(+), 33 deletions(-)

diff --git a/plugins/irmc.c b/plugins/irmc.c
index 2283fe6..2574b22 100644
--- a/plugins/irmc.c
+++ b/plugins/irmc.c
@@ -226,7 +226,7 @@ static void *irmc_connect(struct obex_session *os, int *err)
 	param->maxlistcount = 0; /* to count the number of vcards... */
 	param->filter = 0x200085; /* UID TEL N VERSION */
 	irmc->params = param;
-	irmc->request = phonebook_pull("/telecom/pb.vcf", irmc->params,
+	irmc->request = phonebook_pull(PB_CONTACTS, irmc->params,
 					phonebook_size_result, irmc, err);
 	ret = phonebook_pull_read(irmc->request);
 	if (err)
@@ -312,7 +312,7 @@ static void *irmc_open_pb(const char *name, struct irmc_session *irmc,
 
 	if (!g_strcmp0(name, ".vcf")) {
 		/* how can we tell if the vcard count call already finished? */
-		irmc->request = phonebook_pull("/telecom/pb.vcf", irmc->params,
+		irmc->request = phonebook_pull(PB_CONTACTS, irmc->params,
 						query_result, irmc, &ret);
 		if (ret < 0) {
 			DBG("phonebook_pull failed...");
diff --git a/plugins/phonebook-ebook.c b/plugins/phonebook-ebook.c
index a1f06b5..59a4eac 100644
--- a/plugins/phonebook-ebook.c
+++ b/plugins/phonebook-ebook.c
@@ -459,7 +459,7 @@ char *phonebook_set_folder(const char *current_folder,
 	root = (g_strcmp0("/", current_folder) == 0);
 	child = (new_folder && strlen(new_folder) != 0);
 
-	/* Evolution back-end will support telecom/pb folder only */
+	/* Evolution back-end will support /telecom/pb folder only */
 
 	switch (flags) {
 	case 0x02:
@@ -471,8 +471,8 @@ char *phonebook_set_folder(const char *current_folder,
 
 		/* Go down 1 level */
 		fullname = g_build_filename(current_folder, new_folder, NULL);
-		if (strcmp("/telecom", fullname) != 0 &&
-				strcmp("/telecom/pb", fullname) != 0) {
+		if (strcmp(PB_TELECOM_FOLDER, fullname) != 0 &&
+				strcmp(PB_CONTACTS_FOLDER, fullname) != 0) {
 			g_free(fullname);
 			fullname = NULL;
 			ret = -ENOENT;
@@ -511,8 +511,8 @@ char *phonebook_set_folder(const char *current_folder,
 		}
 
 		fullname = g_build_filename(base, new_folder, NULL);
-		if (strcmp(fullname, "/telecom") != 0 &&
-				strcmp(fullname, "/telecom/pb") != 0) {
+		if (strcmp(fullname, PB_TELECOM_FOLDER) != 0 &&
+				strcmp(fullname, PB_CONTACTS_FOLDER) != 0) {
 			g_free(fullname);
 			fullname = NULL;
 			ret = -ENOENT;
@@ -548,7 +548,7 @@ void *phonebook_pull(const char *name, const struct apparam_field *params,
 {
 	struct query_context *data;
 
-	if (g_strcmp0("/telecom/pb.vcf", name) != 0) {
+	if (g_strcmp0(PB_CONTACTS, name) != 0) {
 		if (err)
 			*err = -ENOENT;
 
@@ -638,7 +638,7 @@ void *phonebook_create_cache(const char *name, phonebook_entry_cb entry_cb,
 	EVCardAttribute *attrib;
 	char *uid, *tel, *cname;
 
-	if (g_strcmp0("/telecom/pb", name) != 0) {
+	if (g_strcmp0(PB_CONTACTS_FOLDER, name) != 0) {
 		if (err)
 			*err = -ENOENT;
 
diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 96635c4..2fd7ba1 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -513,15 +513,15 @@ static TrackerSparqlConnection *connection = NULL;
 
 static const char *name2query(const char *name)
 {
-	if (g_str_equal(name, "/telecom/pb.vcf"))
+	if (g_str_equal(name, PB_CONTACTS))
 		return CONTACTS_QUERY_ALL;
-	else if (g_str_equal(name, "/telecom/ich.vcf"))
+	else if (g_str_equal(name, PB_CALLS_INCOMING))
 		return INCOMING_CALLS_QUERY;
-	else if (g_str_equal(name, "/telecom/och.vcf"))
+	else if (g_str_equal(name, PB_CALLS_OUTGOING))
 		return OUTGOING_CALLS_QUERY;
-	else if (g_str_equal(name, "/telecom/mch.vcf"))
+	else if (g_str_equal(name, PB_CALLS_MISSED))
 		return MISSED_CALLS_QUERY;
-	else if (g_str_equal(name, "/telecom/cch.vcf"))
+	else if (g_str_equal(name, PB_CALLS_COMBINED))
 		return COMBINED_CALLS_QUERY;
 
 	return NULL;
@@ -529,15 +529,15 @@ static const char *name2query(const char *name)
 
 static const char *name2count_query(const char *name)
 {
-	if (g_str_equal(name, "/telecom/pb.vcf"))
+	if (g_str_equal(name, PB_CONTACTS))
 		return CONTACTS_COUNT_QUERY;
-	else if (g_str_equal(name, "/telecom/ich.vcf"))
+	else if (g_str_equal(name, PB_CALLS_INCOMING))
 		return INCOMING_CALLS_COUNT_QUERY;
-	else if (g_str_equal(name, "/telecom/och.vcf"))
+	else if (g_str_equal(name, PB_CALLS_OUTGOING))
 		return OUTGOING_CALLS_COUNT_QUERY;
-	else if (g_str_equal(name, "/telecom/mch.vcf"))
+	else if (g_str_equal(name, PB_CALLS_MISSED))
 		return MISSED_CALLS_COUNT_QUERY;
-	else if (g_str_equal(name, "/telecom/cch.vcf"))
+	else if (g_str_equal(name, PB_CALLS_COMBINED))
 		return COMBINED_CALLS_COUNT_QUERY;
 
 	return NULL;
@@ -550,17 +550,17 @@ static gboolean folder_is_valid(const char *folder)
 
 	if (g_str_equal(folder, "/"))
 		return TRUE;
-	else if (g_str_equal(folder, "/telecom"))
+	else if (g_str_equal(folder, PB_TELECOM_FOLDER))
 		return TRUE;
-	else if (g_str_equal(folder, "/telecom/pb"))
+	else if (g_str_equal(folder, PB_CONTACTS_FOLDER))
 		return TRUE;
-	else if (g_str_equal(folder, "/telecom/ich"))
+	else if (g_str_equal(folder, PB_CALLS_INCOMING_FOLDER))
 		return TRUE;
-	else if (g_str_equal(folder, "/telecom/och"))
+	else if (g_str_equal(folder, PB_CALLS_OUTGOING_FOLDER))
 		return TRUE;
-	else if (g_str_equal(folder, "/telecom/mch"))
+	else if (g_str_equal(folder, PB_CALLS_MISSED_FOLDER))
 		return TRUE;
-	else if (g_str_equal(folder, "/telecom/cch"))
+	else if (g_str_equal(folder, PB_CALLS_COMBINED_FOLDER))
 		return TRUE;
 
 	return FALSE;
@@ -568,15 +568,15 @@ static gboolean folder_is_valid(const char *folder)
 
 static const char *folder2query(const char *folder)
 {
-	if (g_str_equal(folder, "/telecom/pb"))
+	if (g_str_equal(folder, PB_CONTACTS_FOLDER))
 		return CONTACTS_QUERY_ALL_LIST;
-	else if (g_str_equal(folder, "/telecom/ich"))
+	else if (g_str_equal(folder, PB_CALLS_INCOMING_FOLDER))
 		return INCOMING_CALLS_LIST;
-	else if (g_str_equal(folder, "/telecom/och"))
+	else if (g_str_equal(folder, PB_CALLS_OUTGOING_FOLDER))
 		return OUTGOING_CALLS_LIST;
-	else if (g_str_equal(folder, "/telecom/mch"))
+	else if (g_str_equal(folder, PB_CALLS_MISSED_FOLDER))
 		return MISSED_CALLS_LIST;
-	else if (g_str_equal(folder, "/telecom/cch"))
+	else if (g_str_equal(folder, PB_CALLS_COMBINED_FOLDER))
 		return COMBINED_CALLS_LIST;
 
 	return NULL;
@@ -1541,11 +1541,11 @@ static int pull_newmissedcalls(const char **reply, int num_fields,
 	}
 
 	if (data->params->maxlistcount == 0) {
-		query = name2count_query("/telecom/mch.vcf");
+		query = name2count_query(PB_CALLS_MISSED);
 		col_amount = COUNT_QUERY_COL_AMOUNT;
 		pull_cb = pull_contacts_size;
 	} else {
-		query = name2query("/telecom/mch.vcf");
+		query = name2query(PB_CALLS_MISSED);
 		col_amount = PULL_QUERY_COL_AMOUNT;
 		pull_cb = pull_contacts;
 	}
@@ -1613,7 +1613,7 @@ int phonebook_pull_read(void *request)
 
 	data->newmissedcalls = 0;
 
-	if (g_strcmp0(data->req_name, "/telecom/mch.vcf") == 0 &&
+	if (g_strcmp0(data->req_name, PB_CALLS_MISSED) == 0 &&
 						data->tracker_index == 0) {
 		/* new missed calls amount should be counted only once - it
 		 * will be done during generating first part of results of
diff --git a/plugins/phonebook.h b/plugins/phonebook.h
index 00abc08..740557c 100644
--- a/plugins/phonebook.h
+++ b/plugins/phonebook.h
@@ -29,6 +29,19 @@
 #define VCARD_LISTING_ELEMENT "<card handle = \"%d.vcf\" name = \"%s\"/>" EOL
 #define VCARD_LISTING_END "</vCard-listing>"
 
+#define PB_TELECOM_FOLDER "/telecom"
+#define PB_CONTACTS_FOLDER "/telecom/pb"
+#define PB_CALLS_COMBINED_FOLDER "/telecom/cch"
+#define PB_CALLS_INCOMING_FOLDER "/telecom/ich"
+#define PB_CALLS_MISSED_FOLDER "/telecom/mch"
+#define PB_CALLS_OUTGOING_FOLDER "/telecom/och"
+
+#define PB_CONTACTS "/telecom/pb.vcf"
+#define PB_CALLS_COMBINED "/telecom/cch.vcf"
+#define PB_CALLS_INCOMING "/telecom/ich.vcf"
+#define PB_CALLS_MISSED "/telecom/mch.vcf"
+#define PB_CALLS_OUTGOING "/telecom/och.vcf"
+
 struct apparam_field {
 	/* list and pull attributes */
 	uint16_t maxlistcount;
-- 
1.7.9.5

