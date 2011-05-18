Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH] Rewrite of PBAP call history queries
Date: Wed, 18 May 2011 15:05:10 +0200
Message-Id: <1305723910-13168-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Graph patterns used in queries for PullPhonebook and PullvCardListing in
case of call history are now rewritten to share the same code and be
simpler - previously they were doing almost the same, but exact code
differed. So in this patch repeating parts of queries were reduced to one
place for easy management.

Also new queries fix the behaviour in situation when there is more than
one contact matching a phone number from call history entry - in this
case no contact data is returned instead of returning random contact as
it was the case before.
---
 plugins/phonebook-tracker.c |  600 ++++--------------------------------------
 1 files changed, 58 insertions(+), 542 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 8da8b80..eec1e5d 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -156,428 +156,40 @@
 	"} "								\
 	"} GROUP BY ?c"
 
-#define MISSED_CALLS_QUERY						\
-"SELECT "								\
-"(SELECT fn:concat(rdf:type(?role_number),"				\
-	"\"\31\", nco:phoneNumber(?role_number))"			\
-	"WHERE {"							\
-	"{"								\
-	"	?_role nco:hasPhoneNumber ?role_number "		\
-	"	FILTER (?role_number = ?_number)"			\
-	"} UNION { "							\
-		"?_unb_contact nco:hasPhoneNumber ?role_number . "	\
-	"}"								\
-"} GROUP BY nco:phoneNumber(?role_number) ) "				\
-	"nco:fullname(?_contact) "					\
-	"nco:nameFamily(?_contact) "					\
-	"nco:nameGiven(?_contact) "					\
-	"nco:nameAdditional(?_contact) "				\
-	"nco:nameHonorificPrefix(?_contact) "				\
-	"nco:nameHonorificSuffix(?_contact) "				\
-"(SELECT GROUP_CONCAT(fn:concat("					\
-	"tracker:coalesce(nco:pobox(?aff_addr), \"\"), \";\","		\
-	"tracker:coalesce(nco:extendedAddress(?aff_addr), \"\"), \";\","\
-	"tracker:coalesce(nco:streetAddress(?aff_addr), \"\"), \";\","	\
-	"tracker:coalesce(nco:locality(?aff_addr), \"\"), \";\","	\
-	"tracker:coalesce(nco:region(?aff_addr), \"\"), \";\","		\
-	"tracker:coalesce(nco:postalcode(?aff_addr), \"\"), \";\","	\
-	"tracker:coalesce(nco:country(?aff_addr), \"\"), "		\
-	"\"\31\", rdfs:label(?c_role) ), "				\
-	"\"\30\") "							\
-	"WHERE {"							\
-	"?_contact nco:hasAffiliation ?c_role . "			\
-	"?c_role nco:hasPostalAddress ?aff_addr"			\
-	"}) "								\
-	"nco:birthDate(?_contact) "					\
-	"nco:nickname(?_contact) "					\
-"(SELECT GROUP_CONCAT(fn:concat( "					\
-	"?url_value, \"\31\", ?aff_type "				\
-	"), \"\30\") "							\
-	"WHERE {"							\
-		"?_contact nco:hasAffiliation ?c_role . "		\
-		"?c_role nco:url ?url_value . "				\
-		"?c_role rdfs:label ?aff_type . "			\
-"})"									\
-	"nie:url(nco:photo(?_contact)) "				\
-	"nco:role(?_role) "						\
-	"nco:contactUID(?_contact) "					\
-	"nco:title(?_role) "						\
-	"rdfs:label(?_role) "						\
-	"nco:fullname(nco:org(?_role)) "				\
-	"nco:department(?_role) "					\
-"(SELECT GROUP_CONCAT(fn:concat(?emailaddress,\"\31\","			\
-	"rdfs:label(?c_role)),"						\
-	"\"\30\") "							\
-	"WHERE { "							\
-	"?_contact nco:hasAffiliation ?c_role . "			\
-	"?c_role nco:hasEmailAddress "					\
-	"		[ nco:emailAddress ?emailaddress ] "		\
-	"}) "								\
-	"nmo:receivedDate(?_call) "					\
-	"nmo:isSent(?_call) "						\
-	"nmo:isAnswered(?_call) "					\
-	"fn:concat(tracker:coalesce(?_ncontact, \"\"),"			\
-	"tracker:coalesce(?_unb_contact, \"\"))"			\
-	" "								\
-"WHERE { "								\
-"{ "									\
-	"?_ncontact a nco:Contact . "					\
-	"?_ncontact nco:hasPhoneNumber ?_number . "			\
-	"?_call a nmo:Call ; "						\
-	"nmo:from ?_ncontact ; "					\
-	"nmo:isAnswered false ;"					\
-	"nmo:isSent false . "						\
-	"?_contact a nco:PersonContact ; "				\
-	"nco:hasPhoneNumber ?_number . "				\
-	"OPTIONAL { ?_contact nco:hasAffiliation ?_role .} "		\
-"} UNION { "								\
-	"?_ncontact a nco:Contact . "					\
-	"?_ncontact nco:hasPhoneNumber ?_other . "			\
-	"?_call a nmo:Call ; "						\
-	"nmo:from ?_ncontact ; "					\
-	"nmo:isAnswered false ;"					\
-	"nmo:isSent false . "						\
-	"?_contact a nco:PersonContact . "				\
-	"?_contact nco:hasAffiliation ?_role . "			\
-	"?_role nco:hasPhoneNumber ?_number . "				\
-	"?_other maemo:localPhoneNumber ?_realnum . "			\
-	"?_number maemo:localPhoneNumber ?_realnum . "			\
-"} UNION { "								\
+#define CALLS_CONSTRAINTS(CONSTRAINT)					\
+" WHERE { "								\
+	"?_call a nmo:Call . "						\
 	"?_unb_contact a nco:Contact . "				\
