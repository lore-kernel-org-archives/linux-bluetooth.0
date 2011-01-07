Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH] Remove unused columns in PBAP queries
Date: Fri,  7 Jan 2011 11:03:38 +0200
Message-Id: <1294391018-3109-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Application for filling contact's data does not use
"contact:" for attaching email, phones, and addresses
without context. This fix removes columns for getting
mentioned data from "contact:" context - they are no
longer needed (all phone, email and addresses are now
fetched from "affilation" structures).
---
 plugins/phonebook-tracker.c |  184 ++++--------------------------------------
 1 files changed, 18 insertions(+), 166 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 936ff03..25eca62 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -46,7 +46,7 @@
 #define AFFILATION_HOME "Home"
 #define AFFILATION_WORK "Work"
 #define ADDR_FIELD_AMOUNT 7
-#define PULL_QUERY_COL_AMOUNT 26
+#define PULL_QUERY_COL_AMOUNT 23
 #define COUNT_QUERY_COL_AMOUNT 1
 
 #define COL_PHONE_AFF 0 /* work/home phone numbers */
@@ -56,25 +56,22 @@
 #define COL_ADDITIONAL_NAME 4
 #define COL_NAME_PREFIX 5
 #define COL_NAME_SUFFIX 6
-#define COL_EMAIL_CONTACT 7 /*email's for other category */
-#define COL_ADDR_AFF 8 /* addresses from affilation */
-#define COL_ADDR_CONTACT 9 /* addresses from contacts */
-#define COL_PHONE_CONTACT 10 /* phone numbers from contact's */
-#define COL_BIRTH_DATE 11
-#define COL_NICKNAME 12
-#define COL_URL 13
-#define COL_PHOTO 14
-#define COL_ORG_ROLE 15
-#define COL_UID 16
-#define COL_TITLE 17
-#define COL_AFF_TYPE 18
-#define COL_ORG_NAME 19
-#define COL_ORG_DEPARTMENT 20
-#define COL_EMAIL_AFF 21 /* email's from affilation (work/home) */
-#define COL_DATE 22
-#define COL_SENT 23
-#define COL_ANSWERED 24
-#define CONTACTS_ID_COL 25
+#define COL_ADDR_AFF 7 /* addresses from affilation */
+#define COL_BIRTH_DATE 8
+#define COL_NICKNAME 9
+#define COL_URL 10
+#define COL_PHOTO 11
+#define COL_ORG_ROLE 12
+#define COL_UID 13
+#define COL_TITLE 14
+#define COL_AFF_TYPE 15
+#define COL_ORG_NAME 16
+#define COL_ORG_DEPARTMENT 17
+#define COL_EMAIL_AFF 18 /* email's from affilation (work/home) */
+#define COL_DATE 19
+#define COL_SENT 20
+#define COL_ANSWERED 21
+#define CONTACTS_ID_COL 22
 #define CONTACT_ID_PREFIX "contact:"
 
 #define FAX_NUM_TYPE "http://www.semanticdesktop.org/ontologies/2007/03/22/nco#FaxNumber"
@@ -97,11 +94,6 @@
 "nco:nameAdditional(?_contact) "					\
 "nco:nameHonorificPrefix(?_contact) "					\
 "nco:nameHonorificSuffix(?_contact) "					\
-"(SELECT GROUP_CONCAT(?emailaddress_other, \"\30\") " 			\
-	"WHERE {"							\
-	"?_contact nco:hasEmailAddress "				\
-			"[nco:emailAddress ?emailaddress_other]"	\
-	"}) "								\
 "(SELECT GROUP_CONCAT(fn:concat("					\
 "tracker:coalesce(nco:pobox(?aff_addr), \"\"), \";\","			\
 "tracker:coalesce(nco:extendedAddress(?aff_addr), \"\"), \";\","	\
@@ -115,22 +107,6 @@
 "WHERE {"								\
 "?_role nco:hasPostalAddress ?aff_addr"					\
 "}) "									\
