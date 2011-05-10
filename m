Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH v2] Adjust SPARQL queries to the changes in call history
Date: Tue, 10 May 2011 13:09:41 +0200
Message-Id: <1305025781-21893-1-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1305017315-30927-1-git-send-email-lkslawek@gmail.com>
References: <1305017315-30927-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Currently nmo:Call resources put to the Tracker by commhistory do not use
the same nco:PhoneNumber as the one bound to the nco:PersonContact. This
patch introduces matching contacts by actual phone number, thus returning
proper contact data regardless of this commhistory change.
---
In the previous version backslashes at the ends of lines were incorrectly
aligned.
 plugins/phonebook-tracker.c |   74 ++++++++++++++++++++++++++++++------------
 1 files changed, 53 insertions(+), 21 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index d72c04e..9431d8a 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -231,7 +231,7 @@
 	"OPTIONAL { ?_contact nco:hasAffiliation ?_role .} "		\
 "} UNION { "								\
 	"?_ncontact a nco:Contact . "					\
-	"?_ncontact nco:hasPhoneNumber ?_number . "			\
+	"?_ncontact nco:hasPhoneNumber ?_other . "			\
 	"?_call a nmo:Call ; "						\
 	"nmo:from ?_ncontact ; "					\
 	"nmo:isAnswered false ;"					\
@@ -239,9 +239,11 @@
 	"?_contact a nco:PersonContact . "				\
 	"?_contact nco:hasAffiliation ?_role . "			\
 	"?_role nco:hasPhoneNumber ?_number . "				\
+	"?_other maemo:localPhoneNumber ?_realnum . "			\
+	"?_number maemo:localPhoneNumber ?_realnum . "			\
 "} UNION { "								\
 	"?_unb_contact a nco:Contact . "				\
-	"?_unb_contact nco:hasPhoneNumber ?_number . "			\
+	"?_unb_contact nco:hasPhoneNumber ?_other . "			\
 	"?_call a nmo:Call ; "						\
 	"nmo:from ?_unb_contact ; "					\
 	"nmo:isAnswered false ;"					\
@@ -250,7 +252,9 @@
 	"nco:hasPhoneNumber ?_number . } "				\
 	"OPTIONAL {?_contact a nco:PersonContact ; "			\
 	"nco:hasAffiliation ?_role . "					\
-	"?_role nco:hasPhoneNumber ?_number. } "			\
+	"?_role nco:hasPhoneNumber ?_number . "				\
+	"?_other maemo:localPhoneNumber ?_realnum . "			\
+	"?_number maemo:localPhoneNumber ?_realnum . }"			\
 	"FILTER ( !bound(?_contact) && !bound(?_role) ) "		\
 "} "									\
 "} "									\
@@ -288,7 +292,9 @@
 		"nmo:isAnswered false ."				\
 		"?c a nco:PersonContact . "				\
 		"?c nco:hasAffiliation ?a . "				\
-		"?a nco:hasPhoneNumber ?h . "				\
+		"?a nco:hasPhoneNumber ?no . "				\
+		"?h maemo:localPhoneNumber ?num . "			\
+		"?no maemo:localPhoneNumber ?num . "			\
 	"} "								\
 	"} GROUP BY ?call ORDER BY DESC(nmo:receivedDate(?call))"
 
@@ -368,7 +374,7 @@
 	"OPTIONAL { ?_contact nco:hasAffiliation ?_role .} "		\
 "} UNION { "								\
 	"?_ncontact a nco:Contact . "					\
-	"?_ncontact nco:hasPhoneNumber ?_number . "			\
+	"?_ncontact nco:hasPhoneNumber ?_other . "			\
 	"?_call a nmo:Call ; "						\
 	"nmo:from ?_ncontact ; "					\
 	"nmo:isAnswered true ;"						\
@@ -376,9 +382,11 @@
 	"?_contact a nco:PersonContact . "				\
 	"?_contact nco:hasAffiliation ?_role . "			\
 	"?_role nco:hasPhoneNumber ?_number . "				\
+	"?_number maemo:localPhoneNumber ?_realnum . "			\
+	"?_other maemo:localPhoneNumber ?_realnum . "			\
 "} UNION { "								\
 	"?_unb_contact a nco:Contact . "				\
-	"?_unb_contact nco:hasPhoneNumber ?_number . "			\
+	"?_unb_contact nco:hasPhoneNumber ?_other . "			\
 	"?_call a nmo:Call ; "						\
 	"nmo:from ?_unb_contact ; "					\
 	"nmo:isAnswered true ;"						\
