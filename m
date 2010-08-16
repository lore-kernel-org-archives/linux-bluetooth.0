Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH] Fix empty contact in missed calls problem
Date: Mon, 16 Aug 2010 16:03:47 +0300
Message-Id: <1281963827-20375-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fixed problem with tracker queries for calls history - previously call
without contact in phonebook was missing in some scenario for pull
requests.
---
 plugins/phonebook-tracker.c |   28 ++++------------------------
 1 files changed, 4 insertions(+), 24 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 705460d..618ce8d 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -96,7 +96,7 @@
 	"} GROUP BY ?c"
 
 #define MISSED_CALLS_QUERY						\
-	"SELECT ?v nco:fullname(?c) "					\
+	"SELECT nco:phoneNumber(?h) nco:fullname(?c) "			\
 	"nco:nameFamily(?c) nco:nameGiven(?c) "				\
 	"nco:nameAdditional(?c) nco:nameHonorificPrefix(?c) "		\
 	"nco:nameHonorificSuffix(?c) nco:emailAddress(?e) "		\
@@ -115,10 +115,6 @@
 		"?h a nco:FaxNumber ; "					\
 		"nco:phoneNumber ?f . "					\
 		"}"							\
-		"OPTIONAL {"						\
-		"?h a nco:VoicePhoneNumber ; "				\
-		"nco:phoneNumber ?v"					\
-		"} "							\
 	"} "								\
 	"OPTIONAL { ?c nco:hasEmailAddress ?e . } "			\
 	"OPTIONAL { ?c nco:hasPostalAddress ?p . } "			\
@@ -143,7 +139,7 @@
 	"} ORDER BY DESC(nmo:receivedDate(?call))"
 
 #define INCOMING_CALLS_QUERY						\
-	"SELECT ?v nco:fullname(?c) "					\
+	"SELECT nco:phoneNumber(?h) nco:fullname(?c) "			\
 	"nco:nameFamily(?c) nco:nameGiven(?c) "				\
 	"nco:nameAdditional(?c) nco:nameHonorificPrefix(?c) "		\
 	"nco:nameHonorificSuffix(?c) nco:emailAddress(?e) "		\
@@ -162,10 +158,6 @@
 		"?h a nco:FaxNumber ; "					\
 		"nco:phoneNumber ?f . "					\
 		"}"							\
-		"OPTIONAL {"						\
-		"?h a nco:VoicePhoneNumber ; "				\
-		"nco:phoneNumber ?v"					\
-		"} "							\
 	"} "								\
 	"OPTIONAL { ?c nco:hasEmailAddress ?e . } "			\
 	"OPTIONAL { ?c nco:hasPostalAddress ?p . } "			\
@@ -190,7 +182,7 @@
 	"} ORDER BY DESC(nmo:receivedDate(?call))"
 
 #define OUTGOING_CALLS_QUERY						\
-	"SELECT ?v nco:fullname(?c) "					\
+	"SELECT nco:phoneNumber(?h) nco:fullname(?c) "			\
 	"nco:nameFamily(?c) nco:nameGiven(?c) "				\
 	"nco:nameAdditional(?c) nco:nameHonorificPrefix(?c) "		\
 	"nco:nameHonorificSuffix(?c) nco:emailAddress(?e) "		\
@@ -208,10 +200,6 @@
 		"?h a nco:FaxNumber ; "					\
 		"nco:phoneNumber ?f . "					\
 		"}"							\
-		"OPTIONAL {"						\
-		"?h a nco:VoicePhoneNumber ; "				\
-		"nco:phoneNumber ?v"					\
-		"} "							\
 	"} "								\
 	"OPTIONAL { ?c nco:hasEmailAddress ?e . } "			\
 	"OPTIONAL { ?c nco:hasPostalAddress ?p . } "			\
@@ -235,7 +223,7 @@
 	"} ORDER BY DESC(nmo:sentDate(?call))"
 
 #define COMBINED_CALLS_QUERY						\
-	"SELECT ?v nco:fullname(?c) "					\
+	"SELECT nco:phoneNumber(?h) nco:fullname(?c) "			\
 	"nco:nameFamily(?c) nco:nameGiven(?c) "				\
 	"nco:nameAdditional(?c) nco:nameHonorificPrefix(?c) "		\
 	"nco:nameHonorificSuffix(?c) nco:emailAddress(?e) "		\
@@ -254,10 +242,6 @@
 		"?h a nco:FaxNumber ; "					\
 		"nco:phoneNumber ?f . "					\
 		"}"							\
-		"OPTIONAL {"						\
-		"?h a nco:VoicePhoneNumber ; "				\
-		"nco:phoneNumber ?v"					\
-		"} "							\
 	"} "								\
 		"OPTIONAL { ?c nco:hasEmailAddress ?e . } "		\
 		"OPTIONAL { ?c nco:hasPostalAddress ?p . } "		\
@@ -275,10 +259,6 @@
 		"?h a nco:FaxNumber ; "					\
 		"nco:phoneNumber ?f . "					\
 		"}"							\
-		"OPTIONAL {"						\
-		"?h a nco:VoicePhoneNumber ; "				\
-		"nco:phoneNumber ?v"					\
-		"} "							\
 	"} "								\
 		"OPTIONAL { ?c nco:hasEmailAddress ?e . } "		\
 		"OPTIONAL { ?c nco:hasPostalAddress ?p . } "		\
-- 
1.7.0.4

