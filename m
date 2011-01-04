Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH] Fix for handling fax and cell phone numbers in PBAP
Date: Tue,  4 Jan 2011 13:35:11 +0200
Message-Id: <1294140911-18377-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Application which stores contacts data in database has been
optimized - fax and cell phones are now stored in "affilation"
structures for better performance. So queries used in
phonebook-tracker need to be changed to handle this properly.
Without that cell and fax phone numbers are not listed in pull
phonebook results.
---
 plugins/phonebook-tracker.c |   71 +++++++++++++++++-------------------------
 1 files changed, 29 insertions(+), 42 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index b7acead..70db5bd 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -86,10 +86,10 @@
 
 #define CONTACTS_QUERY_ALL						\
 "SELECT "								\
-"(SELECT GROUP_CONCAT("							\
-"nco:phoneNumber(?number), \"\30\")"					\
+"(SELECT GROUP_CONCAT(fn:concat(rdf:type(?aff_number),"			\
+"\"\31\", nco:phoneNumber(?aff_number)), \"\30\")"			\
 "WHERE {"								\
-"	?_role nco:hasPhoneNumber ?number"				\
+"	?_role nco:hasPhoneNumber ?aff_number"				\
 "}) "									\
 "nco:fullname(?_contact) "						\
 "nco:nameFamily(?_contact) "						\
@@ -168,7 +168,8 @@
 
 #define MISSED_CALLS_QUERY						\
 "SELECT "								\
-"(SELECT nco:phoneNumber(?role_number) "				\
+"(SELECT fn:concat(rdf:type(?role_number),"				\
+	"\"\31\", nco:phoneNumber(?role_number))"			\
 	"WHERE {"							\
 	"?_role nco:hasPhoneNumber ?role_number "			\
 	"FILTER (?role_number = ?_number)"				\
@@ -247,7 +248,6 @@
 	"?_contact a nco:PersonContact ; "				\
 	"nco:hasPhoneNumber ?_number . "				\
 	"OPTIONAL { ?_contact nco:hasAffiliation ?_role .} "		\
-	"?_contact nco:nameFamily ?_key ."				\
 "} UNION { "								\
 	"?_ncontact a nco:Contact . "					\
 	"?_ncontact nco:hasPhoneNumber ?_number . "			\
@@ -256,7 +256,6 @@
 	"nmo:isAnswered false ;"					\
 	"nmo:isSent false . "						\
 	"?_contact a nco:PersonContact . "				\
-	"?_contact nco:nameFamily ?_key . "				\
 	"?_contact nco:hasAffiliation ?_role . "			\
 	"?_role nco:hasPhoneNumber ?_number . "				\
 "} UNION { "								\
@@ -314,10 +313,11 @@
 
 #define INCOMING_CALLS_QUERY						\
 "SELECT "								\
-"(SELECT nco:phoneNumber(?role_number) "				\
+"(SELECT fn:concat(rdf:type(?role_number),"				\
+	"\"\31\", nco:phoneNumber(?role_number))"			\
 	"WHERE {"							\
-"	?_role nco:hasPhoneNumber ?role_number"				\
-"	FILTER (?role_number = ?_number)"				\
+	"?_role nco:hasPhoneNumber ?role_number "			\
+	"FILTER (?role_number = ?_number)"				\
 "} GROUP BY nco:phoneNumber(?role_number) ) "				\
 	"nco:fullname(?_contact) "					\
 	"nco:nameFamily(?_contact) "					\
@@ -393,7 +393,6 @@
 	"?_contact a nco:PersonContact ; "				\
 	"nco:hasPhoneNumber ?_number . "				\
 	"OPTIONAL { ?_contact nco:hasAffiliation ?_role .} "		\
-	"?_contact nco:nameFamily ?_key ."				\
 "} UNION { "								\
 	"?_ncontact a nco:Contact . "					\
 	"?_ncontact nco:hasPhoneNumber ?_number . "			\
@@ -402,7 +401,6 @@
 	"nmo:isAnswered true ;"						\
 	"nmo:isSent false . "						\
 	"?_contact a nco:PersonContact . "				\
-	"?_contact nco:nameFamily ?_key . "				\
 	"?_contact nco:hasAffiliation ?_role . "			\
 	"?_role nco:hasPhoneNumber ?_number . "				\
 "} UNION { "								\
@@ -459,10 +457,11 @@
 
 #define OUTGOING_CALLS_QUERY						\
 "SELECT "								\
-"(SELECT nco:phoneNumber(?role_number) "				\
+"(SELECT fn:concat(rdf:type(?role_number),"				\
+	"\"\31\", nco:phoneNumber(?role_number))"			\
 	"WHERE {"							\
-"	?_role nco:hasPhoneNumber ?role_number"				\
-"	FILTER (?role_number = ?_number)"				\
+	"?_role nco:hasPhoneNumber ?role_number "			\
+	"FILTER (?role_number = ?_number)"				\
 "} GROUP BY nco:phoneNumber(?role_number) ) "				\
 	"nco:fullname(?_contact) "					\
 	"nco:nameFamily(?_contact) "					\
@@ -537,7 +536,6 @@
 	"?_contact a nco:PersonContact ; "				\
 	"nco:hasPhoneNumber ?_number . "				\
 	"OPTIONAL { ?_contact nco:hasAffiliation ?_role .} "		\
-	"?_contact nco:nameFamily ?_key ."				\
 "} UNION { "								\
 	"?_ncontact a nco:Contact . "					\
 	"?_ncontact nco:hasPhoneNumber ?_number . "			\
@@ -545,7 +543,6 @@
 	"nmo:to ?_ncontact ; "						\
 	"nmo:isSent true . "						\
 	"?_contact a nco:PersonContact . "				\
