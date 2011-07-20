Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH obexd 6/6] Adjust escaping and encoding in vcard module
Date: Wed, 20 Jul 2011 09:11:47 +0200
Message-Id: <1311145907-3874-6-git-send-email-michalski.raf@gmail.com>
In-Reply-To: <1311145907-3874-5-git-send-email-michalski.raf@gmail.com>
References: <1311145907-3874-1-git-send-email-michalski.raf@gmail.com>
 <1311145907-3874-2-git-send-email-michalski.raf@gmail.com>
 <1311145907-3874-3-git-send-email-michalski.raf@gmail.com>
 <1311145907-3874-4-git-send-email-michalski.raf@gmail.com>
 <1311145907-3874-5-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch makes vcard module adjusted to escaping and encoding methods
depending on formatting vcard type and its properties field's content.
In general here are three possibilities (selection from escaping and
encoding methods is applied for each property separately):

default encoding and standard escaping method (for character set:
'\n', '\r', ';', ',', '\') - preferable for vcard 3.0

default encoding and only semicolon escaped - preferable for vcard 2.1
which property field does not contain newline character (and character
from set: '!', '"', '#', '$', '@', '[', '\', ']', '^', '`', '{', '|',
'}', '~' as well) - in this situation "quoted printable" encoding is not
taken into account

"quoted printable" encoding - preferable for vcard 2.1 which property
field contains newline character or character from set:
'!', '"', '#', '$', '@', '[', '\', ']', '^', '`', '{', '|', '}', '~'
Semicolon escaping is not taken into account since ';' character
(contained in property field) is always converted to "=3B" sequence.
---
 plugins/vcard.c |  183 +++++++++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 145 insertions(+), 38 deletions(-)

diff --git a/plugins/vcard.c b/plugins/vcard.c
index 3e978ee..df865ab 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -350,10 +350,11 @@ gboolean address_fields_present(const char *address)
 	return FALSE;
 }
 
