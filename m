Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH 3/3] Remove redundant functions for adding addressess and emails
Date: Thu, 13 Jan 2011 09:39:01 +0200
Message-Id: <1294904341-16047-3-git-send-email-ext-jablonski.radoslaw@nokia.com>
In-Reply-To: <y>
References: <y>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Functions "add_aff_email" and "add_aff_address" were doing
basically the same thing. Now for splitting fields and
adding them to contact structure "add_aff_field" is used.
---
 plugins/phonebook-tracker.c |   42 ++++++++----------------------------------
 1 files changed, 8 insertions(+), 34 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 204f0fd..67e4d40 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -856,6 +856,9 @@
 typedef void (*reply_list_foreach_t) (char **reply, int num_fields,
 							void *user_data);
 
+typedef void (*add_field_t) (struct phonebook_contact *contact,
+						const char *value, int type);
+
 struct pending_reply {
 	reply_list_foreach_t callback;
 	void *user_data;
@@ -1403,7 +1406,8 @@ static enum phonebook_field_type get_field_type(const char *affilation)
 	return FIELD_TYPE_OTHER;
 }
 
-static void add_aff_email(struct phonebook_contact *contact, char *aff_email)
+static void add_aff_field(struct phonebook_contact *contact, char *aff_email,
+						add_field_t add_field_cb)
 {
 	char **email_parts;
 	char *type, *email;
@@ -1426,7 +1430,7 @@ static void add_aff_email(struct phonebook_contact *contact, char *aff_email)
 	else
 		goto failed;
 
-	add_email(contact, email, get_field_type(type));
+	add_field_cb(contact, email, get_field_type(type));
 
 failed:
 	g_strfreev(email_parts);
@@ -1443,40 +1447,11 @@ static void contact_add_emails(struct phonebook_contact *contact,
 
 	if (aff_emails)
 		for(i = 0; aff_emails[i] != NULL; ++i)
-			add_aff_email(contact, aff_emails[i]);
+			add_aff_field(contact, aff_emails[i], add_email);
 
 	g_strfreev(aff_emails);
 }
 
-static void add_aff_address(struct phonebook_contact *contact, char *aff_addr)
-{
-	char **addr_parts;
-	char *type, *address;
-
-	/* Addresses from affilation data, are represented as real address
-	 * string and affilation type - those strings are separated by
-	 * SUB_DELIM string */
-	addr_parts = g_strsplit(aff_addr, SUB_DELIM, 2);
-
-	if (!addr_parts)
-		return;
-
-	if (addr_parts[0])
-		address = addr_parts[0];
-	else
-		goto failed;
-
-	if (addr_parts[1])
-		type = addr_parts[1];
-	else
-		goto failed;
-
-	add_address(contact, address, get_field_type(type));
-
-failed:
-	g_strfreev(addr_parts);
-}
-
 static void contact_add_addresses(struct phonebook_contact *contact,
 								char **reply)
 {
@@ -1489,12 +1464,11 @@ static void contact_add_addresses(struct phonebook_contact *contact,
 
 	if (aff_addr)
 		for(i = 0; aff_addr[i] != NULL; ++i)
-			add_aff_address(contact, aff_addr[i]);
+			add_aff_field(contact, aff_addr[i], add_address);
 
 	g_strfreev(aff_addr);
 }
 
-
 static void contact_add_organization(struct phonebook_contact *contact,
 								char **reply)
 {
-- 
1.7.0.4