-	"?_unb_contact nco:hasPhoneNumber ?_other . "			\
-	"?_call a nmo:Call ; "						\
-	"nmo:from ?_unb_contact ; "					\
-	"nmo:isAnswered false ;"					\
-	"nmo:isSent false . "						\
-	"OPTIONAL {?_contact a nco:PersonContact ; "			\
-	"nco:hasPhoneNumber ?_number . } "				\
-	"OPTIONAL {?_contact a nco:PersonContact ; "			\
-	"nco:hasAffiliation ?_role . "					\
-	"?_role nco:hasPhoneNumber ?_number . "				\
-	"?_other maemo:localPhoneNumber ?_realnum . "			\
-	"?_number maemo:localPhoneNumber ?_realnum . }"			\
-	"FILTER ( !bound(?_contact) && !bound(?_role) ) "		\
-"} "									\
-"} "									\
-"ORDER BY DESC(nmo:sentDate(?_call)) "
-
-
-#define MISSED_CALLS_LIST						\
-	"SELECT ?c nco:nameFamily(?c) "					\
-	"nco:nameGiven(?c) nco:nameAdditional(?c) "			\
-	"nco:nameHonorificPrefix(?c) nco:nameHonorificSuffix(?c) "	\
-	"nco:phoneNumber(?h) "						\
-	"WHERE { "							\
-	"{"								\
-		"?c a nco:Contact . "					\
-		"?c nco:hasPhoneNumber ?h . "				\
-		"?call a nmo:Call ; "					\
-		"nmo:from ?c ; "					\
-		"nmo:isSent false ; "					\
-		"nmo:isAnswered false ."				\
-	"}UNION{"							\
-		"?x a nco:Contact . "					\
-		"?x nco:hasPhoneNumber ?h . "				\
-		"?call a nmo:Call ; "					\
-		"nmo:from ?x ; "					\
-		"nmo:isSent false ; "					\
-		"nmo:isAnswered false ."				\
-		"?c a nco:PersonContact . "				\
-		"?c nco:hasPhoneNumber ?h . "				\
-	"} UNION { "							\
-		"?x a nco:Contact . "					\
-		"?x nco:hasPhoneNumber ?h . "				\
-		"?call a nmo:Call ; "					\
-		"nmo:from ?x ; "					\
-		"nmo:isSent false ; "					\
-		"nmo:isAnswered false ."				\
-		"?c a nco:PersonContact . "				\
-		"?c nco:hasAffiliation ?a . "				\
-		"?a nco:hasPhoneNumber ?no . "				\
-		"?h maemo:localPhoneNumber ?num . "			\
-		"?no maemo:localPhoneNumber ?num . "			\
+	"?_unb_contact nco:hasPhoneNumber ?_cpn . "			\
+	"OPTIONAL { "							\
+		"{ SELECT ?_contact ?_cpn ?_role ?_number "		\
+			"count(?_contact) as ?cnt "			\
+		"WHERE { "						\
+			"?_contact a nco:PersonContact . "		\
+			"{ "						\
+				"?_contact nco:hasAffiliation ?_role . "\
+				"?_role nco:hasPhoneNumber ?_number . " \
+			"} UNION { "					\
+				"?_contact nco:hasPhoneNumber ?_number" \
+			"} "						\
+			"?_number maemo:localPhoneNumber ?_no . "	\
+			"?_cpn maemo:localPhoneNumber ?_no . "		\
+		"} GROUP BY ?_cpn } "					\
+		"FILTER(?cnt = 1) "					\
 	"} "								\
