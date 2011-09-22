Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH obexd 4/4] Code clean-up: Simplify vCard's phone number printing
Date: Thu, 22 Sep 2011 09:52:48 +0200
Message-Id: <1316677968-3494-4-git-send-email-michalski.raf@gmail.com>
In-Reply-To: <1316677968-3494-3-git-send-email-michalski.raf@gmail.com>
References: <1316677968-3494-1-git-send-email-michalski.raf@gmail.com>
 <1316677968-3494-2-git-send-email-michalski.raf@gmail.com>
 <1316677968-3494-3-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously, it was trynig to create string (by snprintf function
and stored in "buf" buffer) containing "%s" formatting piece for
"vcard_printf" function.
In this case "\%" is not valid escape sequence (it is "%%" for percent
character) - backslash is ignored, so sequence "\%s" is treated as "%s"
and replaced by string for "number" field when snprintf function is
executed. Hence "vcard_printf" function has nothing to do with "number"
field, since "buf" does not contain any "%s" formatting sequence.

This patch make simplification for printing phone number field by
avoiding storing formatting pieces (for instance "%%s"). Now string
for phone number field is stored directly in "field" buffer
(common with Quoted Printable encoding) and simply passed to
"vcard_printf" function.
---
 plugins/vcard.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/plugins/vcard.c b/plugins/vcard.c
index 901a2ac..5b581fb 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -450,17 +450,15 @@ static void vcard_printf_number(GString *vcards, uint8_t format,
 	if ((type == TYPE_INTERNATIONAL) && (number[0] != '+'))
 		intl = "+";
 
+	snprintf(field, sizeof(field), "%s%s", intl, number);
+
 	if (select_qp_encoding(format, number, NULL)) {
 		snprintf(buf, sizeof(buf), "TEL;%s", category_string);
-		snprintf(field, sizeof(field), "%s%s", intl, number);
 		vcard_qp_print_encoded(vcards, buf, field, NULL);
 		return;
 	}
 
-	snprintf(buf, sizeof(buf), "TEL;%s:%s\%s", category_string,
-								intl, number);
-
-	vcard_printf(vcards, buf, number);
+	vcard_printf(vcards, "TEL;%s:%s", category_string, field);
 }
 
 static void vcard_printf_tag(GString *vcards, uint8_t format,
-- 
1.6.3.3

