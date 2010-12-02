Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH] Optimize tracker queries for PBAP
Date: Thu,  2 Dec 2010 18:02:08 +0200
Message-Id: <1291305728-3463-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now data from tracker is fetched without redundand fields. Also
determining which type has phone, address and email (work or home) is
done in backend code - no tracker sub-query is used for that case. Now
queries are about 6 times faster for any amount of data( call history
queries, which were heavy loaded with OPTIONAL sub-queries are even 10
times faster than before)
---
 plugins/phonebook-tracker.c |  514 ++++++++++++++-----------------------------
 1 files changed, 166 insertions(+), 348 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index a6b9e72..cdc1008 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -43,30 +43,32 @@
 #define TRACKER_RESOURCES_INTERFACE "org.freedesktop.Tracker1.Resources"
 
 #define TRACKER_DEFAULT_CONTACT_ME "http://www.semanticdesktop.org/ontologies/2007/03/22/nco#default-contact-me"
+#define AFFILATION_HOME "Home"
+#define AFFILATION_WORK "Work"
 #define ADDR_FIELD_AMOUNT 7
-#define PULL_QUERY_COL_AMOUNT 48
+#define PULL_QUERY_COL_AMOUNT 40
 #define COUNT_QUERY_COL_AMOUNT 1
 
-#define COL_HOME_NUMBER 0
+#define COL_PHONE_NUMBER 0
 #define COL_FULL_NAME 1
 #define COL_FAMILY_NAME 2
 #define COL_GIVEN_NAME 3
 #define COL_ADDITIONAL_NAME 4
 #define COL_NAME_PREFIX 5
 #define COL_NAME_SUFFIX 6
-#define COL_HOME_EMAIL 7
-#define COL_WORK_NUMBER 8
+#define COL_EMAIL 7
+#define COL_CELL_NUMBER 8
 
-#define COL_HOME_ADDR_POBOX 9
-#define COL_HOME_ADDR_EXT 10
-#define COL_HOME_ADDR_STREET 11
-#define COL_HOME_ADDR_LOCALITY 12
-#define COL_HOME_ADDR_REGION 13
-#define COL_HOME_ADDR_CODE 14
-#define COL_HOME_ADDR_COUNTRY 15
+#define COL_ADDR_POBOX 9
+#define COL_ADDR_EXT 10
+#define COL_ADDR_STREET 11
+#define COL_ADDR_LOCALITY 12
+#define COL_ADDR_REGION 13
+#define COL_ADDR_CODE 14
+#define COL_ADDR_COUNTRY 15
 
 #define COL_FAX_NUMBER 16
-#define COL_WORK_EMAIL 17
+#define COL_AFF_TYPE 17
 #define COL_BIRTH_DATE 18
 #define COL_NICKNAME 19
 #define COL_URL 20
@@ -76,51 +78,39 @@
 #define COL_ORG_DEPARTMENT 23
 #define COL_ORG_ROLE 24
 
-#define COL_WORK_ADDR_POBOX 25
-#define COL_WORK_ADDR_EXT 26
-#define COL_WORK_ADDR_STREET 27
-#define COL_WORK_ADDR_LOCALITY 28
-#define COL_WORK_ADDR_REGION 29
-#define COL_WORK_ADDR_CODE 30
-#define COL_WORK_ADDR_COUNTRY 31
-
-#define COL_UID 32
-#define COL_TITLE 33
-#define COL_OTHER_NUMBER 34
-
-#define COL_OTHER_ADDR_POBOX 35
-#define COL_OTHER_ADDR_EXT 36
-#define COL_OTHER_ADDR_STREET 37
-#define COL_OTHER_ADDR_LOCALITY 38
-#define COL_OTHER_ADDR_REGION 39
-#define COL_OTHER_ADDR_CODE 40
-#define COL_OTHER_ADDR_COUNTRY 41
-
-#define COL_OTHER_EMAIL 42
-#define COL_CELL_NUMBER 43
-#define COL_DATE 44
-#define COL_SENT 45
-#define COL_ANSWERED 46
-#define CONTACTS_ID_COL 47
+#define COL_UID 25
+#define COL_TITLE 26
+#define COL_OTHER_NUMBER 27
+
+#define COL_OTHER_ADDR_POBOX 28
+#define COL_OTHER_ADDR_EXT 29
+#define COL_OTHER_ADDR_STREET 30
+#define COL_OTHER_ADDR_LOCALITY 31
+#define COL_OTHER_ADDR_REGION 32
+#define COL_OTHER_ADDR_CODE 33
+#define COL_OTHER_ADDR_COUNTRY 34
+
+#define COL_OTHER_EMAIL 35
+#define COL_DATE 36
+#define COL_SENT 37
+#define COL_ANSWERED 38
+#define CONTACTS_ID_COL 39
 #define CONTACT_ID_PREFIX "contact:"
 
 #define CONTACTS_QUERY_ALL						\
 	"SELECT nco:phoneNumber(?v) nco:fullname(?c) "			\
 	"nco:nameFamily(?c) nco:nameGiven(?c) "				\
 	"nco:nameAdditional(?c) nco:nameHonorificPrefix(?c) "		\
-	"nco:nameHonorificSuffix(?c) nco:emailAddress(?e) "		\
-	"nco:phoneNumber(?w) nco:pobox(?p) nco:extendedAddress(?p) "	\
+	"nco:nameHonorificSuffix(?c) nco:emailAddress(?e) ?vc "		\
+	"nco:pobox(?p) nco:extendedAddress(?p) "			\
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
-	"nco:postalcode(?p) nco:country(?p) ?f nco:emailAddress(?ew) "	\
+	"nco:postalcode(?p) nco:country(?p) ?f ?affType "		\
 	"nco:birthDate(?c) nco:nickname(?c) nco:url(?c) "		\
 	"?file nco:fullname(?o) nco:department(?a) "			\