@@ -387,7 +395,9 @@
 	"nco:hasPhoneNumber ?_number . } "				\
 	"OPTIONAL {?_contact a nco:PersonContact ; "			\
 	"nco:hasAffiliation ?_role . "					\
-	"?_role nco:hasPhoneNumber ?_number. } "			\
+	"?_role nco:hasPhoneNumber ?_number . "				\
+	"?_number maemo:localPhoneNumber ?_realnum ."			\
+	"?_other maemo:localPhoneNumber ?_realnum . }"			\
 	"FILTER ( !bound(?_contact) && !bound(?_role) ) "		\
 "} "									\
 "} "\
@@ -424,7 +434,9 @@
 		"nmo:isAnswered true ."					\
 		"?c a nco:PersonContact . "				\
 		"?c nco:hasAffiliation ?a . "				\
-		"?a nco:hasPhoneNumber ?h . "				\
+		"?a nco:hasPhoneNumber ?no . "				\
+		"?h maemo:localPhoneNumber ?num . "			\
+		"?no maemo:localPhoneNumber ?num . "			\
 	"}"								\
 	"} GROUP BY ?call ORDER BY DESC(nmo:receivedDate(?call))"
 
@@ -503,16 +515,18 @@
 	"OPTIONAL { ?_contact nco:hasAffiliation ?_role .} "		\
 "} UNION { "								\
 	"?_ncontact a nco:Contact . "					\
-	"?_ncontact nco:hasPhoneNumber ?_number . "			\
+	"?_ncontact nco:hasPhoneNumber ?_other . "			\
 	"?_call a nmo:Call ; "						\
 	"nmo:to ?_ncontact ; "						\
 	"nmo:isSent true . "						\
 	"?_contact a nco:PersonContact . "				\
 	"?_contact nco:hasAffiliation ?_role . "			\
 	"?_role nco:hasPhoneNumber ?_number . "				\
+	"?_other maemo:localPhoneNumber ?_realnum . "			\
+	"?_number maemo:localPhoneNumber ?_realnum . "			\
 "} UNION { "								\
 	"?_unb_contact a nco:Contact . "				\
-	"?_unb_contact nco:hasPhoneNumber ?_number . "			\
+	"?_unb_contact nco:hasPhoneNumber ?_other . "			\
 	"?_call a nmo:Call ; "						\
 	"nmo:to ?_unb_contact ; "					\
 	"nmo:isSent true . "						\
@@ -520,7 +534,9 @@
 	"nco:hasPhoneNumber ?_number . } "				\
 	"OPTIONAL {?_contact a nco:PersonContact ; "			\
 	"nco:hasAffiliation ?_role . "					\
-	"?_role nco:hasPhoneNumber ?_number. } "			\
+	"?_role nco:hasPhoneNumber ?_number . "				\
+	"?_other maemo:localPhoneNumber ?_realnum ."			\
+	"?_number maemo:localPhoneNumber ?_realnum . }"			\
 	"FILTER ( !bound(?_contact) && !bound(?_role) ) "		\
 "} "									\
 "} "									\
@@ -554,7 +570,9 @@
 		"nmo:isSent true . "					\
 		"?c a nco:PersonContact . "				\
 		"?c nco:hasAffiliation ?a . "				\
-		"?a nco:hasPhoneNumber ?h . "				\
+		"?a nco:hasPhoneNumber ?no . "				\
+		"?h maemo:localPhoneNumber ?num . "			\
+		"?no maemo:localPhoneNumber ?num . "			\
 	"}"								\
 	"} GROUP BY ?call ORDER BY DESC(nmo:sentDate(?call))"
 
@@ -633,16 +651,18 @@
 	"OPTIONAL { ?_contact nco:hasAffiliation ?_role .} "		\
 "} UNION { "								\
 	"?_ncontact a nco:Contact . "					\
-	"?_ncontact nco:hasPhoneNumber ?_number . "			\
+	"?_ncontact nco:hasPhoneNumber ?_other . "			\
 	"?_call a nmo:Call ; "						\
 	"nmo:to ?_ncontact ; "						\
 	"nmo:isSent true . "						\
 	"?_contact a nco:PersonContact . "				\
 	"?_contact nco:hasAffiliation ?_role . "			\
 	"?_role nco:hasPhoneNumber ?_number . "				\
+	"?_other maemo:localPhoneNumber ?_realnum . "			\
+	"?_number maemo:localPhoneNumber ?_realnum . "			\
 "} UNION { "								\
 	"?_unb_contact a nco:Contact . "				\
