Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH] Fix history listing queries in phonebook-tracker
Date: Thu, 21 Oct 2010 15:26:39 +0300
Message-Id: <1287663999-22701-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now we are able to display contact's name in vcard-listing when
contact has entry in phonebook available.
---
 plugins/phonebook-tracker.c |  140 ++++++++++++++++++++++++++++++++++++-------
 1 files changed, 118 insertions(+), 22 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index f0e00b8..1c579d1 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -172,13 +172,34 @@
 	"nco:nameHonorificPrefix(?c) nco:nameHonorificSuffix(?c) "	\
 	"nco:phoneNumber(?h) "						\
 	"WHERE { "							\
+	"{"								\
+		"?c a nco:Contact . "					\
+		"?c nco:hasPhoneNumber ?h . "				\
 		"?call a nmo:Call ; "					\
 		"nmo:from ?c ; "					\
 		"nmo:isSent false ; "					\
 		"nmo:isAnswered false ."				\
-		"?c a nco:Contact . "					\
-	"OPTIONAL { ?c nco:hasPhoneNumber ?h . } "			\
-	"} ORDER BY DESC(nmo:receivedDate(?call))"
+	"}UNION{"							\
+		"?x a nco:Contact . "					\
+		"?x nco:hasPhoneNumber ?h . "				\
+		"?call a nmo:Call ; "					\
+		"nmo:from ?x ; "					\
+		"nmo:isSent false ; "					\
+		"nmo:isAnswered false ."				\
+		"?c a nco:PersonContact . "				\
+		"?c nco:hasPhoneNumber ?h . "				\
+	"} UNION { "							\
+		"?x a nco:Contact . "					\
+		"?x nco:hasPhoneNumber ?h . "				\
+		"?call a nmo:Call ; "					\
+		"nmo:from ?x ; "					\
+		"nmo:isSent false ; "					\
+		"nmo:isAnswered false ."				\
+		"?c a nco:PersonContact . "				\
+		"?c nco:hasAffiliation ?a . "				\
+		"?a nco:hasPhoneNumber ?h . "				\
+	"} "								\
+	"} GROUP BY ?call ORDER BY DESC(nmo:receivedDate(?call))"
 
 #define INCOMING_CALLS_QUERY						\
 	"SELECT nco:phoneNumber(?h) nco:fullname(?c) "			\
@@ -244,13 +265,34 @@
 	"nco:nameHonorificPrefix(?c) nco:nameHonorificSuffix(?c) "	\
 	"nco:phoneNumber(?h) "						\
 	"WHERE { "							\
+	"{"								\
+		"?c a nco:Contact . "					\
+		"?c nco:hasPhoneNumber ?h . "				\
 		"?call a nmo:Call ; "					\
 		"nmo:from ?c ; "					\
 		"nmo:isSent false ; "					\
 		"nmo:isAnswered true ."					\
-		"?c a nco:Contact . "					\
-	"OPTIONAL { ?c nco:hasPhoneNumber ?h . } "			\
-	"} ORDER BY DESC(nmo:receivedDate(?call))"
+	"} UNION { "							\
+		"?x a nco:Contact . "					\
+		"?x nco:hasPhoneNumber ?h ."				\
+		"?call a nmo:Call ; "					\
+		"nmo:from ?x ; "					\
+		"nmo:isSent false ; "					\
+		"nmo:isAnswered true ."					\
+		"?c a nco:PersonContact . "				\
+		"?c nco:hasPhoneNumber ?h ."				\
+	"}UNION { "							\
+		"?x a nco:Contact . "					\
+		"?x nco:hasPhoneNumber ?h ."				\
+		"?call a nmo:Call ; "					\
+		"nmo:from ?x ; "					\
+		"nmo:isSent false ; "					\
+		"nmo:isAnswered true ."					\
+		"?c a nco:PersonContact . "				\
+		"?c nco:hasAffiliation ?a . "				\
+		"?a nco:hasPhoneNumber ?h . "				\
+	"}"								\
+	"} GROUP BY ?call ORDER BY DESC(nmo:receivedDate(?call))"
 
 #define OUTGOING_CALLS_QUERY						\
 	"SELECT nco:phoneNumber(?h) nco:fullname(?c) "			\
@@ -313,12 +355,31 @@
 	"nco:nameHonorificPrefix(?c) nco:nameHonorificSuffix(?c) "	\
 	"nco:phoneNumber(?h) "						\
 	"WHERE { "							\
+	"{"								\
+		"?c a nco:Contact . "					\
+		"?c nco:hasPhoneNumber ?h . "				\
 		"?call a nmo:Call ; "					\
 		"nmo:to ?c ; "						\
 		"nmo:isSent true . "					\