-	"nco:role(?a) nco:pobox(?pw) nco:extendedAddress(?pw) "		\
-	"nco:streetAddress(?pw) nco:locality(?pw) nco:region(?pw) "	\
-	"nco:postalcode(?pw) nco:country(?pw) nco:contactUID(?c) "	\
+	"nco:role(?a) nco:contactUID(?c) "				\
 	"nco:title(?a) ?t nco:pobox(?po) nco:extendedAddress(?po) "	\
 	"nco:streetAddress(?po) nco:locality(?po) nco:region(?po) "	\
-        "nco:postalcode(?po) nco:country(?po) nco:emailAddress(?eo) "	\
-	"?vc "								\
+	"nco:postalcode(?po) nco:country(?po) nco:emailAddress(?eo) "	\
 	"\"NOTACALL\" \"false\" \"false\" ?c "				\
 	"WHERE { "							\
 		"?c a nco:PersonContact . "				\
@@ -144,16 +134,10 @@
 	"}"								\
 	"OPTIONAL { "							\
 		"?c nco:hasAffiliation ?a . "				\
-		"OPTIONAL { ?a rdfs:label \"Work\" . "			\
-			"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "	\
-			"OPTIONAL { ?a nco:hasPostalAddress ?pw . } "	\
-			"OPTIONAL { ?a nco:hasPhoneNumber ?w . } "	\
-		"}"							\
-		"OPTIONAL { ?a rdfs:label \"Home\" . "			\
+		"OPTIONAL { ?a rdfs:label ?affType .}"			\
 			"OPTIONAL { ?a nco:hasEmailAddress ?e . } "	\
 			"OPTIONAL { ?a nco:hasPostalAddress ?p . } "	\
 			"OPTIONAL { ?a nco:hasPhoneNumber ?v . } "	\
-		"}"							\
 		"OPTIONAL { ?a nco:org ?o . } "				\
 	"} "								\
 	"OPTIONAL { ?c nco:hasPostalAddress ?po . } "			\
@@ -175,22 +159,19 @@
 	"} GROUP BY ?c"
 
 #define MISSED_CALLS_QUERY						\
-	"SELECT ?h nco:fullname(?c) "					\
+	"SELECT nco:phoneNumber(?ap) nco:fullname(?c) "			\
 	"nco:nameFamily(?c) nco:nameGiven(?c) "				\
 	"nco:nameAdditional(?c) nco:nameHonorificPrefix(?c) "		\
-	"nco:nameHonorificSuffix(?c) nco:emailAddress(?e) "		\
-	"?w nco:pobox(?p) nco:extendedAddress(?p) "			\
+	"nco:nameHonorificSuffix(?c) nco:emailAddress(?e) ?vc "		\
+	"nco:pobox(?p) nco:extendedAddress(?p) "			\
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
-	"nco:postalcode(?p) nco:country(?p) \"\" nco:emailAddress(?ew) "\
+	"nco:postalcode(?p) nco:country(?p) \"\" ?affType "		\
 	"nco:birthDate(?c) nco:nickname(?c) nco:url(?c) "		\
 	"?file nco:fullname(?o) nco:department(?a) "			\
-	"nco:role(?a) nco:pobox(?pw) nco:extendedAddress(?pw) "		\
-	"nco:streetAddress(?pw) nco:locality(?pw) nco:region(?pw) "	\
-	"nco:postalcode(?pw) nco:country(?pw) nco:contactUID(?c) "	\
-	"?title nco:phoneNumber(?t) nco:pobox(?po) "			\
-	"nco:extendedAddress(?po) nco:streetAddress(?po) "		\
-	"nco:locality(?po) nco:region(?po) nco:postalcode(?po) "	\
-	"nco:country(?po) nco:emailAddress(?eo) ?vc "			\
+	"nco:role(?a) nco:contactUID(?c) "				\
+	"nco:title(?a) nco:phoneNumber(?t) nco:pobox(?po) nco:extendedAddress(?po) "	\
+	"nco:streetAddress(?po) nco:locality(?po) nco:region(?po) "	\
+	"nco:postalcode(?po) nco:country(?po) nco:emailAddress(?eo) "	\
 	"nmo:receivedDate(?call) "					\
 	"nmo:isSent(?call) nmo:isAnswered(?call) ?x "			\
 	"WHERE { "							\
@@ -215,63 +196,30 @@
 		"OPTIONAL { ?c nco:hasEmailAddress ?eo . } "		\
 		"OPTIONAL { "						\
 			"?c nco:hasAffiliation ?a . "			\
-			"OPTIONAL { "					\
-			"?a rdfs:label \"Work\" . "			\
-			"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "	\
-			"OPTIONAL { ?a nco:hasPostalAddress ?pw . } "	\
 			"OPTIONAL { ?a nco:title ?title } "		\
-			"}"						\
-			"OPTIONAL { "					\
-			"?a rdfs:label \"Home\" . "			\
 			"OPTIONAL { ?a nco:hasEmailAddress ?e . } "	\
 			"OPTIONAL { ?a nco:hasPostalAddress ?p . } "	\
-			"} "						\
 			"OPTIONAL { ?a nco:org ?o . } "			\
 		"} "							\
 	"} UNION { "							\
 		"?x a nco:Contact . "					\
-		"?x nco:hasPhoneNumber ?tmp . "				\
+		"?x nco:hasPhoneNumber ?ap . "				\
 		"?call a nmo:Call ; "					\
 		"nmo:from ?x ; "					\
 		"nmo:isSent false ; "					\
 		"nmo:isAnswered false . "				\
 		"?c a nco:PersonContact . "				\
 		"?c nco:hasAffiliation ?a . "				\
-		"?a nco:hasPhoneNumber ?tmp . "				\
+		"?a nco:hasPhoneNumber ?ap . "				\
 		"OPTIONAL { "						\
 			"?c a nco:PersonContact ; nco:photo ?pht . "	\
 			"?pht a nfo:FileDataObject ; nie:url ?file . "	\
 		"} "							\
