Return-Path: <cyrus@holtmann.org>
Message-Id: <201007281324.o6SDO2oH010611@joshua.mesa.nl>
From: Marcel Mol <marcel@mesa.nl>
Date: Tue, 27 Jul 2010 21:04:26 +0200
Subject: [PATCH 1/2] Fix vcard filter setting
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The bits for VCARD version 2.1 and version 3.0 were wrong:
oin case of 2.1 the FN bit was on and for 3.0 it is off.
The comment state that 3.0 needs FN while 2.1 does not.
This patch fixes that.
---
 plugins/phonebook-ebook.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugins/phonebook-ebook.c b/plugins/phonebook-ebook.c
index 2d5bec3..089b956 100644
--- a/plugins/phonebook-ebook.c
+++ b/plugins/phonebook-ebook.c
@@ -107,7 +107,7 @@ static char *evcard_to_string(EVCard *evcard, unsigned int format,
 	 * Mandatory attributes for vCard 2.1 are VERSION ,N and TEL.
 	 * Mandatory attributes for vCard 3.0 are VERSION, N, FN and TEL
 	 */
-	filter = format == EVC_FORMAT_VCARD_30 ? filter | 0x85: filter | 0x87;
+	filter = format == EVC_FORMAT_VCARD_30 ? filter | 0x87: filter | 0x85;
 
 	evcard2 = e_vcard_new();
 	for (i = 0; i < 29; i++) {
-- 
1.7.1.1

