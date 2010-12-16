Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH v2] Further optimalization of PBAP tracker queries
Date: Thu, 16 Dec 2010 16:25:34 +0200
Message-Id: <1292509534-24472-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now emails, addresses and telephone numbers of the same type
(work/home/other) are concatenated into sigle strings - this
gains huge difference in speed of queries when there are a lot
of contacts in database. Also changed functions for splitting
these fields on our backend side.
---
 plugins/phonebook-tracker.c | 1240 +++++++++++++++++++++++++------------------
 1 files changed, 710 insertions(+), 530 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 0a023aa..7aa08e8 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -46,103 +46,111 @@
 #define AFFILATION_HOME "Home"
 #define AFFILATION_WORK "Work"
 #define ADDR_FIELD_AMOUNT 7
-#define PULL_QUERY_COL_AMOUNT 40
+#define PULL_QUERY_COL_AMOUNT 26
 #define COUNT_QUERY_COL_AMOUNT 1
 
-#define COL_PHONE_NUMBER 0
+#define COL_PHONE_AFF 0 /* work/home phone numbers */
 #define COL_FULL_NAME 1
 #define COL_FAMILY_NAME 2
 #define COL_GIVEN_NAME 3
 #define COL_ADDITIONAL_NAME 4
 #define COL_NAME_PREFIX 5
 #define COL_NAME_SUFFIX 6
-#define COL_EMAIL 7
-#define COL_CELL_NUMBER 8
-
-#define COL_ADDR_POBOX 9
-#define COL_ADDR_EXT 10
-#define COL_ADDR_STREET 11
-#define COL_ADDR_LOCALITY 12
-#define COL_ADDR_REGION 13
-#define COL_ADDR_CODE 14
-#define COL_ADDR_COUNTRY 15
-
-#define COL_FAX_NUMBER 16
-#define COL_AFF_TYPE 17
-#define COL_BIRTH_DATE 18
-#define COL_NICKNAME 19
-#define COL_URL 20
-#define COL_PHOTO 21
-
-#define COL_ORG_NAME 22
-#define COL_ORG_DEPARTMENT 23
-#define COL_ORG_ROLE 24
-
-#define COL_UID 25
-#define COL_TITLE 26
-#define COL_OTHER_NUMBER 27
-
-#define COL_OTHER_ADDR_POBOX 28
-#define COL_OTHER_ADDR_EXT 29
-#define COL_OTHER_ADDR_STREET 30
-#define COL_OTHER_ADDR_LOCALITY 31
-#define COL_OTHER_ADDR_REGION 32
-#define COL_OTHER_ADDR_CODE 33
-#define COL_OTHER_ADDR_COUNTRY 34
-
-#define COL_OTHER_EMAIL 35
-#define COL_DATE 36
-#define COL_SENT 37
-#define COL_ANSWERED 38
-#define CONTACTS_ID_COL 39
+#define COL_EMAIL_CONTACT 7 /*email's for other category */
+#define COL_ADDR_AFF 8 /* addresses from affilation */
+#define COL_ADDR_CONTACT 9 /* addresses from contacts */
+#define COL_PHONE_CONTACT 10 /* phone numbers from contact's */
+#define COL_BIRTH_DATE 11
+#define COL_NICKNAME 12
+#define COL_URL 13
+#define COL_PHOTO 14
+#define COL_ORG_ROLE 15
+#define COL_UID 16
+#define COL_TITLE 17
+#define COL_AFF_TYPE 18
+#define COL_ORG_NAME 19
+#define COL_ORG_DEPARTMENT 20
+#define COL_EMAIL_AFF 21 /* email's from affilation (work/home) */
+#define COL_DATE 22
+#define COL_SENT 23
+#define COL_ANSWERED 24
+#define CONTACTS_ID_COL 25
 #define CONTACT_ID_PREFIX "contact:"
 
+#define FAX_NUM_TYPE "http://www.semanticdesktop.org/ontologies/2007/03/22/nco#FaxNumber"
+#define MOBILE_NUM_TYPE "http://www.semanticdesktop.org/ontologies/2007/03/22/nco#CellPhoneNumber"
+
+#define MAIN_DELIM "\30" /* Main delimiter between phones, addresses, emails*/
+#define SUB_DELIM "\31" /* Delimiter used in telephone number strings*/
+#define MAX_FIELDS 100 /* Max amount of fields to be concatenated at once*/
+
 #define CONTACTS_QUERY_ALL						\
-	"SELECT nco:phoneNumber(?v) nco:fullname(?c) "			\
-	"nco:nameFamily(?c) nco:nameGiven(?c) "				\
-	"nco:nameAdditional(?c) nco:nameHonorificPrefix(?c) "		\
-	"nco:nameHonorificSuffix(?c) nco:emailAddress(?e) ?vc "		\
-	"nco:pobox(?p) nco:extendedAddress(?p) "			\
-	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
-	"nco:postalcode(?p) nco:country(?p) ?f ?affType "		\
-	"nco:birthDate(?c) nco:nickname(?c) nco:url(?c) "		\
-	"?file nco:fullname(?o) nco:department(?a) "			\
-	"nco:role(?a) nco:contactUID(?c) "				\
-	"nco:title(?a) ?t nco:pobox(?po) nco:extendedAddress(?po) "	\
-	"nco:streetAddress(?po) nco:locality(?po) nco:region(?po) "	\
-	"nco:postalcode(?po) nco:country(?po) nco:emailAddress(?eo) "	\
-	"\"NOTACALL\" \"false\" \"false\" ?c "				\
-	"WHERE { "							\
-		"?c a nco:PersonContact . "				\
-		"OPTIONAL { "						\
-			"?c a nco:PersonContact ; nco:photo ?pht . "	\
-			"?pht a nfo:FileDataObject ; nie:url ?file . "	\
-		"} "							\
-	"OPTIONAL { ?c nco:hasPhoneNumber ?h . "			\
-		"OPTIONAL {"						\
-		"?h a nco:FaxNumber ; "					\
-		"nco:phoneNumber ?f . "					\
-		"}"							\
-		"OPTIONAL {"						\
-		"?h a nco:CellPhoneNumber ; "				\
-		"nco:phoneNumber ?vc"					\
-		"}"							\
-		"OPTIONAL {"						\
-		"?h a nco:VoicePhoneNumber ; "				\
-		"nco:phoneNumber ?t"					\
-		"}"							\
-	"}"								\
-	"OPTIONAL { "							\
-		"?c nco:hasAffiliation ?a . "				\
-		"OPTIONAL { ?a rdfs:label ?affType .}"			\
-			"OPTIONAL { ?a nco:hasEmailAddress ?e . } "	\
-			"OPTIONAL { ?a nco:hasPostalAddress ?p . } "	\
-			"OPTIONAL { ?a nco:hasPhoneNumber ?v . } "	\
-		"OPTIONAL { ?a nco:org ?o . } "				\
-	"} "								\
-	"OPTIONAL { ?c nco:hasPostalAddress ?po . } "			\
-	"OPTIONAL { ?c nco:hasEmailAddress ?eo . } "			\
-	"}"
+"SELECT "								\
+"(SELECT GROUP_CONCAT("							\
+"nco:phoneNumber(?number), \"\30\")"					\
+"WHERE {"								\
+"	?_role nco:hasPhoneNumber ?number"				\
+"}) "									\
+"nco:fullname(?_contact) "						\
+"nco:nameFamily(?_contact) "						\
+"nco:nameGiven(?_contact) "						\
+"nco:nameAdditional(?_contact) "					\
+"nco:nameHonorificPrefix(?_contact) "					\
+"nco:nameHonorificSuffix(?_contact) "					\
+"(SELECT GROUP_CONCAT(?emailaddress_other, \"\30\") " 			\
+	"WHERE {"							\
+	"?_contact nco:hasEmailAddress "				\
+			"[nco:emailAddress ?emailaddress_other]"	\
+	"}) "								\
+"(SELECT GROUP_CONCAT(fn:concat("					\
+"tracker:coalesce(nco:pobox(?aff_addr), \"\"), \";\","			\
+"tracker:coalesce(nco:extendedAddress(?aff_addr), \"\"), \";\","	\
+"tracker:coalesce(nco:streetAddress(?aff_addr), \"\"), \";\","		\
+"tracker:coalesce(nco:locality(?aff_addr), \"\"), \";\","		\
+"tracker:coalesce(nco:region(?aff_addr), \"\"), \";\","			\
+"tracker:coalesce(nco:postalcode(?aff_addr), \"\"), \";\","		\
+"tracker:coalesce(nco:country(?aff_addr), \"\") ),\";\")"		\
+"WHERE {"								\
+"?_role nco:hasPostalAddress ?aff_addr"					\
+"}) "									\
+"(SELECT GROUP_CONCAT(fn:concat("					\
+"tracker:coalesce(nco:pobox(?oth_addr), \"\"), \";\","			\
+"tracker:coalesce(nco:extendedAddress(?oth_addr), \"\"), \";\","	\
+"tracker:coalesce(nco:streetAddress(?oth_addr), \"\"), \";\","		\
+"tracker:coalesce(nco:locality(?oth_addr), \"\"), \";\","		\
+"tracker:coalesce(nco:region(?oth_addr), \"\"), \";\","			\
+"tracker:coalesce(nco:postalcode(?oth_addr), \"\"), \";\","		\
+"tracker:coalesce(nco:country(?oth_addr), \"\") ),\"\30\")"		\
+"WHERE {"								\
+"	?_contact nco:hasPostalAddress ?oth_addr"			\
+"}) "									\
+"(SELECT GROUP_CONCAT(fn:concat(rdf:type(?contact_number),"		\
+"\"\31\", nco:phoneNumber(?contact_number)), \"\30\")"			\
+"WHERE {"								\
+"	?_contact nco:hasPhoneNumber ?contact_number"			\
+"}) "									\
+"nco:birthDate(?_contact) "						\
+"nco:nickname(?_contact) "						\
+"nco:url(?_contact) "							\
+"nie:url(nco:photo(?_contact)) "					\
+"nco:role(?_role) "							\
+"nco:contactUID(?_contact) "						\
+"nco:title(?_role) "							\
+"rdfs:label(?_role) "							\
+"nco:fullname(nco:org(?_role))"						\
+"nco:department(?_role) "						\
+"(SELECT GROUP_CONCAT(?emailaddress, \"\30\")"				\
+"WHERE {"								\
+"	?_role nco:hasEmailAddress [ nco:emailAddress ?emailaddress ]"	\
+"}) "									\
+"\"NOTACALL\" \"false\" \"false\" "					\
+"?_contact "								\
+"WHERE {"								\
+"	?_contact a nco:PersonContact ;"				\
+"	nco:nameFamily ?_key ."						\
+"	OPTIONAL {?_contact nco:hasAffiliation ?_role .}"		\
+"}"									\
+"ORDER BY ?_key tracker:id(?_contact)"
 
 #define CONTACTS_QUERY_ALL_LIST						\
 	"SELECT ?c nco:nameFamily(?c) "					\
