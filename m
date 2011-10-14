Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH obexd] Fix breaking long lines in vCard's fields
Date: Fri, 14 Oct 2011 16:01:22 +0200
Message-Id: <1318600882-14204-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously limit length for vCard's (vCard 2.1 with Quoted Printable
encoding) property line was always set as 75 (QP_LINE_LEN), after
processing each single subfield (for instance under ADR property).
Thus it was not possible to reach limit equal to 0 (then breaking line
is required) for all property subfields.
This patch fixes that issue and length of first line, containing property
parameters, is limited as well.
---
 plugins/vcard.c |    9 +++++++--
 1 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/plugins/vcard.c b/plugins/vcard.c
index 743f19f..7cc7994 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -277,6 +277,8 @@ static gboolean utf8_select(const char *field)
 static void vcard_qp_print_encoded(GString *vcards, const char *desc, ...)
 {
 	const char *field, *charset = "";
+	const char *encoding = ";ENCODING=QUOTED-PRINTABLE";
+	size_t limit, param_len;
 	va_list ap;
 
 	va_start(ap, desc);
@@ -290,13 +292,16 @@ static void vcard_qp_print_encoded(GString *vcards, const char *desc, ...)
 
 	va_end(ap);
 
-	vcard_printf(vcards, "%s;ENCODING=QUOTED-PRINTABLE%s:", desc, charset);
+	vcard_printf(vcards, "%s%s%s:", desc, encoding, charset);
 	g_string_truncate(vcards, vcards->len - 2);
 
+	param_len = strlen(desc) + strlen(encoding) + strlen(charset) + 1;
+	limit = QP_LINE_LEN - param_len;
+
 	va_start(ap, desc);
 
 	for (field = va_arg(ap, char *); field != NULL; ) {
-		size_t i, limit = QP_LINE_LEN, size = strlen(field);
+		size_t i, size = strlen(field);
 
 		for (i = 0; i < size; ++i) {
 			if (set_qp_encoding(field[i])) {
-- 
1.6.3.3

