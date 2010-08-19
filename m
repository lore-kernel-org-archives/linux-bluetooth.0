Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH] Fix problem with multiple emails in vcard
Date: Thu, 19 Aug 2010 09:49:47 +0300
Message-Id: <1282200587-5475-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously only one email appeared in generated vcard, even if contact
had defined multiple email addresses in contact data.
Changed vcard struct and phonebook-tracker pull_contacts func to support
multiple emails.
---
 plugins/phonebook-tracker.c |   99 +++++++++++++++++++++++++++++-------------
 plugins/vcard.c             |   12 ++++-
 plugins/vcard.h             |    2 +-
 3 files changed, 78 insertions(+), 35 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 618ce8d..1109968 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -43,14 +43,16 @@
 #define TRACKER_RESOURCES_INTERFACE "org.freedesktop.Tracker1.Resources"
 
 #define TRACKER_DEFAULT_CONTACT_ME "http://www.semanticdesktop.org/ontologies/2007/03/22/nco#default-contact-me"
-#define CONTACTS_ID_COL 20
-#define PULL_QUERY_COL_AMOUNT 21
+#define CONTACTS_ID_COL 21
+#define PULL_QUERY_COL_AMOUNT 22
 #define COL_HOME_NUMBER 0
+#define COL_HOME_EMAIL 7
 #define COL_WORK_NUMBER 8
 #define COL_FAX_NUMBER 16
-#define COL_DATE 17
-#define COL_SENT 18
-#define COL_ANSWERED 19
+#define COL_WORK_EMAIL 17
+#define COL_DATE 18
+#define COL_SENT 19
+#define COL_ANSWERED 20
 
 #define CONTACTS_QUERY_ALL						\
 	"SELECT ?v nco:fullname(?c) "					\
@@ -59,8 +61,8 @@
 	"nco:nameHonorificSuffix(?c) nco:emailAddress(?e) "		\
 	"nco:phoneNumber(?w) nco:pobox(?p) nco:extendedAddress(?p) "	\
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
-	"nco:postalcode(?p) nco:country(?p) ?f \"NOTACALL\" \"false\" "	\
-	"\"false\" ?c "							\
+	"nco:postalcode(?p) nco:country(?p) ?f nco:emailAddress(?ew) "	\
+	"\"NOTACALL\" \"false\" \"false\" ?c "				\
 	"WHERE { "							\
 		"?c a nco:PersonContact . "				\
 	"OPTIONAL { ?c nco:hasPhoneNumber ?h . 				\
@@ -77,7 +79,8 @@
 	"OPTIONAL { ?c nco:hasPostalAddress ?p . } "			\
 	"OPTIONAL { "							\
 		"?c nco:hasAffiliation ?a . "				\
-		"?a nco:hasPhoneNumber ?w . "				\
+		"OPTIONAL { ?a nco:hasPhoneNumber ?w . } " 		\
+		"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "		\
 	"} "								\
 	"}"
 
@@ -102,7 +105,8 @@
 	"nco:nameHonorificSuffix(?c) nco:emailAddress(?e) "		\
 	"nco:phoneNumber(?w) nco:pobox(?p) nco:extendedAddress(?p) "	\
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
-	"nco:postalcode(?p) nco:country(?p) ?f nmo:receivedDate(?call) "\
+	"nco:postalcode(?p) nco:country(?p) ?f nco:emailAddress(?ew) "	\
+	"nmo:receivedDate(?call) "					\
 	"nmo:isSent(?call) nmo:isAnswered(?call) ?c "			\
 	"WHERE { "							\
 		"?call a nmo:Call ; "					\
@@ -120,7 +124,8 @@
 	"OPTIONAL { ?c nco:hasPostalAddress ?p . } "			\
 	"OPTIONAL { "							\
 		"?c nco:hasAffiliation ?a . "				\
-		"?a nco:hasPhoneNumber ?w . "				\
+		"OPTIONAL { ?a nco:hasPhoneNumber ?w . } " 		\
+		"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "		\
 	"} "								\
 	"} ORDER BY DESC(nmo:receivedDate(?call))"
 
@@ -145,7 +150,8 @@
 	"nco:nameHonorificSuffix(?c) nco:emailAddress(?e) "		\
 	"nco:phoneNumber(?w) nco:pobox(?p) nco:extendedAddress(?p) "	\
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
-	"nco:postalcode(?p) nco:country(?p) ?f nmo:receivedDate(?call) "\
+	"nco:postalcode(?p) nco:country(?p) ?f nco:emailAddress(?ew) "	\
+	"nmo:receivedDate(?call) "					\
 	"nmo:isSent(?call) nmo:isAnswered(?call) ?c "			\
 	"WHERE { "							\
 		"?call a nmo:Call ; "					\