-	"} GROUP BY ?call ORDER BY DESC(nmo:receivedDate(?call))"
-
-#define INCOMING_CALLS_QUERY						\
-"SELECT "								\
-"(SELECT fn:concat(rdf:type(?role_number),"				\
-	"\"\31\", nco:phoneNumber(?role_number))"			\
-	"WHERE {"							\
-	"{"								\
-	"	?_role nco:hasPhoneNumber ?role_number "		\
-	"	FILTER (?role_number = ?_number)"			\
-	"} UNION { "							\
-		"?_unb_contact nco:hasPhoneNumber ?role_number . "	\
-	"}"								\
-"} GROUP BY nco:phoneNumber(?role_number) ) "				\
-	"nco:fullname(?_contact) "					\
-	"nco:nameFamily(?_contact) "					\
-	"nco:nameGiven(?_contact) "					\
-	"nco:nameAdditional(?_contact) "				\
-	"nco:nameHonorificPrefix(?_contact) "				\
-	"nco:nameHonorificSuffix(?_contact) "				\
-"(SELECT GROUP_CONCAT(fn:concat("					\
-	"tracker:coalesce(nco:pobox(?aff_addr), \"\"), \";\","		\
-	"tracker:coalesce(nco:extendedAddress(?aff_addr), \"\"), \";\","\
-	"tracker:coalesce(nco:streetAddress(?aff_addr), \"\"), \";\","	\
-	"tracker:coalesce(nco:locality(?aff_addr), \"\"), \";\","	\
-	"tracker:coalesce(nco:region(?aff_addr), \"\"), \";\","		\
-	"tracker:coalesce(nco:postalcode(?aff_addr), \"\"), \";\","	\
-	"tracker:coalesce(nco:country(?aff_addr), \"\"), "		\
-	"\"\31\", rdfs:label(?c_role) ), "				\
-	"\"\30\") "							\
-	"WHERE {"							\
-	"?_contact nco:hasAffiliation ?c_role . "			\
-	"?c_role nco:hasPostalAddress ?aff_addr"			\
-	"}) "								\
-	"nco:birthDate(?_contact) "					\
-	"nco:nickname(?_contact) "					\
-"(SELECT GROUP_CONCAT(fn:concat( "					\
-	"?url_value, \"\31\", ?aff_type "				\
-	"), \"\30\") "							\
-	"WHERE {"							\
-		"?_contact nco:hasAffiliation ?c_role . "		\
-		"?c_role nco:url ?url_value . "				\
-		"?c_role rdfs:label ?aff_type . "			\
-"})"									\
-	"nie:url(nco:photo(?_contact)) "				\
-	"nco:role(?_role) "						\
-	"nco:contactUID(?_contact) "					\
-	"nco:title(?_role) "						\
-	"rdfs:label(?_role) "						\
-	"nco:fullname(nco:org(?_role)) "				\
-	"nco:department(?_role) "					\
-"(SELECT GROUP_CONCAT(fn:concat(?emailaddress,\"\31\","			\
-	"rdfs:label(?c_role)),"						\
-	"\"\30\") "							\
-	"WHERE { "							\
-	"?_contact nco:hasAffiliation ?c_role . "			\
-	"?c_role nco:hasEmailAddress "					\
-	"		[ nco:emailAddress ?emailaddress ] "		\
-	"}) "								\
-	"nmo:receivedDate(?_call) "					\
-	"nmo:isSent(?_call) "						\
-	"nmo:isAnswered(?_call) "					\
-	"fn:concat(tracker:coalesce(?_ncontact, \"\"),"			\
-	"tracker:coalesce(?_unb_contact, \"\"))"			\
-	" "								\
-"WHERE { "								\
-"{ "									\
-	"?_ncontact a nco:Contact . "					\
-	"?_ncontact nco:hasPhoneNumber ?_number . "			\
-	"?_call a nmo:Call ; "						\
-	"nmo:from ?_ncontact ; "					\
-	"nmo:isAnswered true ;"						\
-	"nmo:isSent false . "						\
-	"?_contact a nco:PersonContact ; "				\
-	"nco:hasPhoneNumber ?_number . "				\
-	"OPTIONAL { ?_contact nco:hasAffiliation ?_role .} "		\
-"} UNION { "								\
-	"?_ncontact a nco:Contact . "					\
-	"?_ncontact nco:hasPhoneNumber ?_other . "			\
-	"?_call a nmo:Call ; "						\
-	"nmo:from ?_ncontact ; "					\
-	"nmo:isAnswered true ;"						\
-	"nmo:isSent false . "						\
-	"?_contact a nco:PersonContact . "				\
-	"?_contact nco:hasAffiliation ?_role . "			\
-	"?_role nco:hasPhoneNumber ?_number . "				\
-	"?_number maemo:localPhoneNumber ?_realnum . "			\
-	"?_other maemo:localPhoneNumber ?_realnum . "			\
-"} UNION { "								\
-	"?_unb_contact a nco:Contact . "				\
-	"?_unb_contact nco:hasPhoneNumber ?_other . "			\
-	"?_call a nmo:Call ; "						\
-	"nmo:from ?_unb_contact ; "					\
-	"nmo:isAnswered true ;"						\
-	"nmo:isSent false . "						\
-	"OPTIONAL {?_contact a nco:PersonContact ; "			\
-	"nco:hasPhoneNumber ?_number . } "				\
-	"OPTIONAL {?_contact a nco:PersonContact ; "			\
-	"nco:hasAffiliation ?_role . "					\
-	"?_role nco:hasPhoneNumber ?_number . "				\
-	"?_number maemo:localPhoneNumber ?_realnum ."			\
-	"?_other maemo:localPhoneNumber ?_realnum . }"			\
-	"FILTER ( !bound(?_contact) && !bound(?_role) ) "		\
-"} "									\
-"} "\
-"ORDER BY DESC(nmo:sentDate(?_call)) "
-
-#define INCOMING_CALLS_LIST						\
-	"SELECT ?c nco:nameFamily(?c) "					\
-	"nco:nameGiven(?c) nco:nameAdditional(?c) "			\
-	"nco:nameHonorificPrefix(?c) nco:nameHonorificSuffix(?c) "	\
-	"nco:phoneNumber(?h) "						\
-	"WHERE { "							\
-	"{"								\
-		"?c a nco:Contact . "					\
-		"?c nco:hasPhoneNumber ?h . "				\
-		"?call a nmo:Call ; "					\
-		"nmo:from ?c ; "					\
-		"nmo:isSent false ; "					\
-		"nmo:isAnswered true ."					\
-	"} UNION { "							\
-		"?x a nco:Contact . "					\
-		"?x nco:hasPhoneNumber ?h ."				\
-		"?call a nmo:Call ; "					\
-		"nmo:from ?x ; "					\
-		"nmo:isSent false ; "					\
-		"nmo:isAnswered true ."					\
-		"?c a nco:PersonContact . "				\
-		"?c nco:hasPhoneNumber ?h ."				\
-	"}UNION { "							\
-		"?x a nco:Contact . "					\
-		"?x nco:hasPhoneNumber ?h ."				\
-		"?call a nmo:Call ; "					\
-		"nmo:from ?x ; "					\
-		"nmo:isSent false ; "					\
-		"nmo:isAnswered true ."					\
-		"?c a nco:PersonContact . "				\
-		"?c nco:hasAffiliation ?a . "				\
-		"?a nco:hasPhoneNumber ?no . "				\
-		"?h maemo:localPhoneNumber ?num . "			\
-		"?no maemo:localPhoneNumber ?num . "			\
-	"}"								\
-	"} GROUP BY ?call ORDER BY DESC(nmo:receivedDate(?call))"
+CONSTRAINT								\
+"} "
 
