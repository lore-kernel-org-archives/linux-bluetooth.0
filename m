Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH] Add support for FAX number in phonebook-tracker.c
Date: Fri, 13 Aug 2010 13:58:37 +0300
Message-Id: <1281697117-23072-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously all fax numbers were treated as home phone numbers. Now
fetching fax field as additional column in tracker query. Data from this
column is filled as phone number with FAX type set. All pull queries are
modified that way to suport fax number type.
---
 plugins/phonebook-tracker.c |  129 +++++++++++++++++++++++++++++++++---------
 1 files changed, 101 insertions(+), 28 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 8300fc7..705460d 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -43,20 +43,36 @@
 #define TRACKER_RESOURCES_INTERFACE "org.freedesktop.Tracker1.Resources"
 
 #define TRACKER_DEFAULT_CONTACT_ME "http://www.semanticdesktop.org/ontologies/2007/03/22/nco#default-contact-me"
-#define CONTACTS_ID_COL 19
+#define CONTACTS_ID_COL 20
+#define PULL_QUERY_COL_AMOUNT 21
+#define COL_HOME_NUMBER 0
+#define COL_WORK_NUMBER 8
+#define COL_FAX_NUMBER 16
+#define COL_DATE 17
+#define COL_SENT 18
+#define COL_ANSWERED 19
 
 #define CONTACTS_QUERY_ALL						\
-	"SELECT nco:phoneNumber(?h) nco:fullname(?c) "			\
+	"SELECT ?v nco:fullname(?c) "					\
 	"nco:nameFamily(?c) nco:nameGiven(?c) "				\
 	"nco:nameAdditional(?c) nco:nameHonorificPrefix(?c) "		\
 	"nco:nameHonorificSuffix(?c) nco:emailAddress(?e) "		\
 	"nco:phoneNumber(?w) nco:pobox(?p) nco:extendedAddress(?p) "	\
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
-	"nco:postalcode(?p) nco:country(?p) \"NOTACALL\" \"false\" "	\
+	"nco:postalcode(?p) nco:country(?p) ?f \"NOTACALL\" \"false\" "	\
 	"\"false\" ?c "							\
 	"WHERE { "							\
 		"?c a nco:PersonContact . "				\
-	"OPTIONAL { ?c nco:hasPhoneNumber ?h . } "			\
+	"OPTIONAL { ?c nco:hasPhoneNumber ?h . 				\
+		OPTIONAL {"						\
+		"?h a nco:FaxNumber ; "					\
+		"nco:phoneNumber ?f . "					\
+		"}"							\
+		"OPTIONAL {"						\
+		"?h a nco:VoicePhoneNumber ; "				\
+		"nco:phoneNumber ?v"					\
+		"}"							\
+	"}"								\
 	"OPTIONAL { ?c nco:hasEmailAddress ?e . } "			\
 	"OPTIONAL { ?c nco:hasPostalAddress ?p . } "			\
 	"OPTIONAL { "							\
@@ -80,13 +96,13 @@
 	"} GROUP BY ?c"
 
 #define MISSED_CALLS_QUERY						\
-	"SELECT nco:phoneNumber(?h) nco:fullname(?c) "			\
+	"SELECT ?v nco:fullname(?c) "					\
 	"nco:nameFamily(?c) nco:nameGiven(?c) "				\
 	"nco:nameAdditional(?c) nco:nameHonorificPrefix(?c) "		\
 	"nco:nameHonorificSuffix(?c) nco:emailAddress(?e) "		\
 	"nco:phoneNumber(?w) nco:pobox(?p) nco:extendedAddress(?p) "	\
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
-	"nco:postalcode(?p) nco:country(?p) nmo:receivedDate(?call) "	\
+	"nco:postalcode(?p) nco:country(?p) ?f nmo:receivedDate(?call) "\
 	"nmo:isSent(?call) nmo:isAnswered(?call) ?c "			\
 	"WHERE { "							\
 		"?call a nmo:Call ; "					\
