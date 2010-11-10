Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH 1/7] Fix proper type handling in contacts_query_all
Date: Wed, 10 Nov 2010 14:15:24 +0100
Message-Id: <1289394930-6694-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously all phone numbers, addresses and emails was considered to be "work".
Now there are three working types for emails and addresses: "work", "home",
"other" and four for phone numbers - these three as well as "cell".
---
 plugins/phonebook-tracker.c |   61 +++++++++++++++++++++++++++++++------------
 1 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 58f52ab..83327e0 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -43,8 +43,8 @@
 #define TRACKER_RESOURCES_INTERFACE "org.freedesktop.Tracker1.Resources"
 
 #define TRACKER_DEFAULT_CONTACT_ME "http://www.semanticdesktop.org/ontologies/2007/03/22/nco#default-contact-me"
-#define CONTACTS_ID_COL 38
-#define PULL_QUERY_COL_AMOUNT 39
+#define CONTACTS_ID_COL 47
+#define PULL_QUERY_COL_AMOUNT 48
 #define COUNT_QUERY_COL_AMOUNT 1
 #define COL_HOME_NUMBER 0
 #define COL_HOME_EMAIL 7
@@ -52,14 +52,16 @@
 #define COL_FAX_NUMBER 16
 #define COL_WORK_EMAIL 17
 #define COL_OTHER_NUMBER 34
-#define COL_DATE 35
-#define COL_SENT 36
-#define COL_ANSWERED 37
+#define COL_OTHER_EMAIL 42
+#define COL_CELL_NUMBER 43
+#define COL_DATE 44
+#define COL_SENT 45
+#define COL_ANSWERED 46
 #define ADDR_FIELD_AMOUNT 7
 #define CONTACT_ID_PREFIX "contact:"
 
 #define CONTACTS_QUERY_ALL						\
-	"SELECT ?v nco:fullname(?c) "					\
+	"SELECT nco:phoneNumber(?v) nco:fullname(?c) "			\
 	"nco:nameFamily(?c) nco:nameGiven(?c) "				\
 	"nco:nameAdditional(?c) nco:nameHonorificPrefix(?c) "		\
 	"nco:nameHonorificSuffix(?c) nco:emailAddress(?e) "		\
@@ -71,29 +73,43 @@
 	"nco:role(?a) nco:pobox(?pw) nco:extendedAddress(?pw) "		\
 	"nco:streetAddress(?pw) nco:locality(?pw) nco:region(?pw) "	\
 	"nco:postalcode(?pw) nco:country(?pw) nco:contactUID(?c) "	\
-	"nco:title(?a) nco:phoneNumber(?t) "				\
+	"nco:title(?a) ?t nco:pobox(?po) nco:extendedAddress(?po) "	\
+	"nco:streetAddress(?po) nco:locality(?po) nco:region(?po) "	\
+        "nco:postalcode(?po) nco:country(?po) nco:emailAddress(?eo) "	\
+	"?vc "								\
 	"\"NOTACALL\" \"false\" \"false\" ?c "				\
 	"WHERE { "							\
 		"?c a nco:PersonContact . "				\
-	"OPTIONAL { ?c nco:hasPhoneNumber ?h . 				\
-		OPTIONAL {"						\
+	"OPTIONAL { ?c nco:hasPhoneNumber ?h . "			\
+		"OPTIONAL {"						\
 		"?h a nco:FaxNumber ; "					\
 		"nco:phoneNumber ?f . "					\
 		"}"							\
 		"OPTIONAL {"						\
+		"?h a nco:CellPhoneNumber ; "				\
+		"nco:phoneNumber ?vc"					\
+		"}"							\
+		"OPTIONAL {"						\
 		"?h a nco:VoicePhoneNumber ; "				\
-		"nco:phoneNumber ?v"					\
+		"nco:phoneNumber ?t"					\
 		"}"							\
 	"}"								\
-	"OPTIONAL { ?c nco:hasEmailAddress ?e . } "			\
-	"OPTIONAL { ?c nco:hasPostalAddress ?p . } "			\
 	"OPTIONAL { "							\
 		"?c nco:hasAffiliation ?a . "				\