-#define OUTGOING_CALLS_QUERY						\
-"SELECT "								\
-"(SELECT fn:concat(rdf:type(?role_number),"				\
-	"\"\31\", nco:phoneNumber(?role_number))"			\
-	"WHERE {"							\
-	"{"								\
-	"	?_role nco:hasPhoneNumber ?role_number "		\
-	"	FILTER (?role_number = ?_number)"			\
-	"} UNION { "							\
-		"?_unb_contact nco:hasPhoneNumber ?role_number . "	\
-	"}"								\
-"} GROUP BY nco:phoneNumber(?role_number) ) "				\
-	"nco:fullname(?_contact) "					\
-	"nco:nameFamily(?_contact) "					\
-	"nco:nameGiven(?_contact) "					\
-	"nco:nameAdditional(?_contact) "				\
+#define CALLS_LIST(CONSTRAINT)						\
+"SELECT ?_contact nco:nameFamily(?_contact) "				\
+	"nco:nameGiven(?_contact) nco:nameAdditional(?_contact) "	\
 	"nco:nameHonorificPrefix(?_contact) "				\
 	"nco:nameHonorificSuffix(?_contact) "				\
-"(SELECT GROUP_CONCAT(fn:concat("					\
-	"tracker:coalesce(nco:pobox(?aff_addr), \"\"), \";\","		\
-	"tracker:coalesce(nco:extendedAddress(?aff_addr), \"\"), \";\","\
-	"tracker:coalesce(nco:streetAddress(?aff_addr), \"\"), \";\","	\
-	"tracker:coalesce(nco:locality(?aff_addr), \"\"), \";\","	\
-	"tracker:coalesce(nco:region(?aff_addr), \"\"), \";\","		\
-	"tracker:coalesce(nco:postalcode(?aff_addr), \"\"), \";\","	\
-	"tracker:coalesce(nco:country(?aff_addr), \"\"), "		\
-	"\"\31\", rdfs:label(?c_role) ), "				\
-	"\"\30\") "							\
-	"WHERE {"							\
-	"?_contact nco:hasAffiliation ?c_role . "			\
-	"?c_role nco:hasPostalAddress ?aff_addr"			\
-	"}) "								\
-	"nco:birthDate(?_contact) "					\
-	"nco:nickname(?_contact) "					\
-"(SELECT GROUP_CONCAT(fn:concat( "					\
-	"?url_value, \"\31\", ?aff_type "				\
-	"), \"\30\") "							\
-	"WHERE {"							\
-		"?_contact nco:hasAffiliation ?c_role . "		\
-		"?c_role nco:url ?url_value . "				\
-		"?c_role rdfs:label ?aff_type . "			\
-"})"									\
-	"nie:url(nco:photo(?_contact)) "				\
-	"nco:role(?_role) "						\
-	"nco:contactUID(?_contact) "					\
-	"nco:title(?_role) "						\
-	"rdfs:label(?_role) "						\
-	"nco:fullname(nco:org(?_role)) "				\
-	"nco:department(?_role) "					\
-"(SELECT GROUP_CONCAT(fn:concat(?emailaddress,\"\31\","			\
-	"rdfs:label(?c_role)),"						\
-	"\"\30\") "							\
-	"WHERE { "							\
-	"?_contact nco:hasAffiliation ?c_role . "			\
-	"?c_role nco:hasEmailAddress "					\
-	"		[ nco:emailAddress ?emailaddress ] "		\
-	"}) "								\
-	"nmo:receivedDate(?_call) "					\
-	"nmo:isSent(?_call) "						\
-	"nmo:isAnswered(?_call) "					\
-	"fn:concat(tracker:coalesce(?_ncontact, \"\"),"			\
-	"tracker:coalesce(?_unb_contact, \"\"))"			\
-	" "								\
-"WHERE { "								\
-"{ "									\
-	"?_ncontact a nco:Contact . "					\
-	"?_ncontact nco:hasPhoneNumber ?_number . "			\
-	"?_call a nmo:Call ; "						\
-	"nmo:to ?_ncontact ; "						\
-	"nmo:isSent true . "						\
-	"?_contact a nco:PersonContact ; "				\
-	"nco:hasPhoneNumber ?_number . "				\
-	"OPTIONAL { ?_contact nco:hasAffiliation ?_role .} "		\
-"} UNION { "								\
-	"?_ncontact a nco:Contact . "					\
-	"?_ncontact nco:hasPhoneNumber ?_other . "			\
-	"?_call a nmo:Call ; "						\
-	"nmo:to ?_ncontact ; "						\
-	"nmo:isSent true . "						\
-	"?_contact a nco:PersonContact . "				\
-	"?_contact nco:hasAffiliation ?_role . "			\
-	"?_role nco:hasPhoneNumber ?_number . "				\
-	"?_other maemo:localPhoneNumber ?_realnum . "			\
-	"?_number maemo:localPhoneNumber ?_realnum . "			\
-"} UNION { "								\
-	"?_unb_contact a nco:Contact . "				\
-	"?_unb_contact nco:hasPhoneNumber ?_other . "			\
-	"?_call a nmo:Call ; "						\
-	"nmo:to ?_unb_contact ; "					\
-	"nmo:isSent true . "						\
-	"OPTIONAL {?_contact a nco:PersonContact ; "			\
-	"nco:hasPhoneNumber ?_number . } "				\
-	"OPTIONAL {?_contact a nco:PersonContact ; "			\
-	"nco:hasAffiliation ?_role . "					\
-	"?_role nco:hasPhoneNumber ?_number . "				\
-	"?_other maemo:localPhoneNumber ?_realnum ."			\
-	"?_number maemo:localPhoneNumber ?_realnum . }"			\
-	"FILTER ( !bound(?_contact) && !bound(?_role) ) "		\
-"} "									\
-"} "									\
+	"nco:phoneNumber(?_cpn) "					\
+CALLS_CONSTRAINTS(CONSTRAINT)						\
 "ORDER BY DESC(nmo:sentDate(?_call)) "
 