@@ -159,84 +167,114 @@
 	"} GROUP BY ?c"
 
 #define MISSED_CALLS_QUERY						\
-	"SELECT nco:phoneNumber(?ap) nco:fullname(?c) "			\
-	"nco:nameFamily(?c) nco:nameGiven(?c) "				\
-	"nco:nameAdditional(?c) nco:nameHonorificPrefix(?c) "		\
-	"nco:nameHonorificSuffix(?c) nco:emailAddress(?e) ?vc "		\
-	"nco:pobox(?p) nco:extendedAddress(?p) "			\
-	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
-	"nco:postalcode(?p) nco:country(?p) \"\" ?affType "		\
-	"nco:birthDate(?c) nco:nickname(?c) nco:url(?c) "		\
-	"?file nco:fullname(?o) nco:department(?a) "			\
-	"nco:role(?a) nco:contactUID(?c) "				\
-	"nco:title(?a) nco:phoneNumber(?t) nco:pobox(?po) nco:extendedAddress(?po) "	\
-	"nco:streetAddress(?po) nco:locality(?po) nco:region(?po) "	\
-	"nco:postalcode(?po) nco:country(?po) nco:emailAddress(?eo) "	\
-	"nmo:receivedDate(?call) "					\
-	"nmo:isSent(?call) nmo:isAnswered(?call) ?x "			\
+"SELECT "								\
+"(SELECT nco:phoneNumber(?role_number) "				\
+	"WHERE {"							\
+	"?_role nco:hasPhoneNumber ?role_number "			\
+	"FILTER (?role_number = ?_number)"				\
+"} GROUP BY nco:phoneNumber(?role_number) ) "				\
+	"nco:fullname(?_contact) "					\
+	"nco:nameFamily(?_contact) "					\
+	"nco:nameGiven(?_contact) "					\
+	"nco:nameAdditional(?_contact) "				\
+	"nco:nameHonorificPrefix(?_contact) "				\
+	"nco:nameHonorificSuffix(?_contact) "				\
+"(SELECT GROUP_CONCAT(?emailaddress_other, \"\30\") " 			\
+	"WHERE {"							\
+	"?_contact nco:hasEmailAddress "				\
+			"[nco:emailAddress ?emailaddress_other]"	\
+	"}) "								\
+"(SELECT GROUP_CONCAT(fn:concat("					\
+	"tracker:coalesce(nco:pobox(?aff_addr), \"\"), \";\","		\
+	"tracker:coalesce(nco:extendedAddress(?aff_addr), \"\"), \";\","\
+	"tracker:coalesce(nco:streetAddress(?aff_addr), \"\"), \";\","	\
+	"tracker:coalesce(nco:locality(?aff_addr), \"\"), \";\","	\
+	"tracker:coalesce(nco:region(?aff_addr), \"\"), \";\","		\
+	"tracker:coalesce(nco:postalcode(?aff_addr), \"\"), \";\","	\
+	"tracker:coalesce(nco:country(?aff_addr), \"\") ),\";\")"	\
+	"WHERE {"							\
+	"?_role nco:hasPostalAddress ?aff_addr"				\
+	"}) "								\
+"(SELECT GROUP_CONCAT(fn:concat("					\
+	"tracker:coalesce(nco:pobox(?oth_addr), \"\"), \";\","		\
+	"tracker:coalesce(nco:extendedAddress(?oth_addr), \"\"), \";\","\
+	"tracker:coalesce(nco:streetAddress(?oth_addr), \"\"), \";\","	\
+	"tracker:coalesce(nco:locality(?oth_addr), \"\"), \";\","	\
+	"tracker:coalesce(nco:region(?oth_addr), \"\"), \";\","		\
+	"tracker:coalesce(nco:postalcode(?oth_addr), \"\"), \";\","	\
+	"tracker:coalesce(nco:country(?oth_addr), \"\") ),\"\30\")"	\
+	"WHERE {"							\
+	"?_contact nco:hasPostalAddress ?oth_addr"			\
+	"}) "								\
+"(SELECT fn:concat(rdf:type(?contact_number),"				\
+	"\"\31\", nco:phoneNumber(?contact_number))"			\
+	"WHERE {"							\
+	"{"								\
+"		?_contact nco:hasPhoneNumber ?contact_number . "	\
+"		FILTER (?contact_number = ?_number) "			\
+"	} UNION { "							\
+"		?_unb_contact nco:hasPhoneNumber ?contact_number . "	\
+"	} "								\
+"}GROUP BY nco:phoneNumber(?contact_number) ) "				\
+	"nco:birthDate(?_contact) "					\
+	"nco:nickname(?_contact) "					\
+	"nco:url(?_contact) "						\
+	"nie:url(nco:photo(?_contact)) "				\
+	"nco:role(?_role) "						\
+	"nco:contactUID(?_contact) "					\
+	"nco:title(?_role) "						\
+	"rdfs:label(?_role) "						\
+	"nco:fullname(nco:org(?_role)) "				\
+	"nco:department(?_role) "					\
+"(SELECT GROUP_CONCAT(?emailaddress, \"\30\") "				\
 	"WHERE { "							\