-		"OPTIONAL { "						\
-			"?a rdfs:label \"Work\" . "			\
-			"?tmp nco:phoneNumber ?w . "			\
-			"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "	\
-			"OPTIONAL { ?a nco:hasPostalAddress ?pw . } "	\
-			"OPTIONAL { ?a nco:org ?o . } "			\
-			"OPTIONAL { ?a nco:title ?title } "		\
-			"{ "						\
-			"SELECT ?p ?e ?c WHERE { "			\
-			"?c nco:hasAffiliation ?b . "			\
-			"OPTIONAL {?b rdfs:label \"Home\" . "		\
-			"OPTIONAL {?b nco:hasEmailAddress ?e . } "	\
-			"OPTIONAL {?b nco:hasPostalAddress ?p . }}} "	\
-			"} "						\
-		"}"							\
-		"OPTIONAL { "						\
-			"?a rdfs:label \"Home\" . "			\
-			"?tmp nco:phoneNumber ?h . "			\
-			"OPTIONAL { ?a nco:hasEmailAddress ?e . } "	\
-			"OPTIONAL { ?a nco:hasPostalAddress ?p . } "	\
-			"OPTIONAL { ?a nco:org ?o . } "			\
-			"{ "						\
-			"SELECT ?pw ?ew ?title ?c WHERE { "		\
-			"?c nco:hasAffiliation ?b . "			\
-			"OPTIONAL {?b rdfs:label \"Work\" . "		\
-			"OPTIONAL {?b nco:hasEmailAddress ?ew . } "	\
-			"OPTIONAL {?b nco:title ?title } "		\
-			"OPTIONAL {?b nco:hasPostalAddress ?pw . }}} "	\
-			"} "						\
-		"}"							\
+		"OPTIONAL {?a rdfs:label ?affType . }"			\
+		"OPTIONAL {?a nco:hasEmailAddress ?e . } "		\
+		"OPTIONAL {?a nco:hasPostalAddress ?p . }"		\
+		"OPTIONAL { ?a nco:org ?o . } "				\
+		"OPTIONAL { ?a nco:title ?title } "			\
 		"OPTIONAL { ?c nco:hasPostalAddress ?po . } "		\
 		"OPTIONAL { ?c nco:hasEmailAddress ?eo . } "		\
 	"} UNION { "							\
@@ -327,22 +275,20 @@
 	"} GROUP BY ?call ORDER BY DESC(nmo:receivedDate(?call))"
 
 #define INCOMING_CALLS_QUERY						\
-	"SELECT ?h nco:fullname(?c) "					\
+	"SELECT nco:phoneNumber(?ap) nco:fullname(?c) "			\
 	"nco:nameFamily(?c) nco:nameGiven(?c) "				\
 	"nco:nameAdditional(?c) nco:nameHonorificPrefix(?c) "		\
-	"nco:nameHonorificSuffix(?c) nco:emailAddress(?e) "		\
-	"?w nco:pobox(?p) nco:extendedAddress(?p) "			\
+	"nco:nameHonorificSuffix(?c) nco:emailAddress(?e) ?vc "		\
+	"nco:pobox(?p) nco:extendedAddress(?p) "			\
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
-	"nco:postalcode(?p) nco:country(?p) \"\" nco:emailAddress(?ew) "\
+	"nco:postalcode(?p) nco:country(?p) \"\" ?affType "		\
 	"nco:birthDate(?c) nco:nickname(?c) nco:url(?c) "		\
 	"?file nco:fullname(?o) nco:department(?a) "			\
-	"nco:role(?a) nco:pobox(?pw) nco:extendedAddress(?pw) "		\
-	"nco:streetAddress(?pw) nco:locality(?pw) nco:region(?pw) "	\
-	"nco:postalcode(?pw) nco:country(?pw) nco:contactUID(?c) "	\
-	"?title nco:phoneNumber(?t) nco:pobox(?po) "			\
-	"nco:extendedAddress(?po) nco:streetAddress(?po) "		\
-	"nco:locality(?po) nco:region(?po) nco:postalcode(?po) "	\
-	"nco:country(?po) nco:emailAddress(?eo) ?vc "			\
+	"nco:role(?a) nco:contactUID(?c) "				\
+	"nco:title(?a) nco:phoneNumber(?t) nco:pobox(?po) "		\
+	"nco:extendedAddress(?po) "					\
+	"nco:streetAddress(?po) nco:locality(?po) nco:region(?po) "	\
+	"nco:postalcode(?po) nco:country(?po) nco:emailAddress(?eo) "	\
 	"nmo:receivedDate(?call) "					\
 	"nmo:isSent(?call) nmo:isAnswered(?call) ?x "			\
 	"WHERE { "							\
@@ -367,63 +313,30 @@
 		"OPTIONAL { ?c nco:hasEmailAddress ?eo . } "		\
 		"OPTIONAL { "						\
 			"?c nco:hasAffiliation ?a . "			\
-			"OPTIONAL { "					\
-			"?a rdfs:label \"Work\" . "			\
 			"OPTIONAL { ?a nco:title ?title } "		\
-			"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "	\
-			"OPTIONAL { ?a nco:hasPostalAddress ?pw . } "	\
-			"}"						\
-			"OPTIONAL { "					\
-			"?a rdfs:label \"Home\" . "			\
 			"OPTIONAL { ?a nco:hasEmailAddress ?e . } "	\
 			"OPTIONAL { ?a nco:hasPostalAddress ?p . } "	\
-			"} "						\
 			"OPTIONAL { ?a nco:org ?o . } "			\
 		"} "							\
 	"} UNION { "							\
 		"?x a nco:Contact . "					\