-		"OPTIONAL { ?a nco:hasPhoneNumber ?w . } " 		\
-		"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "		\
-		"OPTIONAL { ?a nco:hasPostalAddress ?pw . } "		\
+		"OPTIONAL { ?a rdfs:label \"Work\" . "			\
+			"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "	\
+			"OPTIONAL { ?a nco:hasPostalAddress ?pw . } "	\
+			"OPTIONAL { ?a nco:hasPhoneNumber ?w . } "	\
+		"}"							\
+		"OPTIONAL { ?a rdfs:label \"Home\" . "			\
+			"OPTIONAL { ?a nco:hasEmailAddress ?e . } "	\
+			"OPTIONAL { ?a nco:hasPostalAddress ?p . } "	\
+			"OPTIONAL { ?a nco:hasPhoneNumber ?v . } "	\
+		"}"							\
 		"OPTIONAL { ?a nco:org ?o . } "				\
 	"} "								\
+	"OPTIONAL { ?c nco:hasPostalAddress ?po . } "			\
+	"OPTIONAL { ?c nco:hasEmailAddress ?eo . } "			\
 	"}"
 
 #define CONTACTS_QUERY_ALL_LIST						\
@@ -1107,7 +1123,7 @@ static void pull_contacts(char **reply, int num_fields, void *user_data)
 	GString *vcards;
 	int last_index, i;
 	gboolean cdata_present = FALSE;
-	char *home_addr, *work_addr;
+	char *home_addr, *work_addr, *other_addr;
 
 	if (num_fields < 0) {
 		data->cb(NULL, 0, num_fields, 0, data->user_data);
@@ -1178,11 +1194,16 @@ add_numbers:
 	add_phone_number(contact, reply[COL_HOME_NUMBER], TEL_TYPE_HOME);
 	add_phone_number(contact, reply[COL_WORK_NUMBER], TEL_TYPE_WORK);
 	add_phone_number(contact, reply[COL_FAX_NUMBER], TEL_TYPE_FAX);
-	add_phone_number(contact, reply[COL_OTHER_NUMBER], TEL_TYPE_OTHER);
+	add_phone_number(contact, reply[COL_CELL_NUMBER], TEL_TYPE_MOBILE);
+	if ((g_strcmp0(reply[COL_OTHER_NUMBER], reply[COL_CELL_NUMBER]) != 0) &&
+			(g_strcmp0(reply[COL_OTHER_NUMBER], reply[COL_WORK_NUMBER]) != 0) &&
+			(g_strcmp0(reply[COL_OTHER_NUMBER], reply[COL_HOME_NUMBER]) != 0))
+		add_phone_number(contact, reply[COL_OTHER_NUMBER], TEL_TYPE_OTHER);
 
 	/* Adding emails */
 	add_email(contact, reply[COL_HOME_EMAIL], EMAIL_TYPE_HOME);
 	add_email(contact, reply[COL_WORK_EMAIL], EMAIL_TYPE_WORK);
+	add_email(contact, reply[COL_OTHER_EMAIL], EMAIL_TYPE_OTHER);
 
 	/* Adding addresses */
 	home_addr = g_strdup_printf("%s;%s;%s;%s;%s;%s;%s",
@@ -1193,11 +1214,17 @@ add_numbers:
 				reply[25], reply[26], reply[27], reply[28],
 				reply[29], reply[30], reply[31]);
 
+	other_addr = g_strdup_printf("%s;%s;%s;%s;%s;%s;%s",
+				reply[35], reply[36], reply[37], reply[38],
+				reply[39], reply[40], reply[41]);
+
 	add_address(contact, home_addr, ADDR_TYPE_HOME);
 	add_address(contact, work_addr, ADDR_TYPE_WORK);
+	add_address(contact, other_addr, ADDR_TYPE_OTHER);
 
 	g_free(home_addr);
 	g_free(work_addr);
+	g_free(other_addr);
 
 	/* Adding fields connected by nco:hasAffiliation - they may be in
 	 * separate replies */
-- 
1.7.0.4