-	"{ "								\
-		"?x a nco:Contact . "					\
-		"?x nco:hasPhoneNumber ?t . "				\
-		"?call a nmo:Call ; "					\
-		"nmo:from ?x ; "					\
-		"nmo:isSent false ; "					\
-		"nmo:isAnswered false . "				\
-		"?c a nco:PersonContact . "				\
-		"?c nco:hasPhoneNumber ?t . "				\
-		"OPTIONAL { "						\
-			"?c a nco:PersonContact ; nco:photo ?pht . "	\
-			"?pht a nfo:FileDataObject ; nie:url ?file . "	\
-		"} "							\
-		"OPTIONAL { "						\
-			"?t a nco:CellPhoneNumber ; "			\
-				"nco:phoneNumber ?vc . "		\
-		"} "							\
-		"OPTIONAL { ?c nco:hasPostalAddress ?po . } "		\
-		"OPTIONAL { ?c nco:hasEmailAddress ?eo . } "		\
-		"OPTIONAL { "						\
-			"?c nco:hasAffiliation ?a . "			\
-			"OPTIONAL { ?a nco:title ?title } "		\
-			"OPTIONAL { ?a nco:hasEmailAddress ?e . } "	\
-			"OPTIONAL { ?a nco:hasPostalAddress ?p . } "	\
-			"OPTIONAL { ?a nco:org ?o . } "			\
-		"} "							\
-	"} UNION { "							\
-		"?x a nco:Contact . "					\
-		"?x nco:hasPhoneNumber ?ap . "				\
-		"?call a nmo:Call ; "					\
-		"nmo:from ?x ; "					\
-		"nmo:isSent false ; "					\
-		"nmo:isAnswered false . "				\
-		"?c a nco:PersonContact . "				\
-		"?c nco:hasAffiliation ?a . "				\
-		"?a nco:hasPhoneNumber ?ap . "				\
-		"OPTIONAL { "						\
-			"?c a nco:PersonContact ; nco:photo ?pht . "	\
-			"?pht a nfo:FileDataObject ; nie:url ?file . "	\
-		"} "							\
-		"OPTIONAL {?a rdfs:label ?affType . }"			\
-		"OPTIONAL {?a nco:hasEmailAddress ?e . } "		\
-		"OPTIONAL {?a nco:hasPostalAddress ?p . }"		\
-		"OPTIONAL { ?a nco:org ?o . } "				\
-		"OPTIONAL { ?a nco:title ?title } "			\
-		"OPTIONAL { ?c nco:hasPostalAddress ?po . } "		\
-		"OPTIONAL { ?c nco:hasEmailAddress ?eo . } "		\
-	"} UNION { "							\
-		"?x a nco:Contact . "					\
-		"?x nco:hasPhoneNumber ?t . "				\
-		"?call a nmo:Call ; "					\
-		"nmo:from ?x ; "					\
-		"nmo:isSent false ; "					\
-		"nmo:isAnswered false . "				\
-		"OPTIONAL {?c a nco:PersonContact ; "			\
-			"nco:hasPhoneNumber ?t . } "			\
-		"OPTIONAL {?c a nco:PersonContact ; "			\
-			"nco:hasAffiliation ?a . "			\
-			"?a nco:hasPhoneNumber ?t . } "			\
-		"FILTER ( !bound(?c) && !bound(?a) ) . "		\
-	"} "								\
-	"} ORDER BY DESC(nmo:receivedDate(?call)) "
+	"?_role nco:hasEmailAddress [ nco:emailAddress ?emailaddress ] "\
+	"}) "								\
+	"nmo:receivedDate(?_call) "					\
+	"nmo:isSent(?_call) "						\
+	"nmo:isAnswered(?_call) "					\
+	"fn:concat(tracker:coalesce(?_ncontact, \"\"),"			\
+	"tracker:coalesce(?_unb_contact, \"\"))"			\
+	" "								\
+"WHERE { "								\
+"{ "									\
+	"?_ncontact a nco:Contact . "					\
+	"?_ncontact nco:hasPhoneNumber ?_number . "			\
+	"?_call a nmo:Call ; "						\
+	"nmo:from ?_ncontact ; "					\
+	"nmo:isAnswered false ;"					\
+	"nmo:isSent false . "						\
+	"?_contact a nco:PersonContact ; "				\
+	"nco:hasPhoneNumber ?_number . "				\
+	"OPTIONAL { ?_contact nco:hasAffiliation ?_role .} "		\
+	"?_contact nco:nameFamily ?_key ."				\
+"} UNION { "								\
+	"?_ncontact a nco:Contact . "					\
+	"?_ncontact nco:hasPhoneNumber ?_number . "			\
+	"?_call a nmo:Call ; "						\
+	"nmo:from ?_ncontact ; "					\
+	"nmo:isAnswered false ;"					\
+	"nmo:isSent false . "						\
+	"?_contact a nco:PersonContact . "				\
+	"?_contact nco:nameFamily ?_key . "				\
+	"?_contact nco:hasAffiliation ?_role . "			\
+	"?_role nco:hasPhoneNumber ?_number . "				\
+"} UNION { "								\
+	"?_unb_contact a nco:Contact . "				\
+	"?_unb_contact nco:hasPhoneNumber ?_number . "			\
+	"?_call a nmo:Call ; "						\
+	"nmo:from ?_unb_contact ; "					\
+	"nmo:isAnswered false ;"					\
+	"nmo:isSent false . "						\
+	"OPTIONAL {?_contact a nco:PersonContact ; "			\
+	"nco:hasPhoneNumber ?_number . } "				\
+	"OPTIONAL {?_contact a nco:PersonContact ; "			\
+	"nco:hasAffiliation ?_role . "					\
+	"?_role nco:hasPhoneNumber ?_number. } "			\
+	"FILTER ( !bound(?_contact) && !bound(?_role) ) "		\
+"} "									\
+"} "									\
+"ORDER BY DESC(nmo:sentDate(?_call)) "
 
 
 #define MISSED_CALLS_LIST						\
@@ -275,85 +313,114 @@
 	"} GROUP BY ?call ORDER BY DESC(nmo:receivedDate(?call))"
 
 #define INCOMING_CALLS_QUERY						\
-	"SELECT nco:phoneNumber(?ap) nco:fullname(?c) "			\
-	"nco:nameFamily(?c) nco:nameGiven(?c) "				\
-	"nco:nameAdditional(?c) nco:nameHonorificPrefix(?c) "		\
-	"nco:nameHonorificSuffix(?c) nco:emailAddress(?e) ?vc "		\
-	"nco:pobox(?p) nco:extendedAddress(?p) "			\
-	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
-	"nco:postalcode(?p) nco:country(?p) \"\" ?affType "		\
-	"nco:birthDate(?c) nco:nickname(?c) nco:url(?c) "		\
-	"?file nco:fullname(?o) nco:department(?a) "			\
-	"nco:role(?a) nco:contactUID(?c) "				\
-	"nco:title(?a) nco:phoneNumber(?t) nco:pobox(?po) "		\
-	"nco:extendedAddress(?po) "					\
-	"nco:streetAddress(?po) nco:locality(?po) nco:region(?po) "	\
-	"nco:postalcode(?po) nco:country(?po) nco:emailAddress(?eo) "	\
-	"nmo:receivedDate(?call) "					\
-	"nmo:isSent(?call) nmo:isAnswered(?call) ?x "			\
+"SELECT "								\
+"(SELECT nco:phoneNumber(?role_number) "				\
+	"WHERE {"							\
+"	?_role nco:hasPhoneNumber ?role_number"				\
+"	FILTER (?role_number = ?_number)"				\
+"} GROUP BY nco:phoneNumber(?role_number) ) "				\
+	"nco:fullname(?_contact) "					\
+	"nco:nameFamily(?_contact) "					\
+	"nco:nameGiven(?_contact) "					\
+	"nco:nameAdditional(?_contact) "				\
+	"nco:nameHonorificPrefix(?_contact) "				\
+	"nco:nameHonorificSuffix(?_contact) "				\
+"(SELECT GROUP_CONCAT(?emailaddress_other, \"\30\") " 			\
+	"WHERE {"							\
+	"?_contact nco:hasEmailAddress "				\
+			"[nco:emailAddress ?emailaddress_other]"	\
+	"}) "								\
+"(SELECT GROUP_CONCAT(fn:concat("					\
+	"tracker:coalesce(nco:pobox(?aff_addr), \"\"), \";\","		\
+	"tracker:coalesce(nco:extendedAddress(?aff_addr), \"\"), \";\","\
+	"tracker:coalesce(nco:streetAddress(?aff_addr), \"\"), \";\","	\
+	"tracker:coalesce(nco:locality(?aff_addr), \"\"), \";\","	\
+	"tracker:coalesce(nco:region(?aff_addr), \"\"), \";\","		\
+	"tracker:coalesce(nco:postalcode(?aff_addr), \"\"), \";\","	\
+	"tracker:coalesce(nco:country(?aff_addr), \"\") ),\";\")"	\
+	"WHERE {"							\
+	"?_role nco:hasPostalAddress ?aff_addr"				\
+	"}) "								\
+"(SELECT GROUP_CONCAT(fn:concat("					\
+	"tracker:coalesce(nco:pobox(?oth_addr), \"\"), \";\","		\
+	"tracker:coalesce(nco:extendedAddress(?oth_addr), \"\"), \";\","\
+	"tracker:coalesce(nco:streetAddress(?oth_addr), \"\"), \";\","	\
+	"tracker:coalesce(nco:locality(?oth_addr), \"\"), \";\","	\
+	"tracker:coalesce(nco:region(?oth_addr), \"\"), \";\","		\
+	"tracker:coalesce(nco:postalcode(?oth_addr), \"\"), \";\","	\
+	"tracker:coalesce(nco:country(?oth_addr), \"\") ),\"\30\")"	\
+	"WHERE {"							\
+	"?_contact nco:hasPostalAddress ?oth_addr"			\
+	"}) "								\
+"(SELECT fn:concat(rdf:type(?contact_number),"				\
+	"\"\31\", nco:phoneNumber(?contact_number))"			\
+	"WHERE {"							\
+	"{"								\
+"		?_contact nco:hasPhoneNumber ?contact_number . "	\
+"		FILTER (?contact_number = ?_number) "			\
+"	} UNION { "							\
+"		?_unb_contact nco:hasPhoneNumber ?contact_number . "	\
+"	} "								\
+	"}GROUP BY nco:phoneNumber(?contact_number) ) "			\
+	"nco:birthDate(?_contact) "					\
+	"nco:nickname(?_contact) "					\
+	"nco:url(?_contact) "						\
+	"nie:url(nco:photo(?_contact)) "				\
+	"nco:role(?_role) "						\
+	"nco:contactUID(?_contact) "					\
+	"nco:title(?_role) "						\
+	"rdfs:label(?_role) "						\
+	"nco:fullname(nco:org(?_role)) "				\
+	"nco:department(?_role) "					\
+"(SELECT GROUP_CONCAT(?emailaddress, \"\30\") "				\
 	"WHERE { "							\