-		"?x nco:hasPhoneNumber ?tmp . "				\
+		"?x nco:hasPhoneNumber ?ap . "				\
 		"?call a nmo:Call ; "					\
 		"nmo:from ?x ; "					\
 		"nmo:isSent false ; "					\
 		"nmo:isAnswered true . "				\
 		"?c a nco:PersonContact . "				\
 		"?c nco:hasAffiliation ?a . "				\
-		"?a nco:hasPhoneNumber ?tmp . "				\
+		"?a nco:hasPhoneNumber ?ap . "				\
 		"OPTIONAL { "						\
 			"?c a nco:PersonContact ; nco:photo ?pht . "	\
 			"?pht a nfo:FileDataObject ; nie:url ?file . "	\
 		"} "							\
-		"OPTIONAL { "						\
-			"?a rdfs:label \"Work\" . "			\
-			"?tmp nco:phoneNumber ?w . "			\
-			"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "	\
-			"OPTIONAL { ?a nco:hasPostalAddress ?pw . } "	\
-			"OPTIONAL { ?a nco:org ?o . } "			\
-			"OPTIONAL { ?a nco:title ?title } "		\
-			"{ "						\
-			"SELECT ?p ?e ?c WHERE { "			\
-			"?c nco:hasAffiliation ?b . "			\
-			"OPTIONAL {?b rdfs:label \"Home\" . "		\
-			"OPTIONAL {?b nco:hasEmailAddress ?e . } "	\
-			"OPTIONAL {?b nco:hasPostalAddress ?p . }}} "	\
-			"} "						\
-		"}"							\
-		"OPTIONAL { "						\
-			"?a rdfs:label \"Home\" . "			\
-			"?tmp nco:phoneNumber ?h . "			\
-			"OPTIONAL { ?a nco:hasEmailAddress ?e . } "	\
-			"OPTIONAL { ?a nco:hasPostalAddress ?p . } "	\
-			"OPTIONAL { ?a nco:org ?o . } "			\
-			"{ "						\
-			"SELECT ?pw ?ew ?title ?c WHERE { "		\
-			"?c nco:hasAffiliation ?b . "			\
-			"OPTIONAL {?b rdfs:label \"Work\" . "		\
-			"OPTIONAL {?b nco:hasEmailAddress ?ew . } "	\
-			"OPTIONAL {?b nco:title ?title } "		\
-			"OPTIONAL {?b nco:hasPostalAddress ?pw . }}} "	\
-			"} "						\
-		"}"							\
+		"OPTIONAL {?a rdfs:label ?affType . }"			\
+		"OPTIONAL {?a nco:hasEmailAddress ?e . } "		\
+		"OPTIONAL {?a nco:hasPostalAddress ?p . }"		\
+		"OPTIONAL { ?a nco:org ?o . } "				\
+		"OPTIONAL { ?a nco:title ?title } "			\
 		"OPTIONAL { ?c nco:hasPostalAddress ?po . } "		\
 		"OPTIONAL { ?c nco:hasEmailAddress ?eo . } "		\
 	"} UNION { "							\
@@ -478,22 +391,20 @@
 	"} GROUP BY ?call ORDER BY DESC(nmo:receivedDate(?call))"
 
 #define OUTGOING_CALLS_QUERY						\
-	"SELECT ?h nco:fullname(?c) "					\
+	"SELECT nco:phoneNumber(?ap) nco:fullname(?c) "			\
 	"nco:nameFamily(?c) nco:nameGiven(?c) "				\
 	"nco:nameAdditional(?c) nco:nameHonorificPrefix(?c) "		\
-	"nco:nameHonorificSuffix(?c) nco:emailAddress(?e) "		\
-	"?w nco:pobox(?p) nco:extendedAddress(?p) "			\
+	"nco:nameHonorificSuffix(?c) nco:emailAddress(?e) ?vc "		\
+	"nco:pobox(?p) nco:extendedAddress(?p) "			\
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
-	"nco:postalcode(?p) nco:country(?p) \"\" nco:emailAddress(?ew) "\
+	"nco:postalcode(?p) nco:country(?p) \"\" ?affType "		\
 	"nco:birthDate(?c) nco:nickname(?c) nco:url(?c) "		\
 	"?file nco:fullname(?o) nco:department(?a) "			\
-	"nco:role(?a) nco:pobox(?pw) nco:extendedAddress(?pw) "		\
-	"nco:streetAddress(?pw) nco:locality(?pw) nco:region(?pw) "	\
-	"nco:postalcode(?pw) nco:country(?pw) nco:contactUID(?c) "	\
-	"?title nco:phoneNumber(?t) nco:pobox(?po) "			\
-	"nco:extendedAddress(?po) nco:streetAddress(?po) "		\
-	"nco:locality(?po) nco:region(?po) nco:postalcode(?po) "	\
-	"nco:country(?po) nco:emailAddress(?eo) ?vc "			\
+	"nco:role(?a) nco:contactUID(?c) "				\
+	"nco:title(?a) nco:phoneNumber(?t) nco:pobox(?po) "		\
+	"nco:extendedAddress(?po) "					\
+	"nco:streetAddress(?po) nco:locality(?po) nco:region(?po) "	\
+	"nco:postalcode(?po) nco:country(?po) nco:emailAddress(?eo) "	\
 	"nmo:receivedDate(?call) "					\
 	"nmo:isSent(?call) nmo:isAnswered(?call) ?x "			\
 	"WHERE { "							\
@@ -517,62 +428,29 @@
 		"OPTIONAL { ?c nco:hasEmailAddress ?eo . } "		\
 		"OPTIONAL { "						\
 			"?c nco:hasAffiliation ?a . "			\
-			"OPTIONAL { "					\
-			"?a rdfs:label \"Work\" . "			\
-			"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "	\
-			"OPTIONAL { ?a nco:hasPostalAddress ?pw . } "	\
 			"OPTIONAL { ?a nco:title ?title } "		\
