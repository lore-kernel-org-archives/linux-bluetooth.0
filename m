Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH 2/2 v2] Remove unnecessary "?_key" variable in call history queries
Date: Tue,  4 Jan 2011 14:23:57 +0200
Message-Id: <1294143837-19059-2-git-send-email-ext-jablonski.radoslaw@nokia.com>
In-Reply-To: <1294143837-19059-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
References: <1294143837-19059-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This "?_key" variable need to be filled only in pull phonebook
queries(for sorting results). In call history queries it is
unnecessary.
---
 plugins/phonebook-tracker.c |   10 ----------
 1 files changed, 0 insertions(+), 10 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index eda5d38..c052b43 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -248,7 +248,6 @@
 	"?_contact a nco:PersonContact ; "				\
 	"nco:hasPhoneNumber ?_number . "				\
 	"OPTIONAL { ?_contact nco:hasAffiliation ?_role .} "		\
-	"?_contact nco:nameFamily ?_key ."				\
 "} UNION { "								\
 	"?_ncontact a nco:Contact . "					\
 	"?_ncontact nco:hasPhoneNumber ?_number . "			\
@@ -257,7 +256,6 @@
 	"nmo:isAnswered false ;"					\
 	"nmo:isSent false . "						\
 	"?_contact a nco:PersonContact . "				\
-	"?_contact nco:nameFamily ?_key . "				\
 	"?_contact nco:hasAffiliation ?_role . "			\
 	"?_role nco:hasPhoneNumber ?_number . "				\
 "} UNION { "								\
@@ -395,7 +393,6 @@
 	"?_contact a nco:PersonContact ; "				\
 	"nco:hasPhoneNumber ?_number . "				\
 	"OPTIONAL { ?_contact nco:hasAffiliation ?_role .} "		\
-	"?_contact nco:nameFamily ?_key ."				\
 "} UNION { "								\
 	"?_ncontact a nco:Contact . "					\
 	"?_ncontact nco:hasPhoneNumber ?_number . "			\
@@ -404,7 +401,6 @@
 	"nmo:isAnswered true ;"						\
 	"nmo:isSent false . "						\
 	"?_contact a nco:PersonContact . "				\
-	"?_contact nco:nameFamily ?_key . "				\
 	"?_contact nco:hasAffiliation ?_role . "			\
 	"?_role nco:hasPhoneNumber ?_number . "				\
 "} UNION { "								\
@@ -540,7 +536,6 @@
 	"?_contact a nco:PersonContact ; "				\
 	"nco:hasPhoneNumber ?_number . "				\
 	"OPTIONAL { ?_contact nco:hasAffiliation ?_role .} "		\
-	"?_contact nco:nameFamily ?_key ."				\
 "} UNION { "								\
 	"?_ncontact a nco:Contact . "					\
 	"?_ncontact nco:hasPhoneNumber ?_number . "			\
@@ -548,7 +543,6 @@
 	"nmo:to ?_ncontact ; "						\
 	"nmo:isSent true . "						\
 	"?_contact a nco:PersonContact . "				\
-	"?_contact nco:nameFamily ?_key . "				\
 	"?_contact nco:hasAffiliation ?_role . "			\
 	"?_role nco:hasPhoneNumber ?_number . "				\
 "} UNION { "								\
@@ -680,7 +674,6 @@
 	"?_contact a nco:PersonContact ; "				\
 	"nco:hasPhoneNumber ?_number . "				\
 	"OPTIONAL { ?_contact nco:hasAffiliation ?_role .} "		\
-	"?_contact nco:nameFamily ?_key ."				\
 "} UNION { "								\
 	"?_ncontact a nco:Contact . "					\
 	"?_ncontact nco:hasPhoneNumber ?_number . "			\
@@ -688,7 +681,6 @@
 	"nmo:to ?_ncontact ; "						\
 	"nmo:isSent true . "						\
 	"?_contact a nco:PersonContact . "				\
-	"?_contact nco:nameFamily ?_key . "				\
 	"?_contact nco:hasAffiliation ?_role . "			\
 	"?_role nco:hasPhoneNumber ?_number . "				\
 "} UNION { "								\
@@ -712,7 +704,6 @@
 	"?_contact a nco:PersonContact ; "				\
 	"nco:hasPhoneNumber ?_number . "				\
 	"OPTIONAL { ?_contact nco:hasAffiliation ?_role .} "		\
-	"?_contact nco:nameFamily ?_key ."				\
 "} UNION { "								\
 	"?_ncontact a nco:Contact . "					\
 	"?_ncontact nco:hasPhoneNumber ?_number . "			\
@@ -720,7 +711,6 @@
 	"nmo:from ?_ncontact ; "					\
 	"nmo:isSent false . "						\
 	"?_contact a nco:PersonContact . "				\
-	"?_contact nco:nameFamily ?_key . "				\
 	"?_contact nco:hasAffiliation ?_role . "			\
 	"?_role nco:hasPhoneNumber ?_number . "				\
 "} UNION { "								\
-- 
1.7.0.4

