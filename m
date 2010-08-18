Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH] Additional contact's field handled in VCARD structure
Date: Wed, 18 Aug 2010 10:39:36 +0300
Message-Id: <1282117176-28912-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

After pulling contacts some fields weren't present in downloaded
VCARD structure in spite of that these fields existed (not empty).

I added handling fields: BDAY, NICKNAME, URL, PHOTO and three fields
grouped under ORG tag (Company, Department, Job Title).
To solve this problem extending number of columns and queries of database
was needed especially. Of course fields mentioned above were added to
phonebook_contact structure as char * type to save gained data
---
 plugins/phonebook-tracker.c |  102 ++++++++++++++++++++++++++----------------
 plugins/vcard.c             |   96 ++++++++++++++++++++++++++++++++++++++++
 plugins/vcard.h             |    7 +++
 3 files changed, 166 insertions(+), 39 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 618ce8d..2bccdfc 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -43,14 +43,14 @@
 #define TRACKER_RESOURCES_INTERFACE "org.freedesktop.Tracker1.Resources"
 
 #define TRACKER_DEFAULT_CONTACT_ME "http://www.semanticdesktop.org/ontologies/2007/03/22/nco#default-contact-me"
-#define CONTACTS_ID_COL 20
-#define PULL_QUERY_COL_AMOUNT 21
+#define CONTACTS_ID_COL 27
+#define PULL_QUERY_COL_AMOUNT 28
 #define COL_HOME_NUMBER 0
 #define COL_WORK_NUMBER 8
 #define COL_FAX_NUMBER 16
-#define COL_DATE 17
-#define COL_SENT 18
-#define COL_ANSWERED 19
+#define COL_DATE 24
+#define COL_SENT 25
+#define COL_ANSWERED 26
 
 #define CONTACTS_QUERY_ALL						\
 	"SELECT ?v nco:fullname(?c) "					\
@@ -59,8 +59,10 @@
 	"nco:nameHonorificSuffix(?c) nco:emailAddress(?e) "		\
 	"nco:phoneNumber(?w) nco:pobox(?p) nco:extendedAddress(?p) "	\
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
-	"nco:postalcode(?p) nco:country(?p) ?f \"NOTACALL\" \"false\" "	\
-	"\"false\" ?c "							\
+	"nco:postalcode(?p) nco:country(?p) ?f nco:birthDate(?c) " 	\
+	"nco:nickname(?c) nco:websiteUrl(?c) nco:photo(?c) "		\
+	"nco:fullname(?o) nco:department(?a) nco:role(?a) "		\
+	"\"NOTACALL\" \"false\" \"false\" ?c "				\
 	"WHERE { "							\
 		"?c a nco:PersonContact . "				\
 	"OPTIONAL { ?c nco:hasPhoneNumber ?h . 				\
@@ -75,9 +77,9 @@
 	"}"								\
 	"OPTIONAL { ?c nco:hasEmailAddress ?e . } "			\
 	"OPTIONAL { ?c nco:hasPostalAddress ?p . } "			\
-	"OPTIONAL { "							\
-		"?c nco:hasAffiliation ?a . "				\
-		"?a nco:hasPhoneNumber ?w . "				\
+	"OPTIONAL { ?c nco:hasAffiliation ?a . "			\
+		"OPTIONAL { ?a nco:hasPhoneNumber ?w . } "		\
+		"OPTIONAL { ?a nco:org ?o . } "				\
 	"} "								\
 	"}"
 
@@ -102,8 +104,11 @@
 	"nco:nameHonorificSuffix(?c) nco:emailAddress(?e) "		\
 	"nco:phoneNumber(?w) nco:pobox(?p) nco:extendedAddress(?p) "	\
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
-	"nco:postalcode(?p) nco:country(?p) ?f nmo:receivedDate(?call) "\
-	"nmo:isSent(?call) nmo:isAnswered(?call) ?c "			\
+	"nco:postalcode(?p) nco:country(?p) ?f nco:birthDate(?c) "	\
+	"nco:nickname(?c) nco:websiteUrl(?c) nco:photo(?c) "		\
+	"nco:fullname(?o) nco:department(?a) nco:role(?a) "		\
+	"nmo:receivedDate(?call) nmo:isSent(?call) "			\
+	"nmo:isAnswered(?call) ?c "					\
 	"WHERE { "							\
 		"?call a nmo:Call ; "					\
 		"nmo:from ?c ; "					\
