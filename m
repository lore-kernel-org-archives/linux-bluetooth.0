Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <radoslawjablonski@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <radoslawjablonski@gmail.com>
Subject: [PATCH obexd 2/2] Add NULL-field checking in vcard_printf_address
Date: Mon, 10 Oct 2011 09:22:39 +0200
Message-Id: <1318231359-3309-2-git-send-email-radoslawjablonski@gmail.com>
In-Reply-To: <1318231359-3309-1-git-send-email-radoslawjablonski@gmail.com>
References: <1318231359-3309-1-git-send-email-radoslawjablonski@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Without that checking strlen(..) could be called with NULL
as param and this will result crash (in some scenarios
'field' may be NULL)
---
 plugins/vcard.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/plugins/vcard.c b/plugins/vcard.c
index c0a33cb..dc20a77 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -680,8 +680,11 @@ static void vcard_printf_address(GString *vcards, uint8_t format,
 	for (l = address->fields; l; l = l->next) {
 		char *field = l->data;
 
-		set_escape(format, field_esc, field, LEN_MAX, strlen(field));
-		g_strlcat(fields, field_esc, len);
+		if (field) {
+			set_escape(format, field_esc, field, LEN_MAX,
+								strlen(field));
+			g_strlcat(fields, field_esc, len);
+		}
 
 		if (l->next)
 			/* not adding ';' after last addr field */
-- 
1.7.0.4

