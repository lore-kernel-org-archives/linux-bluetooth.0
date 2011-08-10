Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH obexd v2] Support for Quoted Printable encoding
Date: Wed, 10 Aug 2011 16:14:06 +0200
Message-Id: <1312985646-15061-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to vCard 2.1 specification, this patch provides Quoted Printable
encoding (described in RFC1521 document), which is specific for vcard 2.1
formatting and should be preferable for instance, if vcard's property field
contains newline character (encoded to "=0D=0A" sequence).
In general all characters can be replaced with "=<Hex>" where "<Hex>"
is the 2-character hexadecimal representation of the character's decimal value.
Characters with decimal values of 33 through 60 inclusive, and 62 through 126,
inclusive, may be represented as the ASCII characters.
Quoted-Printable lines of text must also be limited to less than 76 characters
(max 75 characters terminated by soft line break). For longer lines soft line
breaks must be used - an equal sign as the last character (61 decimal value)
on a encoded line indicates such soft line break in the encoded text.

In this case, Quoted Printable is selected, if vcard's 2.1 value property
field contains newline character or some specific ASCII character from set:
'!', '"', '#', '$', '@', '[', '\', ']', '^', '`', '{', '|', '}', '~'.
(these will be encoded if occur in property value).

Equal sign (61 decimal value) character in property value is always encoded
(it is mandatory) since it is special character used for encoding characters
and indicating soft line breaks.

Horizontal tab (9 decimal value) and space (32 decimal value) characters are
encoded only if they are not followed by any other character.

According to vCard 2.1 specification semicolon (if in property value occured)
character (59 decimal value) must be escaped with backslash character
(92 decimal value).
---
 plugins/vcard.c |  213 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 202 insertions(+), 11 deletions(-)

diff --git a/plugins/vcard.c b/plugins/vcard.c
index 5a5bcf4..51060a1 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -75,6 +75,14 @@
 #define FORMAT_VCARD21 0x00
 #define FORMAT_VCARD30 0x01
 
+#define QP_LINE_LEN 75
+#define QP_CHAR_LEN 3
+#define QP_SELECT "\n!\"#$@[\\]^`{|}~"
+#define QP_SOFT_BREAK "="
+#define QP_SUBSET QP_SELECT QP_SOFT_BREAK
+#define QP_CR 0x0D
+#define QP_LF 0x0A
+
 /* according to RFC 2425, the output string may need folding */
 static void vcard_printf(GString *str, const char *fmt, ...)
 {
@@ -169,6 +177,121 @@ static void get_escaped_fields(char **fields, ...)
 	*fields = g_string_free(line, FALSE);
 }
 
+static gboolean qp_set(char c)
+{
+	int i;
+	unsigned char q = c;
+
+	for (i = 0; QP_SUBSET[i] != '\0' && q != QP_SUBSET[i]; ++i);
+
+	if (QP_SUBSET[i] != '\0')
+		return TRUE;
+
+	if (q != '\t' && q != ' ' && (q < '!' || q > '~'))
+		return TRUE;
+
+	return FALSE;
+}
+
+static void append_qp_break_line(GString *vcards, size_t *limit)
+{
+	g_string_append(vcards, QP_SOFT_BREAK);
+	g_string_append(vcards, "\r\n ");
+	*limit = QP_LINE_LEN - 1;
+}
+
+static void append_qp_ascii(GString *vcards, size_t *limit, char c)
+{
+	if (*limit == 0)
+		append_qp_break_line(vcards, limit);
+
+	g_string_append_c(vcards, c);
+	--*limit;
+}
+
+static void append_qp_hex(GString *vcards, size_t *limit, char c)
+{
+	if (*limit < QP_CHAR_LEN)
+		append_qp_break_line(vcards, limit);
+
+	g_string_append_printf(vcards, "=%2.2X", (unsigned char) c);
+	*limit -= QP_CHAR_LEN;
+}
+
+static void vcard_qp_print_encoded(GString *vcards, const char *desc, ...)
+{
+	size_t i, size, limit = QP_LINE_LEN;
+	char *field, last;
+	va_list ap;
+
+	vcard_printf(vcards, "%s;ENCODING=QUOTED-PRINTABLE:", desc);
+	g_string_truncate(vcards, vcards->len - 2);
+
+	va_start(ap, desc);
+
+	for (field = va_arg(ap, char *); field; ) {
+		size = strlen(field);
+
+		for (i = 0; i < size; ++i) {
+			if (field[i] == '\n') {
+				append_qp_hex(vcards, &limit, QP_CR);
+				append_qp_hex(vcards, &limit, QP_LF);
+			} else if (qp_set(field[i])) {
+				append_qp_hex(vcards, &limit, field[i]);
+			} else {
+				/* semicolon character in a property
+				 * parameter value must be escaped with
+				 * backslash character
+				 */
+				if (field[i] == ';')
+					append_qp_ascii(vcards, &limit, '\\');
+
+				append_qp_ascii(vcards, &limit, field[i]);
+			}
+		}
+
+		last = field[size - 1];
+		field = va_arg(ap, char *);
+		if (field) {
+			append_qp_ascii(vcards, &limit, ';');
+		} else if (last == '\t' || last == ' ') {
+			/* space and tab character not followed by any other
+			 * character must be always encoded
+			 */
+			++limit;
+			g_string_truncate(vcards, vcards->len - 1);
+			append_qp_hex(vcards, &limit, last);
+		}
+	}
+
+	va_end(ap);
+
+	g_string_append(vcards, "\r\n");
+}
+
+static gboolean select_qp_encoding(uint8_t format, ...)
+{
+	char *field;
+	va_list ap;
+
+	if (format == FORMAT_VCARD21) {
+		va_start(ap, format);
+
+		for (field = va_arg(ap, char *); field; ) {
+			if (strpbrk(field, QP_SELECT)) {
+				va_end(ap);
+				return TRUE;
+			}
+
+			field = va_arg(ap, char *);
+		}
+
+		va_end(ap);
+	}
+
+	return FALSE;
+}
+
 static void vcard_printf_begin(GString *vcards, uint8_t format)
 {
 	vcard_printf(vcards, "BEGIN:VCARD");
@@ -219,7 +342,7 @@ gboolean address_fields_present(const char *address)
 	return FALSE;
 }
 
