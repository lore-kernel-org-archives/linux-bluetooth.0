Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH obexd v2] Support for encoding UTF-8 characters in vCard's fields
Date: Wed, 12 Oct 2011 11:56:08 +0200
Message-Id: <1318413368-30795-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch provides additional condition for selection of Quoted Printable
encoding (for vCard's 2.1 fields). It will be satisfied if there is any
byte which value is out of range standard ASCII set. Such byte may be
a part of sequence (composed of more than single byte) for non-standard
characters specified by UTF-8 and if detected, CHARSET parameter for
property is set as "UTF-8".
This fix is required since without such improvement some carkits may
display non-standard characters incorrectly (for instance they may be
omitted completely).
---
 plugins/vcard.c |   48 ++++++++++++++++++++++++++++++++++++++++++++++--
 1 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/plugins/vcard.c b/plugins/vcard.c
index dc20a77..743f19f 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -82,6 +82,7 @@
 #define QP_ESC 0x5C
 #define QP_SOFT_LINE_BREAK "="
 #define QP_SELECT "\n!\"#$=@[\\]^`{|}~"
+#define ASCII_LIMIT 0x7F
 
 /* according to RFC 2425, the output string may need folding */
 static void vcard_printf(GString *str, const char *fmt, ...)
@@ -255,12 +256,41 @@ static void append_qp_new_line(GString *vcards, size_t *limit)
 	append_qp_break_line(vcards, limit);
 }
 
+static gboolean utf8_select(const char *field)
+{
+	const char *pos;
+
+	if (g_utf8_validate(field, -1, NULL) == FALSE)
+		return FALSE;
+
+	for (pos = field; *pos != '\0'; pos = g_utf8_next_char(pos)) {
+		/* Test for non-standard UTF-8 character (out of range
+		 * standard ASCII set), composed of more than single byte
+		 * and represented by 32-bit value greater than 0x7F */
+		if (g_utf8_get_char(pos) > ASCII_LIMIT)
+			return TRUE;
+	}
+
+	return FALSE;
+}
+
 static void vcard_qp_print_encoded(GString *vcards, const char *desc, ...)
 {
-	char *field;
+	const char *field, *charset = "";
 	va_list ap;
 
-	vcard_printf(vcards, "%s;ENCODING=QUOTED-PRINTABLE:", desc);
+	va_start(ap, desc);
+
+	for (field = va_arg(ap, char *); field; field = va_arg(ap, char *)) {
+		if (utf8_select(field) == TRUE) {
+			charset = ";CHARSET=UTF-8";
+			break;
+		}
+	}
+
+	va_end(ap);
+
+	vcard_printf(vcards, "%s;ENCODING=QUOTED-PRINTABLE%s:", desc, charset);
 	g_string_truncate(vcards, vcards->len - 2);
 
 	va_start(ap, desc);
@@ -307,10 +337,24 @@ static gboolean select_qp_encoding(uint8_t format, ...)
 	va_start(ap, format);
 
 	for (field = va_arg(ap, char *); field; field = va_arg(ap, char *)) {
+		int i;
+		unsigned char c;
+
 		if (strpbrk(field, QP_SELECT)) {
 			va_end(ap);
 			return TRUE;
 		}
+
+		/* Quoted Printable encoding is selected if there is
+		 * a character, which value is out of range standard
+		 * ASCII set, since it may be a part of some
+		 * non-standard character such as specified by UTF-8 */
+		for (i = 0; (c = field[i]) != '\0'; ++i) {
+			if (c > ASCII_LIMIT) {
+				va_end(ap);
+				return TRUE;
+			}
+		}
 	}
 
 	va_end(ap);
-- 
1.6.3.3

