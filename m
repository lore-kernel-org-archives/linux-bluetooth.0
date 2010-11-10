Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH 4/7] Fix proper type handling in outgoing_calls_query
Date: Wed, 10 Nov 2010 14:15:27 +0100
Message-Id: <1289394930-6694-4-git-send-email-bulislaw@linux.com>
In-Reply-To: <1289394930-6694-1-git-send-email-bulislaw@linux.com>
References: <1289394930-6694-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously all phone numbers, addresses and emails was considered to be "work".
Now there are three working types for emails and addresses: "work", "home",
"other" and four for phone numbers - these three as well as "cell".
---
 plugins/phonebook-tracker.c |   85 +++++++++++++++++++++++++++++++++----------
 1 files changed, 65 insertions(+), 20 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index bd67699..c40eb63 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -404,19 +404,23 @@
 	"} GROUP BY ?call ORDER BY DESC(nmo:receivedDate(?call))"
 
 #define OUTGOING_CALLS_QUERY						\
-	"SELECT nco:phoneNumber(?h) nco:fullname(?c) "			\
+	"SELECT ?h nco:fullname(?c) "					\
 	"nco:nameFamily(?c) nco:nameGiven(?c) "				\
 	"nco:nameAdditional(?c) nco:nameHonorificPrefix(?c) "		\
 	"nco:nameHonorificSuffix(?c) nco:emailAddress(?e) "		\
-	"nco:phoneNumber(?w) nco:pobox(?p) nco:extendedAddress(?p) "	\
+	"?w nco:pobox(?p) nco:extendedAddress(?p) "			\
 	"nco:streetAddress(?p) nco:locality(?p) nco:region(?p) "	\
-	"nco:postalcode(?p) nco:country(?p) \"\" nco:emailAddress(?ew)"	\
+	"nco:postalcode(?p) nco:country(?p) \"\" nco:emailAddress(?ew) "\
 	"nco:birthDate(?c) nco:nickname(?c) nco:url(?c) "		\
 	"nco:photo(?c) nco:fullname(?o) nco:department(?a) "		\
 	"nco:role(?a) nco:pobox(?pw) nco:extendedAddress(?pw) "		\
 	"nco:streetAddress(?pw) nco:locality(?pw) nco:region(?pw) "	\
 	"nco:postalcode(?pw) nco:country(?pw) nco:contactUID(?c) "	\
-	"nco:title(?a) nco:phoneNumber(?t) nmo:receivedDate(?call) "	\
+	"nco:title(?a) nco:phoneNumber(?t) nco:pobox(?po) "		\
+	"nco:extendedAddress(?po) nco:streetAddress(?po) "		\
+	"nco:locality(?po) nco:region(?po) nco:postalcode(?po) "	\
+	"nco:country(?po) nco:emailAddress(?eo) ?vc "			\
+	"nmo:receivedDate(?call) "					\
 	"nmo:isSent(?call) nmo:isAnswered(?call) ?x "			\
 	"WHERE { "							\
 	"{ "								\
@@ -425,38 +429,79 @@
 		"?call a nmo:Call ; "					\
 		"nmo:to ?x ; "						\
 		"nmo:isSent true . "					\
+		"?c a nco:PersonContact . "				\
+		"?c nco:hasPhoneNumber ?t . "				\
+		"OPTIONAL { "						\
+			"?t a nco:CellPhoneNumber ; "			\
+				"nco:phoneNumber ?vc . "		\
+		"} "							\
+		"OPTIONAL { ?c nco:hasPostalAddress ?po . } "		\
+		"OPTIONAL { ?c nco:hasEmailAddress ?eo . } "		\
+		"OPTIONAL { "						\
+			"?c nco:hasAffiliation ?a . "			\
+			"OPTIONAL { "					\
+			"?a rdfs:label \"Work\" . "			\
+			"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "	\
+			"OPTIONAL { ?a nco:hasPostalAddress ?pw . } "	\
+			"}"						\
+			"OPTIONAL { "					\
+			"?a rdfs:label \"Home\" . "			\
+			"OPTIONAL { ?a nco:hasEmailAddress ?e . } "	\
+			"OPTIONAL { ?a nco:hasPostalAddress ?p . } "	\
+			"} "						\
+			"OPTIONAL { ?a nco:org ?o . } "			\
+		"} "							\
 	"} UNION { "							\
 		"?x a nco:Contact . "					\