-static void vcard_printf_name(GString *vcards,
+static void vcard_printf_name(GString *vcards, uint8_t format,
 					struct phonebook_contact *contact)
 {
 	char *fields;
@@ -236,6 +359,15 @@ static void vcard_printf_name(GString *vcards,
 		return;
 	}
 
+	if (select_qp_encoding(format, contact->family, contact->given,
+					contact->additional, contact->prefix,
+					contact->suffix, NULL)) {
+		vcard_qp_print_encoded(vcards, "N", contact->family,
+					contact->given, contact->additional,
+					contact->prefix, contact->suffix,
+					NULL);
+		return;
+	}
 
 	get_escaped_fields(&fields, contact->family,
 				contact->given, contact->additional,
@@ -247,9 +379,16 @@ static void vcard_printf_name(GString *vcards,
 	g_free(fields);
 }
 
-static void vcard_printf_fullname(GString *vcards, const char *text)
+static void vcard_printf_fullname(GString *vcards, uint8_t format,
+							const char *text)
 {
 	char field[LEN_MAX];
+
+	if (select_qp_encoding(format, text, NULL)) {
+		vcard_qp_print_encoded(vcards, "FN", text, NULL);
+		return;
+	}
+
 	add_slash(field, text, LEN_MAX, strlen(text));
 	vcard_printf(vcards, "FN:%s", field);
 }
@@ -259,7 +398,7 @@ static void vcard_printf_number(GString *vcards, uint8_t format,
 					enum phonebook_number_type category)
 {
 	const char *intl = "", *category_string = "";
-	char buf[128];
+	char buf[128], field[LEN_MAX];
 
 	/* TEL is a mandatory field, include even if empty */
 	if (!number || !strlen(number) || !type) {
@@ -303,6 +442,13 @@ static void vcard_printf_number(GString *vcards, uint8_t format,
 	if ((type == TYPE_INTERNATIONAL) && (number[0] != '+'))
 		intl = "+";
 
+	if (select_qp_encoding(format, number, NULL)) {
+		snprintf(buf, sizeof(buf), "TEL;%s", category_string);
+		snprintf(field, sizeof(field), "%s%s", intl, number);
+		vcard_qp_print_encoded(vcards, buf, field, NULL);
+		return;
+	}
+
 	snprintf(buf, sizeof(buf), "TEL;%s:%s\%s", category_string,
 								intl, number);
 
@@ -335,6 +481,11 @@ static void vcard_printf_tag(GString *vcards, uint8_t format,
 
 	snprintf(buf, LEN_MAX, "%s%s%s%s", tag, separator, type, category);
 
+	if (select_qp_encoding(format, fld, NULL)) {
+		vcard_qp_print_encoded(vcards, buf, fld, NULL);
+		return;
+	}
+
 	add_slash(field, fld, LEN_MAX, len);
 	vcard_printf(vcards, "%s:%s", buf, field);
 }
@@ -344,7 +495,7 @@ static void vcard_printf_email(GString *vcards, uint8_t format,
 					enum phonebook_field_type category)
 {
 	const char *category_string = "";
-	char field[LEN_MAX];
+	char buf[LEN_MAX], field[LEN_MAX];
 	int len = 0;
 
 	if (!address || !(len = strlen(address))) {
@@ -371,6 +522,12 @@ static void vcard_printf_email(GString *vcards, uint8_t format,
 			category_string = "TYPE=INTERNET;TYPE=OTHER";
 	}
 
+	if (select_qp_encoding(format, address, NULL)) {
+		snprintf(buf, sizeof(buf), "EMAIL;%s", category_string);
+		vcard_qp_print_encoded(vcards, buf, address, NULL);
+		return;
+	}
+
 	add_slash(field, address, LEN_MAX, len);
 	vcard_printf(vcards, "EMAIL;%s:%s", category_string, field);
 }
@@ -380,7 +537,7 @@ static void vcard_printf_url(GString *vcards, uint8_t format,
 					enum phonebook_field_type category)
 {
 	const char *category_string = "";
-	char field[LEN_MAX];
+	char buf[LEN_MAX], field[LEN_MAX];
 
 	if (!url || strlen(url) == 0) {
 		vcard_printf(vcards, "URL:");
@@ -408,6 +565,12 @@ static void vcard_printf_url(GString *vcards, uint8_t format,
 		break;
 	}
 
+	if (select_qp_encoding(format, url, NULL)) {
+		snprintf(buf, sizeof(buf), "URL;%s", category_string);
+		vcard_qp_print_encoded(vcards, buf, url, NULL);
+		return;
+	}
+
 	add_slash(field, url, LEN_MAX, strlen(url));
 	vcard_printf(vcards, "URL;%s:%s", category_string, field);
 }
@@ -423,7 +586,7 @@ static gboolean org_fields_present(struct phonebook_contact *contact)
 	return FALSE;
 }
 
-static void vcard_printf_org(GString *vcards,
+static void vcard_printf_org(GString *vcards, uint8_t format,
 					struct phonebook_contact *contact)
 {
 	char *fields;
@@ -431,6 +594,13 @@ static void vcard_printf_org(GString *vcards,
 	if (org_fields_present(contact) == FALSE)
 		return;
 
+	if (select_qp_encoding(format, contact->company,
+						contact->department, NULL)) {
+		vcard_qp_print_encoded(vcards, "ORG", contact->company,
+						contact->department, NULL);
+		return;
+	}
+
 	get_escaped_fields(&fields, contact->company,
 					contact->department, NULL);
 
@@ -477,6 +647,20 @@ static void vcard_printf_address(GString *vcards, uint8_t format,
 
 	address_fields = g_strsplit(address, ";", ADDR_FIELD_AMOUNT);
 
+	if (select_qp_encoding(format, address_fields[0], address_fields[1],
+					address_fields[2], address_fields[3],
+					address_fields[4], address_fields[5],
+					address_fields[6], NULL)) {
+		snprintf(buf, sizeof(buf), "ADR;%s", category_string);
+		vcard_qp_print_encoded(vcards, buf,
+					address_fields[0], address_fields[1],
+					address_fields[2], address_fields[3],
+					address_fields[4], address_fields[5],
+					address_fields[6], NULL);
+		g_strfreev(address_fields);
+		return;
+	}
+
 	for (i = 0; i < ADDR_FIELD_AMOUNT; ++i) {
 		len = strlen(address_fields[i]);
 		add_slash(field[i], address_fields[i], LEN_MAX, len);
@@ -489,10 +673,11 @@ static void vcard_printf_address(GString *vcards, uint8_t format,
 	vcard_printf(vcards,"ADR;%s:%s", category_string, buf);
 }
 
-static void vcard_printf_datetime(GString *vcards,
+static void vcard_printf_datetime(GString *vcards, uint8_t format,
 					struct phonebook_contact *contact)
 {
 	const char *type;
+	char buf[LEN_MAX];
 
 	switch (contact->calltype) {
 	case CALL_TYPE_MISSED:
@@ -512,6 +697,12 @@ static void vcard_printf_datetime(GString *vcards,
 		return;
 	}
 
+	if (select_qp_encoding(format, contact->datetime, NULL)) {
+		snprintf(buf, sizeof(buf), "X-IRMC-CALL-DATETIME;%s", type);
+		vcard_qp_print_encoded(vcards, buf, contact->datetime, NULL);
+		return;
+	}
+
 	vcard_printf(vcards, "X-IRMC-CALL-DATETIME;%s:%s", type,
 							contact->datetime);
 }
@@ -541,11 +732,11 @@ void phonebook_add_contact(GString *vcards, struct phonebook_contact *contact,
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
@@ -604,7 +795,7 @@ void phonebook_add_contact(GString *vcards, struct phonebook_contact *contact,
 							contact->photo);
 
 	if (filter & FILTER_ORG)
-		vcard_printf_org(vcards, contact);
+		vcard_printf_org(vcards, format, contact);
 
 	if (filter & FILTER_ROLE && *contact->role)
 		vcard_printf_tag(vcards, format, "ROLE", NULL, contact->role);
@@ -613,7 +804,7 @@ void phonebook_add_contact(GString *vcards, struct phonebook_contact *contact,
 		vcard_printf_tag(vcards, format, "TITLE", NULL, contact->title);
 
 	if (filter & FILTER_X_IRMC_CALL_DATETIME)
-		vcard_printf_datetime(vcards, contact);
+		vcard_printf_datetime(vcards, format, contact);
 
 	vcard_printf_end(vcards);
 }
-- 
1.6.3.3