-#define OUTGOING_CALLS_LIST						\
-	"SELECT ?c nco:nameFamily(?c) "					\
-	"nco:nameGiven(?c) nco:nameAdditional(?c) "			\
-	"nco:nameHonorificPrefix(?c) nco:nameHonorificSuffix(?c) "	\
-	"nco:phoneNumber(?h) "						\
-	"WHERE { "							\
-	"{"								\
-		"?c a nco:Contact . "					\
-		"?c nco:hasPhoneNumber ?h . "				\
-		"?call a nmo:Call ; "					\
-		"nmo:to ?c ; "						\
-		"nmo:isSent true . "					\
-	"} UNION {"							\
-		"?x a nco:Contact . "					\
-		"?x nco:hasPhoneNumber ?h . "				\
-		"?call a nmo:Call ; "					\
-		"nmo:to ?x ; "						\
-		"nmo:isSent true . "					\
-		"?c a nco:PersonContact . "				\
-		"?c nco:hasPhoneNumber ?h . "				\
-	"} UNION {"							\
-		"?x a nco:Contact . "					\
-		"?x nco:hasPhoneNumber ?h . "				\
-		"?call a nmo:Call ; "					\
-		"nmo:to ?x ; "						\
-		"nmo:isSent true . "					\
-		"?c a nco:PersonContact . "				\
-		"?c nco:hasAffiliation ?a . "				\
-		"?a nco:hasPhoneNumber ?no . "				\
-		"?h maemo:localPhoneNumber ?num . "			\
-		"?no maemo:localPhoneNumber ?num . "			\
-	"}"								\
-	"} GROUP BY ?call ORDER BY DESC(nmo:sentDate(?call))"
-
-#define COMBINED_CALLS_QUERY						\
+#define CALLS_QUERY(CONSTRAINT)						\
 "SELECT "								\
 "(SELECT fn:concat(rdf:type(?role_number),"				\
 	"\"\31\", nco:phoneNumber(?role_number))"			\
