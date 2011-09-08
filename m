Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH obexd v3 1/3] Extend functions parameter list for vCard's format
Date: Thu,  8 Sep 2011 15:12:18 +0200
Message-Id: <1315487540-16607-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch extends some functions ("get_escaped_fields" and some from
"vcard_printf_*" family) parameter list for format value, since it would
be needed to select escaping and encoding method, depending on vCard's
type (vCard 2.1 or vCard 3.0).
---
 plugins/vcard.c |   23 ++++++++++++-----------
 1 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/plugins/vcard.c b/plugins/vcard.c
index a4a1921..3b9d9cd 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -144,7 +144,7 @@ done:
 	dest[j] = 0;
 }
 
-static void get_escaped_fields(char **fields, ...)
+static void get_escaped_fields(uint8_t format, char **fields, ...)
 {
 	va_list ap;
 	GString *line;
@@ -201,7 +201,7 @@ static gboolean contact_fields_present(struct phonebook_contact * contact)
 	return FALSE;
 }
 
-static void vcard_printf_name(GString *vcards,
+static void vcard_printf_name(GString *vcards, uint8_t format,
 					struct phonebook_contact *contact)
 {
 	char *fields;
@@ -219,7 +219,7 @@ static void vcard_printf_name(GString *vcards,
 	}
 
 
-	get_escaped_fields(&fields, contact->family,
+	get_escaped_fields(format, &fields, contact->family,
 				contact->given, contact->additional,
 				contact->prefix, contact->suffix,
 				NULL);
@@ -229,7 +229,8 @@ static void vcard_printf_name(GString *vcards,
 	g_free(fields);
 }
 
-static void vcard_printf_fullname(GString *vcards, const char *text)
+static void vcard_printf_fullname(GString *vcards, uint8_t format,
+							const char *text)
 {
 	char field[LEN_MAX];
 	add_slash(field, text, LEN_MAX, strlen(text));
@@ -405,7 +406,7 @@ static gboolean org_fields_present(struct phonebook_contact *contact)
 	return FALSE;
 }
 
-static void vcard_printf_org(GString *vcards,
+static void vcard_printf_org(GString *vcards, uint8_t format,
 					struct phonebook_contact *contact)
 {
 	char *fields;
@@ -413,7 +414,7 @@ static void vcard_printf_org(GString *vcards,
 	if (org_fields_present(contact) == FALSE)
 		return;
 
-	get_escaped_fields(&fields, contact->company,
+	get_escaped_fields(format, &fields, contact->company,
 					contact->department, NULL);
 
 	vcard_printf(vcards, "ORG:%s", fields);
@@ -476,7 +477,7 @@ static void vcard_printf_address(GString *vcards, uint8_t format,
 	g_free(fields);
 }
 
-static void vcard_printf_datetime(GString *vcards,
+static void vcard_printf_datetime(GString *vcards, uint8_t format,
 					struct phonebook_contact *contact)
 {
 	const char *type;
@@ -528,11 +529,11 @@ void phonebook_add_contact(GString *vcards, struct phonebook_contact *contact,
 		vcard_printf_tag(vcards, format, "UID", NULL, contact->uid);
 
 	if (filter & FILTER_N)
-		vcard_printf_name(vcards, contact);
+		vcard_printf_name(vcards, format, contact);
 
 	if (filter & FILTER_FN && (*contact->fullname ||
 					format == FORMAT_VCARD30))
-		vcard_printf_fullname(vcards, contact->fullname);
+		vcard_printf_fullname(vcards, format, contact->fullname);
 
 	if (filter & FILTER_TEL) {
 		GSList *l = contact->numbers;
@@ -590,7 +591,7 @@ void phonebook_add_contact(GString *vcards, struct phonebook_contact *contact,
 							contact->photo);
 
 	if (filter & FILTER_ORG)
-		vcard_printf_org(vcards, contact);
+		vcard_printf_org(vcards, format, contact);
 
 	if (filter & FILTER_ROLE && *contact->role)
 		vcard_printf_tag(vcards, format, "ROLE", NULL, contact->role);
@@ -599,7 +600,7 @@ void phonebook_add_contact(GString *vcards, struct phonebook_contact *contact,
 		vcard_printf_tag(vcards, format, "TITLE", NULL, contact->title);
 
 	if (filter & FILTER_X_IRMC_CALL_DATETIME)
-		vcard_printf_datetime(vcards, contact);
+		vcard_printf_datetime(vcards, format, contact);
 
 	vcard_printf_end(vcards);
 }
-- 
1.6.3.3

