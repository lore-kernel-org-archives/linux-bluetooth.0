Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH obexd 2/6] Add escaping selection method
Date: Wed, 20 Jul 2011 09:11:43 +0200
Message-Id: <1311145907-3874-2-git-send-email-michalski.raf@gmail.com>
In-Reply-To: <1311145907-3874-1-git-send-email-michalski.raf@gmail.com>
References: <1311145907-3874-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch provides mechanism of selection between two methods of
escaping, depending on vcard format - vcard 2.1 requires only semicolon
for escaping ("escape_semicolon" function) and vcard 3.0 requires some
set of characters ('\n', '\r', ';', ',', '\') for escaping
("add_slash" function).
---
 plugins/vcard.c |   31 +++++++++++++++++++++++++++++--
 1 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/plugins/vcard.c b/plugins/vcard.c
index 4f61368..544ea82 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -70,6 +70,9 @@
 #define FORMAT_VCARD21 0x00
 #define FORMAT_VCARD30 0x01
 
+typedef void (*escape_handler)
+			(char *dest, const char *src, int len_max, int len);
+
 /* according to RFC 2425, the output string may need folding */
 static void vcard_printf(GString *str, const char *fmt, ...)
 {
@@ -124,7 +127,7 @@ static void add_slash(char *dest, const char *src, int len_max, int len)
 	return;
 }
 
-static void get_escaped_fields(char **fields, ...)
+static void get_escaped_fields(escape_handler escape, char **fields, ...)
 {
 	va_list ap;
 	GString *line;
@@ -135,7 +138,7 @@ static void get_escaped_fields(char **fields, ...)
 	line = g_string_new("");
 
 	for (field = va_arg(ap, char *); field; ) {
-		add_slash(escaped, field, LEN_MAX, strlen(field));
+		escape(escaped, field, LEN_MAX, strlen(field));
 		g_string_append(line, escaped);
 
 		field = va_arg(ap, char *);
@@ -163,6 +166,30 @@ static void escape_semicolon(char *dest, const char *src, int len_max, int len)
 	dest[j] = 0;
 }
 
+static escape_handler get_escape_handler(uint8_t format)
+{
+	if (format == FORMAT_VCARD21)
+		return escape_semicolon;
+	else if (format == FORMAT_VCARD30)
+		return add_slash;
+
+	return add_slash;
+}
+
+static void select_escape(uint8_t format, char *dest, const char *src,
+							int len_max, int len)
+{
+	switch (format) {
+		case FORMAT_VCARD21:
+			escape_semicolon(dest, src, len_max, len);
+			break;
+		case FORMAT_VCARD30:
+		default:
+			add_slash(dest, src, len_max, len);
+			break;
+	}
+}
+
 static void vcard_printf_begin(GString *vcards, uint8_t format)
 {
 	vcard_printf(vcards, "BEGIN:VCARD");
-- 
1.6.3.3