-		"?x nco:hasPhoneNumber ?h . "				\
+		"?x nco:hasPhoneNumber ?tmp . "				\
 		"?call a nmo:Call ; "					\
 		"nmo:to ?x ; "						\
 		"nmo:isSent true . "					\
 		"?c a nco:PersonContact . "				\
-		"?c nco:hasPhoneNumber ?h . "				\
-		"OPTIONAL { ?c nco:hasEmailAddress ?e . } "		\
-		"OPTIONAL { ?c nco:hasPostalAddress ?p . } "		\
+		"?c nco:hasAffiliation ?a . "				\
+		"?a nco:hasPhoneNumber ?tmp . "				\
 		"OPTIONAL { "						\
-			"?c nco:hasAffiliation ?a . "			\
+			"?a rdfs:label \"Work\" . "			\
+			"?tmp nco:phoneNumber ?w . "			\
 			"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "	\
 			"OPTIONAL { ?a nco:hasPostalAddress ?pw . } "	\
 			"OPTIONAL { ?a nco:org ?o . } "			\
-		"} "							\
+			"{ "						\
+			"SELECT ?p ?e ?c WHERE { "			\
+			"?c nco:hasAffiliation ?b . "			\
+			"?b rdfs:label \"Home\" . "			\
+			"OPTIONAL {?b nco:hasEmailAddress ?e . } "	\
+			"OPTIONAL {?b nco:hasPostalAddress ?p . }} "	\
+			"} "						\
+		"}"							\
+		"OPTIONAL { "						\
+			"?a rdfs:label \"Home\" . "			\
+			"?tmp nco:phoneNumber ?h . "			\
+			"OPTIONAL { ?a nco:hasEmailAddress ?e . } "	\
+			"OPTIONAL { ?a nco:hasPostalAddress ?p . } "	\
+			"OPTIONAL { ?a nco:org ?o . } "			\
+			"{ "						\
+			"SELECT ?pw ?ew ?c WHERE { "			\
+			"?c nco:hasAffiliation ?b . "			\
+			"?b rdfs:label \"Work\" . "			\
+			"OPTIONAL {?b nco:hasEmailAddress ?ew . } "	\
+			"OPTIONAL {?b nco:hasPostalAddress ?pw . }} "	\
+			"} "						\
+		"}"							\
 	"} UNION { "							\
 		"?x a nco:Contact . "					\
-		"?x nco:hasPhoneNumber ?w . "				\
+		"?x nco:hasPhoneNumber ?t . "				\
 		"?call a nmo:Call ; "					\
 		"nmo:to ?x ; "						\
 		"nmo:isSent true . "					\
-		"?c a nco:PersonContact . "				\
-		"OPTIONAL { ?c nco:hasEmailAddress ?e . } "		\
-		"OPTIONAL { ?c nco:hasPostalAddress ?p . } "		\
-		"?c nco:hasAffiliation ?a . "				\
-		"?a nco:hasPhoneNumber ?w . "				\
-		"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "		\
-		"OPTIONAL { ?a nco:hasPostalAddress ?pw . } "		\
-		"OPTIONAL { ?a nco:org ?o . } "				\
+		"OPTIONAL {?c a nco:PersonContact ; "			\
+			"nco:hasPhoneNumber ?t . } "			\
+		"OPTIONAL {?c a nco:PersonContact ; "			\
+			"nco:hasAffiliation ?a . "			\
+			"?a nco:hasPhoneNumber ?t . } "			\
+		"FILTER ( !bound(?c) && !bound(?a) ) . "		\
 	"} "								\
-	"} GROUP BY ?call ORDER BY DESC(nmo:sentDate(?call)) "
+	"} ORDER BY DESC(nmo:sentDate(?call)) "
 
 #define OUTGOING_CALLS_LIST						\
 	"SELECT ?c nco:nameFamily(?c) "					\
-- 
1.7.0.4