-	"{ "								\
-		"?x a nco:Contact . "					\
-		"?x nco:hasPhoneNumber ?t . "				\
-		"?call a nmo:Call ; "					\
-		"nmo:from ?x ; "					\
-		"nmo:isSent false ; "					\
-		"nmo:isAnswered true . "				\
-		"?c a nco:PersonContact . "				\
-		"?c nco:hasPhoneNumber ?t . "				\
-		"OPTIONAL { "						\
-			"?c a nco:PersonContact ; nco:photo ?pht . "	\
-			"?pht a nfo:FileDataObject ; nie:url ?file . "	\
-		"} "							\
-		"OPTIONAL { "						\
-			"?t a nco:CellPhoneNumber ; "			\
-				"nco:phoneNumber ?vc . "		\
-		"} "							\
-		"OPTIONAL { ?c nco:hasPostalAddress ?po . } "		\
-		"OPTIONAL { ?c nco:hasEmailAddress ?eo . } "		\
-		"OPTIONAL { "						\
-			"?c nco:hasAffiliation ?a . "			\
-			"OPTIONAL { ?a nco:title ?title } "		\
-			"OPTIONAL { ?a nco:hasEmailAddress ?e . } "	\
-			"OPTIONAL { ?a nco:hasPostalAddress ?p . } "	\
-			"OPTIONAL { ?a nco:org ?o . } "			\
-		"} "							\
-	"} UNION { "							\
-		"?x a nco:Contact . "					\
-		"?x nco:hasPhoneNumber ?ap . "				\
-		"?call a nmo:Call ; "					\
-		"nmo:from ?x ; "					\
-		"nmo:isSent false ; "					\
-		"nmo:isAnswered true . "				\
-		"?c a nco:PersonContact . "				\
-		"?c nco:hasAffiliation ?a . "				\
-		"?a nco:hasPhoneNumber ?ap . "				\
-		"OPTIONAL { "						\
-			"?c a nco:PersonContact ; nco:photo ?pht . "	\
-			"?pht a nfo:FileDataObject ; nie:url ?file . "	\
-		"} "							\
-		"OPTIONAL {?a rdfs:label ?affType . }"			\
-		"OPTIONAL {?a nco:hasEmailAddress ?e . } "		\
-		"OPTIONAL {?a nco:hasPostalAddress ?p . }"		\
-		"OPTIONAL { ?a nco:org ?o . } "				\
-		"OPTIONAL { ?a nco:title ?title } "			\
-		"OPTIONAL { ?c nco:hasPostalAddress ?po . } "		\
-		"OPTIONAL { ?c nco:hasEmailAddress ?eo . } "		\
-	"} UNION { "							\
-		"?x a nco:Contact . "					\
-		"?x nco:hasPhoneNumber ?t . "				\
-		"?call a nmo:Call ; "					\
-		"nmo:from ?x ; "					\
-		"nmo:isSent false ; "					\
-		"nmo:isAnswered true . "				\
-		"OPTIONAL {?c a nco:PersonContact ; "			\
-			"nco:hasPhoneNumber ?t . } "			\
-		"OPTIONAL {?c a nco:PersonContact ; "			\
-			"nco:hasAffiliation ?a . "			\
-			"?a nco:hasPhoneNumber ?t . } "			\
-		"FILTER ( !bound(?c) && !bound(?a) ) . "		\
-	"} "								\
-	"} ORDER BY DESC(nmo:receivedDate(?call)) "
+	"?_role nco:hasEmailAddress [ nco:emailAddress ?emailaddress ] "\
+	"}) "								\
+	"nmo:receivedDate(?_call) "					\
+	"nmo:isSent(?_call) "						\
+	"nmo:isAnswered(?_call) "					\
+	"fn:concat(tracker:coalesce(?_ncontact, \"\"),"			\
+	"tracker:coalesce(?_unb_contact, \"\"))"			\
+	" "								\
+"WHERE { "								\
+"{ "									\
+	"?_ncontact a nco:Contact . "					\
+	"?_ncontact nco:hasPhoneNumber ?_number . "			\
+	"?_call a nmo:Call ; "						\
+	"nmo:from ?_ncontact ; "					\
+	"nmo:isAnswered true ;"						\
+	"nmo:isSent false . "						\
+	"?_contact a nco:PersonContact ; "				\
+	"nco:hasPhoneNumber ?_number . "				\
+	"OPTIONAL { ?_contact nco:hasAffiliation ?_role .} "		\
+	"?_contact nco:nameFamily ?_key ."				\
+"} UNION { "								\
+	"?_ncontact a nco:Contact . "					\
+	"?_ncontact nco:hasPhoneNumber ?_number . "			\
+	"?_call a nmo:Call ; "						\
+	"nmo:from ?_ncontact ; "					\
+	"nmo:isAnswered true ;"						\
+	"nmo:isSent false . "						\
+	"?_contact a nco:PersonContact . "				\
+	"?_contact nco:nameFamily ?_key . "				\
+	"?_contact nco:hasAffiliation ?_role . "			\
+	"?_role nco:hasPhoneNumber ?_number . "				\
+"} UNION { "								\
+	"?_unb_contact a nco:Contact . "				\
+	"?_unb_contact nco:hasPhoneNumber ?_number . "			\
+	"?_call a nmo:Call ; "						\
+	"nmo:from ?_unb_contact ; "					\
+	"nmo:isAnswered true ;"						\
+	"nmo:isSent false . "						\
+	"OPTIONAL {?_contact a nco:PersonContact ; "			\
+	"nco:hasPhoneNumber ?_number . } "				\
+	"OPTIONAL {?_contact a nco:PersonContact ; "			\
+	"nco:hasAffiliation ?_role . "					\
+	"?_role nco:hasPhoneNumber ?_number. } "			\
+	"FILTER ( !bound(?_contact) && !bound(?_role) ) "		\
+"} "									\
+"} "\
+"ORDER BY DESC(nmo:sentDate(?_call)) "
 
 #define INCOMING_CALLS_LIST						\
 	"SELECT ?c nco:nameFamily(?c) "					\
@@ -391,82 +458,111 @@
 	"} GROUP BY ?call ORDER BY DESC(nmo:receivedDate(?call))"
 
 #define OUTGOING_CALLS_QUERY						\
-	"SELECT nco:phoneNumber(?ap) nco:fullname(?c) "			\
-	"nco:nameFamily(?c) nco:nameGiven(?c) "				\
-	"nco:nameAdditional(?c) nco:nameHonorificPrefix(?c) "		\
-	"nco:nameHonorificSuffix(?c) nco:emailAddress(?e) ?vc "		\
-	"nco:pobox(?p) nco:extendedAddress(?p) "			\
-	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
-	"nco:postalcode(?p) nco:country(?p) \"\" ?affType "		\
-	"nco:birthDate(?c) nco:nickname(?c) nco:url(?c) "		\
-	"?file nco:fullname(?o) nco:department(?a) "			\
-	"nco:role(?a) nco:contactUID(?c) "				\
-	"nco:title(?a) nco:phoneNumber(?t) nco:pobox(?po) "		\
-	"nco:extendedAddress(?po) "					\
-	"nco:streetAddress(?po) nco:locality(?po) nco:region(?po) "	\
-	"nco:postalcode(?po) nco:country(?po) nco:emailAddress(?eo) "	\
-	"nmo:receivedDate(?call) "					\
-	"nmo:isSent(?call) nmo:isAnswered(?call) ?x "			\
+"SELECT "								\
+"(SELECT nco:phoneNumber(?role_number) "				\
+	"WHERE {"							\
+"	?_role nco:hasPhoneNumber ?role_number"				\
+"	FILTER (?role_number = ?_number)"				\
+"} GROUP BY nco:phoneNumber(?role_number) ) "				\
+	"nco:fullname(?_contact) "					\
+	"nco:nameFamily(?_contact) "					\
+	"nco:nameGiven(?_contact) "					\
+	"nco:nameAdditional(?_contact) "				\
+	"nco:nameHonorificPrefix(?_contact) "				\
+	"nco:nameHonorificSuffix(?_contact) "				\
+"(SELECT GROUP_CONCAT(?emailaddress_other, \"\30\") " 			\
+	"WHERE {"							\
+	"?_contact nco:hasEmailAddress "				\
+			"[nco:emailAddress ?emailaddress_other]"	\
+	"}) "								\
+"(SELECT GROUP_CONCAT(fn:concat("					\
+	"tracker:coalesce(nco:pobox(?aff_addr), \"\"), \";\","		\
+	"tracker:coalesce(nco:extendedAddress(?aff_addr), \"\"), \";\","\
+	"tracker:coalesce(nco:streetAddress(?aff_addr), \"\"), \";\","	\
+	"tracker:coalesce(nco:locality(?aff_addr), \"\"), \";\","	\
+	"tracker:coalesce(nco:region(?aff_addr), \"\"), \";\","		\
+	"tracker:coalesce(nco:postalcode(?aff_addr), \"\"), \";\","	\
+	"tracker:coalesce(nco:country(?aff_addr), \"\") ),\";\")"	\
+	"WHERE {"							\
+	"?_role nco:hasPostalAddress ?aff_addr"				\
+	"}) "								\
+"(SELECT GROUP_CONCAT(fn:concat("					\
+	"tracker:coalesce(nco:pobox(?oth_addr), \"\"), \";\","		\
+	"tracker:coalesce(nco:extendedAddress(?oth_addr), \"\"), \";\","\
+	"tracker:coalesce(nco:streetAddress(?oth_addr), \"\"), \";\","	\
+	"tracker:coalesce(nco:locality(?oth_addr), \"\"), \";\","	\
+	"tracker:coalesce(nco:region(?oth_addr), \"\"), \";\","		\
+	"tracker:coalesce(nco:postalcode(?oth_addr), \"\"), \";\","	\
+	"tracker:coalesce(nco:country(?oth_addr), \"\") ),\"\30\")"	\
+	"WHERE {"							\
+	"?_contact nco:hasPostalAddress ?oth_addr"			\
+	"}) "								\
+"(SELECT fn:concat(rdf:type(?contact_number),"				\
+	"\"\31\", nco:phoneNumber(?contact_number))"			\
+	"WHERE {"							\
+	"{"								\
+"		?_contact nco:hasPhoneNumber ?contact_number . "	\
+"		FILTER (?contact_number = ?_number) "			\
+"	} UNION { "							\
+"		?_unb_contact nco:hasPhoneNumber ?contact_number . "	\
+"	} "								\
+	"}GROUP BY nco:phoneNumber(?contact_number) ) "			\
+	"nco:birthDate(?_contact) "					\
+	"nco:nickname(?_contact) "					\
+	"nco:url(?_contact) "						\
+	"nie:url(nco:photo(?_contact)) "				\
+	"nco:role(?_role) "						\
+	"nco:contactUID(?_contact) "					\
+	"nco:title(?_role) "						\
+	"rdfs:label(?_role) "						\
+	"nco:fullname(nco:org(?_role)) "				\
+	"nco:department(?_role) "					\
+"(SELECT GROUP_CONCAT(?emailaddress, \"\30\") "				\
 	"WHERE { "							\
