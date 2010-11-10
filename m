Return-Path: <cyrus@holtmann.org>
From: Lukasz Pawlik <lucas.pawlik@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Pawlik <lucas.pawlik@gmail.com>
Subject: [PATCH] Fix pull phonebook reply if filter not set
Date: Wed, 10 Nov 2010 12:43:07 +0100
Message-Id: <1289389387-14308-1-git-send-email-lucas.pawlik@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

According to the PBAP specification if filter is not set or is set to
0x00000000 in the application parameters header all attributes of the vCard
should be returned. Previously only mandatory attributes were returned in
phonebook pull reply. This patch fix this and now all currently supported
vCards attributes will be returned.
---
 plugins/vcard.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/plugins/vcard.c b/plugins/vcard.c
index 41f9fbd..3f69189 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -457,10 +457,16 @@ static void vcard_printf_end(GString *vcards)
 void phonebook_add_contact(GString *vcards, struct phonebook_contact *contact,
 					uint64_t filter, uint8_t format)
 {
-	if (format == FORMAT_VCARD30)
+	if (format == FORMAT_VCARD30 && filter)
 		filter |= (FILTER_VERSION | FILTER_FN | FILTER_N | FILTER_TEL);
-	else if (format == FORMAT_VCARD21)
+	else if (format == FORMAT_VCARD21 && filter)
 		filter |= (FILTER_VERSION | FILTER_N | FILTER_TEL);
+	else
+		filter = (FILTER_VERSION | FILTER_UID | FILTER_N | FILTER_FN |
+				FILTER_TEL | FILTER_EMAIL | FILTER_ADR |
+				FILTER_BDAY | FILTER_NICKNAME | FILTER_URL |
+				FILTER_PHOTO | FILTER_ORG | FILTER_ROLE |
+				FILTER_TITLE | FILTER_X_IRMC_CALL_DATETIME);
 
 	vcard_printf_begin(vcards, format);
 
-- 
1.7.0.4