@@ -163,7 +169,8 @@
 	"OPTIONAL { ?c nco:hasPostalAddress ?p . } "			\
 	"OPTIONAL { "							\
 		"?c nco:hasAffiliation ?a . "				\
-		"?a nco:hasPhoneNumber ?w . "				\
+		"OPTIONAL { ?a nco:hasPhoneNumber ?w . } " 		\
+		"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "		\
 	"} "								\
 	"} ORDER BY DESC(nmo:receivedDate(?call))"
 
@@ -188,7 +195,8 @@
 	"nco:nameHonorificSuffix(?c) nco:emailAddress(?e) "		\
 	"nco:phoneNumber(?w) nco:pobox(?p) nco:extendedAddress(?p) "	\
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
-	"nco:postalcode(?p) nco:country(?p) ?f nmo:receivedDate(?call) "\
+	"nco:postalcode(?p) nco:country(?p) ?f nco:emailAddress(?ew)"	\
+	"nmo:receivedDate(?call) "					\
 	"nmo:isSent(?call) nmo:isAnswered(?call) ?c "			\
 	"WHERE { "							\
 		"?call a nmo:Call ; "					\
@@ -205,7 +213,8 @@
 	"OPTIONAL { ?c nco:hasPostalAddress ?p . } "			\
 	"OPTIONAL { "							\
 		"?c nco:hasAffiliation ?a . "				\
-		"?a nco:hasPhoneNumber ?w . "				\
+		"OPTIONAL { ?a nco:hasPhoneNumber ?w . } " 		\
+		"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "		\
 	"} "								\
 	"} ORDER BY DESC(nmo:sentDate(?call))"
 
@@ -229,7 +238,8 @@
 	"nco:nameHonorificSuffix(?c) nco:emailAddress(?e) "		\
 	"nco:phoneNumber(?w) nco:pobox(?p) nco:extendedAddress(?p) "	\
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
-	"nco:postalcode(?p) nco:country(?p) ?f nmo:receivedDate(?call) "\
+	"nco:postalcode(?p) nco:country(?p) ?f nco:emailAddress(?ew) "	\
+	"nmo:receivedDate(?call) "					\
 	"nmo:isSent(?call) nmo:isAnswered(?call) ?c "			\
 	"WHERE { "							\
 	"{ "								\
@@ -243,12 +253,12 @@
 		"nco:phoneNumber ?f . "					\
 		"}"							\
 	"} "								\
-		"OPTIONAL { ?c nco:hasEmailAddress ?e . } "		\
-		"OPTIONAL { ?c nco:hasPostalAddress ?p . } "		\
-		"OPTIONAL { "						\
-			"?c nco:hasAffiliation ?a . "			\
-			"?a nco:hasPhoneNumber ?w . "			\
-		"} "							\
+	"OPTIONAL { ?c nco:hasEmailAddress ?e . } "			\
+	"OPTIONAL { ?c nco:hasPostalAddress ?p . } "			\
+	"OPTIONAL { ?c nco:hasAffiliation ?a . "			\
+		"OPTIONAL { ?a nco:hasPhoneNumber ?w . } " 		\
+		"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "		\
+	"} "								\
 	"} UNION { "							\
 		"?call a nmo:Call ; "					\
 		"nmo:from ?c ; "					\
@@ -260,12 +270,12 @@
 		"nco:phoneNumber ?f . "					\
 		"}"							\
 	"} "								\
-		"OPTIONAL { ?c nco:hasEmailAddress ?e . } "		\
-		"OPTIONAL { ?c nco:hasPostalAddress ?p . } "		\
-		"OPTIONAL { "						\
-			"?c nco:hasAffiliation ?a . "			\
-			"?a nco:hasPhoneNumber ?w . "			\
-		"} "							\
+	"OPTIONAL { ?c nco:hasEmailAddress ?e . } "			\
+	"OPTIONAL { ?c nco:hasPostalAddress ?p . } "			\
+	"OPTIONAL { ?c nco:hasAffiliation ?a . "			\
+		"OPTIONAL { ?a nco:hasPhoneNumber ?w . } " 		\
+		"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "		\
+	"} "								\
 	"} } ORDER BY DESC(nmo:receivedDate(?call))"
 
 #define COMBINED_CALLS_LIST						\
