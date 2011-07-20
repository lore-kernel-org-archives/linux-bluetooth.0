Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH obexd 5/6] Fix phone number printing
Date: Wed, 20 Jul 2011 09:11:46 +0200
Message-Id: <1311145907-3874-5-git-send-email-michalski.raf@gmail.com>
In-Reply-To: <1311145907-3874-4-git-send-email-michalski.raf@gmail.com>
References: <1311145907-3874-1-git-send-email-michalski.raf@gmail.com>
 <1311145907-3874-2-git-send-email-michalski.raf@gmail.com>
 <1311145907-3874-3-git-send-email-michalski.raf@gmail.com>
 <1311145907-3874-4-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously, it was trynig to create string (stored in "buf" buffer)
containing "%s" formatting piece for "vcard_printf" function and "number"
field. In this case "\%" is not valid escape sequence (for percent
character, "%%" is a valid sequence) - backslash is ignored, so sequence
"\%s" is treated as "%s" and replaced by string for "number" field,
hence "vcard_printf" function has nothing to do with "number" field, since
"buf" does not contain any "%s" formatting sequence (to get this
formatting sequence "buf" should contain "%%s" sequence).
However, this patch make simplification for printing phone number field by
avoiding storing formatting pieces (for instance "%%s") in "buf".
Now string for phone number field is stored directly in "buf" which is
simply passed to "vcard_printf" function (which uses "%s" formatting
string for this purpose).
---
 plugins/vcard.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/vcard.c b/plugins/vcard.c
index 88851a6..3e978ee 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -434,10 +434,10 @@ static void vcard_printf_number(GString *vcards, uint8_t format,
 	if ((type == TYPE_INTERNATIONAL) && (number[0] != '+'))
 		intl = "+";
 
-	snprintf(buf, sizeof(buf), "TEL;%s:%s\%s", category_string,
+	snprintf(buf, sizeof(buf), "TEL;%s:%s%s", category_string,
 								intl, number);
 
-	vcard_printf(vcards, buf, number);
+	vcard_printf(vcards, "%s", buf);
 }
 
 static void vcard_printf_tag(GString *vcards, uint8_t format,
-- 
1.6.3.3

