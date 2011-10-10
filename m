Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <radoslawjablonski@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <radoslawjablonski@gmail.com>
Subject: [PATCH obexd 1/2] Add check for empty string in vcard_printf_fullname
Date: Mon, 10 Oct 2011 09:22:38 +0200
Message-Id: <1318231359-3309-1-git-send-email-radoslawjablonski@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If tag value is empty there is possibility to quickly create
empty tag without entering to rest of the logic.
Checking for empty parameter at the begining is included
basicaly in every print tag function in code - here somehow
was missing.
---
 plugins/vcard.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/plugins/vcard.c b/plugins/vcard.c
index f1d9edc..c0a33cb 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -392,6 +392,11 @@ static void vcard_printf_fullname(GString *vcards, uint8_t format,
 {
 	char field[LEN_MAX];
 
+	if (!text || strlen(text) == 0) {
+		vcard_printf(vcards, "FN:");
+		return;
+	}
+
 	if (select_qp_encoding(format, text, NULL)) {
 		vcard_qp_print_encoded(vcards, "FN", text, NULL);
 		return;
-- 
1.7.0.4