@@ -94,7 +110,16 @@
 		"nmo:isSent false ; "					\
 		"nmo:isAnswered false ."				\
 		"?c a nco:Contact . "					\
-	"OPTIONAL { ?c nco:hasPhoneNumber ?h . } "			\
+	"OPTIONAL { ?c nco:hasPhoneNumber ?h . "			\
+		"OPTIONAL {"						\
+		"?h a nco:FaxNumber ; "					\
+		"nco:phoneNumber ?f . "					\
+		"}"							\
+		"OPTIONAL {"						\
+		"?h a nco:VoicePhoneNumber ; "				\
+		"nco:phoneNumber ?v"					\
+		"} "							\
+	"} "								\
 	"OPTIONAL { ?c nco:hasEmailAddress ?e . } "			\
 	"OPTIONAL { ?c nco:hasPostalAddress ?p . } "			\
 	"OPTIONAL { "							\
@@ -118,13 +143,13 @@
 	"} ORDER BY DESC(nmo:receivedDate(?call))"
 
 #define INCOMING_CALLS_QUERY						\
-	"SELECT nco:phoneNumber(?h) nco:fullname(?c) "			\
+	"SELECT ?v nco:fullname(?c) "					\
 	"nco:nameFamily(?c) nco:nameGiven(?c) "				\
 	"nco:nameAdditional(?c) nco:nameHonorificPrefix(?c) "		\
 	"nco:nameHonorificSuffix(?c) nco:emailAddress(?e) "		\
 	"nco:phoneNumber(?w) nco:pobox(?p) nco:extendedAddress(?p) "	\
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
-	"nco:postalcode(?p) nco:country(?p) nmo:receivedDate(?call) "	\
+	"nco:postalcode(?p) nco:country(?p) ?f nmo:receivedDate(?call) "\
 	"nmo:isSent(?call) nmo:isAnswered(?call) ?c "			\
 	"WHERE { "							\
 		"?call a nmo:Call ; "					\
@@ -132,7 +157,16 @@
 		"nmo:isSent false ; "					\
 		"nmo:isAnswered true ."					\
 		"?c a nco:Contact . "					\
-	"OPTIONAL { ?c nco:hasPhoneNumber ?h . } "			\
+	"OPTIONAL { ?c nco:hasPhoneNumber ?h . "			\
+		"OPTIONAL {"						\
+		"?h a nco:FaxNumber ; "					\
+		"nco:phoneNumber ?f . "					\
+		"}"							\
+		"OPTIONAL {"						\
+		"?h a nco:VoicePhoneNumber ; "				\
+		"nco:phoneNumber ?v"					\
+		"} "							\
+	"} "								\
 	"OPTIONAL { ?c nco:hasEmailAddress ?e . } "			\
 	"OPTIONAL { ?c nco:hasPostalAddress ?p . } "			\
 	"OPTIONAL { "							\
@@ -156,20 +190,29 @@
 	"} ORDER BY DESC(nmo:receivedDate(?call))"
 
 #define OUTGOING_CALLS_QUERY						\
-	"SELECT nco:phoneNumber(?h) nco:fullname(?c) "			\
+	"SELECT ?v nco:fullname(?c) "					\
 	"nco:nameFamily(?c) nco:nameGiven(?c) "				\
 	"nco:nameAdditional(?c) nco:nameHonorificPrefix(?c) "		\
 	"nco:nameHonorificSuffix(?c) nco:emailAddress(?e) "		\
 	"nco:phoneNumber(?w) nco:pobox(?p) nco:extendedAddress(?p) "	\
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
-	"nco:postalcode(?p) nco:country(?p) nmo:receivedDate(?call) "	\
+	"nco:postalcode(?p) nco:country(?p) ?f nmo:receivedDate(?call) "\
 	"nmo:isSent(?call) nmo:isAnswered(?call) ?c "			\
 	"WHERE { "							\
 		"?call a nmo:Call ; "					\
 		"nmo:to ?c ; "						\
 		"nmo:isSent true . "					\
 		"?c a nco:Contact . "					\