-			"}"						\
-			"OPTIONAL { "					\
-			"?a rdfs:label \"Home\" . "			\
 			"OPTIONAL { ?a nco:hasEmailAddress ?e . } "	\
 			"OPTIONAL { ?a nco:hasPostalAddress ?p . } "	\
-			"} "						\
 			"OPTIONAL { ?a nco:org ?o . } "			\
 		"} "							\
 	"} UNION { "							\
 		"?x a nco:Contact . "					\
-		"?x nco:hasPhoneNumber ?tmp . "				\
+		"?x nco:hasPhoneNumber ?ap . "				\
 		"?call a nmo:Call ; "					\
 		"nmo:to ?x ; "						\
 		"nmo:isSent true . "					\
 		"?c a nco:PersonContact . "				\
 		"?c nco:hasAffiliation ?a . "				\
-		"?a nco:hasPhoneNumber ?tmp . "				\
+		"?a nco:hasPhoneNumber ?ap . "				\
 		"OPTIONAL { "						\
 			"?c a nco:PersonContact ; nco:photo ?pht . "	\
 			"?pht a nfo:FileDataObject ; nie:url ?file . "	\
 		"} "							\
-		"OPTIONAL { "						\
-			"?a rdfs:label \"Work\" . "			\
-			"?tmp nco:phoneNumber ?w . "			\
-			"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "	\
-			"OPTIONAL { ?a nco:hasPostalAddress ?pw . } "	\
-			"OPTIONAL { ?a nco:org ?o . } "			\
-			"OPTIONAL { ?a nco:title ?title } "		\
-			"{ "						\
-			"SELECT ?p ?e ?c WHERE { "			\
-			"?c nco:hasAffiliation ?b . "			\
-			"OPTIONAL {?b rdfs:label \"Home\" . "		\
-			"OPTIONAL {?b nco:hasEmailAddress ?e . } "	\
-			"OPTIONAL {?b nco:hasPostalAddress ?p . }}} "	\
-			"} "						\
-		"}"							\
-		"OPTIONAL { "						\
-			"?a rdfs:label \"Home\" . "			\
-			"?tmp nco:phoneNumber ?h . "			\
-			"OPTIONAL { ?a nco:hasEmailAddress ?e . } "	\
-			"OPTIONAL { ?a nco:hasPostalAddress ?p . } "	\
-			"OPTIONAL { ?a nco:org ?o . } "			\
-			"{ "						\
-			"SELECT ?pw ?ew ?title ?c WHERE { "		\
-			"?c nco:hasAffiliation ?b . "			\
-			"OPTIONAL {?b rdfs:label \"Work\" . "		\
-			"OPTIONAL {?b nco:hasEmailAddress ?ew . } "	\
-			"OPTIONAL { ?a nco:title ?title } "		\
-			"OPTIONAL {?b nco:hasPostalAddress ?pw . }}} "	\
-			"} "						\
-		"}"							\
+		"OPTIONAL {?a rdfs:label ?affType . }"			\
+		"OPTIONAL {?a nco:hasEmailAddress ?e . } "		\
+		"OPTIONAL {?a nco:hasPostalAddress ?p . }"		\
+		"OPTIONAL { ?a nco:org ?o . } "				\
+		"OPTIONAL { ?a nco:title ?title } "			\
 		"OPTIONAL { ?c nco:hasPostalAddress ?po . } "		\
 		"OPTIONAL { ?c nco:hasEmailAddress ?eo . } "		\
 	"} UNION { "							\
@@ -623,22 +501,20 @@
 	"} GROUP BY ?call ORDER BY DESC(nmo:sentDate(?call))"
 
 #define COMBINED_CALLS_QUERY						\
-	"SELECT ?h nco:fullname(?c) "					\
+	"SELECT nco:phoneNumber(?ap) nco:fullname(?c) "			\
 	"nco:nameFamily(?c) nco:nameGiven(?c) "				\
 	"nco:nameAdditional(?c) nco:nameHonorificPrefix(?c) "		\
-	"nco:nameHonorificSuffix(?c) nco:emailAddress(?e) "		\
-	"?w nco:pobox(?p) nco:extendedAddress(?p) "			\
+	"nco:nameHonorificSuffix(?c) nco:emailAddress(?e) ?vc "		\
+	"nco:pobox(?p) nco:extendedAddress(?p) "			\
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
-	"nco:postalcode(?p) nco:country(?p) \"\" nco:emailAddress(?ew) "\
+	"nco:postalcode(?p) nco:country(?p) \"\" ?affType "		\
 	"nco:birthDate(?c) nco:nickname(?c) nco:url(?c) "		\
 	"?file nco:fullname(?o) nco:department(?a) "			\
-	"nco:role(?a) nco:pobox(?pw) nco:extendedAddress(?pw) "		\
-	"nco:streetAddress(?pw) nco:locality(?pw) nco:region(?pw) "	\
-	"nco:postalcode(?pw) nco:country(?pw) nco:contactUID(?c) "	\
-	"?title nco:phoneNumber(?t) nco:pobox(?po) "			\
-	"nco:extendedAddress(?po) nco:streetAddress(?po) "		\
-	"nco:locality(?po) nco:region(?po) nco:postalcode(?po) "	\
-	"nco:country(?po) nco:emailAddress(?eo) ?vc "			\
+	"nco:role(?a) nco:contactUID(?c) "				\
+	"nco:title(?a) nco:phoneNumber(?t) nco:pobox(?po) "		\
+	"nco:extendedAddress(?po) "					\
+	"nco:streetAddress(?po) nco:locality(?po) nco:region(?po) "	\
+	"nco:postalcode(?po) nco:country(?po) nco:emailAddress(?eo) "	\
 	"nmo:receivedDate(?call) "					\
 	"nmo:isSent(?call) nmo:isAnswered(?call) ?x "			\
 	"WHERE { "							\
