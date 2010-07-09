Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH] Fixed empty 'N:' parameter handling for VCARDs
Date: Fri,  9 Jul 2010 17:34:30 +0300
Message-Id: <1278686070-7647-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bluetooth PBAP specification expects for call history listing,
that parameter N: shall be empty when we cannot retrieve personal data
from PSE phone book.
Some devices(by example BH-903) are having problems when after N: parameter
 unnecessary characters occurs. List of dialed/incoming calls on carkit
then is useless - carkit shows only blank lines and it's impossible to
determine who made call.

In previous version unnecessary semicolons were added after N:("N:;;;;")
to represent empty name.
Now if none of the contact fields is available, then adding real empty "N:"
parameter (without semicolons).
---
 plugins/vcard.c |   35 +++++++++++++++++++++++++++++++++++
 1 files changed, 35 insertions(+), 0 deletions(-)

diff --git a/plugins/vcard.c b/plugins/vcard.c
index 5948a4a..108f6bd 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -133,9 +133,44 @@ static void vcard_printf_begin(GString *vcards, uint8_t format)
 		vcard_printf(vcards, "VERSION:2.1");
 }
 
+/* checks if there is at least one present contact field with personal data */
+static gboolean contact_fields_present(struct phonebook_contact * contact)
+{
+	if (contact->family && strlen(contact->family) > 0)
+		return TRUE;
+
+	if (contact->given && strlen(contact->given) > 0)
+		return TRUE;
+
+	if (contact->additional && strlen(contact->additional) > 0)
+		return TRUE;
+
+	if (contact->prefix && strlen(contact->prefix) > 0)
+		return TRUE;
+
+	if (contact->suffix && strlen(contact->suffix) > 0)
+		return TRUE;
+
+	/* none of the personal data fields is present*/
+	return FALSE;
+}
+
 static void vcard_printf_name(GString *vcards,
 					struct phonebook_contact *contact)
 {
+	if (contact_fields_present(contact) == FALSE) {
+		/*
+		 * If fields are empty, then add only 'N:' as parameter.
+		 * This is crucial for some devices ( Nokia BH-903) which
+		 * have problems with history listings - can't determine
+		 * if parameter is really empty if there are unnecessary
+		 * characters after'N:' (like 'N:;;;;').
+		 * We need to add only'N:' param - without semicolons.
+		 */
+		vcard_printf(vcards, "N:");
+		return;
+	}
+
 	vcard_printf(vcards, "N:%s;%s;%s;%s;%s", contact->family,
 				contact->given, contact->additional,
 				contact->prefix, contact->suffix);
-- 
1.6.0.4

