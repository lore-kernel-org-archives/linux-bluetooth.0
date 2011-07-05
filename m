Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd] Escape all text fields in vCard
Date: Tue,  5 Jul 2011 15:45:31 +0200
Message-Id: <1309873531-1418-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds previously missing escaping of some text attributes in vCards.
---
 plugins/vcard.c |   82 ++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 48 insertions(+), 34 deletions(-)

diff --git a/plugins/vcard.c b/plugins/vcard.c
index 4fb7b94..fd2dcba 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -124,6 +124,31 @@ static void add_slash(char *dest, const char *src, int len_max, int len)
 	return;
 }
 
+static void get_escaped_fields(char **fields, ...)
+{
+	va_list ap;
+	GString *line;
+	char *field;
+	char escaped[LEN_MAX];
+
+	va_start(ap, fields);
+	line = g_string_new("");
+
+	for (field = va_arg(ap, char *); field; ) {
+		add_slash(escaped, field, LEN_MAX, strlen(field));
+		g_string_append(line, escaped);
+
+		field = va_arg(ap, char *);
+
+		if (field)
+			g_string_append(line, ";");
+	}
+
+	va_end(ap);
+
+	*fields = g_string_free(line, FALSE);
+}
+
 static void vcard_printf_begin(GString *vcards, uint8_t format)
 {
 	vcard_printf(vcards, "BEGIN:VCARD");
@@ -177,6 +202,8 @@ gboolean address_fields_present(const char *address)
 static void vcard_printf_name(GString *vcards,
 					struct phonebook_contact *contact)
 {
+	char *fields;
+
 	if (contact_fields_present(contact) == FALSE) {
 		/* If fields are empty, add only 'N:' as parameter.
 		 * This is crucial for some devices (Nokia BH-903) which
@@ -189,9 +216,15 @@ static void vcard_printf_name(GString *vcards,
 		return;
 	}
 
-	vcard_printf(vcards, "N:%s;%s;%s;%s;%s", contact->family,
+
+	get_escaped_fields(&fields, contact->family,
 				contact->given, contact->additional,
-				contact->prefix, contact->suffix);
+				contact->prefix, contact->suffix,
+				NULL);
+
+	vcard_printf(vcards, "N:%s", fields);
+
+	g_free(fields);
 }
 
 static void vcard_printf_fullname(GString *vcards, const char *text)
@@ -256,34 +289,7 @@ static void vcard_printf_number(GString *vcards, uint8_t format,
 	vcard_printf(vcards, buf, number);
 }
 
-static void vcard_printf_tag(GString *vcards, uint8_t format, const char *tag,
-					const char *category, const char *fld)
-{
-	char *separator = "", *type = "";
-	char buf[LEN_MAX];
-
-	if (tag == NULL || strlen(tag) == 0)
-		return;
-
-	if (fld == NULL || strlen(fld) == 0){
-		vcard_printf(vcards, "%s:", tag);
-		return;
-	}
-
-	if (category && strlen(category)) {
-		separator = ";";
-		if (format == FORMAT_VCARD30)
-			type = "TYPE=";
-	} else {
-		category = "";
-	}
-
-	snprintf(buf, LEN_MAX, "%s%s%s%s", tag, separator, type, category);
-
-	vcard_printf(vcards, "%s:%s", buf, fld);
-}
-
-static void vcard_printf_slash_tag(GString *vcards, uint8_t format,
+static void vcard_printf_tag(GString *vcards, uint8_t format,
 					const char *tag, const char *category,
 					const char *fld)
 {
@@ -354,6 +360,7 @@ static void vcard_printf_url(GString *vcards, uint8_t format,
 					enum phonebook_field_type category)
 {
 	const char *category_string = "";
+	char *field[LEN_MAX];
 
 	if (!url || strlen(url) == 0) {
 		vcard_printf(vcards, "URL:");
@@ -381,7 +388,8 @@ static void vcard_printf_url(GString *vcards, uint8_t format,
 		break;
 	}
 
-	vcard_printf(vcards,"URL;%s:%s", category_string, url);
+	add_slash(field, url, LEN_MAX, strlen(url));
+	vcard_printf(vcards, "URL;%s:%s", category_string, field);
 }
 
 static gboolean org_fields_present(struct phonebook_contact *contact)
@@ -398,11 +406,17 @@ static gboolean org_fields_present(struct phonebook_contact *contact)
 static void vcard_printf_org(GString *vcards,
 					struct phonebook_contact *contact)
 {
+	char *fields;
+
 	if (org_fields_present(contact) == FALSE)
 		return;
 
-	vcard_printf(vcards, "ORG:%s;%s", contact->company,
-				contact->department);
+	get_escaped_fields(&fields, contact->company,
+			contact->department, NULL);
+
+	vcard_printf(vcards, "ORG:%s", fields);
+
+	g_free(fields);
 }
 
 static void vcard_printf_address(GString *vcards, uint8_t format,
@@ -553,7 +567,7 @@ void phonebook_add_contact(GString *vcards, struct phonebook_contact *contact,
 						contact->birthday);
 
 	if (filter & FILTER_NICKNAME && *contact->nickname)
-		vcard_printf_slash_tag(vcards, format, "NICKNAME", NULL,
+		vcard_printf_tag(vcards, format, "NICKNAME", NULL,
 							contact->nickname);
 
 	if (filter & FILTER_URL) {
-- 
1.7.4.1

