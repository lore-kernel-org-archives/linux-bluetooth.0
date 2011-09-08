Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH obexd v3 3/3] Support for Quoted Printable encoding
Date: Thu,  8 Sep 2011 15:12:20 +0200
Message-Id: <1315487540-16607-3-git-send-email-michalski.raf@gmail.com>
In-Reply-To: <1315487540-16607-2-git-send-email-michalski.raf@gmail.com>
References: <1315487540-16607-1-git-send-email-michalski.raf@gmail.com>
 <1315487540-16607-2-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to vCard 2.1 specification, this patch provides Quoted Printable
encoding (described in RFC1521 document), which is specific for vCard 2.1
formatting and should be preferable for instance, if vcard's property
field contains multiple lines (vCard's 2.1 spec. says: Multiple lines
of formatted text are separated with a Quoted Printable CRLF sequence
of "=0D" followed by "=0A" followed by a Quoted Printable softline
break sequence of "=").

In general all characters can be replaced with "=<Hex>" where "<Hex>"
is the 2-character hexadecimal representation of the character's decimal
value. Characters with decimal values of 33 through 60 inclusive, and 62
through 126, inclusive, may be represented as the ASCII characters.

Quoted Printable lines of text must also be limited to less than 76
characters. For longer lines soft line breaks must be used - an equal sign
as the last character on a encoded line indicates such soft line break
in the encoded text.

In this case, Quoted Printable is selected, if vCard's 2.1 field contains
newline character or some specific ASCII character from set:
'!', '"', '#', '$', '@', '[', '\', ']', '^', '`', '{', '|', '}', '~'.
(it is not mandatory but each character from this set will be encoded
as Quoted Printable spec. suggests).

Equal sign character in vCard's field is always encoded (it is mandatory
and Quoted Printable encoding is taken into account if this character present
in vCard's field) since it is special character used for encoding characters
and indicating soft line breaks.

Horizontal tab and space characters are always encoded. It's mandatory only
if they are not followed by any other character. Always encoding makes
simplification, since we don't need to care about position of these characters.

According to vCard 2.1 specification semicolon character, present in vCard's
field, must be escaped with backslash character. Since backslash is always
encoded it gives sequence "=5C;" (instead of "\;").
---
 plugins/vcard.c |  199 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 196 insertions(+), 3 deletions(-)

diff --git a/plugins/vcard.c b/plugins/vcard.c
index b694438..0522c96 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -75,6 +75,14 @@
 #define FORMAT_VCARD21 0x00
 #define FORMAT_VCARD30 0x01
 
+#define QP_LINE_LEN 75
+#define QP_CHAR_LEN 3
+#define QP_CR 0x0D
+#define QP_LF 0x0A
+#define QP_ESC 0x5C
+#define QP_SOFT_LINE_BREAK "="
+#define QP_SELECT "\n!\"#$=@[\\]^`{|}~"
+
 /* according to RFC 2425, the output string may need folding */
 static void vcard_printf(GString *str, const char *fmt, ...)
 {
@@ -196,6 +204,120 @@ static void get_escaped_fields(uint8_t format, char **fields, ...)
 	*fields = g_string_free(line, FALSE);
 }
 