-static void vcard_printf_name(GString *vcards,
+static void vcard_printf_name(GString *vcards, uint8_t format,
 					struct phonebook_contact *contact)
 {
 	char *fields;
+	struct encoding_type encoding;
 
 	if (contact_fields_present(contact) == FALSE) {
 		/* If fields are empty, add only 'N:' as parameter.
@@ -367,22 +368,45 @@ static void vcard_printf_name(GString *vcards,
 		return;
 	}
 
+	select_fields_encoding(format, &encoding, contact->family,
+					contact->given, contact->additional,
+					contact->prefix, contact->suffix, NULL);
 
-	get_escaped_fields(&fields, contact->family,
-				contact->given, contact->additional,
-				contact->prefix, contact->suffix,
-				NULL);
+	if (encoding.type == ENCODING_TYPE_DEFAULT) {
+		escape_handler escape = get_escape_handler(format);
 
-	vcard_printf(vcards, "N:%s", fields);
+		get_escaped_fields(escape, &fields, contact->family,
+					contact->given, contact->additional,
+					contact->prefix, contact->suffix, NULL);
 
-	g_free(fields);
+		vcard_printf(vcards, "N:%s", fields);
+
+		g_free(fields);
+	} else if (encoding.type == ENCODING_TYPE_QUOTED_PRINTABLE) {
+		vcard_printf(vcards, "N;%s:", encoding.text);
+		g_string_truncate(vcards, vcards->len - 2);
+		vcard_qp_fields_printf(vcards, contact->family, contact->given,
+					contact->additional, contact->prefix,
+					contact->suffix, NULL);
+	}
 }
 
-static void vcard_printf_fullname(GString *vcards, const char *text)
+static void vcard_printf_fullname(GString *vcards, uint8_t format,
+							const char *text)
 {
 	char field[LEN_MAX];
-	add_slash(field, text, LEN_MAX, strlen(text));
-	vcard_printf(vcards, "FN:%s", field);
+	struct encoding_type encoding;
+
+	select_fields_encoding(format, &encoding, text, NULL);
+
+	if (encoding.type == ENCODING_TYPE_DEFAULT) {
+		select_escape(format, field, text, LEN_MAX, strlen(text));
+		vcard_printf(vcards, "FN:%s", field);
+	} else if (encoding.type == ENCODING_TYPE_QUOTED_PRINTABLE) {
+		vcard_printf(vcards, "FN;%s:", encoding.text);
+		g_string_truncate(vcards, vcards->len - 2);
+		vcard_qp_fields_printf(vcards, text, NULL);
+	}
 }
 
 static void vcard_printf_number(GString *vcards, uint8_t format,
@@ -391,6 +415,7 @@ static void vcard_printf_number(GString *vcards, uint8_t format,
 {
 	const char *intl = "", *category_string = "";
 	char buf[128];
+	struct encoding_type encoding;
 
 	/* TEL is a mandatory field, include even if empty */
 	if (!number || !strlen(number) || !type) {
@@ -434,10 +459,19 @@ static void vcard_printf_number(GString *vcards, uint8_t format,
 	if ((type == TYPE_INTERNATIONAL) && (number[0] != '+'))
 		intl = "+";
 
-	snprintf(buf, sizeof(buf), "TEL;%s:%s%s", category_string,
-								intl, number);
+	select_fields_encoding(format, &encoding, number, NULL);
 
-	vcard_printf(vcards, "%s", buf);
+	if (encoding.type == ENCODING_TYPE_DEFAULT) {
+		snprintf(buf, sizeof(buf), "TEL;%s:%s%s", category_string,
+								intl, number);
+		vcard_printf(vcards, "%s", buf);
+	} else if (encoding.type == ENCODING_TYPE_QUOTED_PRINTABLE) {
+		snprintf(buf, sizeof(buf), "TEL;%s", category_string);
+		vcard_printf(vcards, "%s;%s:", buf, encoding.text);
+		g_string_truncate(vcards, vcards->len - 2);
+		snprintf(buf, sizeof(buf), "%s%s", intl, number);
+		vcard_qp_fields_printf(vcards, buf, NULL);
+	}
 }
 
 static void vcard_printf_tag(GString *vcards, uint8_t format,
@@ -447,6 +481,7 @@ static void vcard_printf_tag(GString *vcards, uint8_t format,
 	int len;
 	char *separator = "", *type = "";
 	char buf[LEN_MAX], field[LEN_MAX];
+	struct encoding_type encoding;
 
 	if (tag == NULL || strlen(tag) == 0)
 		return;
@@ -466,8 +501,16 @@ static void vcard_printf_tag(GString *vcards, uint8_t format,
 
 	snprintf(buf, LEN_MAX, "%s%s%s%s", tag, separator, type, category);
 
-	add_slash(field, fld, LEN_MAX, len);
-	vcard_printf(vcards, "%s:%s", buf, field);
+	select_fields_encoding(format, &encoding, fld, NULL);
+
+	if (encoding.type == ENCODING_TYPE_DEFAULT) {
+		select_escape(format, field, fld, LEN_MAX, len);
+		vcard_printf(vcards, "%s:%s", buf, field);
+	} else if (encoding.type == ENCODING_TYPE_QUOTED_PRINTABLE) {
+		vcard_printf(vcards, "%s;%s:", buf, encoding.text);
+		g_string_truncate(vcards, vcards->len - 2);
+		vcard_qp_fields_printf(vcards, fld, NULL);
+	}
 }
 
 static void vcard_printf_email(GString *vcards, uint8_t format,
@@ -477,6 +520,7 @@ static void vcard_printf_email(GString *vcards, uint8_t format,
 	const char *category_string = "";
 	char field[LEN_MAX];
 	int len = 0;
+	struct encoding_type encoding;
 
 	if (!address || !(len = strlen(address))) {
 		vcard_printf(vcards, "EMAIL:");
@@ -502,8 +546,17 @@ static void vcard_printf_email(GString *vcards, uint8_t format,
 			category_string = "TYPE=INTERNET";
 	}
 
-	add_slash(field, address, LEN_MAX, len);
-	vcard_printf(vcards, "EMAIL;%s:%s", category_string, field);
+	select_fields_encoding(format, &encoding, address, NULL);
+
+	if (encoding.type == ENCODING_TYPE_DEFAULT) {
+		select_escape(format, field, address, LEN_MAX, len);
+		vcard_printf(vcards, "EMAIL;%s:%s", category_string, field);
+	} else if (encoding.type == ENCODING_TYPE_QUOTED_PRINTABLE) {
+		vcard_printf(vcards, "EMAIL;%s;%s:",
+					category_string, encoding.text);
+		g_string_truncate(vcards, vcards->len - 2);
+		vcard_qp_fields_printf(vcards, address, NULL);
+	}
 }
 
 static void vcard_printf_url(GString *vcards, uint8_t format,
@@ -512,6 +565,7 @@ static void vcard_printf_url(GString *vcards, uint8_t format,
 {
 	const char *category_string = "";
 	char field[LEN_MAX];
+	struct encoding_type encoding;
 
 	if (!url || strlen(url) == 0) {
 		vcard_printf(vcards, "URL:");
@@ -539,8 +593,17 @@ static void vcard_printf_url(GString *vcards, uint8_t format,
 		break;
 	}
 
-	add_slash(field, url, LEN_MAX, strlen(url));
-	vcard_printf(vcards, "URL;%s:%s", category_string, field);
+	select_fields_encoding(format, &encoding, url, NULL);
+
+	if (encoding.type == ENCODING_TYPE_DEFAULT) {
+		select_escape(format, field, url, LEN_MAX, strlen(url));
+		vcard_printf(vcards, "URL;%s:%s", category_string, field);
+	} else if (encoding.type == ENCODING_TYPE_QUOTED_PRINTABLE) {
+		vcard_printf(vcards, "URL;%s;%s:",
+					category_string, encoding.text);
+		g_string_truncate(vcards, vcards->len - 2);
+		vcard_qp_fields_printf(vcards, url, NULL);
+	}
 }
 
 static gboolean org_fields_present(struct phonebook_contact *contact)
@@ -554,20 +617,33 @@ static gboolean org_fields_present(struct phonebook_contact *contact)
 	return FALSE;
 }
 
-static void vcard_printf_org(GString *vcards,
+static void vcard_printf_org(GString *vcards, uint8_t format,
 					struct phonebook_contact *contact)
 {
 	char *fields;
+	struct encoding_type encoding;
 
 	if (org_fields_present(contact) == FALSE)
 		return;
 
-	get_escaped_fields(&fields, contact->company,
-					contact->department, NULL);
+	select_fields_encoding(format, &encoding, contact->company,
+						contact->department, NULL);
+
+	if (encoding.type == ENCODING_TYPE_DEFAULT) {
+		escape_handler escape = get_escape_handler(format);
 
-	vcard_printf(vcards, "ORG:%s", fields);
+		get_escaped_fields(escape, &fields, contact->company,
+						contact->department, NULL);
 
-	g_free(fields);
+		vcard_printf(vcards, "ORG:%s", fields);
+
+		g_free(fields);
+	} else if (encoding.type == ENCODING_TYPE_QUOTED_PRINTABLE) {
+		vcard_printf(vcards, "ORG;%s:", encoding.text);
+		g_string_truncate(vcards, vcards->len - 2);
+		vcard_qp_fields_printf(vcards, contact->company,
+					contact->department, NULL);
+	}
 }
 
 static void vcard_printf_address(GString *vcards, uint8_t format,
@@ -579,6 +655,7 @@ static void vcard_printf_address(GString *vcards, uint8_t format,
 	const char *category_string = "";
 	int len, i;
 	gchar **address_fields;
+	struct encoding_type encoding;
 
 	if (!address || address_fields_present(address) == FALSE) {
 		vcard_printf(vcards, "ADR:");
@@ -608,22 +685,43 @@ static void vcard_printf_address(GString *vcards, uint8_t format,
 
 	address_fields = g_strsplit(address, ";", ADDR_FIELD_AMOUNT);
 
-	for (i = 0; i < ADDR_FIELD_AMOUNT; ++i) {
-		len = strlen(address_fields[i]);
-		add_slash(field[i], address_fields[i], LEN_MAX, len);
+	select_fields_encoding(format, &encoding, address_fields[0],
+					address_fields[1], address_fields[2],
+					address_fields[3], address_fields[4],
+					address_fields[5], address_fields[6],
+					NULL);
+
+	if (encoding.type == ENCODING_TYPE_DEFAULT) {
+		for (i = 0; i < ADDR_FIELD_AMOUNT; ++i) {
+			len = strlen(address_fields[i]);
+			select_escape(format, field[i], address_fields[i],
+								LEN_MAX, len);
+		}
+
+		snprintf(buf, LEN_MAX, "%s;%s;%s;%s;%s;%s;%s",
+					field[0], field[1], field[2], field[3],
+					field[4], field[5], field[6]);
+
+		vcard_printf(vcards,"ADR;%s:%s", category_string, buf);
+	} else if (encoding.type == ENCODING_TYPE_QUOTED_PRINTABLE) {
+		vcard_printf(vcards, "ADR;%s;%s:",
+					category_string, encoding.text);
+		g_string_truncate(vcards, vcards->len - 2);
+		vcard_qp_fields_printf(vcards, address_fields[0],
+					address_fields[1], address_fields[2],
+					address_fields[3], address_fields[4],
+					address_fields[5], address_fields[6],
+					NULL);
 	}
 
-	snprintf(buf, LEN_MAX, "%s;%s;%s;%s;%s;%s;%s",
-	field[0], field[1], field[2], field[3], field[4], field[5], field[6]);
 	g_strfreev(address_fields);
-
-	vcard_printf(vcards,"ADR;%s:%s", category_string, buf);
 }
 
-static void vcard_printf_datetime(GString *vcards,
+static void vcard_printf_datetime(GString *vcards, uint8_t format,
 					struct phonebook_contact *contact)
 {
 	const char *type;
+	struct encoding_type encoding;
 
 	switch (contact->calltype) {
 	case CALL_TYPE_MISSED:
@@ -643,8 +741,17 @@ static void vcard_printf_datetime(GString *vcards,
 		return;
 	}
 
-	vcard_printf(vcards, "X-IRMC-CALL-DATETIME;%s:%s", type,
-							contact->datetime);
+	select_fields_encoding(format, &encoding, contact->datetime, NULL);
+
+	if (encoding.type == ENCODING_TYPE_DEFAULT) {
+		vcard_printf(vcards, "X-IRMC-CALL-DATETIME;%s:%s",
+						type, contact->datetime);
+	} else if (encoding.type == ENCODING_TYPE_QUOTED_PRINTABLE) {
+		vcard_printf(vcards, "X-IRMC-CALL-DATETIME;%s;%s:",
+							type, encoding.text);
+		g_string_truncate(vcards, vcards->len - 2);
+		vcard_qp_fields_printf(vcards, contact->datetime, NULL);
+	}
 }
 
 static void vcard_printf_end(GString *vcards)
@@ -672,11 +779,11 @@ void phonebook_add_contact(GString *vcards, struct phonebook_contact *contact,
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
@@ -735,7 +842,7 @@ void phonebook_add_contact(GString *vcards, struct phonebook_contact *contact,
 							contact->photo);
 
 	if (filter & FILTER_ORG)
-		vcard_printf_org(vcards, contact);
+		vcard_printf_org(vcards, format, contact);
 
 	if (filter & FILTER_ROLE && *contact->role)
 		vcard_printf_tag(vcards, format, "ROLE", NULL, contact->role);
@@ -744,7 +851,7 @@ void phonebook_add_contact(GString *vcards, struct phonebook_contact *contact,
 		vcard_printf_tag(vcards, format, "TITLE", NULL, contact->title);
 
 	if (filter & FILTER_X_IRMC_CALL_DATETIME)
-		vcard_printf_datetime(vcards, contact);
+		vcard_printf_datetime(vcards, format, contact);
 
 	vcard_printf_end(vcards);
 }
-- 
1.6.3.3

