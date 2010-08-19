Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH 2/2] Add handling of ORG contact's fields handled in VCARD structure
Date: Thu, 19 Aug 2010 14:49:02 +0300
Message-Id: <1282218542-18495-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

After pulling contacts these fields weren't present in downloaded
VCARD structure in spite of that these fields existed (not empty).

This patch adds handling of fields grouped under ORG tag.
To solve this problem extending number of columns and queries of database
was needed especially. Of course fields mentioned above were added to
phonebook_contact structure as char * type to save gained data.
---
 plugins/phonebook-tracker.c |   38 +++++++++++++++++++++++++++-----------
 plugins/vcard.c             |   30 ++++++++++++++++++++++++++++++
 plugins/vcard.h             |    3 +++
 3 files changed, 60 insertions(+), 11 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index fd92125..3f63dcb 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -43,16 +43,16 @@
 #define TRACKER_RESOURCES_INTERFACE "org.freedesktop.Tracker1.Resources"
 
 #define TRACKER_DEFAULT_CONTACT_ME "http://www.semanticdesktop.org/ontologies/2007/03/22/nco#default-contact-me"
-#define CONTACTS_ID_COL 25
-#define PULL_QUERY_COL_AMOUNT 26
+#define CONTACTS_ID_COL 28
+#define PULL_QUERY_COL_AMOUNT 29
 #define COL_HOME_NUMBER 0
 #define COL_HOME_EMAIL 7
 #define COL_WORK_NUMBER 8
 #define COL_FAX_NUMBER 16
 #define COL_WORK_EMAIL 17
-#define COL_DATE 22
-#define COL_SENT 23
-#define COL_ANSWERED 24
+#define COL_DATE 25
+#define COL_SENT 26
+#define COL_ANSWERED 27
 
 #define CONTACTS_QUERY_ALL						\
 	"SELECT ?v nco:fullname(?c) "					\
@@ -63,7 +63,8 @@
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
 	"nco:postalcode(?p) nco:country(?p) ?f nco:emailAddress(?ew) "	\
 	"nco:birthDate(?c) nco:nickname(?c) nco:websiteUrl(?c) "	\
-	"nco:photo(?c) "						\
+	"nco:photo(?c) nco:fullname(?o) nco:department(?a) "		\
+	"nco:role(?a) "							\
 	"\"NOTACALL\" \"false\" \"false\" ?c "				\
 	"WHERE { "							\
 		"?c a nco:PersonContact . "				\
@@ -83,6 +84,7 @@
 		"?c nco:hasAffiliation ?a . "				\
 		"OPTIONAL { ?a nco:hasPhoneNumber ?w . } " 		\
 		"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "		\
+		"OPTIONAL { ?a nco:org ?o . } "				\
 	"} "								\
 	"}"
 
@@ -109,7 +111,8 @@
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
 	"nco:postalcode(?p) nco:country(?p) ?f nco:emailAddress(?ew) "	\
 	"nco:birthDate(?c) nco:nickname(?c) nco:websiteUrl(?c) "	\
-	"nco:photo(?c) "						\
+	"nco:photo(?c) nco:fullname(?o) nco:department(?a) "		\
+	"nco:role(?a) "							\
 	"nmo:receivedDate(?call) "					\
 	"nmo:isSent(?call) nmo:isAnswered(?call) ?c "			\
 	"WHERE { "							\
@@ -130,6 +133,7 @@
 		"?c nco:hasAffiliation ?a . "				\
 		"OPTIONAL { ?a nco:hasPhoneNumber ?w . } " 		\
 		"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "		\
+		"OPTIONAL { ?a nco:org ?o . } "				\
 	"} "								\
 	"} ORDER BY DESC(nmo:receivedDate(?call))"
 
@@ -156,7 +160,8 @@
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
 	"nco:postalcode(?p) nco:country(?p) ?f nco:emailAddress(?ew) "	\
 	"nco:birthDate(?c) nco:nickname(?c) nco:websiteUrl(?c) "	\
-	"nco:photo(?c) "						\
+	"nco:photo(?c) nco:fullname(?o) nco:department(?a) "		\
+	"nco:role(?a) "							\
 	"nmo:receivedDate(?call) "					\
 	"nmo:isSent(?call) nmo:isAnswered(?call) ?c "			\
 	"WHERE { "							\
@@ -177,6 +182,7 @@
 		"?c nco:hasAffiliation ?a . "				\
 		"OPTIONAL { ?a nco:hasPhoneNumber ?w . } " 		\
 		"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "		\
+		"OPTIONAL { ?a nco:org ?o . } "				\
 	"} "								\
 	"} ORDER BY DESC(nmo:receivedDate(?call))"
 
@@ -203,7 +209,8 @@
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
 	"nco:postalcode(?p) nco:country(?p) ?f nco:emailAddress(?ew)"	\
 	"nco:birthDate(?c) nco:nickname(?c) nco:websiteUrl(?c) "	\
-	"nco:photo(?c) "						\
+	"nco:photo(?c) nco:fullname(?o) nco:department(?a) "		\
+	"nco:role(?a) "							\
 	"nmo:receivedDate(?call) "					\
 	"nmo:isSent(?call) nmo:isAnswered(?call) ?c "			\
 	"WHERE { "							\
@@ -223,6 +230,7 @@
 		"?c nco:hasAffiliation ?a . "				\
 		"OPTIONAL { ?a nco:hasPhoneNumber ?w . } " 		\
 		"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "		\