-"(SELECT GROUP_CONCAT(fn:concat("					\
-"tracker:coalesce(nco:pobox(?oth_addr), \"\"), \";\","			\
-"tracker:coalesce(nco:extendedAddress(?oth_addr), \"\"), \";\","	\
-"tracker:coalesce(nco:streetAddress(?oth_addr), \"\"), \";\","		\
-"tracker:coalesce(nco:locality(?oth_addr), \"\"), \";\","		\
-"tracker:coalesce(nco:region(?oth_addr), \"\"), \";\","			\
-"tracker:coalesce(nco:postalcode(?oth_addr), \"\"), \";\","		\
-"tracker:coalesce(nco:country(?oth_addr), \"\") ),\"\30\")"		\
-"WHERE {"								\
-"	?_contact nco:hasPostalAddress ?oth_addr"			\
-"}) "									\
-"(SELECT GROUP_CONCAT(fn:concat(rdf:type(?contact_number),"		\
-"\"\31\", nco:phoneNumber(?contact_number)), \"\30\")"			\
-"WHERE {"								\
-"	?_contact nco:hasPhoneNumber ?contact_number"			\
-"}) "									\
 "nco:birthDate(?_contact) "						\
 "nco:nickname(?_contact) "						\
 "nco:url(?_contact) "							\
@@ -185,11 +161,6 @@
 	"nco:nameAdditional(?_contact) "				\
 	"nco:nameHonorificPrefix(?_contact) "				\
 	"nco:nameHonorificSuffix(?_contact) "				\
-"(SELECT GROUP_CONCAT(?emailaddress_other, \"\30\") " 			\
-	"WHERE {"							\
-	"?_contact nco:hasEmailAddress "				\
-			"[nco:emailAddress ?emailaddress_other]"	\
-	"}) "								\
 "(SELECT GROUP_CONCAT(fn:concat("					\
 	"tracker:coalesce(nco:pobox(?aff_addr), \"\"), \";\","		\
 	"tracker:coalesce(nco:extendedAddress(?aff_addr), \"\"), \";\","\
@@ -204,27 +175,6 @@
 	"?_contact nco:hasAffiliation ?c_role . "			\
 	"?c_role nco:hasPostalAddress ?aff_addr"			\
 	"}) "								\
-"(SELECT GROUP_CONCAT(fn:concat("					\
-	"tracker:coalesce(nco:pobox(?oth_addr), \"\"), \";\","		\
-	"tracker:coalesce(nco:extendedAddress(?oth_addr), \"\"), \";\","\
-	"tracker:coalesce(nco:streetAddress(?oth_addr), \"\"), \";\","	\
-	"tracker:coalesce(nco:locality(?oth_addr), \"\"), \";\","	\
-	"tracker:coalesce(nco:region(?oth_addr), \"\"), \";\","		\
-	"tracker:coalesce(nco:postalcode(?oth_addr), \"\"), \";\","	\
-	"tracker:coalesce(nco:country(?oth_addr), \"\") ),\"\30\")"	\
-	"WHERE {"							\
-	"?_contact nco:hasPostalAddress ?oth_addr"			\
-	"}) "								\
-"(SELECT fn:concat(rdf:type(?contact_number),"				\
-	"\"\31\", nco:phoneNumber(?contact_number))"			\
-	"WHERE {"							\
-	"{"								\
-"		?_contact nco:hasPhoneNumber ?contact_number . "	\
-"		FILTER (?contact_number = ?_number) "			\
-"	} UNION { "							\
-"		?_unb_contact nco:hasPhoneNumber ?contact_number . "	\
-"	} "								\
-"}GROUP BY nco:phoneNumber(?contact_number) ) "				\
 	"nco:birthDate(?_contact) "					\
 	"nco:nickname(?_contact) "					\
 	"nco:url(?_contact) "						\
@@ -337,11 +287,6 @@
 	"nco:nameAdditional(?_contact) "				\
 	"nco:nameHonorificPrefix(?_contact) "				\
 	"nco:nameHonorificSuffix(?_contact) "				\
-"(SELECT GROUP_CONCAT(?emailaddress_other, \"\30\") " 			\
-	"WHERE {"							\
-	"?_contact nco:hasEmailAddress "				\
-			"[nco:emailAddress ?emailaddress_other]"	\
-	"}) "								\
 "(SELECT GROUP_CONCAT(fn:concat("					\
 	"tracker:coalesce(nco:pobox(?aff_addr), \"\"), \";\","		\
 	"tracker:coalesce(nco:extendedAddress(?aff_addr), \"\"), \";\","\
@@ -356,27 +301,6 @@
 	"?_contact nco:hasAffiliation ?c_role . "			\
 	"?c_role nco:hasPostalAddress ?aff_addr"			\
 	"}) "								\