-		"?c a nco:Contact . "					\
-	"OPTIONAL { ?c nco:hasPhoneNumber ?h . } "			\
-	"} ORDER BY DESC(nmo:sentDate(?call))"
+	"} UNION {"							\
+		"?x a nco:Contact . "					\
+		"?x nco:hasPhoneNumber ?h . "				\
+		"?call a nmo:Call ; "					\
+		"nmo:to ?x ; "						\
+		"nmo:isSent true . "					\
+		"?c a nco:PersonContact . "				\
+		"?c nco:hasPhoneNumber ?h . "				\
+	"} UNION {"							\
+		"?x a nco:Contact . "					\
+		"?x nco:hasPhoneNumber ?h . "				\
+		"?call a nmo:Call ; "					\
+		"nmo:to ?x ; "						\
+		"nmo:isSent true . "					\
+		"?c a nco:PersonContact . "				\
+		"?c nco:hasAffiliation ?a . "				\
+		"?a nco:hasPhoneNumber ?h . "				\
+	"}"								\
+	"} GROUP BY ?call ORDER BY DESC(nmo:sentDate(?call))"
 
 #define COMBINED_CALLS_QUERY						\
 	"SELECT nco:phoneNumber(?h) nco:fullname(?c) "			\
@@ -420,19 +481,54 @@
 	"nco:nameAdditional(?c) nco:nameHonorificPrefix(?c) "		\
 	"nco:nameHonorificSuffix(?c) nco:phoneNumber(?h) "		\
 	"WHERE { "							\
-	"{ "								\
-		"?call a nmo:Call ; "					\
-		"nmo:to ?c ; "						\
-		"nmo:isSent true . "					\
-		"?c a nco:Contact . "					\
-		"OPTIONAL { ?c nco:hasPhoneNumber ?h . } "		\
-	"} UNION { "							\
-		"?call a nmo:Call ; "					\
-		"nmo:from ?c ; "					\
-		"nmo:isSent false . "					\
-		"?c a nco:Contact . "					\
-		"OPTIONAL { ?c nco:hasPhoneNumber ?h . } "		\
-	"} } ORDER BY DESC(nmo:receivedDate(?call))"
+	"	{ "							\
+			"?c a nco:Contact . "				\
+			"?c nco:hasPhoneNumber ?h . "			\
+			"?call a nmo:Call ; "				\
+			"nmo:to ?c ; "					\
+			"nmo:isSent true . "				\
+		"} UNION {"						\
+			"?x a nco:Contact . "				\
+			"?x nco:hasPhoneNumber ?h . "			\
+			"?call a nmo:Call ; "				\
+			"nmo:to ?x ; "					\
+			"nmo:isSent true . "				\
+			"?c a nco:PersonContact . "			\
+			"?c nco:hasPhoneNumber ?h . "			\
+		"} UNION {"						\
+			"?x a nco:Contact . "				\
+			"?x nco:hasPhoneNumber ?h . "			\
+			"?call a nmo:Call ; "				\
+			"nmo:to ?x ; "					\
+			"nmo:isSent true . "				\
+			"?c a nco:PersonContact . "			\
+			"?c nco:hasAffiliation ?a . "			\
+			"?a nco:hasPhoneNumber ?h . "			\
+		"}UNION {"						\
+			"?c a nco:Contact . "				\
+			"?c nco:hasPhoneNumber ?h . "			\
+			"?call a nmo:Call ; "				\
+			"nmo:from ?c ; "				\
+			"nmo:isSent false . "				\
+		"} UNION {"						\
+			"?x a nco:Contact . "				\
+			"?x nco:hasPhoneNumber ?h . "			\
+			"?call a nmo:Call ; "				\
+			"nmo:from ?x ; "				\
+			"nmo:isSent false . "				\
+			"?c a nco:PersonContact . "			\
+			"?c nco:hasPhoneNumber ?h . "			\
+		"} UNION {"						\
+			"?x a nco:Contact . "				\
+			"?x nco:hasPhoneNumber ?h . "			\
+			"?call a nmo:Call ; "				\
+			"nmo:from ?x ; "				\
+			"nmo:isSent false . "				\
+			"?c a nco:PersonContact . "			\
+			"?c nco:hasAffiliation ?a . "			\
+			"?a nco:hasPhoneNumber ?h . "			\
+		"}"							\
+	"} GROUP BY ?call ORDER BY DESC(nmo:receivedDate(?call))"
 
 
 #define CONTACTS_QUERY_FROM_URI						\
-- 
1.7.0.4