@@ -662,62 +538,29 @@
 		"OPTIONAL { ?c nco:hasEmailAddress ?eo . } "		\
 		"OPTIONAL { "						\
 			"?c nco:hasAffiliation ?a . "			\
-			"OPTIONAL { "					\
-			"?a rdfs:label \"Work\" . "			\
-			"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "	\
-			"OPTIONAL { ?a nco:hasPostalAddress ?pw . } "	\
 			"OPTIONAL { ?a nco:title ?title } "		\
-			"}"						\
-			"OPTIONAL { "					\
-			"?a rdfs:label \"Home\" . "			\
 			"OPTIONAL { ?a nco:hasEmailAddress ?e . } "	\
 			"OPTIONAL { ?a nco:hasPostalAddress ?p . } "	\
-			"} "						\
 			"OPTIONAL { ?a nco:org ?o . } "			\
 		"} "							\
 	"} UNION { "							\
 		"?x a nco:Contact . "					\
-		"?x nco:hasPhoneNumber ?tmp . "				\
+		"?x nco:hasPhoneNumber ?ap . "				\
 		"?call a nmo:Call ; "					\
 		"nmo:to ?x ; "						\
 		"nmo:isSent true . "					\
 		"?c a nco:PersonContact . "				\
 		"?c nco:hasAffiliation ?a . "				\
-		"?a nco:hasPhoneNumber ?tmp . "				\
+		"?a nco:hasPhoneNumber ?ap . "				\
 		"OPTIONAL { "						\
 			"?c a nco:PersonContact ; nco:photo ?pht . "	\
 			"?pht a nfo:FileDataObject ; nie:url ?file . "	\
 		"} "							\
-		"OPTIONAL { "						\
-			"?a rdfs:label \"Work\" . "			\
-			"?tmp nco:phoneNumber ?w . "			\
-			"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "	\
-			"OPTIONAL { ?a nco:hasPostalAddress ?pw . } "	\
-			"OPTIONAL { ?a nco:org ?o . } "			\
-			"OPTIONAL { ?a nco:title ?title } "		\
-			"{ "						\
-			"SELECT ?p ?e ?c WHERE { "			\
-			"?c nco:hasAffiliation ?b . "			\
-			"OPTIONAL {?b rdfs:label \"Home\" . "		\
-			"OPTIONAL {?b nco:hasEmailAddress ?e . } "	\
-			"OPTIONAL {?b nco:hasPostalAddress ?p . }}} "	\
-			"} "						\
-		"}"							\
-		"OPTIONAL { "						\
-			"?a rdfs:label \"Home\" . "			\
-			"?tmp nco:phoneNumber ?h . "			\
-			"OPTIONAL { ?a nco:hasEmailAddress ?e . } "	\
-			"OPTIONAL { ?a nco:hasPostalAddress ?p . } "	\
-			"OPTIONAL { ?a nco:org ?o . } "			\
-			"{ "						\
-			"SELECT ?pw ?ew ?title ?c WHERE { "		\
-			"?c nco:hasAffiliation ?b . "			\
-			"OPTIONAL {?b rdfs:label \"Work\" . "		\
-			"OPTIONAL {?b nco:hasEmailAddress ?ew . } "	\
-			"OPTIONAL {?b nco:title ?title } "		\
-			"OPTIONAL {?b nco:hasPostalAddress ?pw . }}} "	\
-			"} "						\
-		"}"							\
+		"OPTIONAL {?a rdfs:label ?affType . }"			\
+		"OPTIONAL {?a nco:hasEmailAddress ?e . } "		\
+		"OPTIONAL {?a nco:hasPostalAddress ?p . }"		\
+		"OPTIONAL { ?a nco:org ?o . } "				\
+		"OPTIONAL { ?a nco:title ?title } "			\
 		"OPTIONAL { ?c nco:hasPostalAddress ?po . } "		\
 		"OPTIONAL { ?c nco:hasEmailAddress ?eo . } "		\
 	"} UNION { "							\
@@ -752,62 +595,29 @@
 		"OPTIONAL { ?c nco:hasEmailAddress ?eo . } "		\
 		"OPTIONAL { "						\
 			"?c nco:hasAffiliation ?a . "			\
-			"OPTIONAL { "					\
-			"?a rdfs:label \"Work\" . "			\
-			"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "	\
-			"OPTIONAL { ?a nco:hasPostalAddress ?pw . } "	\
 			"OPTIONAL { ?a nco:title ?title } "		\
-			"}"						\
-			"OPTIONAL { "					\
-			"?a rdfs:label \"Home\" . "			\
 			"OPTIONAL { ?a nco:hasEmailAddress ?e . } "	\
 			"OPTIONAL { ?a nco:hasPostalAddress ?p . } "	\
-			"} "						\
 			"OPTIONAL { ?a nco:org ?o . } "			\
 		"} "							\
 	"} UNION { "							\
 		"?x a nco:Contact . "					\
-		"?x nco:hasPhoneNumber ?tmp . "				\
+		"?x nco:hasPhoneNumber ?ap . "				\
 		"?call a nmo:Call ; "					\
 		"nmo:from ?x ; "					\
 		"nmo:isSent false . "					\
 		"?c a nco:PersonContact . "				\
 		"?c nco:hasAffiliation ?a . "				\
-		"?a nco:hasPhoneNumber ?tmp . "				\
+		"?a nco:hasPhoneNumber ?ap . "				\
 		"OPTIONAL { "						\
 			"?c a nco:PersonContact ; nco:photo ?pht . "	\
 			"?pht a nfo:FileDataObject ; nie:url ?file . "	\
 		"} "							\