@@ -295,8 +305,8 @@
 	"nco:nameHonorificSuffix(<%s>) nco:emailAddress(?e) "		\
 	"nco:phoneNumber(?w) nco:pobox(?p) nco:extendedAddress(?p) "	\
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
-	"nco:postalcode(?p) nco:country(?p) ?f \"NOTACALL\" \"false\" "	\
-	"\"false\" <%s> "						\
+	"nco:postalcode(?p) nco:country(?p) ?f  nco:emailAddress(?ew)"	\
+	"\"NOTACALL\" \"false\" \"false\" <%s> "			\
 	"WHERE { "							\
 		"<%s> a nco:Contact . "					\
 	"OPTIONAL { <%s> nco:hasPhoneNumber ?h . 			\
@@ -313,7 +323,8 @@
 	"OPTIONAL { <%s> nco:hasPostalAddress ?p . } "			\
 	"OPTIONAL { "							\
 		"<%s> nco:hasAffiliation ?a . "				\
-		"?a nco:hasPhoneNumber ?w . "				\
+		"OPTIONAL { ?a nco:hasPhoneNumber ?w . }" 		\
+		"OPTIONAL { ?a nco:hasEmailAddress ?ew . }"		\
 	"} "								\
 	"}"
 
@@ -651,6 +662,29 @@ static void add_phone_number(struct phonebook_contact *contact,
 	contact->numbers = g_slist_append(contact->numbers, number);
 }
 
+static gchar *find_email(GSList *emails, const char *email)
+{
+	GSList *l;
+
+	for (l = emails; l; l = l->next)
+		if (g_strcmp0(l->data, email) == 0)
+			return l->data;
+
+	return NULL;
+}
+
+static void add_email(struct phonebook_contact *contact, const char *email)
+{
+	if (email == NULL || strlen(email) == 0)
+		return;
+
+	/* Not adding email if there is already added with the same value */
+	if (find_email(contact->emails, email))
+		return;
+
+	contact->emails = g_slist_append(contact->emails, g_strdup(email));
+}
+
 static GString *gen_vcards(GSList *contacts,
 					const struct apparam_field *params)
 {
@@ -733,7 +767,6 @@ add_entry:
 	contact->additional = g_strdup(reply[4]);
 	contact->prefix = g_strdup(reply[5]);
 	contact->suffix = g_strdup(reply[6]);
-	contact->email = g_strdup(reply[7]);
 	contact->pobox = g_strdup(reply[9]);
 	contact->extended = g_strdup(reply[10]);
 	contact->street = g_strdup(reply[11]);
@@ -751,6 +784,10 @@ add_numbers:
 	add_phone_number(contact, reply[COL_WORK_NUMBER], TEL_TYPE_WORK);
 	add_phone_number(contact, reply[COL_FAX_NUMBER], TEL_TYPE_FAX);
 
+	/* Adding emails */
+	add_email(contact, reply[COL_HOME_EMAIL]);
+	add_email(contact, reply[COL_WORK_EMAIL]);
+
 	DBG("contact %p", contact);
 
 	/* Adding contacts data to wrapper struct - this data will be used to
diff --git a/plugins/vcard.c b/plugins/vcard.c
index af00cb5..18b5952 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -344,8 +344,12 @@ void phonebook_add_contact(GString *vcards, struct phonebook_contact *contact,
 		}
 	}
 
-	if (filter & FILTER_EMAIL)
-		vcard_printf_email(vcards, contact->email);
+	if (filter & FILTER_EMAIL) {
+		GSList *l;
+
+		for (l = contact->emails; l; l = l->next)
+			vcard_printf_email(vcards, l->data);
+	}
 
 	if (filter & FILTER_ADR)
 		vcard_printf_adr(vcards, contact);
@@ -372,11 +376,13 @@ void phonebook_contact_free(struct phonebook_contact *contact)
 	g_slist_foreach(contact->numbers, number_free, NULL);
 	g_slist_free(contact->numbers);
 
+	g_slist_foreach(contact->emails, (GFunc) g_free, NULL);
+	g_slist_free(contact->emails);
+
 	g_free(contact->fullname);
 	g_free(contact->given);
 	g_free(contact->family);
 	g_free(contact->additional);
-	g_free(contact->email);
 	g_free(contact->prefix);
 	g_free(contact->suffix);
 	g_free(contact->pobox);
diff --git a/plugins/vcard.h b/plugins/vcard.h
index 06bcd35..fa571e4 100644
--- a/plugins/vcard.h
+++ b/plugins/vcard.h
@@ -45,7 +45,7 @@ struct phonebook_contact {
 	char *family;
 	char *additional;
 	GSList *numbers;
-	char *email;
+	GSList *emails;
 	char *prefix;
 	char *suffix;
 	char *pobox;
-- 
1.7.0.4