-"(SELECT GROUP_CONCAT(fn:concat("					\
-	"tracker:coalesce(nco:pobox(?oth_addr), \"\"), \";\","		\
-	"tracker:coalesce(nco:extendedAddress(?oth_addr), \"\"), \";\","\
-	"tracker:coalesce(nco:streetAddress(?oth_addr), \"\"), \";\","	\
-	"tracker:coalesce(nco:locality(?oth_addr), \"\"), \";\","	\
-	"tracker:coalesce(nco:region(?oth_addr), \"\"), \";\","		\
-	"tracker:coalesce(nco:postalcode(?oth_addr), \"\"), \";\","	\
-	"tracker:coalesce(nco:country(?oth_addr), \"\") ),\"\30\")"	\
-	"WHERE {"							\
-	"?_contact nco:hasPostalAddress ?oth_addr"			\
-	"}) "								\
-"(SELECT fn:concat(rdf:type(?contact_number),"				\
-	"\"\31\", nco:phoneNumber(?contact_number))"			\
-	"WHERE {"							\
-	"{"								\
-"		?_contact nco:hasPhoneNumber ?contact_number . "	\
-"		FILTER (?contact_number = ?_number) "			\
-"	} UNION { "							\
-"		?_unb_contact nco:hasPhoneNumber ?contact_number . "	\
-"	} "								\
-	"}GROUP BY nco:phoneNumber(?contact_number) ) "			\
 	"nco:birthDate(?_contact) "					\
 	"nco:nickname(?_contact) "					\
 	"nco:url(?_contact) "						\
@@ -488,11 +412,6 @@
 	"nco:nameAdditional(?_contact) "				\
 	"nco:nameHonorificPrefix(?_contact) "				\
 	"nco:nameHonorificSuffix(?_contact) "				\
-"(SELECT GROUP_CONCAT(?emailaddress_other, \"\30\") " 			\
-	"WHERE {"							\
-	"?_contact nco:hasEmailAddress "				\
-			"[nco:emailAddress ?emailaddress_other]"	\
-	"}) "								\
 "(SELECT GROUP_CONCAT(fn:concat("					\
 	"tracker:coalesce(nco:pobox(?aff_addr), \"\"), \";\","		\
 	"tracker:coalesce(nco:extendedAddress(?aff_addr), \"\"), \";\","\
@@ -507,27 +426,6 @@
 	"?_contact nco:hasAffiliation ?c_role . "			\
 	"?c_role nco:hasPostalAddress ?aff_addr"			\
 	"}) "								\
-"(SELECT GROUP_CONCAT(fn:concat("					\
-	"tracker:coalesce(nco:pobox(?oth_addr), \"\"), \";\","		\
-	"tracker:coalesce(nco:extendedAddress(?oth_addr), \"\"), \";\","\
-	"tracker:coalesce(nco:streetAddress(?oth_addr), \"\"), \";\","	\
-	"tracker:coalesce(nco:locality(?oth_addr), \"\"), \";\","	\
-	"tracker:coalesce(nco:region(?oth_addr), \"\"), \";\","		\
-	"tracker:coalesce(nco:postalcode(?oth_addr), \"\"), \";\","	\
-	"tracker:coalesce(nco:country(?oth_addr), \"\") ),\"\30\")"	\
-	"WHERE {"							\
-	"?_contact nco:hasPostalAddress ?oth_addr"			\
-	"}) "								\
-"(SELECT fn:concat(rdf:type(?contact_number),"				\
-	"\"\31\", nco:phoneNumber(?contact_number))"			\
-	"WHERE {"							\
-	"{"								\
-"		?_contact nco:hasPhoneNumber ?contact_number . "	\
-"		FILTER (?contact_number = ?_number) "			\
-"	} UNION { "							\
-"		?_unb_contact nco:hasPhoneNumber ?contact_number . "	\
-"	} "								\
-	"}GROUP BY nco:phoneNumber(?contact_number) ) "			\
 	"nco:birthDate(?_contact) "					\
 	"nco:nickname(?_contact) "					\
 	"nco:url(?_contact) "						\
@@ -633,11 +531,6 @@
 	"nco:nameAdditional(?_contact) "				\
 	"nco:nameHonorificPrefix(?_contact) "				\
 	"nco:nameHonorificSuffix(?_contact) "				\
-"(SELECT GROUP_CONCAT(?emailaddress_other, \"\30\") " 			\
-	"WHERE {"							\
-	"?_contact nco:hasEmailAddress "				\
-			"[nco:emailAddress ?emailaddress_other]"	\
-	"}) "								\
 "(SELECT GROUP_CONCAT(fn:concat("					\
 	"tracker:coalesce(nco:pobox(?aff_addr), \"\"), \";\","		\
 	"tracker:coalesce(nco:extendedAddress(?aff_addr), \"\"), \";\","\