-	"{ "								\
-		"?x a nco:Contact . "					\
-		"?x nco:hasPhoneNumber ?t . "				\
-		"?call a nmo:Call ; "					\
-		"nmo:to ?x ; "						\
-		"nmo:isSent true . "					\
-		"?c a nco:PersonContact . "				\
-		"?c nco:hasPhoneNumber ?t . "				\
-		"OPTIONAL { "						\
-			"?c a nco:PersonContact ; nco:photo ?pht . "	\
-			"?pht a nfo:FileDataObject ; nie:url ?file . "	\
-		"} "							\
-		"OPTIONAL { "						\
-			"?t a nco:CellPhoneNumber ; "			\
-				"nco:phoneNumber ?vc . "		\
-		"} "							\
-		"OPTIONAL { ?c nco:hasPostalAddress ?po . } "		\
-		"OPTIONAL { ?c nco:hasEmailAddress ?eo . } "		\
-		"OPTIONAL { "						\
-			"?c nco:hasAffiliation ?a . "			\
-			"OPTIONAL { ?a nco:title ?title } "		\
-			"OPTIONAL { ?a nco:hasEmailAddress ?e . } "	\
-			"OPTIONAL { ?a nco:hasPostalAddress ?p . } "	\
-			"OPTIONAL { ?a nco:org ?o . } "			\
-		"} "							\
-	"} UNION { "							\
-		"?x a nco:Contact . "					\
-		"?x nco:hasPhoneNumber ?ap . "				\
-		"?call a nmo:Call ; "					\
-		"nmo:to ?x ; "						\
-		"nmo:isSent true . "					\
-		"?c a nco:PersonContact . "				\
-		"?c nco:hasAffiliation ?a . "				\
-		"?a nco:hasPhoneNumber ?ap . "				\
-		"OPTIONAL { "						\
-			"?c a nco:PersonContact ; nco:photo ?pht . "	\
-			"?pht a nfo:FileDataObject ; nie:url ?file . "	\
-		"} "							\
-		"OPTIONAL {?a rdfs:label ?affType . }"			\
-		"OPTIONAL {?a nco:hasEmailAddress ?e . } "		\
-		"OPTIONAL {?a nco:hasPostalAddress ?p . }"		\
-		"OPTIONAL { ?a nco:org ?o . } "				\
-		"OPTIONAL { ?a nco:title ?title } "			\
-		"OPTIONAL { ?c nco:hasPostalAddress ?po . } "		\
-		"OPTIONAL { ?c nco:hasEmailAddress ?eo . } "		\
-	"} UNION { "							\
-		"?x a nco:Contact . "					\
-		"?x nco:hasPhoneNumber ?t . "				\
-		"?call a nmo:Call ; "					\
-		"nmo:to ?x ; "						\
-		"nmo:isSent true . "					\
-		"OPTIONAL {?c a nco:PersonContact ; "			\
-			"nco:hasPhoneNumber ?t . } "			\
-		"OPTIONAL {?c a nco:PersonContact ; "			\
-			"nco:hasAffiliation ?a . "			\
-			"?a nco:hasPhoneNumber ?t . } "			\
-		"FILTER ( !bound(?c) && !bound(?a) ) . "		\
-	"} "								\
-	"} ORDER BY DESC(nmo:sentDate(?call)) "
+	"?_role nco:hasEmailAddress [ nco:emailAddress ?emailaddress ] "\
+	"}) "								\
+	"nmo:receivedDate(?_call) "					\
+	"nmo:isSent(?_call) "						\
+	"nmo:isAnswered(?_call) "					\
+	"fn:concat(tracker:coalesce(?_ncontact, \"\"),"			\
+	"tracker:coalesce(?_unb_contact, \"\"))"			\
+	" "								\
+"WHERE { "								\
+"{ "									\
+	"?_ncontact a nco:Contact . "					\
+	"?_ncontact nco:hasPhoneNumber ?_number . "			\
+	"?_call a nmo:Call ; "						\
+	"nmo:to ?_ncontact ; "						\
+	"nmo:isSent true . "						\
+	"?_contact a nco:PersonContact ; "				\
+	"nco:hasPhoneNumber ?_number . "				\
+	"OPTIONAL { ?_contact nco:hasAffiliation ?_role .} "		\
+	"?_contact nco:nameFamily ?_key ."				\
+"} UNION { "								\
+	"?_ncontact a nco:Contact . "					\
+	"?_ncontact nco:hasPhoneNumber ?_number . "			\
+	"?_call a nmo:Call ; "						\
+	"nmo:to ?_ncontact ; "						\
+	"nmo:isSent true . "						\
+	"?_contact a nco:PersonContact . "				\
+	"?_contact nco:nameFamily ?_key . "				\
+	"?_contact nco:hasAffiliation ?_role . "			\
+	"?_role nco:hasPhoneNumber ?_number . "				\
+"} UNION { "								\
+	"?_unb_contact a nco:Contact . "				\
+	"?_unb_contact nco:hasPhoneNumber ?_number . "			\
+	"?_call a nmo:Call ; "						\
+	"nmo:to ?_unb_contact ; "					\
+	"nmo:isSent true . "						\
+	"OPTIONAL {?_contact a nco:PersonContact ; "			\
+	"nco:hasPhoneNumber ?_number . } "				\
+	"OPTIONAL {?_contact a nco:PersonContact ; "			\
+	"nco:hasAffiliation ?_role . "					\
+	"?_role nco:hasPhoneNumber ?_number. } "			\
+	"FILTER ( !bound(?_contact) && !bound(?_role) ) "		\
+"} "									\
+"} "									\
+"ORDER BY DESC(nmo:sentDate(?_call)) "
 
 #define OUTGOING_CALLS_LIST						\
 	"SELECT ?c nco:nameFamily(?c) "					\
@@ -501,139 +597,143 @@
 	"} GROUP BY ?call ORDER BY DESC(nmo:sentDate(?call))"
 
 #define COMBINED_CALLS_QUERY						\
