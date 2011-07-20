Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH obexd 4/6] Add encoding selection method
Date: Wed, 20 Jul 2011 09:11:45 +0200
Message-Id: <1311145907-3874-4-git-send-email-michalski.raf@gmail.com>
In-Reply-To: <1311145907-3874-3-git-send-email-michalski.raf@gmail.com>
References: <1311145907-3874-1-git-send-email-michalski.raf@gmail.com>
 <1311145907-3874-2-git-send-email-michalski.raf@gmail.com>
 <1311145907-3874-3-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch provides mechanism of selection between two methods of encoding
vcard's property field, depending on vcard format and field's content.
In general "quoted printable" is selected, if vcard's 2.1 property field
contains newline character or some specific ASCII character from set:
'!', '"', '#', '$', '@', '[', '\', ']', '^', '`', '{', '|', '}', '~'.
In other cases default encoding is taken into account.
---
 plugins/vcard.c |   26 ++++++++++++++++++++++++++
 plugins/vcard.h |    5 +++++
 2 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/plugins/vcard.c b/plugins/vcard.c
index e2bbf4e..88851a6 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -274,6 +274,32 @@ static void vcard_qp_fields_printf(GString *vcards, ...)
 	g_string_append(vcards, "\r\n");
 }
 
+static void select_fields_encoding(uint8_t format,
+					struct encoding_type *encoding, ...)
+{
+	char *field;
+	va_list ap;
+
+	encoding->type = ENCODING_TYPE_DEFAULT;
+	encoding->text = "";
+
+	if (format == FORMAT_VCARD21) {
+		va_start(ap, encoding);
+
+		for (field = va_arg(ap, char *); field; ) {
+			if (strpbrk(field, QP_SELECT)) {
+				encoding->type = ENCODING_TYPE_QUOTED_PRINTABLE;
+				encoding->text = "ENCODING=QUOTED-PRINTABLE";
+				break;
+			}
+
+			field = va_arg(ap, char *);
+		}
+
+		va_end(ap);
+	}
+}
+
 static void vcard_printf_begin(GString *vcards, uint8_t format)
 {
 	vcard_printf(vcards, "BEGIN:VCARD");
diff --git a/plugins/vcard.h b/plugins/vcard.h
index c317b1f..128a927 100644
--- a/plugins/vcard.h
+++ b/plugins/vcard.h
@@ -73,6 +73,11 @@ struct phonebook_contact {
 	int calltype;
 };
 
+struct encoding_type {
+	char *text;
+	int type;
+};
+
 void phonebook_add_contact(GString *vcards, struct phonebook_contact *contact,
 					uint64_t filter, uint8_t format);
 
-- 
1.6.3.3

