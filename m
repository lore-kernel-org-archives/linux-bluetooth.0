Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH] Fix queries for contact with only one affiliation
Date: Thu, 18 Nov 2010 16:01:43 +0100
Message-Id: <1290092503-10324-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously some fields may be omitted for contacts with only one affiliation,
when querying for call history.
---
 plugins/phonebook-tracker.c |   83 ++++++++++++++++++++++++++++---------------
 1 files changed, 54 insertions(+), 29 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 6d8915e..2cf8ba2 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -183,7 +183,7 @@
 	"nco:role(?a) nco:pobox(?pw) nco:extendedAddress(?pw) "		\
 	"nco:streetAddress(?pw) nco:locality(?pw) nco:region(?pw) "	\
 	"nco:postalcode(?pw) nco:country(?pw) nco:contactUID(?c) "	\
-	"nco:title(?a) nco:phoneNumber(?t) nco:pobox(?po) "		\
+	"?title nco:phoneNumber(?t) nco:pobox(?po) "			\
 	"nco:extendedAddress(?po) nco:streetAddress(?po) "		\
 	"nco:locality(?po) nco:region(?po) nco:postalcode(?po) "	\
 	"nco:country(?po) nco:emailAddress(?eo) ?vc "			\
@@ -211,6 +211,7 @@
 			"?a rdfs:label \"Work\" . "			\
 			"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "	\
 			"OPTIONAL { ?a nco:hasPostalAddress ?pw . } "	\
+			"OPTIONAL { ?a nco:title ?title } "		\
 			"}"						\
 			"OPTIONAL { "					\
 			"?a rdfs:label \"Home\" . "			\
@@ -235,12 +236,13 @@
 			"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "	\
 			"OPTIONAL { ?a nco:hasPostalAddress ?pw . } "	\
 			"OPTIONAL { ?a nco:org ?o . } "			\
+			"OPTIONAL { ?a nco:title ?title } "		\
 			"{ "						\
 			"SELECT ?p ?e ?c WHERE { "			\
 			"?c nco:hasAffiliation ?b . "			\
-			"?b rdfs:label \"Home\" . "			\
+			"OPTIONAL {?b rdfs:label \"Home\" . "		\
 			"OPTIONAL {?b nco:hasEmailAddress ?e . } "	\
-			"OPTIONAL {?b nco:hasPostalAddress ?p . }} "	\
+			"OPTIONAL {?b nco:hasPostalAddress ?p . }}} "	\
 			"} "						\
 		"}"							\
 		"OPTIONAL { "						\
@@ -250,13 +252,16 @@
 			"OPTIONAL { ?a nco:hasPostalAddress ?p . } "	\
 			"OPTIONAL { ?a nco:org ?o . } "			\
 			"{ "						\
-			"SELECT ?pw ?ew ?c WHERE { "			\
+			"SELECT ?pw ?ew ?title ?c WHERE { "		\
 			"?c nco:hasAffiliation ?b . "			\
-			"?b rdfs:label \"Work\" . "			\
+			"OPTIONAL {?b rdfs:label \"Work\" . "		\
 			"OPTIONAL {?b nco:hasEmailAddress ?ew . } "	\
-			"OPTIONAL {?b nco:hasPostalAddress ?pw . }} "	\
+			"OPTIONAL {?b nco:title ?title } "		\
+			"OPTIONAL {?b nco:hasPostalAddress ?pw . }}} "	\
 			"} "						\
 		"}"							\
+		"OPTIONAL { ?c nco:hasPostalAddress ?po . } "		\
+		"OPTIONAL { ?c nco:hasEmailAddress ?eo . } "		\
 	"} UNION { "							\
 		"?x a nco:Contact . "					\
 		"?x nco:hasPhoneNumber ?t . "				\
@@ -322,7 +327,7 @@
 	"nco:role(?a) nco:pobox(?pw) nco:extendedAddress(?pw) "		\
 	"nco:streetAddress(?pw) nco:locality(?pw) nco:region(?pw) "	\
 	"nco:postalcode(?pw) nco:country(?pw) nco:contactUID(?c) "	\
