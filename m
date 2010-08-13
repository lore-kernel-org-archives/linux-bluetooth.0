Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH] Fix unnecessary checking for empty phones list
Date: Fri, 13 Aug 2010 09:35:11 +0300
Message-Id: <1281681311-17074-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Removed not needed anymore checking for empty list of phone numbers.
---
 plugins/vcard.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/plugins/vcard.c b/plugins/vcard.c
index 9beb62a..80f8265 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -295,11 +295,6 @@ static void vcard_printf_end(GString *vcards)
 void phonebook_add_contact(GString *vcards, struct phonebook_contact *contact,
 					uint64_t filter, uint8_t format)
 {
-	/* There's really nothing to do */
-	if ((contact->numbers == NULL && (contact->fullname == NULL ||
-						contact->fullname[0] == '\0')))
-		return;
-
 	if (format == FORMAT_VCARD30)
 		filter |= (FILTER_VERSION | FILTER_FN | FILTER_N | FILTER_TEL);
 	else if (format == FORMAT_VCARD21)
-- 
1.7.0.4

