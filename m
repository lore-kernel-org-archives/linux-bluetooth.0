Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH obexd v3 2/3] Escape semicolons in vCard's fields
Date: Thu,  8 Sep 2011 15:12:19 +0200
Message-Id: <1315487540-16607-2-git-send-email-michalski.raf@gmail.com>
In-Reply-To: <1315487540-16607-1-git-send-email-michalski.raf@gmail.com>
References: <1315487540-16607-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch provides possibility to escape only semicolon character
in vCard's fields, as vCard 2.1 specification requires
(for comparision vCard 3.0 requires escaping for set of characters:
'\n', '\r', ';', ',', '\').
---
 plugins/vcard.c |   39 +++++++++++++++++++++++++++++++++------
 1 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/plugins/vcard.c b/plugins/vcard.c
index 3b9d9cd..b694438 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -144,6 +144,33 @@ done:
 	dest[j] = 0;
 }
 
+static void escape_semicolon(char *dest, const char *src, int len_max, int len)
+{
+	int i, j;
+
+	for (i = 0, j = 0; i < len && j + 1 < len_max; i++, j++) {
+		if (src[i] == ';') {
+			if (j + 2 >= len_max)
+				break;
+
+			dest[j++] = '\\';
+		}
+
+		dest[j] = src[i];
+	}
+
+	dest[j] = 0;
+}
+
+static void set_escape(uint8_t format, char *dest, const char *src,
+							int len_max, int len)
+{
+	if (format == FORMAT_VCARD30)
+		add_slash(dest, src, len_max, len);
+	else if (format == FORMAT_VCARD21)
+		escape_semicolon(dest, src, len_max, len);
+}
+
 static void get_escaped_fields(uint8_t format, char **fields, ...)
 {
 	va_list ap;
@@ -155,7 +182,7 @@ static void get_escaped_fields(uint8_t format, char **fields, ...)
 	line = g_string_new("");
 
 	for (field = va_arg(ap, char *); field; ) {
-		add_slash(escaped, field, LEN_MAX, strlen(field));
+		set_escape(format, escaped, field, LEN_MAX, strlen(field));
 		g_string_append(line, escaped);
 
 		field = va_arg(ap, char *);
@@ -233,7 +260,7 @@ static void vcard_printf_fullname(GString *vcards, uint8_t format,
 							const char *text)
 {
 	char field[LEN_MAX];
-	add_slash(field, text, LEN_MAX, strlen(text));
+	set_escape(format, field, text, LEN_MAX, strlen(text));
 	vcard_printf(vcards, "FN:%s", field);
 }
 
@@ -318,7 +345,7 @@ static void vcard_printf_tag(GString *vcards, uint8_t format,
 
 	snprintf(buf, LEN_MAX, "%s%s%s%s", tag, separator, type, category);
 
-	add_slash(field, fld, LEN_MAX, len);
+	set_escape(format, field, fld, LEN_MAX, len);
 	vcard_printf(vcards, "%s:%s", buf, field);
 }
 
@@ -354,7 +381,7 @@ static void vcard_printf_email(GString *vcards, uint8_t format,
 			category_string = "TYPE=INTERNET;TYPE=OTHER";
 	}
 
-	add_slash(field, address, LEN_MAX, len);
+	set_escape(format, field, address, LEN_MAX, len);
 	vcard_printf(vcards, "EMAIL;%s:%s", category_string, field);
 }
 
@@ -391,7 +418,7 @@ static void vcard_printf_url(GString *vcards, uint8_t format,
 		break;
 	}
 
-	add_slash(field, url, LEN_MAX, strlen(url));
+	set_escape(format, field, url, LEN_MAX, strlen(url));
 	vcard_printf(vcards, "URL;%s:%s", category_string, field);
 }
 
@@ -464,7 +491,7 @@ static void vcard_printf_address(GString *vcards, uint8_t format,
 	for (l = address->fields; l; l = l->next) {
 		char *field = l->data;
 
-		add_slash(field_esc, field, LEN_MAX, strlen(field));
+		set_escape(format, field_esc, field, LEN_MAX, strlen(field));
 		g_strlcat(fields, field_esc, len);
 
 		if (l->next)
-- 
1.6.3.3