-	"nco:title(?a) nco:phoneNumber(?t) nco:pobox(?po) "		\
+	"?title nco:phoneNumber(?t) nco:pobox(?po) "			\
 	"nco:extendedAddress(?po) nco:streetAddress(?po) "		\
 	"nco:locality(?po) nco:region(?po) nco:postalcode(?po) "	\
 	"nco:country(?po) nco:emailAddress(?eo) ?vc "			\
@@ -348,6 +353,7 @@
 			"?c nco:hasAffiliation ?a . "			\
 			"OPTIONAL { "					\
 			"?a rdfs:label \"Work\" . "			\
+			"OPTIONAL { ?a nco:title ?title } "		\
 			"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "	\
 			"OPTIONAL { ?a nco:hasPostalAddress ?pw . } "	\
 			"}"						\
@@ -374,12 +380,13 @@
 			"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "	\
 			"OPTIONAL { ?a nco:hasPostalAddress ?pw . } "	\
 			"OPTIONAL { ?a nco:org ?o . } "			\
+			"OPTIONAL { ?a nco:title ?title } "		\
 			"{ "						\
 			"SELECT ?p ?e ?c WHERE { "			\
 			"?c nco:hasAffiliation ?b . "			\
-			"?b rdfs:label \"Home\" . "			\
+			"OPTIONAL {?b rdfs:label \"Home\" . "		\
 			"OPTIONAL {?b nco:hasEmailAddress ?e . } "	\
-			"OPTIONAL {?b nco:hasPostalAddress ?p . }} "	\
+			"OPTIONAL {?b nco:hasPostalAddress ?p . }}} "	\
 			"} "						\
 		"}"							\
 		"OPTIONAL { "						\
@@ -389,13 +396,16 @@
 			"OPTIONAL { ?a nco:hasPostalAddress ?p . } "	\
 			"OPTIONAL { ?a nco:org ?o . } "			\
 			"{ "						\
-			"SELECT ?pw ?ew ?c WHERE { "			\
+			"SELECT ?pw ?ew ?title ?c WHERE { "		\
 			"?c nco:hasAffiliation ?b . "			\
-			"?b rdfs:label \"Work\" . "			\
+			"OPTIONAL {?b rdfs:label \"Work\" . "		\
 			"OPTIONAL {?b nco:hasEmailAddress ?ew . } "	\
-			"OPTIONAL {?b nco:hasPostalAddress ?pw . }} "	\
+			"OPTIONAL {?b nco:title ?title } "		\
+			"OPTIONAL {?b nco:hasPostalAddress ?pw . }}} "	\
 			"} "						\
 		"}"							\
+		"OPTIONAL { ?c nco:hasPostalAddress ?po . } "		\
+		"OPTIONAL { ?c nco:hasEmailAddress ?eo . } "		\
 	"} UNION { "							\
 		"?x a nco:Contact . "					\
 		"?x nco:hasPhoneNumber ?t . "				\
@@ -460,7 +470,7 @@
 	"nco:role(?a) nco:pobox(?pw) nco:extendedAddress(?pw) "		\
 	"nco:streetAddress(?pw) nco:locality(?pw) nco:region(?pw) "	\
 	"nco:postalcode(?pw) nco:country(?pw) nco:contactUID(?c) "	\
-	"nco:title(?a) nco:phoneNumber(?t) nco:pobox(?po) "		\
+	"?title nco:phoneNumber(?t) nco:pobox(?po) "			\
 	"nco:extendedAddress(?po) nco:streetAddress(?po) "		\
 	"nco:locality(?po) nco:region(?po) nco:postalcode(?po) "	\
 	"nco:country(?po) nco:emailAddress(?eo) ?vc "			\
@@ -487,6 +497,7 @@
 			"?a rdfs:label \"Work\" . "			\
 			"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "	\
 			"OPTIONAL { ?a nco:hasPostalAddress ?pw . } "	\