-	"SELECT nco:phoneNumber(?ap) nco:fullname(?c) "			\
-	"nco:nameFamily(?c) nco:nameGiven(?c) "				\
-	"nco:nameAdditional(?c) nco:nameHonorificPrefix(?c) "		\
-	"nco:nameHonorificSuffix(?c) nco:emailAddress(?e) ?vc "		\
-	"nco:pobox(?p) nco:extendedAddress(?p) "			\
-	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
-	"nco:postalcode(?p) nco:country(?p) \"\" ?affType "		\
-	"nco:birthDate(?c) nco:nickname(?c) nco:url(?c) "		\
-	"?file nco:fullname(?o) nco:department(?a) "			\
-	"nco:role(?a) nco:contactUID(?c) "				\
-	"nco:title(?a) nco:phoneNumber(?t) nco:pobox(?po) "		\
-	"nco:extendedAddress(?po) "					\
-	"nco:streetAddress(?po) nco:locality(?po) nco:region(?po) "	\
-	"nco:postalcode(?po) nco:country(?po) nco:emailAddress(?eo) "	\
-	"nmo:receivedDate(?call) "					\
-	"nmo:isSent(?call) nmo:isAnswered(?call) ?x "			\
+"SELECT "								\
+"(SELECT nco:phoneNumber(?role_number) "				\
+	"WHERE {"							\
+"	?_role nco:hasPhoneNumber ?role_number"				\
+"	FILTER (?role_number = ?_number)"				\
+"} GROUP BY nco:phoneNumber(?role_number) ) "				\
+	"nco:fullname(?_contact) "					\
+	"nco:nameFamily(?_contact) "					\
+	"nco:nameGiven(?_contact) "					\
+	"nco:nameAdditional(?_contact) "				\
+	"nco:nameHonorificPrefix(?_contact) "				\
+	"nco:nameHonorificSuffix(?_contact) "				\
+"(SELECT GROUP_CONCAT(?emailaddress_other, \"\30\") " 			\
+	"WHERE {"							\
+	"?_contact nco:hasEmailAddress "				\
+			"[nco:emailAddress ?emailaddress_other]"	\
+	"}) "								\
+"(SELECT GROUP_CONCAT(fn:concat("					\
+	"tracker:coalesce(nco:pobox(?aff_addr), \"\"), \";\","		\
+	"tracker:coalesce(nco:extendedAddress(?aff_addr), \"\"), \";\","\
+	"tracker:coalesce(nco:streetAddress(?aff_addr), \"\"), \";\","	\
+	"tracker:coalesce(nco:locality(?aff_addr), \"\"), \";\","	\
+	"tracker:coalesce(nco:region(?aff_addr), \"\"), \";\","		\
+	"tracker:coalesce(nco:postalcode(?aff_addr), \"\"), \";\","	\
+	"tracker:coalesce(nco:country(?aff_addr), \"\") ),\";\")"	\
+	"WHERE {"							\
+	"?_role nco:hasPostalAddress ?aff_addr"				\
+	"}) "								\
+"(SELECT GROUP_CONCAT(fn:concat("					\
+	"tracker:coalesce(nco:pobox(?oth_addr), \"\"), \";\","		\
+	"tracker:coalesce(nco:extendedAddress(?oth_addr), \"\"), \";\","\
+	"tracker:coalesce(nco:streetAddress(?oth_addr), \"\"), \";\","	\
+	"tracker:coalesce(nco:locality(?oth_addr), \"\"), \";\","	\
+	"tracker:coalesce(nco:region(?oth_addr), \"\"), \";\","		\
+	"tracker:coalesce(nco:postalcode(?oth_addr), \"\"), \";\","	\
+	"tracker:coalesce(nco:country(?oth_addr), \"\") ),\"\30\")"	\
+	"WHERE {"							\
+	"?_contact nco:hasPostalAddress ?oth_addr"			\
+	"}) "								\
+"(SELECT fn:concat(rdf:type(?contact_number),"				\
+	"\"\31\", nco:phoneNumber(?contact_number))"			\
+	"WHERE {"							\
+	"{"								\
+"		?_contact nco:hasPhoneNumber ?contact_number . "	\
+"		FILTER (?contact_number = ?_number) "			\
+"	} UNION { "							\
+"		?_unb_contact nco:hasPhoneNumber ?contact_number . "	\
+"	} "								\
+	"}GROUP BY nco:phoneNumber(?contact_number) ) "			\
+	"nco:birthDate(?_contact) "					\
+	"nco:nickname(?_contact) "					\
+	"nco:url(?_contact) "						\
+	"nie:url(nco:photo(?_contact)) "				\
+	"nco:role(?_role) "						\
+	"nco:contactUID(?_contact) "					\
+	"nco:title(?_role) "						\
+	"rdfs:label(?_role) "						\
+	"nco:fullname(nco:org(?_role)) "				\
+	"nco:department(?_role) "					\
+"(SELECT GROUP_CONCAT(?emailaddress, \"\30\") "				\
 	"WHERE { "							\
-	"{ "								\
-		"?x a nco:Contact . "					\
-		"?x nco:hasPhoneNumber ?t . "				\
-		"?call a nmo:Call ; "					\
-		"nmo:to ?x ; "						\
-		"nmo:isSent true . "					\
-		"?c a nco:PersonContact . "				\
-		"?c nco:hasPhoneNumber ?t . "				\
-		"OPTIONAL { "						\
-			"?c a nco:PersonContact ; nco:photo ?pht . "	\
-			"?pht a nfo:FileDataObject ; nie:url ?file . "	\
-		"} "							\
-		"OPTIONAL { "						\
-			"?t a nco:CellPhoneNumber ; "			\
-				"nco:phoneNumber ?vc . "		\
-		"} "							\
-		"OPTIONAL { ?c nco:hasPostalAddress ?po . } "		\
-		"OPTIONAL { ?c nco:hasEmailAddress ?eo . } "		\
-		"OPTIONAL { "						\
-			"?c nco:hasAffiliation ?a . "			\
-			"OPTIONAL { ?a nco:title ?title } "		\
-			"OPTIONAL { ?a nco:hasEmailAddress ?e . } "	\
-			"OPTIONAL { ?a nco:hasPostalAddress ?p . } "	\
-			"OPTIONAL { ?a nco:org ?o . } "			\
-		"} "							\
-	"} UNION { "							\
-		"?x a nco:Contact . "					\
-		"?x nco:hasPhoneNumber ?ap . "				\
-		"?call a nmo:Call ; "					\
-		"nmo:to ?x ; "						\
-		"nmo:isSent true . "					\
-		"?c a nco:PersonContact . "				\
-		"?c nco:hasAffiliation ?a . "				\
-		"?a nco:hasPhoneNumber ?ap . "				\
-		"OPTIONAL { "						\
-			"?c a nco:PersonContact ; nco:photo ?pht . "	\
-			"?pht a nfo:FileDataObject ; nie:url ?file . "	\
-		"} "							\
-		"OPTIONAL {?a rdfs:label ?affType . }"			\
-		"OPTIONAL {?a nco:hasEmailAddress ?e . } "		\
-		"OPTIONAL {?a nco:hasPostalAddress ?p . }"		\
-		"OPTIONAL { ?a nco:org ?o . } "				\
-		"OPTIONAL { ?a nco:title ?title } "			\
-		"OPTIONAL { ?c nco:hasPostalAddress ?po . } "		\
-		"OPTIONAL { ?c nco:hasEmailAddress ?eo . } "		\
-	"} UNION { "							\
-		"?x a nco:Contact . "					\
-		"?x nco:hasPhoneNumber ?t . "				\
-		"?call a nmo:Call ; "					\
-		"nmo:to ?x ; "						\
-		"nmo:isSent true . "					\
-		"OPTIONAL {?c a nco:PersonContact ; "			\
-			"nco:hasPhoneNumber ?t . } "			\
-		"OPTIONAL {?c a nco:PersonContact ; "			\
-			"nco:hasAffiliation ?a . "			\
-			"?a nco:hasPhoneNumber ?t . } "			\
-		"FILTER ( !bound(?c) && !bound(?a) ) . "		\
-	"} UNION { "							\
-		"?x a nco:Contact . "					\
-		"?x nco:hasPhoneNumber ?t . "				\
-		"?call a nmo:Call ; "					\
-		"nmo:from ?x ; "					\
-		"nmo:isSent false . "					\
-		"?c a nco:PersonContact . "				\
-		"?c nco:hasPhoneNumber ?t . "				\
-		"OPTIONAL { "						\
-			"?c a nco:PersonContact ; nco:photo ?pht . "	\
-			"?pht a nfo:FileDataObject ; nie:url ?file . "	\
-		"} "							\
-		"OPTIONAL { "						\
-			"?t a nco:CellPhoneNumber ; "			\
-				"nco:phoneNumber ?vc . "		\
-		"} "							\
-		"OPTIONAL { ?c nco:hasPostalAddress ?po . } "		\
-		"OPTIONAL { ?c nco:hasEmailAddress ?eo . } "		\
-		"OPTIONAL { "						\
-			"?c nco:hasAffiliation ?a . "			\
-			"OPTIONAL { ?a nco:title ?title } "		\
-			"OPTIONAL { ?a nco:hasEmailAddress ?e . } "	\
-			"OPTIONAL { ?a nco:hasPostalAddress ?p . } "	\
-			"OPTIONAL { ?a nco:org ?o . } "			\
-		"} "							\
-	"} UNION { "							\
-		"?x a nco:Contact . "					\
-		"?x nco:hasPhoneNumber ?ap . "				\
-		"?call a nmo:Call ; "					\
-		"nmo:from ?x ; "					\
-		"nmo:isSent false . "					\
-		"?c a nco:PersonContact . "				\
-		"?c nco:hasAffiliation ?a . "				\
-		"?a nco:hasPhoneNumber ?ap . "				\
-		"OPTIONAL { "						\
-			"?c a nco:PersonContact ; nco:photo ?pht . "	\
-			"?pht a nfo:FileDataObject ; nie:url ?file . "	\
-		"} "							\
-		"OPTIONAL {?a rdfs:label ?affType . }"			\
-		"OPTIONAL {?a nco:hasEmailAddress ?e . } "		\
-		"OPTIONAL {?a nco:hasPostalAddress ?p . }"		\
-		"OPTIONAL { ?a nco:org ?o . } "				\
-		"OPTIONAL { ?a nco:title ?title } "			\
-		"OPTIONAL { ?c nco:hasPostalAddress ?po . } "		\
-		"OPTIONAL { ?c nco:hasEmailAddress ?eo . } "		\
-	"} UNION { "							\
-		"?x a nco:Contact . "					\
-		"?x nco:hasPhoneNumber ?t . "				\
-		"?call a nmo:Call ; "					\
-		"nmo:from ?x ; "					\
-		"nmo:isSent false . "					\
-		"OPTIONAL {?c a nco:PersonContact ; "			\
-			"nco:hasPhoneNumber ?t . } "			\
-		"OPTIONAL {?c a nco:PersonContact ; "			\
-			"nco:hasAffiliation ?a . "			\
-			"?a nco:hasPhoneNumber ?t . } "			\
-		"FILTER ( !bound(?c) && !bound(?a) ) . "		\
-	"} "								\
-	"} ORDER BY DESC(nmo:receivedDate(?call)) "
+	"?_role nco:hasEmailAddress [ nco:emailAddress ?emailaddress ] "\
+	"}) "								\
+	"nmo:receivedDate(?_call) "					\
+	"nmo:isSent(?_call) "						\
+	"nmo:isAnswered(?_call) "					\
+	"fn:concat(tracker:coalesce(?_ncontact, \"\"),"			\
+	"tracker:coalesce(?_unb_contact, \"\"))"			\
+	" "								\
+"WHERE { "								\
+"{ "									\
+	"?_ncontact a nco:Contact . "					\
+	"?_ncontact nco:hasPhoneNumber ?_number . "			\
+	"?_call a nmo:Call ; "						\
+	"nmo:to ?_ncontact ; "						\
+	"nmo:isSent true . "						\
+	"?_contact a nco:PersonContact ; "				\
+	"nco:hasPhoneNumber ?_number . "				\
+	"OPTIONAL { ?_contact nco:hasAffiliation ?_role .} "		\
+	"?_contact nco:nameFamily ?_key ."				\
+"} UNION { "								\
+	"?_ncontact a nco:Contact . "					\
+	"?_ncontact nco:hasPhoneNumber ?_number . "			\
+	"?_call a nmo:Call ; "						\
+	"nmo:to ?_ncontact ; "						\
+	"nmo:isSent true . "						\
+	"?_contact a nco:PersonContact . "				\
+	"?_contact nco:nameFamily ?_key . "				\
+	"?_contact nco:hasAffiliation ?_role . "			\
+	"?_role nco:hasPhoneNumber ?_number . "				\
+"} UNION { "								\
+	"?_unb_contact a nco:Contact . "				\
+	"?_unb_contact nco:hasPhoneNumber ?_number . "			\
+	"?_call a nmo:Call ; "						\
+	"nmo:to ?_unb_contact ; "					\
+	"nmo:isSent true . "						\
+	"OPTIONAL {?_contact a nco:PersonContact ; "			\
+	"nco:hasPhoneNumber ?_number . } "				\
+	"OPTIONAL {?_contact a nco:PersonContact ; "			\
+	"nco:hasAffiliation ?_role . "					\
+	"?_role nco:hasPhoneNumber ?_number. } "			\
+	"FILTER ( !bound(?_contact) && !bound(?_role) ) "		\
+"} UNION { "								\
+	"?_ncontact a nco:Contact . "					\
+	"?_ncontact nco:hasPhoneNumber ?_number . "			\
+	"?_call a nmo:Call ; "						\
+	"nmo:from ?_ncontact ; "					\
+	"nmo:isSent false . "						\
+	"?_contact a nco:PersonContact ; "				\
+	"nco:hasPhoneNumber ?_number . "				\
+	"OPTIONAL { ?_contact nco:hasAffiliation ?_role .} "		\
+	"?_contact nco:nameFamily ?_key ."				\
+"} UNION { "								\
+	"?_ncontact a nco:Contact . "					\
+	"?_ncontact nco:hasPhoneNumber ?_number . "			\
+	"?_call a nmo:Call ; "						\
+	"nmo:from ?_ncontact ; "					\
+	"nmo:isSent false . "						\
+	"?_contact a nco:PersonContact . "				\
+	"?_contact nco:nameFamily ?_key . "				\
+	"?_contact nco:hasAffiliation ?_role . "			\
+	"?_role nco:hasPhoneNumber ?_number . "				\
+"} UNION { "								\
+	"?_unb_contact a nco:Contact . "				\
+	"?_unb_contact nco:hasPhoneNumber ?_number . "			\
+	"?_call a nmo:Call ; "						\
+	"nmo:from ?_unb_contact ; "					\
+	"nmo:isSent false . "						\
+	"OPTIONAL {?_contact a nco:PersonContact ; "			\
+	"nco:hasPhoneNumber ?_number . } "				\
+	"OPTIONAL {?_contact a nco:PersonContact ; "			\
+	"nco:hasAffiliation ?_role . "					\
+	"?_role nco:hasPhoneNumber ?_number. } "			\
+	"FILTER ( !bound(?_contact) && !bound(?_role) ) "		\
+"} "									\
+"} "									\
+"ORDER BY DESC(nmo:sentDate(?_call)) "
 
 #define COMBINED_CALLS_LIST						\
 	"SELECT ?c nco:nameFamily(?c) nco:nameGiven(?c) "		\
