Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Add workaround for devices which use absolute path in pbap Name header
Date: Thu, 17 Feb 2011 10:53:29 +0200
Message-Id: <1297932809-3460-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1297932809-3460-1-git-send-email-luiz.dentz@gmail.com>
References: <1297932809-3460-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

The pbap spec says:

"5.1.2 Name
The Name header shall contain the absolute path in the virtual folders
architecture of the PSE, appended with the name of the file representation of
one of the Phone Book Objects.
Example: telecom/pb.vcf or SIM1/telecom/pb.vcf for the main phone book
objects."

The example actually uses relative paths but text state absolute paths although
the OBEX specification says that the Name header is always relative to the
current path.
---
 plugins/pbap.c              |    6 +++++-
 plugins/phonebook-tracker.c |   26 +++++++++++++-------------
 2 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/plugins/pbap.c b/plugins/pbap.c
index b04dca9..61e7e42 100644
--- a/plugins/pbap.c
+++ b/plugins/pbap.c
@@ -658,7 +658,11 @@ static int pbap_get(struct obex_session *os, obex_object_t *obj,
 
 	if (strcmp(type, PHONEBOOK_TYPE) == 0) {
 		/* Always contains the absolute path */
-		path = g_strdup(name);
+		if (g_path_is_absolute(name))
+			path = g_strdup(name);
+		else
+			path = g_build_filename("/", name, NULL);
+
 		*stream = (params->maxlistcount == 0 ? FALSE : TRUE);
 	} else if (strcmp(type, VCARDLISTING_TYPE) == 0) {
 		/* Always relative */
diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index eb38a46..8a0246a 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -934,15 +934,15 @@ static TrackerSparqlConnection *connection = NULL;
 
 static const char *name2query(const char *name)
 {
-	if (g_str_equal(name, "telecom/pb.vcf"))
+	if (g_str_equal(name, "/telecom/pb.vcf"))
 		return CONTACTS_QUERY_ALL;
-	else if (g_str_equal(name, "telecom/ich.vcf"))
+	else if (g_str_equal(name, "/telecom/ich.vcf"))
 		return INCOMING_CALLS_QUERY;
-	else if (g_str_equal(name, "telecom/och.vcf"))
+	else if (g_str_equal(name, "/telecom/och.vcf"))
 		return OUTGOING_CALLS_QUERY;
-	else if (g_str_equal(name, "telecom/mch.vcf"))
+	else if (g_str_equal(name, "/telecom/mch.vcf"))
 		return MISSED_CALLS_QUERY;
-	else if (g_str_equal(name, "telecom/cch.vcf"))
+	else if (g_str_equal(name, "/telecom/cch.vcf"))
 		return COMBINED_CALLS_QUERY;
 
 	return NULL;
@@ -950,15 +950,15 @@ static const char *name2query(const char *name)
 
 static const char *name2count_query(const char *name)
 {
-	if (g_str_equal(name, "telecom/pb.vcf"))
+	if (g_str_equal(name, "/telecom/pb.vcf"))
 		return CONTACTS_COUNT_QUERY;
-	else if (g_str_equal(name, "telecom/ich.vcf"))
+	else if (g_str_equal(name, "/telecom/ich.vcf"))
 		return INCOMING_CALLS_COUNT_QUERY;
-	else if (g_str_equal(name, "telecom/och.vcf"))
+	else if (g_str_equal(name, "/telecom/och.vcf"))
 		return OUTGOING_CALLS_COUNT_QUERY;
-	else if (g_str_equal(name, "telecom/mch.vcf"))
+	else if (g_str_equal(name, "/telecom/mch.vcf"))
 		return MISSED_CALLS_COUNT_QUERY;
-	else if (g_str_equal(name, "telecom/cch.vcf"))
+	else if (g_str_equal(name, "/telecom/cch.vcf"))
 		return COMBINED_CALLS_COUNT_QUERY;
 
 	return NULL;
@@ -1921,11 +1921,11 @@ done:
 	}
 
 	if (data->params->maxlistcount == 0) {
-		query = name2count_query("telecom/mch.vcf");
+		query = name2count_query("/telecom/mch.vcf");
 		col_amount = COUNT_QUERY_COL_AMOUNT;
 		pull_cb = pull_contacts_size;
 	} else {
-		query = name2query("telecom/mch.vcf");
+		query = name2query("/telecom/mch.vcf");
 		col_amount = PULL_QUERY_COL_AMOUNT;
 		pull_cb = pull_contacts;
 	}
@@ -1970,7 +1970,7 @@ int phonebook_pull_read(void *request)
 	if(!data)
 		return -ENOENT;
 
-	if (g_strcmp0(data->req_name, "telecom/mch.vcf") == 0) {
+	if (g_strcmp0(data->req_name, "/telecom/mch.vcf") == 0) {
 		query = NEW_MISSED_CALLS_LIST;
 		col_amount = PULL_QUERY_COL_AMOUNT;
 		pull_cb = pull_newmissedcalls;
-- 
1.7.1

