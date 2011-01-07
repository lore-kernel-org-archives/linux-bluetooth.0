Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH] Fix for handling emails in pull call history queries
Date: Fri,  7 Jan 2011 10:19:57 +0200
Message-Id: <1294388397-1642-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously only emails of one type at a time were listed
in call history for given contact. With this fix every
email for contact will be displayed in pull call history
result.
---
 plugins/phonebook-tracker.c |   99 ++++++++++++++++++++++++++++++-------------
 1 files changed, 69 insertions(+), 30 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 3dcf818..936ff03 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -141,10 +141,13 @@
 "rdfs:label(?_role) "							\
 "nco:fullname(nco:org(?_role))"						\
 "nco:department(?_role) "						\
-"(SELECT GROUP_CONCAT(?emailaddress, \"\30\")"				\
-"WHERE {"								\
-"	?_role nco:hasEmailAddress [ nco:emailAddress ?emailaddress ]"	\
-"}) "									\
+"(SELECT GROUP_CONCAT(fn:concat(?emailaddress,\"\31\","			\
+	"rdfs:label(?_role)),"						\
+	"\"\30\") "							\
+	"WHERE { "							\
+	"?_role nco:hasEmailAddress "					\
+	"		[ nco:emailAddress ?emailaddress ] "		\
+	"}) "								\
 "\"NOTACALL\" \"false\" \"false\" "					\
 "?_contact "								\
 "WHERE {"								\
@@ -232,9 +235,13 @@
 	"rdfs:label(?_role) "						\
 	"nco:fullname(nco:org(?_role)) "				\
 	"nco:department(?_role) "					\
-"(SELECT GROUP_CONCAT(?emailaddress, \"\30\") "				\
+"(SELECT GROUP_CONCAT(fn:concat(?emailaddress,\"\31\","			\
+	"rdfs:label(?c_role)),"						\
+	"\"\30\") "							\
 	"WHERE { "							\
-	"?_role nco:hasEmailAddress [ nco:emailAddress ?emailaddress ] "\
+	"?_contact nco:hasAffiliation ?c_role . "			\
+	"?c_role nco:hasEmailAddress "					\
+	"		[ nco:emailAddress ?emailaddress ] "		\
 	"}) "								\
 	"nmo:receivedDate(?_call) "					\
 	"nmo:isSent(?_call) "						\
@@ -380,9 +387,13 @@
 	"rdfs:label(?_role) "						\
 	"nco:fullname(nco:org(?_role)) "				\
 	"nco:department(?_role) "					\
-"(SELECT GROUP_CONCAT(?emailaddress, \"\30\") "				\
+"(SELECT GROUP_CONCAT(fn:concat(?emailaddress,\"\31\","			\
+	"rdfs:label(?c_role)),"						\
+	"\"\30\") "							\
 	"WHERE { "							\
-	"?_role nco:hasEmailAddress [ nco:emailAddress ?emailaddress ] "\
+	"?_contact nco:hasAffiliation ?c_role . "			\
+	"?c_role nco:hasEmailAddress "					\
+	"		[ nco:emailAddress ?emailaddress ] "		\
 	"}) "								\
 	"nmo:receivedDate(?_call) "					\
 	"nmo:isSent(?_call) "						\
@@ -527,9 +538,13 @@
 	"rdfs:label(?_role) "						\
 	"nco:fullname(nco:org(?_role)) "				\
 	"nco:department(?_role) "					\
-"(SELECT GROUP_CONCAT(?emailaddress, \"\30\") "				\
+"(SELECT GROUP_CONCAT(fn:concat(?emailaddress,\"\31\","			\
+	"rdfs:label(?c_role)),"						\
+	"\"\30\") "							\
 	"WHERE { "							\
-	"?_role nco:hasEmailAddress [ nco:emailAddress ?emailaddress ] "\
+	"?_contact nco:hasAffiliation ?c_role . "			\
+	"?c_role nco:hasEmailAddress "					\
+	"		[ nco:emailAddress ?emailaddress ] "		\
 	"}) "								\
 	"nmo:receivedDate(?_call) "					\
 	"nmo:isSent(?_call) "						\