+		"OPTIONAL { ?a nco:org ?o . } "				\
 	"} "								\
 	"} ORDER BY DESC(nmo:sentDate(?call))"
 
@@ -248,7 +256,8 @@
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
 	"nco:postalcode(?p) nco:country(?p) ?f nco:emailAddress(?ew) "	\
 	"nco:birthDate(?c) nco:nickname(?c) nco:websiteUrl(?c) "	\
-	"nco:photo(?c) "						\
+	"nco:photo(?c) nco:fullname(?o) nco:department(?a) "		\
+	"nco:role(?a) "							\
 	"nmo:receivedDate(?call) "					\
 	"nmo:isSent(?call) nmo:isAnswered(?call) ?c "			\
 	"WHERE { "							\
@@ -268,6 +277,7 @@
 	"OPTIONAL { ?c nco:hasAffiliation ?a . "			\
 		"OPTIONAL { ?a nco:hasPhoneNumber ?w . } " 		\
 		"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "		\
+		"OPTIONAL { ?a nco:org ?o . } "				\
 	"} "								\
 	"} UNION { "							\
 		"?call a nmo:Call ; "					\
@@ -285,6 +295,7 @@
 	"OPTIONAL { ?c nco:hasAffiliation ?a . "			\
 		"OPTIONAL { ?a nco:hasPhoneNumber ?w . } " 		\
 		"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "		\
+		"OPTIONAL { ?a nco:org ?o . } "				\
 	"} "								\
 	"} } ORDER BY DESC(nmo:receivedDate(?call))"
 
@@ -317,7 +328,8 @@
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
 	"nco:postalcode(?p) nco:country(?p) ?f  nco:emailAddress(?ew)"	\
 	"nco:birthDate(<%s>) nco:nickname(<%s>) nco:websiteUrl(<%s>) "	\
-	"nco:photo(<%s>) "						\
+	"nco:photo(<%s>) nco:fullname(?o) nco:department(?a) "		\
+	"nco:role(?a) "							\
 	"\"NOTACALL\" \"false\" \"false\" <%s> "			\
 	"WHERE { "							\
 		"<%s> a nco:Contact . "					\
@@ -337,6 +349,7 @@
 		"<%s> nco:hasAffiliation ?a . "				\
 		"OPTIONAL { ?a nco:hasPhoneNumber ?w . }" 		\
 		"OPTIONAL { ?a nco:hasEmailAddress ?ew . }"		\
+		"OPTIONAL { ?a nco:org ?o . } "				\
 	"} "								\
 	"}"
 
@@ -790,6 +803,9 @@ add_entry:
 	contact->nickname = g_strdup(reply[19]);
 	contact->website = g_strdup(reply[20]);
 	contact->photo = g_strdup(reply[21]);
+	contact->company = g_strdup(reply[22]);
+	contact->department = g_strdup(reply[23]);
+	contact->title = g_strdup(reply[24]);
 
 	set_call_type(contact, reply[COL_DATE], reply[COL_SENT],
 			reply[COL_ANSWERED]);
diff --git a/plugins/vcard.c b/plugins/vcard.c
index c45bfcd..b33c8e3 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -319,6 +319,30 @@ static void vcard_printf_email(GString *vcards, const char *email)
 	}
 }
 
+static gboolean org_fields_present(struct phonebook_contact *contact)
+{
+	if (contact->company && strlen(contact->company))
+		return TRUE;
+
+	if (contact->department && strlen(contact->department))
+		return TRUE;
+
+	if (contact->title && strlen(contact->title))
+		return TRUE;
+
+	return FALSE;
+}
+
+static void vcard_printf_org(GString *vcards,
+					struct phonebook_contact *contact)
+{
+	if (org_fields_present(contact) == FALSE)
+		return;
+
+	vcard_printf(vcards, "ORG:%s;%s;%s", contact->company,
+				contact->department, contact->title);
+}
+
 static void vcard_printf_adr(GString *vcards, struct phonebook_contact *contact)
 {
 	if (address_fields_present(contact) == FALSE) {
@@ -416,6 +440,9 @@ void phonebook_add_contact(GString *vcards, struct phonebook_contact *contact,
 	if (filter & FILTER_PHOTO)
 		vcard_printf_tag(vcards, "PHOTO", NULL, contact->photo);
 
+	if (filter & FILTER_ORG)
+		vcard_printf_org(vcards, contact);
+
 	if (filter & FILTER_X_IRMC_CALL_DATETIME)
 		vcard_printf_datetime(vcards, contact);
 
@@ -458,6 +485,9 @@ void phonebook_contact_free(struct phonebook_contact *contact)
 	g_free(contact->nickname);
 	g_free(contact->website);
 	g_free(contact->photo);
+	g_free(contact->company);
+	g_free(contact->department);
+	g_free(contact->title);
 	g_free(contact->datetime);
 	g_free(contact);
 }
diff --git a/plugins/vcard.h b/plugins/vcard.h
index a9809ea..0f52425 100644
--- a/plugins/vcard.h
+++ b/plugins/vcard.h
@@ -59,6 +59,9 @@ struct phonebook_contact {
 	char *nickname;
 	char *website;
 	char *photo;
+	char *company;
+	char *department;
+	char *title;
 	char *datetime;
 	int calltype;
 };
-- 
1.6.3.3

