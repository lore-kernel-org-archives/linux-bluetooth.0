Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH 2/3] Simplify add numbers/emails/addresses logic in PBAP
Date: Thu, 13 Jan 2011 09:39:00 +0200
Message-Id: <1294904341-16047-2-git-send-email-ext-jablonski.radoslaw@nokia.com>
In-Reply-To: <y>
References: <y>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There was 3 diffent functions for doing the same -
checking if some field is already added. Now using only
function named "find_field" for that purpose.
---
 plugins/phonebook-tracker.c |   46 +++++++-----------------------------------
 1 files changed, 8 insertions(+), 38 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 9354a47..204f0fd 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -1178,17 +1178,17 @@ static struct phonebook_contact *find_contact(GSList *contacts, const char *id)
 	return NULL;
 }
 
-static struct phonebook_field *find_phone(GSList *numbers, const char *phone,
+static struct phonebook_field *find_field(GSList *fields, const char *value,
 								int type)
 {
 	GSList *l;
 
-	for (l = numbers; l; l = l->next) {
-		struct phonebook_field *pb_num = l->data;
+	for (l = fields; l; l = l->next) {
+		struct phonebook_field *field = l->data;
 		/* Returning phonebook number if phone values and type values
 		 * are equal */
-		if (g_strcmp0(pb_num->text, phone) == 0 && pb_num->type == type)
-			return pb_num;
+		if (g_strcmp0(field->text, value) == 0 && field->type == type)
+			return field;
 	}
 
 	return NULL;
@@ -1203,7 +1203,7 @@ static void add_phone_number(struct phonebook_contact *contact,
 		return;
 
 	/* Not adding number if there is already added with the same value */
-	if (find_phone(contact->numbers, phone, type))
+	if (find_field(contact->numbers, phone, type))
 		return;
 
 	number = g_new0(struct phonebook_field, 1);
@@ -1213,21 +1213,6 @@ static void add_phone_number(struct phonebook_contact *contact,
 	contact->numbers = g_slist_append(contact->numbers, number);
 }
 
-static struct phonebook_field *find_email(GSList *emails, const char *address,
-								int type)
-{
-	GSList *l;
-
-	for (l = emails; l; l = l->next) {
-		struct phonebook_field *email = l->data;
-		if (g_strcmp0(email->text, address) == 0 &&
-						email->type == type)
-			return email;
-	}
-
-	return NULL;
-}
-
 static void add_email(struct phonebook_contact *contact, const char *address,
 								int type)
 {
@@ -1237,7 +1222,7 @@ static void add_email(struct phonebook_contact *contact, const char *address,
 		return;
 
 	/* Not adding email if there is already added with the same value */
-	if (find_email(contact->emails, address, type))
+	if (find_field(contact->emails, address, type))
 		return;
 
 	email = g_new0(struct phonebook_field, 1);
@@ -1247,21 +1232,6 @@ static void add_email(struct phonebook_contact *contact, const char *address,
 	contact->emails = g_slist_append(contact->emails, email);
 }
 
-static struct phonebook_field *find_address(GSList *addresses,
-					const char *address, int type)
-{
-	GSList *l;
-
-	for (l = addresses; l; l = l->next) {
-		struct phonebook_field *addr = l->data;
-		if (g_strcmp0(addr->text, address) == 0 &&
-						addr->type == type)
-			return addr;
-	}
-
-	return NULL;
-}
-
 static void add_address(struct phonebook_contact *contact,
 					const char *address, int type)
 {
@@ -1271,7 +1241,7 @@ static void add_address(struct phonebook_contact *contact,
 		return;
 
 	/* Not adding address if there is already added with the same value */
-	if (find_address(contact->addresses, address, type))
+	if (find_field(contact->addresses, address, type))
 		return;
 
 	addr = g_new0(struct phonebook_field, 1);
-- 
1.7.0.4