-		"OPTIONAL { "						\
-			"?a rdfs:label \"Work\" . "			\
-			"?tmp nco:phoneNumber ?w . "			\
-			"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "	\
-			"OPTIONAL { ?a nco:hasPostalAddress ?pw . } "	\
-			"OPTIONAL { ?a nco:org ?o . } "			\
-			"OPTIONAL { ?a nco:title ?title } "		\
-			"{ "						\
-			"SELECT ?p ?e ?c WHERE { "			\
-			"?c nco:hasAffiliation ?b . "			\
-			"OPTIONAL {?b rdfs:label \"Home\" . "		\
-			"OPTIONAL {?b nco:hasEmailAddress ?e . } "	\
-			"OPTIONAL {?b nco:hasPostalAddress ?p . }}} "	\
-			"} "						\
-		"}"							\
-		"OPTIONAL { "						\
-			"?a rdfs:label \"Home\" . "			\
-			"?tmp nco:phoneNumber ?h . "			\
-			"OPTIONAL { ?a nco:hasEmailAddress ?e . } "	\
-			"OPTIONAL { ?a nco:hasPostalAddress ?p . } "	\
-			"OPTIONAL { ?a nco:org ?o . } "			\
-			"{ "						\
-			"SELECT ?pw ?ew ?title ?c WHERE { "		\
-			"?c nco:hasAffiliation ?b . "			\
-			"OPTIONAL {?b rdfs:label \"Work\" . "		\
-			"OPTIONAL {?b nco:hasEmailAddress ?ew . } "	\
-			"OPTIONAL {?b nco:title ?title } "		\
-			"OPTIONAL {?b nco:hasPostalAddress ?pw . }}} "	\
-			"} "						\
-		"}"							\
+		"OPTIONAL {?a rdfs:label ?affType . }"			\
+		"OPTIONAL {?a nco:hasEmailAddress ?e . } "		\
+		"OPTIONAL {?a nco:hasPostalAddress ?p . }"		\
+		"OPTIONAL { ?a nco:org ?o . } "				\
+		"OPTIONAL { ?a nco:title ?title } "			\
 		"OPTIONAL { ?c nco:hasPostalAddress ?po . } "		\
 		"OPTIONAL { ?c nco:hasEmailAddress ?eo . } "		\
 	"} UNION { "							\
@@ -880,23 +690,20 @@
 	"} GROUP BY ?call ORDER BY DESC(nmo:receivedDate(?call))"
 
 #define CONTACTS_QUERY_FROM_URI						\
-	"SELECT nco:phoneNumber(?v) nco:fullname(<%s>) "		\
-	"nco:nameFamily(<%s>) nco:nameGiven(<%s>) "			\
-	"nco:nameAdditional(<%s>) nco:nameHonorificPrefix(<%s>) "	\
-	"nco:nameHonorificSuffix(<%s>) nco:emailAddress(?e) "		\
-	"nco:phoneNumber(?w) nco:pobox(?p) nco:extendedAddress(?p) "	\
+	"SELECT nco:phoneNumber(?v) nco:fullname(<%s>) "			\
+	"nco:nameFamily(<%s>) nco:nameGiven(<%s>) "				\
+	"nco:nameAdditional(<%s>) nco:nameHonorificPrefix(<%s>) "		\
+	"nco:nameHonorificSuffix(<%s>) nco:emailAddress(?e) ?vc "		\
+	"nco:pobox(?p) nco:extendedAddress(?p) "			\
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
-	"nco:postalcode(?p) nco:country(?p) ?f nco:emailAddress(?ew) "	\
+	"nco:postalcode(?p) nco:country(?p) ?f ?affType "		\
 	"nco:birthDate(<%s>) nco:nickname(<%s>) nco:url(<%s>) "		\
 	"?file nco:fullname(?o) nco:department(?a) "			\
-	"nco:role(?a) nco:pobox(?pw) nco:extendedAddress(?pw) "		\
-	"nco:streetAddress(?pw) nco:locality(?pw) nco:region(?pw) "	\
-	"nco:postalcode(?pw) nco:country(?pw) nco:contactUID(<%s>) "	\
+	"nco:role(?a) nco:contactUID(<%s>) "				\
 	"nco:title(?a) ?t nco:pobox(?po) nco:extendedAddress(?po) "	\
 	"nco:streetAddress(?po) nco:locality(?po) nco:region(?po) "	\
-        "nco:postalcode(?po) nco:country(?po) nco:emailAddress(?eo) "	\
-	"?vc "								\
-	"\"NOTACALL\" \"false\" \"false\" <%s> "			\
+	"nco:postalcode(?po) nco:country(?po) nco:emailAddress(?eo) "	\
+	"\"NOTACALL\" \"false\" \"false\" <%s> "				\
 	"WHERE { "							\
 		"<%s> a nco:PersonContact . "				\
 		"OPTIONAL { "						\
@@ -919,16 +726,10 @@
 	"}"								\
 	"OPTIONAL { "							\
 		"<%s> nco:hasAffiliation ?a . "				\
-		"OPTIONAL { ?a rdfs:label \"Work\" . "			\
-			"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "	\
-			"OPTIONAL { ?a nco:hasPostalAddress ?pw . } "	\
-			"OPTIONAL { ?a nco:hasPhoneNumber ?w . } "	\
-		"}"							\
-		"OPTIONAL { ?a rdfs:label \"Home\" . "			\
+		"OPTIONAL { ?a rdfs:label ?affType .}"			\
 			"OPTIONAL { ?a nco:hasEmailAddress ?e . } "	\
 			"OPTIONAL { ?a nco:hasPostalAddress ?p . } "	\
 			"OPTIONAL { ?a nco:hasPhoneNumber ?v . } "	\
-		"}"							\
 		"OPTIONAL { ?a nco:org ?o . } "				\
 	"} "								\
 	"OPTIONAL { <%s> nco:hasPostalAddress ?po . } "			\
@@ -939,7 +740,7 @@
 	"SELECT \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" "\
 	"\"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" "	\
 	"\"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" "	\
-	"\"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" \"\" "			\
+	"\"\" "								\
 	"nco:phoneNumber(?t) \"NOTACALL\" \"false\" \"false\" <%s> "	\
 	"WHERE { "							\
 		"<%s> a nco:Contact . "					\