+			"OPTIONAL { ?a nco:title ?title } "		\
 			"}"						\
 			"OPTIONAL { "					\
 			"?a rdfs:label \"Home\" . "			\
@@ -510,12 +521,13 @@
 			"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "	\
 			"OPTIONAL { ?a nco:hasPostalAddress ?pw . } "	\
 			"OPTIONAL { ?a nco:org ?o . } "			\
+			"OPTIONAL { ?a nco:title ?title } "		\
 			"{ "						\
 			"SELECT ?p ?e ?c WHERE { "			\
 			"?c nco:hasAffiliation ?b . "			\
-			"?b rdfs:label \"Home\" . "			\
+			"OPTIONAL {?b rdfs:label \"Home\" . "		\
 			"OPTIONAL {?b nco:hasEmailAddress ?e . } "	\
-			"OPTIONAL {?b nco:hasPostalAddress ?p . }} "	\
+			"OPTIONAL {?b nco:hasPostalAddress ?p . }}} "	\
 			"} "						\
 		"}"							\
 		"OPTIONAL { "						\
@@ -525,13 +537,16 @@
 			"OPTIONAL { ?a nco:hasPostalAddress ?p . } "	\
 			"OPTIONAL { ?a nco:org ?o . } "			\
 			"{ "						\
-			"SELECT ?pw ?ew ?c WHERE { "			\
+			"SELECT ?pw ?ew ?title ?c WHERE { "		\
 			"?c nco:hasAffiliation ?b . "			\
-			"?b rdfs:label \"Work\" . "			\
+			"OPTIONAL {?b rdfs:label \"Work\" . "		\
 			"OPTIONAL {?b nco:hasEmailAddress ?ew . } "	\
-			"OPTIONAL {?b nco:hasPostalAddress ?pw . }} "	\
+			"OPTIONAL { ?a nco:title ?title } "		\
+			"OPTIONAL {?b nco:hasPostalAddress ?pw . }}} "	\
 			"} "						\
 		"}"							\
+		"OPTIONAL { ?c nco:hasPostalAddress ?po . } "		\
+		"OPTIONAL { ?c nco:hasEmailAddress ?eo . } "		\
 	"} UNION { "							\
 		"?x a nco:Contact . "					\
 		"?x nco:hasPhoneNumber ?t . "				\
@@ -592,7 +607,7 @@
 	"nco:role(?a) nco:pobox(?pw) nco:extendedAddress(?pw) "		\
 	"nco:streetAddress(?pw) nco:locality(?pw) nco:region(?pw) "	\
 	"nco:postalcode(?pw) nco:country(?pw) nco:contactUID(?c) "	\
-	"nco:title(?a) nco:phoneNumber(?t) nco:pobox(?po) "		\
+	"?title nco:phoneNumber(?t) nco:pobox(?po) "			\
 	"nco:extendedAddress(?po) nco:streetAddress(?po) "		\
 	"nco:locality(?po) nco:region(?po) nco:postalcode(?po) "	\
 	"nco:country(?po) nco:emailAddress(?eo) ?vc "			\
@@ -619,6 +634,7 @@
 			"?a rdfs:label \"Work\" . "			\
 			"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "	\
 			"OPTIONAL { ?a nco:hasPostalAddress ?pw . } "	\
+			"OPTIONAL { ?a nco:title ?title } "		\
 			"}"						\
 			"OPTIONAL { "					\
 			"?a rdfs:label \"Home\" . "			\
@@ -642,12 +658,13 @@
 			"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "	\
 			"OPTIONAL { ?a nco:hasPostalAddress ?pw . } "	\
 			"OPTIONAL { ?a nco:org ?o . } "			\
+			"OPTIONAL { ?a nco:title ?title } "		\
 			"{ "						\
 			"SELECT ?p ?e ?c WHERE { "			\
 			"?c nco:hasAffiliation ?b . "			\
-			"?b rdfs:label \"Home\" . "			\
+			"OPTIONAL {?b rdfs:label \"Home\" . "		\
 			"OPTIONAL {?b nco:hasEmailAddress ?e . } "	\