+static gboolean set_qp_encoding(char c)
+{
+	unsigned char q = c;
+
+	if (strchr(QP_SELECT, q) != NULL)
+		return TRUE;
+
+	if (q < '!' || q > '~')
+		return TRUE;
+
+	return FALSE;
+}
+
+static void append_qp_break_line(GString *vcards, size_t *limit)
+{
+	/* Quoted Printable lines of text must be limited to less than 76
+	 * characters and terminated by Quoted Printable softline break
+	 * sequence of "=" (if some more characters left) */
+	g_string_append(vcards, QP_SOFT_LINE_BREAK);
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
+static void append_qp_new_line(GString *vcards, size_t *limit)
+{
+	/* Multiple lines of text are separated with a Quoted Printable CRLF
+	 * sequence of "=0D" followed by "=0A" followed by a Quoted Printable
+	 * softline break sequence of "=" */
+	append_qp_hex(vcards, limit, QP_CR);
+	append_qp_hex(vcards, limit, QP_LF);
+	append_qp_break_line(vcards, limit);
+}
+
+static void vcard_qp_print_encoded(GString *vcards, const char *desc, ...)
+{
+	size_t i, size, limit = QP_LINE_LEN;
+	char *field;
+	va_list ap;
+
+	vcard_printf(vcards, "%s;ENCODING=QUOTED-PRINTABLE:", desc);
+	g_string_truncate(vcards, vcards->len - 2);
+
+	va_start(ap, desc);
+
+	for (field = va_arg(ap, char *); field; ) {
+		size = strlen(field);
+		for (i = 0; i < size; ++i) {
+			if (set_qp_encoding(field[i])) {
+				if (field[i] == '\n') {
+					append_qp_new_line(vcards, &limit);
+					continue;
+				}
+
+				append_qp_hex(vcards, &limit, field[i]);
+			} else {
+				/* According to vCard 2.1 spec. semicolons in
+				 * property parameter value must be escaped */
+				if (field[i] == ';')
+					append_qp_hex(vcards, &limit, QP_ESC);
+
+				append_qp_ascii(vcards, &limit, field[i]);
+			}
+		}
+
+		field = va_arg(ap, char *);
+		if (field)
+			append_qp_ascii(vcards, &limit, ';');
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
@@ -245,6 +367,15 @@ static void vcard_printf_name(GString *vcards, uint8_t format,
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
 
 	get_escaped_fields(format, &fields, contact->family,
 				contact->given, contact->additional,
@@ -260,6 +391,12 @@ static void vcard_printf_fullname(GString *vcards, uint8_t format,
 							const char *text)
 {
 	char field[LEN_MAX];
+
+	if (select_qp_encoding(format, text, NULL)) {
+		vcard_qp_print_encoded(vcards, "FN", text, NULL);
+		return;
+	}
+
 	set_escape(format, field, text, LEN_MAX, strlen(text));
 	vcard_printf(vcards, "FN:%s", field);
 }
@@ -269,7 +406,7 @@ static void vcard_printf_number(GString *vcards, uint8_t format,
 					enum phonebook_number_type category)
 {
 	const char *intl = "", *category_string = "";
-	char buf[128];
+	char buf[128], field[LEN_MAX];
 
 	/* TEL is a mandatory field, include even if empty */
 	if (!number || !strlen(number) || !type) {
@@ -313,6 +450,13 @@ static void vcard_printf_number(GString *vcards, uint8_t format,
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
 
@@ -345,6 +489,11 @@ static void vcard_printf_tag(GString *vcards, uint8_t format,
 
 	snprintf(buf, LEN_MAX, "%s%s%s%s", tag, separator, type, category);
 
+	if (select_qp_encoding(format, fld, NULL)) {
+		vcard_qp_print_encoded(vcards, buf, fld, NULL);
+		return;
+	}
+
 	set_escape(format, field, fld, LEN_MAX, len);
 	vcard_printf(vcards, "%s:%s", buf, field);
 }
@@ -354,7 +503,7 @@ static void vcard_printf_email(GString *vcards, uint8_t format,
 					enum phonebook_field_type category)
 {
 	const char *category_string = "";
-	char field[LEN_MAX];
+	char buf[LEN_MAX], field[LEN_MAX];
 	int len = 0;
 
 	if (!address || !(len = strlen(address))) {
@@ -381,6 +530,12 @@ static void vcard_printf_email(GString *vcards, uint8_t format,
 			category_string = "TYPE=INTERNET;TYPE=OTHER";
 	}
 
+	if (select_qp_encoding(format, address, NULL)) {
+		snprintf(buf, sizeof(buf), "EMAIL;%s", category_string);
+		vcard_qp_print_encoded(vcards, buf, address, NULL);
+		return;
+	}
+
 	set_escape(format, field, address, LEN_MAX, len);
 	vcard_printf(vcards, "EMAIL;%s:%s", category_string, field);
 }
@@ -390,7 +545,7 @@ static void vcard_printf_url(GString *vcards, uint8_t format,
 					enum phonebook_field_type category)
 {
 	const char *category_string = "";
-	char field[LEN_MAX];
+	char buf[LEN_MAX], field[LEN_MAX];
 
 	if (!url || strlen(url) == 0) {
 		vcard_printf(vcards, "URL:");
@@ -418,6 +573,12 @@ static void vcard_printf_url(GString *vcards, uint8_t format,
 		break;
 	}
 
+	if (select_qp_encoding(format, url, NULL)) {
+		snprintf(buf, sizeof(buf), "URL;%s", category_string);
+		vcard_qp_print_encoded(vcards, buf, url, NULL);
+		return;
+	}
+
 	set_escape(format, field, url, LEN_MAX, strlen(url));
 	vcard_printf(vcards, "URL;%s:%s", category_string, field);
 }
@@ -441,6 +602,13 @@ static void vcard_printf_org(GString *vcards, uint8_t format,
 	if (org_fields_present(contact) == FALSE)
 		return;
 
+	if (select_qp_encoding(format, contact->company,
+						contact->department, NULL)) {
+		vcard_qp_print_encoded(vcards, "ORG", contact->company,
+						contact->department, NULL);
+		return;
+	}
+
 	get_escaped_fields(format, &fields, contact->company,
 					contact->department, NULL);
 
@@ -454,6 +622,8 @@ static void vcard_printf_address(GString *vcards, uint8_t format,
 {
 	char *fields, field_esc[LEN_MAX];
 	const char *category_string = "";
+	char buf[LEN_MAX], *address_fields[ADDR_FIELD_AMOUNT];
+	int i;
 	size_t len;
 	GSList *l;
 
@@ -483,6 +653,22 @@ static void vcard_printf_address(GString *vcards, uint8_t format,
 		break;
 	}
 
+	for (i = 0, l = address->fields; l; l = l->next)
+		address_fields[i++] = l->data;
+
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
+		return;
+	}
+
 	/* allocate enough memory to insert address fields separated by ';'
 	 * and terminated by '\0' */
 	len = ADDR_FIELD_AMOUNT * LEN_MAX;
@@ -508,6 +694,7 @@ static void vcard_printf_datetime(GString *vcards, uint8_t format,
 					struct phonebook_contact *contact)
 {
 	const char *type;
+	char buf[LEN_MAX];
 
 	switch (contact->calltype) {
 	case CALL_TYPE_MISSED:
@@ -527,6 +714,12 @@ static void vcard_printf_datetime(GString *vcards, uint8_t format,
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
-- 
1.6.3.3