@@ -587,6 +199,7 @@
 	"	FILTER (?role_number = ?_number)"			\
 	"} UNION { "							\
 		"?_unb_contact nco:hasPhoneNumber ?role_number . "	\
+	"	FILTER (!bound(?_role)) "				\
 	"}"								\
 "} GROUP BY nco:phoneNumber(?role_number) ) "				\
 	"nco:fullname(?_contact) "					\
@@ -639,137 +252,40 @@
 	"nmo:isAnswered(?_call) "					\
 	"fn:concat(tracker:coalesce(?_ncontact, \"\"),"			\
 	"tracker:coalesce(?_unb_contact, \"\"))"			\
-	" "								\
-"WHERE { "								\
-"{ "									\
-	"?_ncontact a nco:Contact . "					\
-	"?_ncontact nco:hasPhoneNumber ?_number . "			\
-	"?_call a nmo:Call ; "						\
-	"nmo:to ?_ncontact ; "						\
-	"nmo:isSent true . "						\
-	"?_contact a nco:PersonContact ; "				\
-	"nco:hasPhoneNumber ?_number . "				\
-	"OPTIONAL { ?_contact nco:hasAffiliation ?_role .} "		\
-"} UNION { "								\
-	"?_ncontact a nco:Contact . "					\
-	"?_ncontact nco:hasPhoneNumber ?_other . "			\
-	"?_call a nmo:Call ; "						\
-	"nmo:to ?_ncontact ; "						\
-	"nmo:isSent true . "						\
-	"?_contact a nco:PersonContact . "				\
-	"?_contact nco:hasAffiliation ?_role . "			\
-	"?_role nco:hasPhoneNumber ?_number . "				\
-	"?_other maemo:localPhoneNumber ?_realnum . "			\
-	"?_number maemo:localPhoneNumber ?_realnum . "			\
-"} UNION { "								\
-	"?_unb_contact a nco:Contact . "				\
-	"?_unb_contact nco:hasPhoneNumber ?_other . "			\
-	"?_call a nmo:Call ; "						\
-	"nmo:to ?_unb_contact ; "					\
-	"nmo:isSent true . "						\
-	"OPTIONAL {?_contact a nco:PersonContact ; "			\
-	"nco:hasPhoneNumber ?_number . } "				\
-	"OPTIONAL {?_contact a nco:PersonContact ; "			\
-	"nco:hasAffiliation ?_role . "					\
-	"?_role nco:hasPhoneNumber ?_number . "				\
-	"?_other maemo:localPhoneNumber ?_realnum ."			\
-	"?_number maemo:localPhoneNumber ?_realnum . }"			\
-	"FILTER ( !bound(?_contact) && !bound(?_role) ) "		\
-"} UNION { "								\
-	"?_ncontact a nco:Contact . "					\
-	"?_ncontact nco:hasPhoneNumber ?_number . "			\
-	"?_call a nmo:Call ; "						\
-	"nmo:from ?_ncontact ; "					\
-	"nmo:isSent false . "						\
-	"?_contact a nco:PersonContact ; "				\
-	"nco:hasPhoneNumber ?_number . "				\
-	"OPTIONAL { ?_contact nco:hasAffiliation ?_role .} "		\
-"} UNION { "								\
-	"?_ncontact a nco:Contact . "					\
-	"?_ncontact nco:hasPhoneNumber ?_other . "			\
-	"?_call a nmo:Call ; "						\
-	"nmo:from ?_ncontact ; "					\
-	"nmo:isSent false . "						\
-	"?_contact a nco:PersonContact . "				\
-	"?_contact nco:hasAffiliation ?_role . "			\
-	"?_role nco:hasPhoneNumber ?_number . "				\
-	"?_other maemo:localPhoneNumber ?_realnum . "			\
-	"?_number maemo:localPhoneNumber ?_realnum . "			\
-"} UNION { "								\
-	"?_unb_contact a nco:Contact . "				\
-	"?_unb_contact nco:hasPhoneNumber ?_other . "			\
-	"?_call a nmo:Call ; "						\
-	"nmo:from ?_unb_contact ; "					\
-	"nmo:isSent false . "						\
-	"OPTIONAL {?_contact a nco:PersonContact ; "			\
-	"nco:hasPhoneNumber ?_number . } "				\
-	"OPTIONAL {?_contact a nco:PersonContact ; "			\
-	"nco:hasAffiliation ?_role . "					\
-	"?_role nco:hasPhoneNumber ?_number . "				\
-	"?_other maemo:localPhoneNumber ?_realnum ."			\
-	"?_number maemo:localPhoneNumber ?_realnum . }"			\
-	"FILTER ( !bound(?_contact) && !bound(?_role) ) "		\
-"} "									\
-"} "									\
+CALLS_CONSTRAINTS(CONSTRAINT)						\
 "ORDER BY DESC(nmo:sentDate(?_call)) "
 