@@ -118,9 +123,9 @@
 	"} "								\
 	"OPTIONAL { ?c nco:hasEmailAddress ?e . } "			\
 	"OPTIONAL { ?c nco:hasPostalAddress ?p . } "			\
-	"OPTIONAL { "							\
-		"?c nco:hasAffiliation ?a . "				\
-		"?a nco:hasPhoneNumber ?w . "				\
+	"OPTIONAL { ?c nco:hasAffiliation ?a . "			\
+		"OPTIONAL { ?a nco:hasPhoneNumber ?w . } "		\
+		"OPTIONAL { ?a nco:org ?o . } "				\
 	"} "								\
 	"} ORDER BY DESC(nmo:receivedDate(?call))"
 
@@ -145,8 +150,11 @@
 	"nco:nameHonorificSuffix(?c) nco:emailAddress(?e) "		\
 	"nco:phoneNumber(?w) nco:pobox(?p) nco:extendedAddress(?p) "	\
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
-	"nco:postalcode(?p) nco:country(?p) ?f nmo:receivedDate(?call) "\
-	"nmo:isSent(?call) nmo:isAnswered(?call) ?c "			\
+	"nco:postalcode(?p) nco:country(?p) ?f nco:birthDate(?c) "	\
+	"nco:nickname(?c) nco:websiteUrl(?c) nco:photo(?c) "		\
+	"nco:fullname(?o) nco:department(?a) nco:role(?a) "		\
+	"nmo:receivedDate(?call) nmo:isSent(?call) "			\
+	"nmo:isAnswered(?call) ?c "					\
 	"WHERE { "							\
 		"?call a nmo:Call ; "					\
 		"nmo:from ?c ; "					\
@@ -161,9 +169,9 @@
 	"} "								\
 	"OPTIONAL { ?c nco:hasEmailAddress ?e . } "			\
 	"OPTIONAL { ?c nco:hasPostalAddress ?p . } "			\
-	"OPTIONAL { "							\
-		"?c nco:hasAffiliation ?a . "				\
-		"?a nco:hasPhoneNumber ?w . "				\
+	"OPTIONAL { ?c nco:hasAffiliation ?a . "			\
+		"OPTIONAL { ?a nco:hasPhoneNumber ?w . } "		\
+		"OPTIONAL { ?a nco:org ?o . } "				\
 	"} "								\
 	"} ORDER BY DESC(nmo:receivedDate(?call))"
 
@@ -188,8 +196,11 @@
 	"nco:nameHonorificSuffix(?c) nco:emailAddress(?e) "		\
 	"nco:phoneNumber(?w) nco:pobox(?p) nco:extendedAddress(?p) "	\
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
-	"nco:postalcode(?p) nco:country(?p) ?f nmo:receivedDate(?call) "\
-	"nmo:isSent(?call) nmo:isAnswered(?call) ?c "			\
+	"nco:postalcode(?p) nco:country(?p) ?f nco:birthDate(?c) "	\
+	"nco:nickname(?c) nco:websiteUrl(?c) nco:photo(?c) "		\
+	"nco:fullname(?o) nco:department(?a) nco:role(?a) "		\
+	"nmo:receivedDate(?call) nmo:isSent(?call) " 			\
+	"nmo:isAnswered(?call) ?c "					\
 	"WHERE { "							\
 		"?call a nmo:Call ; "					\
 		"nmo:to ?c ; "						\
@@ -203,9 +214,9 @@
 	"} "								\
 	"OPTIONAL { ?c nco:hasEmailAddress ?e . } "			\
 	"OPTIONAL { ?c nco:hasPostalAddress ?p . } "			\
-	"OPTIONAL { "							\
-		"?c nco:hasAffiliation ?a . "				\
-		"?a nco:hasPhoneNumber ?w . "				\
+	"OPTIONAL { ?c nco:hasAffiliation ?a . "			\
+		"OPTIONAL { ?a nco:hasPhoneNumber ?w . } "		\
+		"OPTIONAL { ?a nco:org ?o . } "				\
 	"} "								\
 	"} ORDER BY DESC(nmo:sentDate(?call))"
 
