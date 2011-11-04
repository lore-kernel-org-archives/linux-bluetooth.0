Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <radoslawjablonski@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH obexd 1/1] Fix missing URL vCard's field with OTHER subtype
Date: Fri,  4 Nov 2011 15:00:51 +0100
Message-Id: <1320415251-10350-2-git-send-email-radoslawjablonski@gmail.com>
In-Reply-To: <1320415251-10350-1-git-send-email-radoslawjablonski@gmail.com>
References: <1320415251-10350-1-git-send-email-radoslawjablonski@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Rafal Michalski <michalski.raf@gmail.com>

Previously URL vCard's field (imported with default OTHER subtype) was
missing after pulling entire phonebook or single vCard (for phonebook
and each call history as well).
This patch fixes that issue by adjusting queries to URL field.
---
 plugins/phonebook-tracker.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index e4f2383..a8b97c2 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -115,7 +115,7 @@
 "nco:birthDate(?_contact) "						\
 "nco:nickname(?_contact) "						\
 "(SELECT GROUP_CONCAT(fn:concat( "					\
-	"?url_val, \"\31\", rdfs:label(?_role) "			\
+	"?url_val, \"\31\", tracker:coalesce(rdfs:label(?_role), \"\") "\
 	"), \"\30\") "							\
 	"WHERE {"							\
 		"?_role nco:url ?url_val . "				\
@@ -224,13 +224,11 @@ CALLS_CONSTRAINTS(CONSTRAINT)						\
 	"}) "								\
 	"nco:birthDate(?_contact) "					\
 	"nco:nickname(?_contact) "					\
-"(SELECT GROUP_CONCAT(fn:concat( "					\
-	"?url_value, \"\31\", ?aff_type "				\
-	"), \"\30\") "							\
+"(SELECT GROUP_CONCAT(fn:concat(?url_value, \"\31\", "			\
+	"tracker:coalesce(rdfs:label(?c_role), \"\")), \"\30\") "	\
 	"WHERE {"							\
 		"?_contact nco:hasAffiliation ?c_role . "		\
 		"?c_role nco:url ?url_value . "				\
-		"?c_role rdfs:label ?aff_type . "			\
 "})"									\
 	"nie:url(nco:photo(?_contact)) "				\
 	"nco:role(?_role) "						\
@@ -320,7 +318,7 @@ COMBINED_CONSTRAINT		\
 "nco:birthDate(<%s>) "							\
 "nco:nickname(<%s>) "							\
 "(SELECT GROUP_CONCAT(fn:concat( "					\
-	"?url_val, \"\31\", rdfs:label(?_role) "			\
+	"?url_val, \"\31\", tracker:coalesce(rdfs:label(?_role), \"\") "\
 	"), \"\30\") "							\
 	"WHERE {"							\
 		"?_role nco:url ?url_val . "				\
-- 
1.6.3.3