-#define COMBINED_CALLS_LIST						\
-	"SELECT ?c nco:nameFamily(?c) nco:nameGiven(?c) "		\
-	"nco:nameAdditional(?c) nco:nameHonorificPrefix(?c) "		\
-	"nco:nameHonorificSuffix(?c) nco:phoneNumber(?h) "		\
-	"WHERE { "							\
-	"	{ "							\
-			"?c a nco:Contact . "				\
-			"?c nco:hasPhoneNumber ?h . "			\
-			"?call a nmo:Call ; "				\
-			"nmo:to ?c ; "					\
-			"nmo:isSent true . "				\
-		"} UNION {"						\
-			"?x a nco:Contact . "				\
-			"?x nco:hasPhoneNumber ?h . "			\
-			"?call a nmo:Call ; "				\
-			"nmo:to ?x ; "					\
-			"nmo:isSent true . "				\
-			"?c a nco:PersonContact . "			\
-			"?c nco:hasPhoneNumber ?h . "			\
-		"} UNION {"						\
-			"?x a nco:Contact . "				\
-			"?x nco:hasPhoneNumber ?h . "			\
-			"?call a nmo:Call ; "				\
-			"nmo:to ?x ; "					\
-			"nmo:isSent true . "				\
-			"?c a nco:PersonContact . "			\
-			"?c nco:hasAffiliation ?a . "			\
-			"?a nco:hasPhoneNumber ?no . "			\
-			"?h maemo:localPhoneNumber ?num . "		\
-			"?no maemo:localPhoneNumber ?num . "		\
-		"}UNION {"						\
-			"?c a nco:Contact . "				\
-			"?c nco:hasPhoneNumber ?h . "			\
-			"?call a nmo:Call ; "				\
-			"nmo:from ?c ; "				\
-			"nmo:isSent false . "				\
-		"} UNION {"						\
-			"?x a nco:Contact . "				\
-			"?x nco:hasPhoneNumber ?h . "			\
-			"?call a nmo:Call ; "				\
-			"nmo:from ?x ; "				\
-			"nmo:isSent false . "				\
-			"?c a nco:PersonContact . "			\
-			"?c nco:hasPhoneNumber ?h . "			\
-		"} UNION {"						\
-			"?x a nco:Contact . "				\
-			"?x nco:hasPhoneNumber ?h . "			\
-			"?call a nmo:Call ; "				\
-			"nmo:from ?x ; "				\
-			"nmo:isSent false . "				\
-			"?c a nco:PersonContact . "			\
-			"?c nco:hasAffiliation ?a . "			\
-			"?a nco:hasPhoneNumber ?no . "			\
-			"?h maemo:localPhoneNumber ?num . "		\
-			"?no maemo:localPhoneNumber ?num . "		\
-		"}"							\
-	"} GROUP BY ?call ORDER BY DESC(nmo:receivedDate(?call))"
+#define MISSED_CONSTRAINT		\
+"?_call nmo:from ?_unb_contact . "	\
+"?_call nmo:isSent false . "		\
+"?_call nmo:isAnswered false . "
+
+#define INCOMING_CONSTRAINT		\
+"?_call nmo:from ?_unb_contact . "	\
+"?_call nmo:isSent false . "		\
+"?_call nmo:isAnswered true . "
+
+#define OUTGOING_CONSTRAINT		\
+"?_call nmo:to ?_unb_contact . "	\
+"?_call nmo:isSent true . "
+
+#define COMBINED_CONSTRAINT			\
+"{ "						\
+"	?_call nmo:from ?_unb_contact .  "	\
+"	?_call nmo:isSent false "		\
+"} UNION { "					\
+"	?_call nmo:to ?_unb_contact . "		\
+"	?_call nmo:isSent true "		\
+"} "
+
+#define MISSED_CALLS_QUERY CALLS_QUERY(MISSED_CONSTRAINT)
+#define MISSED_CALLS_LIST CALLS_LIST(MISSED_CONSTRAINT)
+#define INCOMING_CALLS_QUERY CALLS_QUERY(INCOMING_CONSTRAINT)
+#define INCOMING_CALLS_LIST CALLS_LIST(INCOMING_CONSTRAINT)
+#define OUTGOING_CALLS_QUERY CALLS_QUERY(OUTGOING_CONSTRAINT)
+#define OUTGOING_CALLS_LIST CALLS_LIST(OUTGOING_CONSTRAINT)
+#define COMBINED_CALLS_QUERY CALLS_QUERY(COMBINED_CONSTRAINT)
+#define COMBINED_CALLS_LIST CALLS_LIST(COMBINED_CONSTRAINT)
 
 #define CONTACTS_QUERY_FROM_URI						\
 "SELECT "								\
-- 
1.7.4.1