@@ -652,27 +545,6 @@
 	"?_contact nco:hasAffiliation ?c_role . "			\
 	"?c_role nco:hasPostalAddress ?aff_addr"			\
 	"}) "								\
-"(SELECT GROUP_CONCAT(fn:concat("					\
-	"tracker:coalesce(nco:pobox(?oth_addr), \"\"), \";\","		\
-	"tracker:coalesce(nco:extendedAddress(?oth_addr), \"\"), \";\","\
-	"tracker:coalesce(nco:streetAddress(?oth_addr), \"\"), \";\","	\
-	"tracker:coalesce(nco:locality(?oth_addr), \"\"), \";\","	\
-	"tracker:coalesce(nco:region(?oth_addr), \"\"), \";\","		\
-	"tracker:coalesce(nco:postalcode(?oth_addr), \"\"), \";\","	\
-	"tracker:coalesce(nco:country(?oth_addr), \"\") ),\"\30\")"	\
-	"WHERE {"							\
-	"?_contact nco:hasPostalAddress ?oth_addr"			\
-	"}) "								\
-"(SELECT fn:concat(rdf:type(?contact_number),"				\
-	"\"\31\", nco:phoneNumber(?contact_number))"			\
-	"WHERE {"							\
-	"{"								\
-"		?_contact nco:hasPhoneNumber ?contact_number . "	\
-"		FILTER (?contact_number = ?_number) "			\
-"	} UNION { "							\
-"		?_unb_contact nco:hasPhoneNumber ?contact_number . "	\
-"	} "								\
-	"}GROUP BY nco:phoneNumber(?contact_number) ) "			\
 	"nco:birthDate(?_contact) "					\
 	"nco:nickname(?_contact) "					\
 	"nco:url(?_contact) "						\
@@ -829,10 +701,6 @@
 "nco:nameAdditional(<%s>) "						\
 "nco:nameHonorificPrefix(<%s>) "					\
 "nco:nameHonorificSuffix(<%s>) "					\
-"(SELECT GROUP_CONCAT(?emailaddress_other, \"\30\")"			\
-"WHERE {"								\
-"	<%s> nco:hasEmailAddress [nco:emailAddress ?emailaddress_other]"\
-"}) "									\
 "(SELECT GROUP_CONCAT(fn:concat("					\
 "tracker:coalesce(nco:pobox(?aff_addr), \"\"), \";\","			\
 "tracker:coalesce(nco:extendedAddress(?aff_addr), \"\"), \";\","	\
@@ -846,22 +714,6 @@
 "WHERE {"								\
 "?_role nco:hasPostalAddress ?aff_addr"					\
 "}) "									\
-"(SELECT GROUP_CONCAT(fn:concat("					\
-"tracker:coalesce(nco:pobox(?oth_addr), \"\"), \";\","			\
-"tracker:coalesce(nco:extendedAddress(?oth_addr), \"\"), \";\","	\
-"tracker:coalesce(nco:streetAddress(?oth_addr), \"\"), \";\","		\
-"tracker:coalesce(nco:locality(?oth_addr), \"\"), \";\","		\
-"tracker:coalesce(nco:region(?oth_addr), \"\"), \";\","			\
-"tracker:coalesce(nco:postalcode(?oth_addr), \"\"), \";\","		\
-"tracker:coalesce(nco:country(?oth_addr), \"\") ),\"\30\")"		\
-"WHERE {"								\
-"	<%s> nco:hasPostalAddress ?oth_addr"				\
-"}) "									\
-"(SELECT GROUP_CONCAT(fn:concat(rdf:type(?contact_number),"		\
-"\"\31\", nco:phoneNumber(?contact_number)), \"\30\")"			\
-"WHERE {"								\
-"	<%s> nco:hasPhoneNumber ?contact_number"			\
-"}) "									\
 "nco:birthDate(<%s>) "							\
 "nco:nickname(<%s>) "							\
 "nco:url(<%s>) "							\
@@ -2051,7 +1903,7 @@ void *phonebook_get_entry(const char *folder, const char *id,
 	if (strncmp(id, CONTACT_ID_PREFIX, strlen(CONTACT_ID_PREFIX)) == 0)
 		query = g_strdup_printf(CONTACTS_QUERY_FROM_URI, id, id, id, id,
 						id, id, id, id, id, id, id, id,
-						id, id, id, id, id, id);
+						id, id, id);
 	else
 		query = g_strdup_printf(CONTACTS_OTHER_QUERY_FROM_URI,
 								id, id, id);
-- 
1.7.0.4

