Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH] Fix history queries for contacts outside pb
Date: Tue, 11 Jan 2011 15:35:51 +0200
Message-Id: <1294752951-27299-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Phone number for contacts outside phonebook need to
be fetched differently - application which saves call data
saves this number directly in "nco:Contact" now.
Without this fix, calls to/from numbers outside phonebook
won't be listed in call history results
---
 plugins/phonebook-tracker.c |   32 ++++++++++++++++++++++++--------
 1 files changed, 24 insertions(+), 8 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 25eca62..237fb33 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -152,8 +152,12 @@
 "(SELECT fn:concat(rdf:type(?role_number),"				\
 	"\"\31\", nco:phoneNumber(?role_number))"			\
 	"WHERE {"							\
-	"?_role nco:hasPhoneNumber ?role_number "			\
-	"FILTER (?role_number = ?_number)"				\
+	"{"								\
+	"	?_role nco:hasPhoneNumber ?role_number "		\
+	"	FILTER (?role_number = ?_number)"			\
+	"} UNION { "							\
+		"?_unb_contact nco:hasPhoneNumber ?role_number . "	\
+	"}"								\
 "} GROUP BY nco:phoneNumber(?role_number) ) "				\
 	"nco:fullname(?_contact) "					\
 	"nco:nameFamily(?_contact) "					\
@@ -278,8 +282,12 @@
 "(SELECT fn:concat(rdf:type(?role_number),"				\
 	"\"\31\", nco:phoneNumber(?role_number))"			\
 	"WHERE {"							\
-	"?_role nco:hasPhoneNumber ?role_number "			\
-	"FILTER (?role_number = ?_number)"				\
+	"{"								\
+	"	?_role nco:hasPhoneNumber ?role_number "		\
+	"	FILTER (?role_number = ?_number)"			\
+	"} UNION { "							\
+		"?_unb_contact nco:hasPhoneNumber ?role_number . "	\
+	"}"								\
 "} GROUP BY nco:phoneNumber(?role_number) ) "				\
 	"nco:fullname(?_contact) "					\
 	"nco:nameFamily(?_contact) "					\
@@ -403,8 +411,12 @@
 "(SELECT fn:concat(rdf:type(?role_number),"				\
 	"\"\31\", nco:phoneNumber(?role_number))"			\
 	"WHERE {"							\
-	"?_role nco:hasPhoneNumber ?role_number "			\
-	"FILTER (?role_number = ?_number)"				\
+	"{"								\
+	"	?_role nco:hasPhoneNumber ?role_number "		\
+	"	FILTER (?role_number = ?_number)"			\
+	"} UNION { "							\
+		"?_unb_contact nco:hasPhoneNumber ?role_number . "	\
+	"}"								\
 "} GROUP BY nco:phoneNumber(?role_number) ) "				\
 	"nco:fullname(?_contact) "					\
 	"nco:nameFamily(?_contact) "					\
@@ -522,8 +534,12 @@
 "(SELECT fn:concat(rdf:type(?role_number),"				\
 	"\"\31\", nco:phoneNumber(?role_number))"			\
 	"WHERE {"							\
-	"?_role nco:hasPhoneNumber ?role_number "			\
-	"FILTER (?role_number = ?_number)"				\
+	"{"								\
+	"	?_role nco:hasPhoneNumber ?role_number "		\
+	"	FILTER (?role_number = ?_number)"			\
+	"} UNION { "							\
+		"?_unb_contact nco:hasPhoneNumber ?role_number . "	\
+	"}"								\
 "} GROUP BY nco:phoneNumber(?role_number) ) "				\
 	"nco:fullname(?_contact) "					\
 	"nco:nameFamily(?_contact) "					\
-- 
1.7.0.4