@@ -690,58 +790,77 @@
 	"} GROUP BY ?call ORDER BY DESC(nmo:receivedDate(?call))"
 
 #define CONTACTS_QUERY_FROM_URI						\
-	"SELECT nco:phoneNumber(?v) nco:fullname(<%s>) "			\
-	"nco:nameFamily(<%s>) nco:nameGiven(<%s>) "				\
-	"nco:nameAdditional(<%s>) nco:nameHonorificPrefix(<%s>) "		\
-	"nco:nameHonorificSuffix(<%s>) nco:emailAddress(?e) ?vc "		\
-	"nco:pobox(?p) nco:extendedAddress(?p) "			\
-	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
-	"nco:postalcode(?p) nco:country(?p) ?f ?affType "		\
-	"nco:birthDate(<%s>) nco:nickname(<%s>) nco:url(<%s>) "		\
-	"?file nco:fullname(?o) nco:department(?a) "			\
-	"nco:role(?a) nco:contactUID(<%s>) "				\
-	"nco:title(?a) ?t nco:pobox(?po) nco:extendedAddress(?po) "	\
-	"nco:streetAddress(?po) nco:locality(?po) nco:region(?po) "	\
-	"nco:postalcode(?po) nco:country(?po) nco:emailAddress(?eo) "	\
-	"\"NOTACALL\" \"false\" \"false\" <%s> "				\
-	"WHERE { "							\
-		"<%s> a nco:PersonContact . "				\
-		"OPTIONAL { "						\
-			"<%s> a nco:PersonContact ; nco:photo ?pht . "	\
-			"?pht a nfo:FileDataObject ; nie:url ?file . "	\
-		"} "							\
-	"OPTIONAL { <%s> nco:hasPhoneNumber ?h . "			\
-		"OPTIONAL {"						\
-		"?h a nco:FaxNumber ; "					\
-		"nco:phoneNumber ?f . "					\
-		"}"							\
-		"OPTIONAL {"						\
-		"?h a nco:CellPhoneNumber ; "				\
-		"nco:phoneNumber ?vc"					\
-		"}"							\
-		"OPTIONAL {"						\
-		"?h a nco:VoicePhoneNumber ; "				\
-		"nco:phoneNumber ?t"					\
-		"}"							\
-	"}"								\
-	"OPTIONAL { "							\
-		"<%s> nco:hasAffiliation ?a . "				\
-		"OPTIONAL { ?a rdfs:label ?affType .}"			\
-			"OPTIONAL { ?a nco:hasEmailAddress ?e . } "	\
-			"OPTIONAL { ?a nco:hasPostalAddress ?p . } "	\
-			"OPTIONAL { ?a nco:hasPhoneNumber ?v . } "	\
-		"OPTIONAL { ?a nco:org ?o . } "				\
-	"} "								\
-	"OPTIONAL { <%s> nco:hasPostalAddress ?po . } "			\
-	"OPTIONAL { <%s> nco:hasEmailAddress ?eo . } "			\
-	"}"
+"SELECT "								\
+"(SELECT GROUP_CONCAT("							\
+"nco:phoneNumber(?number), \"\30\")"					\
+"WHERE {"								\
+"	?_role nco:hasPhoneNumber ?number"				\
+"}) "									\
+"nco:fullname(<%s>) "							\
+"nco:nameFamily(<%s>) "							\
+"nco:nameGiven(<%s>) "							\
+"nco:nameAdditional(<%s>) "						\
+"nco:nameHonorificPrefix(<%s>) "					\
+"nco:nameHonorificSuffix(<%s>) "					\
+"(SELECT GROUP_CONCAT(?emailaddress_other, \"\30\")"			\
+"WHERE {"								\
+"	<%s> nco:hasEmailAddress [nco:emailAddress ?emailaddress_other]"\
+"}) "									\
+"(SELECT GROUP_CONCAT(fn:concat("					\
+"tracker:coalesce(nco:pobox(?aff_addr), \"\"), \";\","			\
+"tracker:coalesce(nco:extendedAddress(?aff_addr), \"\"), \";\","	\
+"tracker:coalesce(nco:streetAddress(?aff_addr), \"\"), \";\","		\
+"tracker:coalesce(nco:locality(?aff_addr), \"\"), \";\","		\
+"tracker:coalesce(nco:region(?aff_addr), \"\"), \";\","			\
+"tracker:coalesce(nco:postalcode(?aff_addr), \"\"), \";\","		\
+"tracker:coalesce(nco:country(?aff_addr), \"\") ),\";\")"		\
+"WHERE {"								\
+"?_role nco:hasPostalAddress ?aff_addr"					\
+"}) "									\
+"(SELECT GROUP_CONCAT(fn:concat("					\
+"tracker:coalesce(nco:pobox(?oth_addr), \"\"), \";\","			\
+"tracker:coalesce(nco:extendedAddress(?oth_addr), \"\"), \";\","	\
+"tracker:coalesce(nco:streetAddress(?oth_addr), \"\"), \";\","		\
+"tracker:coalesce(nco:locality(?oth_addr), \"\"), \";\","		\
+"tracker:coalesce(nco:region(?oth_addr), \"\"), \";\","			\
+"tracker:coalesce(nco:postalcode(?oth_addr), \"\"), \";\","		\
+"tracker:coalesce(nco:country(?oth_addr), \"\") ),\"\30\")"		\
+"WHERE {"								\
+"	<%s> nco:hasPostalAddress ?oth_addr"				\
+"}) "									\
+"(SELECT GROUP_CONCAT(fn:concat(rdf:type(?contact_number),"		\
+"\"\31\", nco:phoneNumber(?contact_number)), \"\30\")"			\
+"WHERE {"								\
+"	<%s> nco:hasPhoneNumber ?contact_number"			\
+"}) "									\
+"nco:birthDate(<%s>) "							\
+"nco:nickname(<%s>) "							\
+"nco:url(<%s>) "							\
+"nie:url(nco:photo(<%s>)) "						\
+"nco:role(?_role) "							\
+"nco:contactUID(<%s>) "							\
+"nco:title(?_role) "							\
+"rdfs:label(?_role) "							\
+"nco:fullname(nco:org(?_role))"						\
+"nco:department(?_role) "						\
+"(SELECT GROUP_CONCAT(?emailaddress, \"\30\")"				\
+"WHERE {"								\
+"	?_role nco:hasEmailAddress [ nco:emailAddress ?emailaddress ]"	\
+"}) "									\
+"\"NOTACALL\" \"false\" \"false\" "					\
+"<%s> "									\
+"WHERE {"								\
+"	<%s> a nco:PersonContact ;"					\
+"	nco:nameFamily ?_key ."						\
+"	OPTIONAL {<%s> nco:hasAffiliation ?_role .}"			\
+"}"									\
+"ORDER BY ?_key tracker:id(<%s>)"
 
 #define CONTACTS_OTHER_QUERY_FROM_URI					\