-	"OPTIONAL { ?c nco:hasPhoneNumber ?h . } "			\
+	"OPTIONAL { ?c nco:hasPhoneNumber ?h . "			\
+		"OPTIONAL {"						\
+		"?h a nco:FaxNumber ; "					\
+		"nco:phoneNumber ?f . "					\
+		"}"							\
+		"OPTIONAL {"						\
+		"?h a nco:VoicePhoneNumber ; "				\
+		"nco:phoneNumber ?v"					\
+		"} "							\
+	"} "								\
 	"OPTIONAL { ?c nco:hasEmailAddress ?e . } "			\
 	"OPTIONAL { ?c nco:hasPostalAddress ?p . } "			\
 	"OPTIONAL { "							\
@@ -188,17 +231,17 @@
 		"nmo:to ?c ; "						\
 		"nmo:isSent true . "					\
 		"?c a nco:Contact . "					\
-	"OPTIONAL { ?c nco:hasPhoneNumber ?h . } "				\
+	"OPTIONAL { ?c nco:hasPhoneNumber ?h . } "			\
 	"} ORDER BY DESC(nmo:sentDate(?call))"
 
 #define COMBINED_CALLS_QUERY						\
-	"SELECT nco:phoneNumber(?h) nco:fullname(?c) "			\
+	"SELECT ?v nco:fullname(?c) "					\
 	"nco:nameFamily(?c) nco:nameGiven(?c) "				\
 	"nco:nameAdditional(?c) nco:nameHonorificPrefix(?c) "		\
 	"nco:nameHonorificSuffix(?c) nco:emailAddress(?e) "		\
 	"nco:phoneNumber(?w) nco:pobox(?p) nco:extendedAddress(?p) "	\
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
-	"nco:postalcode(?p) nco:country(?p) nmo:receivedDate(?call) "	\
+	"nco:postalcode(?p) nco:country(?p) ?f nmo:receivedDate(?call) "\
 	"nmo:isSent(?call) nmo:isAnswered(?call) ?c "			\
 	"WHERE { "							\
 	"{ "								\
@@ -206,7 +249,16 @@
 		"nmo:to ?c ; "						\
 		"nmo:isSent true . "					\
 		"?c a nco:Contact . "					\
-		"OPTIONAL { ?c nco:hasPhoneNumber ?h . } "		\
+	"OPTIONAL { ?c nco:hasPhoneNumber ?h . "			\
+		"OPTIONAL {"						\
+		"?h a nco:FaxNumber ; "					\
+		"nco:phoneNumber ?f . "					\
+		"}"							\
+		"OPTIONAL {"						\
+		"?h a nco:VoicePhoneNumber ; "				\
+		"nco:phoneNumber ?v"					\
+		"} "							\
+	"} "								\
 		"OPTIONAL { ?c nco:hasEmailAddress ?e . } "		\
 		"OPTIONAL { ?c nco:hasPostalAddress ?p . } "		\
 		"OPTIONAL { "						\
@@ -218,7 +270,16 @@
 		"nmo:from ?c ; "					\
 		"nmo:isSent false . "					\
 		"?c a nco:Contact . "					\
-		"OPTIONAL { ?c nco:hasPhoneNumber ?h . } "		\
+	"OPTIONAL { ?c nco:hasPhoneNumber ?h . "			\
+		"OPTIONAL {"						\
+		"?h a nco:FaxNumber ; "					\
+		"nco:phoneNumber ?f . "					\
+		"}"							\
+		"OPTIONAL {"						\
+		"?h a nco:VoicePhoneNumber ; "				\
+		"nco:phoneNumber ?v"					\
+		"} "							\
+	"} "								\
 		"OPTIONAL { ?c nco:hasEmailAddress ?e . } "		\
 		"OPTIONAL { ?c nco:hasPostalAddress ?p . } "		\
 		"OPTIONAL { "						\
@@ -248,17 +309,26 @@
 
 
 #define CONTACTS_QUERY_FROM_URI						\