@@ -229,8 +240,11 @@
 	"nco:nameHonorificSuffix(?c) nco:emailAddress(?e) "		\
 	"nco:phoneNumber(?w) nco:pobox(?p) nco:extendedAddress(?p) "	\
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
-	"nco:postalcode(?p) nco:country(?p) ?f nmo:receivedDate(?call) "\
-	"nmo:isSent(?call) nmo:isAnswered(?call) ?c "			\
+	"nco:postalcode(?p) nco:country(?p) ?f nco:birthDate(?c) " 	\
+	"nco:nickname(?c) nco:websiteUrl(?c) nco:photo(?c) "		\
+	"nco:fullname(?o) nco:department(?a) nco:role(?a) "		\
+	"nmo:receivedDate(?call) nmo:isSent(?call) " 			\
+	"nmo:isAnswered(?call) ?c "					\
 	"WHERE { "							\
 	"{ "								\
 		"?call a nmo:Call ; "					\
@@ -245,9 +259,9 @@
 	"} "								\
 		"OPTIONAL { ?c nco:hasEmailAddress ?e . } "		\
 		"OPTIONAL { ?c nco:hasPostalAddress ?p . } "		\
-		"OPTIONAL { "						\
-			"?c nco:hasAffiliation ?a . "			\
-			"?a nco:hasPhoneNumber ?w . "			\
+		"OPTIONAL { ?c nco:hasAffiliation ?a . "		\
+			"OPTIONAL { ?a nco:hasPhoneNumber ?w . } "	\
+			"OPTIONAL { ?a nco:org ?o . } "			\
 		"} "							\
 	"} UNION { "							\
 		"?call a nmo:Call ; "					\
@@ -262,9 +276,9 @@
 	"} "								\
 		"OPTIONAL { ?c nco:hasEmailAddress ?e . } "		\
 		"OPTIONAL { ?c nco:hasPostalAddress ?p . } "		\
-		"OPTIONAL { "						\
-			"?c nco:hasAffiliation ?a . "			\
-			"?a nco:hasPhoneNumber ?w . "			\
+		"OPTIONAL { ?c nco:hasAffiliation ?a . "		\
+			"OPTIONAL { ?a nco:hasPhoneNumber ?w . } "	\
+			"OPTIONAL { ?a nco:org ?o . } "			\
 		"} "							\
 	"} } ORDER BY DESC(nmo:receivedDate(?call))"
 
@@ -295,8 +309,10 @@
 	"nco:nameHonorificSuffix(<%s>) nco:emailAddress(?e) "		\
 	"nco:phoneNumber(?w) nco:pobox(?p) nco:extendedAddress(?p) "	\
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
-	"nco:postalcode(?p) nco:country(?p) ?f \"NOTACALL\" \"false\" "	\
-	"\"false\" <%s> "						\
+	"nco:postalcode(?p) nco:country(?p) ?f nco:birthDate(<%s>) "	\
+	"nco:nickname(<%s>) nco:websiteUrl(<%s>) nco:photo(<%s>) "	\
+	"nco:fullname(?o) nco:department(?a) nco:role(?a) "		\
+	"\"NOTACALL\" \"false\" \"false\" <%s> "			\
 	"WHERE { "							\
 		"<%s> a nco:Contact . "					\
 	"OPTIONAL { <%s> nco:hasPhoneNumber ?h . 			\
@@ -311,9 +327,9 @@
 	"}"								\
 	"OPTIONAL { <%s> nco:hasEmailAddress ?e . } "			\
 	"OPTIONAL { <%s> nco:hasPostalAddress ?p . } "			\
-	"OPTIONAL { "							\
-		"<%s> nco:hasAffiliation ?a . "				\
-		"?a nco:hasPhoneNumber ?w . "				\
+	"OPTIONAL { <%s> nco:hasAffiliation ?a . "			\
+		"OPTIONAL { ?a nco:hasPhoneNumber ?w . } "		\
+		"OPTIONAL { ?a nco:org ?o . } "				\
 	"} "								\
 	"}"
 
@@ -741,6 +757,13 @@ add_entry:
 	contact->region = g_strdup(reply[13]);
 	contact->postal = g_strdup(reply[14]);
 	contact->country = g_strdup(reply[15]);
