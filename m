Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH obexd 3/6] Support for "quoted printable" encoding
Date: Wed, 20 Jul 2011 09:11:44 +0200
Message-Id: <1311145907-3874-3-git-send-email-michalski.raf@gmail.com>
In-Reply-To: <1311145907-3874-2-git-send-email-michalski.raf@gmail.com>
References: <1311145907-3874-1-git-send-email-michalski.raf@gmail.com>
 <1311145907-3874-2-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Accoridng to vcard 2.1 specification, this patch provides
"quoted printable" encoding (described in RFC1521 document), which is
specific for vcard 2.1 formatting and should be preferable for instance,
if vcard's property field contains newline character.
---
 plugins/vcard.c |   84 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 plugins/vcard.h |    5 +++
 2 files changed, 89 insertions(+), 0 deletions(-)

diff --git a/plugins/vcard.c b/plugins/vcard.c
index 544ea82..e2bbf4e 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -70,6 +70,15 @@
 #define FORMAT_VCARD21 0x00
 #define FORMAT_VCARD30 0x01
 
+#define QP_LINE_LEN 75
+#define QP_SELECT "\n!\"#$@[\\]^`{|}~"
+#define QP_ALWAYS "\t ;="
+#define QP_SUBSET QP_SELECT QP_ALWAYS
+#define QP_CR 0x0D
+#define QP_LF 0x0A
+#define QP_SOFT_BREAK "="
+#define QP_CHAR_LEN 3
+
 typedef void (*escape_handler)
 			(char *dest, const char *src, int len_max, int len);
 
@@ -190,6 +199,81 @@ static void select_escape(uint8_t format, char *dest, const char *src,
 	}
 }
 
+static gboolean qp_set(char c)
+{
+	unsigned char q = c;
+	int i;
+
+	for (i = 0; QP_SUBSET[i] != '\0' && q != QP_SUBSET[i]; i++);
+
+	if (QP_SUBSET[i] != '\0' || q < 0x20 || q > 0x7E)
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
+	char hex[QP_CHAR_LEN + 1];
+
+	snprintf(hex, QP_CHAR_LEN + 1, "=%2.2X", (unsigned char) c);
+
+	if (*limit < QP_CHAR_LEN)
+		append_qp_break_line(vcards, limit);
+
+	g_string_append(vcards, hex);
+	*limit -= QP_CHAR_LEN;
+}
+
+static void vcard_qp_fields_printf(GString *vcards, ...)
+{
+	size_t i, size, limit = QP_LINE_LEN;
+	char *field;
+	va_list ap;
+
+	va_start(ap, vcards);
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
+				append_qp_ascii(vcards, &limit, field[i]);
+			}
+		}
+
+		field = va_arg(ap, char *);
+
+		if (field)
+			append_qp_ascii(vcards, &limit, ';');
+	}
+
+	va_end(ap);
+
+	g_string_append(vcards, "\r\n");
+}
+
 static void vcard_printf_begin(GString *vcards, uint8_t format)
 {
 	vcard_printf(vcards, "BEGIN:VCARD");
diff --git a/plugins/vcard.h b/plugins/vcard.h
index 88cdbed..c317b1f 100644
--- a/plugins/vcard.h
+++ b/plugins/vcard.h
@@ -40,6 +40,11 @@ enum phonebook_call_type {
 	CALL_TYPE_OUTGOING,
 };
 
+enum encoding_field_type {
+	ENCODING_TYPE_DEFAULT,
+	ENCODING_TYPE_QUOTED_PRINTABLE,
+};
+
 struct phonebook_field {
 	char *text;
 	int type;
-- 
1.6.3.3