@@ -1491,57 +1292,75 @@ static void contact_init(struct phonebook_contact *contact, char **reply)
 							reply[COL_ANSWERED]);
 }
 
+static enum phonebook_number_type get_phone_type(const char *affilation)
+{
+	if (g_strcmp0(AFFILATION_HOME, affilation) == 0)
+		return TEL_TYPE_HOME;
+	else if (g_strcmp0(AFFILATION_WORK, affilation) == 0)
+		return TEL_TYPE_WORK;
+
+	return TEL_TYPE_OTHER;
+}
+
 static void contact_add_numbers(struct phonebook_contact *contact,
 								char **reply)
 {
-	add_phone_number(contact, reply[COL_HOME_NUMBER], TEL_TYPE_HOME);
-	add_phone_number(contact, reply[COL_WORK_NUMBER], TEL_TYPE_WORK);
+	add_phone_number(contact, reply[COL_PHONE_NUMBER],
+					get_phone_type(reply[COL_AFF_TYPE]));
 	add_phone_number(contact, reply[COL_FAX_NUMBER], TEL_TYPE_FAX);
 	add_phone_number(contact, reply[COL_CELL_NUMBER], TEL_TYPE_MOBILE);
 
 	if (g_strcmp0(reply[COL_OTHER_NUMBER], reply[COL_CELL_NUMBER]) == 0)
 		return;
 
-	if (g_strcmp0(reply[COL_OTHER_NUMBER], reply[COL_WORK_NUMBER]) == 0)
-		return;
-
-	if (g_strcmp0(reply[COL_OTHER_NUMBER], reply[COL_HOME_NUMBER]) == 0)
+	if (g_strcmp0(reply[COL_OTHER_NUMBER], reply[COL_PHONE_NUMBER]) == 0)
 		return;
 
 	add_phone_number(contact, reply[COL_OTHER_NUMBER], TEL_TYPE_OTHER);
 }
 
+static enum phonebook_email_type get_email_type(const char *affilation)
+{
+	if (g_strcmp0(AFFILATION_HOME, affilation) == 0)
+		return EMAIL_TYPE_HOME;
+	else if (g_strcmp0(AFFILATION_WORK, affilation) == 0)
+		return EMAIL_TYPE_WORK;
+
+	return EMAIL_TYPE_OTHER;
+}
+
 static void contact_add_emails(struct phonebook_contact *contact,
 								char **reply)
 {
-	add_email(contact, reply[COL_HOME_EMAIL], EMAIL_TYPE_HOME);
-	add_email(contact, reply[COL_WORK_EMAIL], EMAIL_TYPE_WORK);
+	add_email(contact, reply[COL_EMAIL],
+					get_email_type(reply[COL_AFF_TYPE]));
 	add_email(contact, reply[COL_OTHER_EMAIL], EMAIL_TYPE_OTHER);
 }
 
+static enum phonebook_address_type get_addr_type(const char *affilation)
+{
+	if (g_strcmp0(AFFILATION_HOME, affilation) == 0)
+		return ADDR_TYPE_HOME;
+	else if (g_strcmp0(AFFILATION_WORK, affilation) == 0)
+		return ADDR_TYPE_WORK;
+
+	return ADDR_TYPE_HOME;
+}
+
 static void contact_add_addresses(struct phonebook_contact *contact,
 								char **reply)
 {
 
-	char *home_addr, *work_addr, *other_addr;
-
-	home_addr = g_strdup_printf("%s;%s;%s;%s;%s;%s;%s",
-					reply[COL_HOME_ADDR_POBOX],
-					reply[COL_HOME_ADDR_EXT],
-					reply[COL_HOME_ADDR_STREET],
-					reply[COL_HOME_ADDR_LOCALITY],
-					reply[COL_HOME_ADDR_REGION],
-					reply[COL_HOME_ADDR_CODE],
-					reply[COL_HOME_ADDR_COUNTRY]);
-
-	work_addr = g_strdup_printf("%s;%s;%s;%s;%s;%s;%s",
-					reply[COL_WORK_ADDR_POBOX],
-					reply[COL_WORK_ADDR_EXT],
-					reply[COL_WORK_ADDR_STREET],
-					reply[COL_WORK_ADDR_LOCALITY],
-					reply[COL_WORK_ADDR_REGION],
-					reply[COL_WORK_ADDR_CODE],
-					reply[COL_WORK_ADDR_COUNTRY]);
+	char *main_addr, *other_addr;
+
+	main_addr = g_strdup_printf("%s;%s;%s;%s;%s;%s;%s",
+					reply[COL_ADDR_POBOX],
+					reply[COL_ADDR_EXT],
+					reply[COL_ADDR_STREET],
+					reply[COL_ADDR_LOCALITY],
+					reply[COL_ADDR_REGION],
+					reply[COL_ADDR_CODE],
+					reply[COL_ADDR_COUNTRY]);
 
 	other_addr = g_strdup_printf("%s;%s;%s;%s;%s;%s;%s",
 					reply[COL_OTHER_ADDR_POBOX],
@@ -1552,12 +1371,11 @@ static void contact_add_addresses(struct phonebook_contact *contact,
 					reply[COL_OTHER_ADDR_CODE],
 					reply[COL_OTHER_ADDR_COUNTRY]);
 
-	add_address(contact, home_addr, ADDR_TYPE_HOME);
-	add_address(contact, work_addr, ADDR_TYPE_WORK);
+	add_address(contact, main_addr, get_addr_type(reply[COL_AFF_TYPE]));
+
 	add_address(contact, other_addr, ADDR_TYPE_OTHER);
 
-	g_free(home_addr);
-	g_free(work_addr);
+	g_free(main_addr);
 	g_free(other_addr);
 }
 
-- 
1.7.0.4