@@ -668,9 +683,13 @@
 	"rdfs:label(?_role) "						\
 	"nco:fullname(nco:org(?_role)) "				\
 	"nco:department(?_role) "					\
-"(SELECT GROUP_CONCAT(?emailaddress, \"\30\") "				\
+"(SELECT GROUP_CONCAT(fn:concat(?emailaddress,\"\31\","			\
+	"rdfs:label(?c_role)),"						\
+	"\"\30\") "							\
 	"WHERE { "							\
-	"?_role nco:hasEmailAddress [ nco:emailAddress ?emailaddress ] "\
+	"?_contact nco:hasAffiliation ?c_role . "			\
+	"?c_role nco:hasEmailAddress "					\
+	"		[ nco:emailAddress ?emailaddress ] "		\
 	"}) "								\
 	"nmo:receivedDate(?_call) "					\
 	"nmo:isSent(?_call) "						\
@@ -853,10 +872,13 @@
 "rdfs:label(?_role) "							\
 "nco:fullname(nco:org(?_role))"						\
 "nco:department(?_role) "						\
-"(SELECT GROUP_CONCAT(?emailaddress, \"\30\")"				\
-"WHERE {"								\
-"	?_role nco:hasEmailAddress [ nco:emailAddress ?emailaddress ]"	\
-"}) "									\
+"(SELECT GROUP_CONCAT(fn:concat(?emailaddress,\"\31\","			\
+	"rdfs:label(?_role)),"						\
+	"\"\30\") "							\
+	"WHERE { "							\
+	"?_role nco:hasEmailAddress "					\
+	"		[ nco:emailAddress ?emailaddress ] "		\
+	"}) "								\
 "\"NOTACALL\" \"false\" \"false\" "					\
 "<%s> "									\
 "WHERE {"								\
@@ -1543,10 +1565,39 @@ static enum phonebook_email_type get_email_type(const char *affilation)
 	return EMAIL_TYPE_OTHER;
 }
 
+static void add_aff_email(struct phonebook_contact *contact, char *aff_email)
+{
+	char **email_parts;
+	char *type, *email;
+
+	/* Emails from affilation data, are represented as real email
+	 * string and affilation type - those strings are separated by
+	 * SUB_DELIM string */
+	email_parts = g_strsplit(aff_email, SUB_DELIM, 2);
+
+	if (!email_parts)
+		return;
+
+	if (email_parts[0])
+		email = email_parts[0];
+	else
+		goto failed;
+
+	if (email_parts[1])
+		type = email_parts[1];
+	else
+		goto failed;
+
+	add_email(contact, email, get_email_type(type));
+
+failed:
+	g_strfreev(email_parts);
+}
+
 static void contact_add_emails(struct phonebook_contact *contact,
 								char **reply)
 {
-	char **aff_emails, **con_emails;
+	char **aff_emails;
 	int i;
 
 	/* Emails from affilation */
@@ -1554,21 +1605,9 @@ static void contact_add_emails(struct phonebook_contact *contact,
 
 	if (aff_emails)
 		for(i = 0; aff_emails[i] != NULL; ++i)
-			add_email(contact, aff_emails[i],
-					get_email_type(reply[COL_AFF_TYPE]));
+			add_aff_email(contact, aff_emails[i]);
 
 	g_strfreev(aff_emails);
-
-	/* Emails taken directly from contact's data have always type OTHER */
-	con_emails = g_strsplit(reply[COL_EMAIL_CONTACT], MAIN_DELIM,
-								MAX_FIELDS);
-
-	if (con_emails)
-		for(i = 0; con_emails[i] != NULL; ++i)
-			add_email(contact, con_emails[i], EMAIL_TYPE_OTHER);
-
-	g_strfreev(con_emails);
-
 }
 
 static enum phonebook_address_type get_addr_type(const char *affilation)
-- 
1.7.0.4