-	"?_contact nco:nameFamily ?_key . "				\
 	"?_contact nco:hasAffiliation ?_role . "			\
 	"?_role nco:hasPhoneNumber ?_number . "				\
 "} UNION { "								\
@@ -598,10 +595,11 @@
 
 #define COMBINED_CALLS_QUERY						\
 "SELECT "								\
-"(SELECT nco:phoneNumber(?role_number) "				\
+"(SELECT fn:concat(rdf:type(?role_number),"				\
+	"\"\31\", nco:phoneNumber(?role_number))"			\
 	"WHERE {"							\
-"	?_role nco:hasPhoneNumber ?role_number"				\
-"	FILTER (?role_number = ?_number)"				\
+	"?_role nco:hasPhoneNumber ?role_number "			\
+	"FILTER (?role_number = ?_number)"				\
 "} GROUP BY nco:phoneNumber(?role_number) ) "				\
 	"nco:fullname(?_contact) "					\
 	"nco:nameFamily(?_contact) "					\
@@ -676,7 +674,6 @@
 	"?_contact a nco:PersonContact ; "				\
 	"nco:hasPhoneNumber ?_number . "				\
 	"OPTIONAL { ?_contact nco:hasAffiliation ?_role .} "		\
-	"?_contact nco:nameFamily ?_key ."				\
 "} UNION { "								\
 	"?_ncontact a nco:Contact . "					\
 	"?_ncontact nco:hasPhoneNumber ?_number . "			\
@@ -684,7 +681,6 @@
 	"nmo:to ?_ncontact ; "						\
 	"nmo:isSent true . "						\
 	"?_contact a nco:PersonContact . "				\
-	"?_contact nco:nameFamily ?_key . "				\
 	"?_contact nco:hasAffiliation ?_role . "			\
 	"?_role nco:hasPhoneNumber ?_number . "				\
 "} UNION { "								\
@@ -708,7 +704,6 @@
 	"?_contact a nco:PersonContact ; "				\
 	"nco:hasPhoneNumber ?_number . "				\
 	"OPTIONAL { ?_contact nco:hasAffiliation ?_role .} "		\
-	"?_contact nco:nameFamily ?_key ."				\
 "} UNION { "								\
 	"?_ncontact a nco:Contact . "					\
 	"?_ncontact nco:hasPhoneNumber ?_number . "			\
@@ -716,7 +711,6 @@
 	"nmo:from ?_ncontact ; "					\
 	"nmo:isSent false . "						\
 	"?_contact a nco:PersonContact . "				\
-	"?_contact nco:nameFamily ?_key . "				\
 	"?_contact nco:hasAffiliation ?_role . "			\
 	"?_role nco:hasPhoneNumber ?_number . "				\
 "} UNION { "								\
@@ -791,10 +785,10 @@
 
 #define CONTACTS_QUERY_FROM_URI						\
 "SELECT "								\
-"(SELECT GROUP_CONCAT("							\
-"nco:phoneNumber(?number), \"\30\")"					\
+"(SELECT GROUP_CONCAT(fn:concat(rdf:type(?aff_number),"			\
+"\"\31\", nco:phoneNumber(?aff_number)), \"\30\")"			\
 "WHERE {"								\
-"	?_role nco:hasPhoneNumber ?number"				\
+"	?_role nco:hasPhoneNumber ?aff_number"				\
 "}) "									\
 "nco:fullname(<%s>) "							\
 "nco:nameFamily(<%s>) "							\
@@ -1452,7 +1446,8 @@ static enum phonebook_number_type get_phone_type(const char *affilation)
 	return TEL_TYPE_OTHER;
 }
 
-static void add_main_number(struct phonebook_contact *contact, char *pnumber)
+static void add_aff_number(struct phonebook_contact *contact, char *pnumber,
+								char *aff_type)
 {
 	char **num_parts;
 	char *type, *number;
@@ -1480,7 +1475,9 @@ static void add_main_number(struct phonebook_contact *contact, char *pnumber)
 	else if (g_strrstr(type, MOBILE_NUM_TYPE))
 		add_phone_number(contact, number, TEL_TYPE_MOBILE);
 	else
-		add_phone_number(contact, number, TEL_TYPE_OTHER);
+		/* if this is no fax/mobile phone, then adding phone number
+		 * type based on type of the affilation field */
+		add_phone_number(contact, number, get_phone_type(aff_type));
 
 failed:
 	g_strfreev(num_parts);
@@ -1489,28 +1486,18 @@ failed:
 static void contact_add_numbers(struct phonebook_contact *contact,
 								char **reply)
 {
-	char **aff_numbers, **con_numbers;
+	char **aff_numbers;
 	int i;
 
-	/* Filling phonegit  numbers from contact's affilation */
+	/* Filling phone numbers from contact's affilation */
 	aff_numbers = g_strsplit(reply[COL_PHONE_AFF], MAIN_DELIM, MAX_FIELDS);
 
 	if (aff_numbers)
 		for(i = 0;aff_numbers[i]; ++i)
-			add_phone_number(contact, aff_numbers[i],
-					get_phone_type(reply[COL_AFF_TYPE]));
+			add_aff_number(contact, aff_numbers[i],
+							reply[COL_AFF_TYPE]);
 
 	g_strfreev(aff_numbers);
-
-	/* Filling phone numbers directly from contact's struct */
-	con_numbers = g_strsplit(reply[COL_PHONE_CONTACT], MAIN_DELIM,
-								MAX_FIELDS);
-
-	if (con_numbers)
-		for(i = 0; con_numbers[i] != NULL; ++i)
-			add_main_number(contact, con_numbers[i]);
-
-	g_strfreev(con_numbers);
 }
 
 static enum phonebook_email_type get_email_type(const char *affilation)
-- 
1.7.0.4

