Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH obexd] Fix handling vCard type "OTHER" emails in PBAP
Date: Fri,  5 Aug 2011 13:01:30 +0200
Message-Id: <1312542090-11434-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Until now contacts with emails, without type specified, were not included
in vCards. Also default type for vCard 3.0 is set to "OTHER" - not
empty field as it is in vCard 2.1.
---
 plugins/phonebook-tracker.c |    6 +++---
 plugins/vcard.c             |    2 +-
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 3ac1c44..8bc070f 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -129,7 +129,7 @@
 "nco:fullname(nco:org(?_role))"						\
 "nco:department(?_role) "						\
 "(SELECT GROUP_CONCAT(fn:concat(?emailaddress,\"\31\","			\
-	"rdfs:label(?_role)),"						\
+	"tracker:coalesce(rdfs:label(?_role), \"\")),"			\
 	"\"\30\") "							\
 	"WHERE { "							\
 	"?_role nco:hasEmailAddress "					\
@@ -241,7 +241,7 @@ CALLS_CONSTRAINTS(CONSTRAINT)						\
 	"nco:fullname(nco:org(?_role)) "				\
 	"nco:department(?_role) "					\
 "(SELECT GROUP_CONCAT(fn:concat(?emailaddress,\"\31\","			\
-	"rdfs:label(?c_role)),"						\
+	"tracker:coalesce(rdfs:label(?c_role), \"\")),"			\
 	"\"\30\") "							\
 	"WHERE { "							\
 	"?_contact nco:hasAffiliation ?c_role . "			\
@@ -334,7 +334,7 @@ COMBINED_CONSTRAINT		\
 "nco:fullname(nco:org(?_role))"						\
 "nco:department(?_role) "						\
 "(SELECT GROUP_CONCAT(fn:concat(?emailaddress,\"\31\","			\
-	"rdfs:label(?_role)),"						\
+	"tracker:coalesce(rdfs:label(?_role), \"\")),"			\
 	"\"\30\") "							\
 	"WHERE { "							\
 	"?_role nco:hasEmailAddress "					\
diff --git a/plugins/vcard.c b/plugins/vcard.c
index 4d12687..5a5bcf4 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -368,7 +368,7 @@ static void vcard_printf_email(GString *vcards, uint8_t format,
 		if (format == FORMAT_VCARD21)
 			category_string = "INTERNET";
 		else if (format == FORMAT_VCARD30)
-			category_string = "TYPE=INTERNET";
+			category_string = "TYPE=INTERNET;TYPE=OTHER";
 	}
 
 	add_slash(field, address, LEN_MAX, len);
-- 
1.7.4.1