-	"SELECT nco:phoneNumber(?h) nco:fullname(<%s>) "		\
+	"SELECT ?v nco:fullname(<%s>) "					\
 	"nco:nameFamily(<%s>) nco:nameGiven(<%s>) "			\
 	"nco:nameAdditional(<%s>) nco:nameHonorificPrefix(<%s>) "	\
 	"nco:nameHonorificSuffix(<%s>) nco:emailAddress(?e) "		\
 	"nco:phoneNumber(?w) nco:pobox(?p) nco:extendedAddress(?p) "	\
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
-	"nco:postalcode(?p) nco:country(?p) \"NOTACALL\" \"false\" "	\
-	"\"false\" <%s> "							\
+	"nco:postalcode(?p) nco:country(?p) ?f \"NOTACALL\" \"false\" "	\
+	"\"false\" <%s> "						\
 	"WHERE { "							\
 		"<%s> a nco:Contact . "					\
-	"OPTIONAL { <%s> nco:hasPhoneNumber ?h . } "			\
+	"OPTIONAL { <%s> nco:hasPhoneNumber ?h . 			\
+		OPTIONAL {"						\
+		"?h a nco:FaxNumber ; "					\
+		"nco:phoneNumber ?f . "					\
+		"}"							\
+		"OPTIONAL {"						\
+		"?h a nco:VoicePhoneNumber ; "				\
+		"nco:phoneNumber ?v"					\
+		"}"							\
+	"}"								\
 	"OPTIONAL { <%s> nco:hasEmailAddress ?e . } "			\
 	"OPTIONAL { <%s> nco:hasPostalAddress ?p . } "			\
 	"OPTIONAL { "							\
@@ -660,7 +730,8 @@ static void pull_contacts(char **reply, int num_fields, void *user_data)
 	}
 
 	if (i == num_fields - 4 &&
-			!g_str_equal(reply[19], TRACKER_DEFAULT_CONTACT_ME))
+			!g_str_equal(reply[CONTACTS_ID_COL],
+					TRACKER_DEFAULT_CONTACT_ME))
 		return;
 
 	data->index++;
@@ -691,12 +762,14 @@ add_entry:
 	contact->postal = g_strdup(reply[14]);
 	contact->country = g_strdup(reply[15]);
 
-	set_call_type(contact, reply[16], reply[17], reply[18]);
+	set_call_type(contact, reply[COL_DATE], reply[COL_SENT],
+			reply[COL_ANSWERED]);
 
 add_numbers:
 	/* Adding phone numbers to contact struct */
-	add_phone_number(contact, reply[0], TEL_TYPE_HOME);
-	add_phone_number(contact, reply[8], TEL_TYPE_WORK);
+	add_phone_number(contact, reply[COL_HOME_NUMBER], TEL_TYPE_HOME);
+	add_phone_number(contact, reply[COL_WORK_NUMBER], TEL_TYPE_WORK);
+	add_phone_number(contact, reply[COL_FAX_NUMBER], TEL_TYPE_FAX);
 
 	DBG("contact %p", contact);
 
@@ -868,7 +941,7 @@ int phonebook_pull(const char *name, const struct apparam_field *params,
 	data->user_data = user_data;
 	data->cb = cb;
 
-	return query_tracker(query, 20, pull_contacts, data);
+	return query_tracker(query, PULL_QUERY_COL_AMOUNT, pull_contacts, data);
 }
 
 int phonebook_get_entry(const char *folder, const char *id,
@@ -890,7 +963,7 @@ int phonebook_get_entry(const char *folder, const char *id,
 	query = g_strdup_printf(CONTACTS_QUERY_FROM_URI, id, id, id, id, id,
 						id, id, id, id, id, id, id);
 
-	ret = query_tracker(query, 20, pull_contacts, data);
+	ret = query_tracker(query, PULL_QUERY_COL_AMOUNT, pull_contacts, data);
 
 	g_free(query);
 
-- 
1.7.0.4