-	"?_unb_contact nco:hasPhoneNumber ?_number . "			\
+	"?_unb_contact nco:hasPhoneNumber ?_other . "			\
 	"?_call a nmo:Call ; "						\
 	"nmo:to ?_unb_contact ; "					\
 	"nmo:isSent true . "						\
@@ -650,7 +670,9 @@
 	"nco:hasPhoneNumber ?_number . } "				\
 	"OPTIONAL {?_contact a nco:PersonContact ; "			\
 	"nco:hasAffiliation ?_role . "					\
-	"?_role nco:hasPhoneNumber ?_number. } "			\
+	"?_role nco:hasPhoneNumber ?_number . "				\
+	"?_other maemo:localPhoneNumber ?_realnum ."			\
+	"?_number maemo:localPhoneNumber ?_realnum . }"			\
 	"FILTER ( !bound(?_contact) && !bound(?_role) ) "		\
 "} UNION { "								\
 	"?_ncontact a nco:Contact . "					\
@@ -663,16 +685,18 @@
 	"OPTIONAL { ?_contact nco:hasAffiliation ?_role .} "		\
 "} UNION { "								\
 	"?_ncontact a nco:Contact . "					\
-	"?_ncontact nco:hasPhoneNumber ?_number . "			\
+	"?_ncontact nco:hasPhoneNumber ?_other . "			\
 	"?_call a nmo:Call ; "						\
 	"nmo:from ?_ncontact ; "					\
 	"nmo:isSent false . "						\
 	"?_contact a nco:PersonContact . "				\
 	"?_contact nco:hasAffiliation ?_role . "			\
 	"?_role nco:hasPhoneNumber ?_number . "				\
+	"?_other maemo:localPhoneNumber ?_realnum . "			\
+	"?_number maemo:localPhoneNumber ?_realnum . "			\
 "} UNION { "								\
 	"?_unb_contact a nco:Contact . "				\
-	"?_unb_contact nco:hasPhoneNumber ?_number . "			\
+	"?_unb_contact nco:hasPhoneNumber ?_other . "			\
 	"?_call a nmo:Call ; "						\
 	"nmo:from ?_unb_contact ; "					\
 	"nmo:isSent false . "						\
@@ -680,7 +704,9 @@
 	"nco:hasPhoneNumber ?_number . } "				\
 	"OPTIONAL {?_contact a nco:PersonContact ; "			\
 	"nco:hasAffiliation ?_role . "					\
-	"?_role nco:hasPhoneNumber ?_number. } "			\
+	"?_role nco:hasPhoneNumber ?_number . "				\
+	"?_other maemo:localPhoneNumber ?_realnum ."			\
+	"?_number maemo:localPhoneNumber ?_realnum . }"			\
 	"FILTER ( !bound(?_contact) && !bound(?_role) ) "		\
 "} "									\
 "} "									\
@@ -713,7 +739,9 @@
 			"nmo:isSent true . "				\
 			"?c a nco:PersonContact . "			\
 			"?c nco:hasAffiliation ?a . "			\
-			"?a nco:hasPhoneNumber ?h . "			\
+			"?a nco:hasPhoneNumber ?no . "			\
+			"?h maemo:localPhoneNumber ?num . "		\
+			"?no maemo:localPhoneNumber ?num . "		\
 		"}UNION {"						\
 			"?c a nco:Contact . "				\
 			"?c nco:hasPhoneNumber ?h . "			\
@@ -736,7 +764,9 @@
 			"nmo:isSent false . "				\
 			"?c a nco:PersonContact . "			\
 			"?c nco:hasAffiliation ?a . "			\
-			"?a nco:hasPhoneNumber ?h . "			\
+			"?a nco:hasPhoneNumber ?no . "			\
+			"?h maemo:localPhoneNumber ?num . "		\
+			"?no maemo:localPhoneNumber ?num . "		\
 		"}"							\
 	"} GROUP BY ?call ORDER BY DESC(nmo:receivedDate(?call))"
 
@@ -887,7 +917,9 @@
 		"nmo:isAnswered false ."				\
 		"?c a nco:PersonContact . "				\
 		"?c nco:hasAffiliation ?a . "				\
-		"?a nco:hasPhoneNumber ?h . "				\
+		"?a nco:hasPhoneNumber ?no . "				\
+		"?h maemo:localPhoneNumber ?num . "			\
+		"?no maemo:localPhoneNumber ?num . "			\
 	"} "								\
 	"} GROUP BY ?call ORDER BY DESC(nmo:receivedDate(?call)) "	\
 	"LIMIT 40"
-- 
1.7.4.1