+	contact->birthday = g_strdup(reply[17]);
+	contact->nickname = g_strdup(reply[18]);
+	contact->website = g_strdup(reply[19]);
+	contact->photo = g_strdup(reply[20]);
+	contact->company = g_strdup(reply[21]);
+	contact->department = g_strdup(reply[22]);
+	contact->title = g_strdup(reply[23]);
 
 	set_call_type(contact, reply[COL_DATE], reply[COL_SENT],
 			reply[COL_ANSWERED]);
@@ -941,7 +964,8 @@ int phonebook_get_entry(const char *folder, const char *id,
 	data->vcardentry = TRUE;
 
 	query = g_strdup_printf(CONTACTS_QUERY_FROM_URI, id, id, id, id, id,
-						id, id, id, id, id, id, id);
+						id, id, id, id, id, id, id,
+						id, id, id, id);
 
 	ret = query_tracker(query, PULL_QUERY_COL_AMOUNT, pull_contacts, data);
 
diff --git a/plugins/vcard.c b/plugins/vcard.c
index af00cb5..0439506 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -271,6 +271,80 @@ static void vcard_printf_email(GString *vcards, const char *email)
 	}
 }
 
+static void vcard_printf_bday(GString *vcards, const char *birthday)
+{
+	int len = 0;
+
+	if (birthday)
+		len = strlen(birthday);
+
+	if (len)
+		vcard_printf(vcards, "BDAY:%s", birthday);
+}
+
+static void vcard_printf_nickname(GString *vcards, const char *nickname)
+{
+	int len = 0;
+
+	if (nickname)
+		len = strlen(nickname);
+
+	if (len) {
+		char field[LEN_MAX];
+		add_slash(field, nickname, LEN_MAX, len);
+		vcard_printf(vcards, "NICKNAME:%s", field);
+	}
+}
+
+static void vcard_printf_url(GString *vcards, const char *website)
+{
+	int len = 0;
+
+	if (website)
+		len = strlen(website);
+
+	if (len) {
+		char field[LEN_MAX];
+		add_slash(field, website, LEN_MAX, len);
+		vcard_printf(vcards, "URL;TYPE=INTERNET:%s", field);
+	}
+}
+
+static void vcard_printf_photo(GString *vcards, const char *photo)
+{
+	int len = 0;
+
+	if (photo)
+		len = strlen(photo);
+
+	if (len)
+		vcard_printf(vcards, "PHOTO:%s", photo);
+}
+
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
@@ -350,6 +424,21 @@ void phonebook_add_contact(GString *vcards, struct phonebook_contact *contact,
 	if (filter & FILTER_ADR)
 		vcard_printf_adr(vcards, contact);
 
+	if (filter & FILTER_BDAY)
+		vcard_printf_bday(vcards, contact->birthday);
+
+	if (filter & FILTER_NICKNAME)
+		vcard_printf_nickname(vcards, contact->nickname);
+
+	if (filter & FILTER_URL)
+		vcard_printf_url(vcards, contact->website);
+
+	if (filter & FILTER_PHOTO)
+		vcard_printf_photo(vcards, contact->photo);
+
+	if (filter & FILTER_ORG)
+		vcard_printf_org(vcards, contact);
+
 	if (filter & FILTER_X_IRMC_CALL_DATETIME)
 		vcard_printf_datetime(vcards, contact);
 
@@ -386,6 +475,13 @@ void phonebook_contact_free(struct phonebook_contact *contact)
 	g_free(contact->region);
 	g_free(contact->postal);
 	g_free(contact->country);
+	g_free(contact->birthday);
+	g_free(contact->nickname);
+	g_free(contact->website);
+	g_free(contact->photo);
+	g_free(contact->company);
+	g_free(contact->department);
+	g_free(contact->title);
 	g_free(contact->datetime);
 	g_free(contact);
 }
diff --git a/plugins/vcard.h b/plugins/vcard.h
index 06bcd35..8484a5d 100644
--- a/plugins/vcard.h
+++ b/plugins/vcard.h
@@ -55,6 +55,13 @@ struct phonebook_contact {
 	char *region;
 	char *postal;
 	char *country;
+	char *birthday;
+	char *nickname;
+	char *website;
+	char *photo;
+	char *company;
+	char *department;
+	char *title;
 	char *datetime;
 	int calltype;
 };
-- 
1.6.3.3