-	"SELECT \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" "\
-	"\"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" "	\
-	"\"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" "	\
-	"\"\" "								\
-	"nco:phoneNumber(?t) \"NOTACALL\" \"false\" \"false\" <%s> "	\
+	"SELECT \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" "	\
+	"fn:concat(\"TYPE_OTHER\", \"\31\", nco:phoneNumber(?t)) \"\" "	\
+	"\"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" "		\
+	" \"NOTACALL\" \"false\" \"false\" <%s> "	\
 	"WHERE { "							\
 		"<%s> a nco:Contact . "					\
 		"OPTIONAL { <%s> nco:hasPhoneNumber ?t . } "		\
@@ -1333,21 +1452,64 @@ static enum phonebook_number_type get_phone_type(const char *affilation)
 	return TEL_TYPE_OTHER;
 }
 
+static void add_main_number(struct phonebook_contact *contact, char *pnumber)
+{
+	char **num_parts;
+	char *type, *number;
+
+	/* For phone taken directly from contacts data, phone number string
+	 * is represented as number type and number string - those strings are
+	 * separated by SUB_DELIM string */
+	num_parts = g_strsplit(pnumber, SUB_DELIM, 2);
+
+	if (num_parts) {
+		if (num_parts[0])
+			type = num_parts[0];
+		else
+			goto fail;
+
+		if (num_parts[1])
+			number = num_parts[1];
+		else
+			goto fail;
+	}
+
+	if (g_strrstr(type, FAX_NUM_TYPE))
+		add_phone_number(contact, number, TEL_TYPE_FAX);
+	else if (g_strrstr(type, MOBILE_NUM_TYPE))
+		add_phone_number(contact, number, TEL_TYPE_MOBILE);
+	else
+		add_phone_number(contact, number, TEL_TYPE_OTHER);
+
+fail:
+	g_strfreev(num_parts);
+}
+
 static void contact_add_numbers(struct phonebook_contact *contact,
 								char **reply)
 {
-	add_phone_number(contact, reply[COL_PHONE_NUMBER],
+	char **aff_numbers, **con_numbers;
+	int i;
+
+	/* Filling phone numbers from contact's affilation */
+	aff_numbers = g_strsplit(reply[COL_PHONE_AFF], MAIN_DELIM, MAX_FIELDS);
+
+	if (aff_numbers)
+		for(i = 0;aff_numbers[i]; ++i)
+			add_phone_number(contact, aff_numbers[i],
 					get_phone_type(reply[COL_AFF_TYPE]));
-	add_phone_number(contact, reply[COL_FAX_NUMBER], TEL_TYPE_FAX);
-	add_phone_number(contact, reply[COL_CELL_NUMBER], TEL_TYPE_MOBILE);
 
-	if (g_strcmp0(reply[COL_OTHER_NUMBER], reply[COL_CELL_NUMBER]) == 0)
-		return;
+	g_strfreev(aff_numbers);
 
-	if (g_strcmp0(reply[COL_OTHER_NUMBER], reply[COL_PHONE_NUMBER]) == 0)
-		return;
+	/* Filling phone numbers directly from contact's struct */
+	con_numbers = g_strsplit(reply[COL_PHONE_CONTACT], MAIN_DELIM,
+								MAX_FIELDS);
 
-	add_phone_number(contact, reply[COL_OTHER_NUMBER], TEL_TYPE_OTHER);
+	if (con_numbers)
+		for(i = 0; con_numbers[i] != NULL; ++i)
+			add_main_number(contact, con_numbers[i]);
+
+	g_strfreev(con_numbers);
 }
 
 static enum phonebook_email_type get_email_type(const char *affilation)
@@ -1363,9 +1525,29 @@ static enum phonebook_email_type get_email_type(const char *affilation)
 static void contact_add_emails(struct phonebook_contact *contact,
 								char **reply)
 {
-	add_email(contact, reply[COL_EMAIL],
+	char **aff_emails, **con_emails;
+	int i;
+
+	/* Emails from affilation */
+	aff_emails = g_strsplit(reply[COL_EMAIL_AFF], MAIN_DELIM, MAX_FIELDS);
+
+	if (aff_emails)
+		for(i = 0; aff_emails[i] != NULL; ++i)
+			add_email(contact, aff_emails[i],
 					get_email_type(reply[COL_AFF_TYPE]));
-	add_email(contact, reply[COL_OTHER_EMAIL], EMAIL_TYPE_OTHER);
+
+	g_strfreev(aff_emails);
+
+	/* Emails taken directly from contact's data have always type OTHER */
+	con_emails = g_strsplit(reply[COL_EMAIL_CONTACT], MAIN_DELIM,
+								MAX_FIELDS);
+
+	if (con_emails)
+		for(i = 0; con_emails[i] != NULL; ++i)
+			add_email(contact, con_emails[i], EMAIL_TYPE_OTHER);
+
+	g_strfreev(con_emails);
+
 }
 
 static enum phonebook_address_type get_addr_type(const char *affilation)
@@ -1382,32 +1564,30 @@ static void contact_add_addresses(struct phonebook_contact *contact,
 								char **reply)
 {
 
-	char *main_addr, *other_addr;
+	char **aff_addr, **con_addr;
+	int i;
+
+	/* Addresses from affilation */
+	aff_addr = g_strsplit(reply[COL_ADDR_AFF], MAIN_DELIM,
+								MAX_FIELDS);
+
+	if (aff_addr)
+		for(i = 0; aff_addr[i] != NULL; ++i)
+			add_address(contact, aff_addr[i],
+					get_addr_type(reply[COL_AFF_TYPE]));
 
-	main_addr = g_strdup_printf("%s;%s;%s;%s;%s;%s;%s",
-					reply[COL_ADDR_POBOX],
-					reply[COL_ADDR_EXT],
-					reply[COL_ADDR_STREET],
-					reply[COL_ADDR_LOCALITY],
-					reply[COL_ADDR_REGION],
-					reply[COL_ADDR_CODE],
-					reply[COL_ADDR_COUNTRY]);
+	g_strfreev(aff_addr);
 
-	other_addr = g_strdup_printf("%s;%s;%s;%s;%s;%s;%s",
-					reply[COL_OTHER_ADDR_POBOX],
-					reply[COL_OTHER_ADDR_EXT],
-					reply[COL_OTHER_ADDR_STREET],
-					reply[COL_OTHER_ADDR_LOCALITY],
-					reply[COL_OTHER_ADDR_REGION],
-					reply[COL_OTHER_ADDR_CODE],
-					reply[COL_OTHER_ADDR_COUNTRY]);
+	/* Addresses from contact struct */
+	con_addr = g_strsplit(reply[COL_ADDR_CONTACT], MAIN_DELIM,
+								MAX_FIELDS);
 
-	add_address(contact, main_addr, get_addr_type(reply[COL_AFF_TYPE]));
+	if (con_addr)
+		for(i = 0; con_addr[i] != NULL; ++i)
+			add_address(contact, con_addr[i], ADDR_TYPE_OTHER);
 
-	add_address(contact, other_addr, ADDR_TYPE_OTHER);
+	g_strfreev(con_addr);
 
-	g_free(main_addr);
-	g_free(other_addr);
 }
 
 static void contact_add_organization(struct phonebook_contact *contact,
@@ -1722,7 +1902,7 @@ void *phonebook_get_entry(const char *folder, const char *id,
 	if (strncmp(id, CONTACT_ID_PREFIX, strlen(CONTACT_ID_PREFIX)) == 0)
 		query = g_strdup_printf(CONTACTS_QUERY_FROM_URI, id, id, id, id,
 						id, id, id, id, id, id, id, id,
-						id, id, id, id, id);
+						id, id, id, id, id, id);
 	else
 		query = g_strdup_printf(CONTACTS_OTHER_QUERY_FROM_URI,
 								id, id, id);
-- 
1.7.0.4