-			"OPTIONAL {?b nco:hasPostalAddress ?p . }} "	\
+			"OPTIONAL {?b nco:hasPostalAddress ?p . }}} "	\
 			"} "						\
 		"}"							\
 		"OPTIONAL { "						\
@@ -657,13 +674,16 @@
 			"OPTIONAL { ?a nco:hasPostalAddress ?p . } "	\
 			"OPTIONAL { ?a nco:org ?o . } "			\
 			"{ "						\
-			"SELECT ?pw ?ew ?c WHERE { "			\
+			"SELECT ?pw ?ew ?title ?c WHERE { "		\
 			"?c nco:hasAffiliation ?b . "			\
-			"?b rdfs:label \"Work\" . "			\
+			"OPTIONAL {?b rdfs:label \"Work\" . "		\
 			"OPTIONAL {?b nco:hasEmailAddress ?ew . } "	\
-			"OPTIONAL {?b nco:hasPostalAddress ?pw . }} "	\
+			"OPTIONAL {?b nco:title ?title } "		\
+			"OPTIONAL {?b nco:hasPostalAddress ?pw . }}} "	\
 			"} "						\
 		"}"							\
+		"OPTIONAL { ?c nco:hasPostalAddress ?po . } "		\
+		"OPTIONAL { ?c nco:hasEmailAddress ?eo . } "		\
 	"} UNION { "							\
 		"?x a nco:Contact . "					\
 		"?x nco:hasPhoneNumber ?t . "				\
@@ -696,6 +716,7 @@
 			"?a rdfs:label \"Work\" . "			\
 			"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "	\
 			"OPTIONAL { ?a nco:hasPostalAddress ?pw . } "	\
+			"OPTIONAL { ?a nco:title ?title } "		\
 			"}"						\
 			"OPTIONAL { "					\
 			"?a rdfs:label \"Home\" . "			\
@@ -719,12 +740,13 @@
 			"OPTIONAL { ?a nco:hasEmailAddress ?ew . } "	\
 			"OPTIONAL { ?a nco:hasPostalAddress ?pw . } "	\
 			"OPTIONAL { ?a nco:org ?o . } "			\
+			"OPTIONAL { ?a nco:title ?title } "		\
 			"{ "						\
 			"SELECT ?p ?e ?c WHERE { "			\
 			"?c nco:hasAffiliation ?b . "			\
-			"?b rdfs:label \"Home\" . "			\
+			"OPTIONAL {?b rdfs:label \"Home\" . "		\
 			"OPTIONAL {?b nco:hasEmailAddress ?e . } "	\
-			"OPTIONAL {?b nco:hasPostalAddress ?p . }} "	\
+			"OPTIONAL {?b nco:hasPostalAddress ?p . }}} "	\
 			"} "						\
 		"}"							\
 		"OPTIONAL { "						\
@@ -734,13 +756,16 @@
 			"OPTIONAL { ?a nco:hasPostalAddress ?p . } "	\
 			"OPTIONAL { ?a nco:org ?o . } "			\
 			"{ "						\
-			"SELECT ?pw ?ew ?c WHERE { "			\
+			"SELECT ?pw ?ew ?title ?c WHERE { "		\
 			"?c nco:hasAffiliation ?b . "			\
-			"?b rdfs:label \"Work\" . "			\
+			"OPTIONAL {?b rdfs:label \"Work\" . "		\
 			"OPTIONAL {?b nco:hasEmailAddress ?ew . } "	\
-			"OPTIONAL {?b nco:hasPostalAddress ?pw . }} "	\
+			"OPTIONAL {?b nco:title ?title } "		\
+			"OPTIONAL {?b nco:hasPostalAddress ?pw . }}} "	\
 			"} "						\
 		"}"							\
+		"OPTIONAL { ?c nco:hasPostalAddress ?po . } "		\
+		"OPTIONAL { ?c nco:hasEmailAddress ?eo . } "		\
 	"} UNION { "							\
 		"?x a nco:Contact . "					\
 		"?x nco:hasPhoneNumber ?t . "				\
-- 
1.7.0.4

