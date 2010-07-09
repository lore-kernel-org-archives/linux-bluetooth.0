Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH] Fixed empty 'N:' parameter handling for VCARDs
Date: Fri,  9 Jul 2010 12:27:01 +0300
Message-Id: <1278667621-8157-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bluetooth PBAP specification expects for call history listing, that parameter N: shall be empty when we cannot retrieve personal data from PSE phone book.
Some devices(by example BH-903) are having problems when after N: parameter unnecessary characters occurs. List of dialed/incoming calls on carkit then is useless - carkit shows only blank lines and it's impossible to determine who made call.

In previous version unnecessary semicolons were added after N: parameter ("N:;;;;") to represent empty name.
Now if none of the contact fields is available, then adding real empty "N:" parameter (without semicolons).
---
 plugins/vcard.c |   27 +++++++++++++++++++++++++++
 1 files changed, 27 insertions(+), 0 deletions(-)

diff --git a/plugins/vcard.c b/plugins/vcard.c
index 5948a4a..8c7147b 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -123,6 +123,27 @@ static void add_slash(char *dest, const char *src, int len_max, int len)
 	return;
 }
 
+/* checks if there is at least one present contact field with personal data */
+static gboolean contact_fields_present(struct phonebook_contact * contact)
+{
+	if (contact->family && strlen(contact->family))
+		return TRUE;
+
+	if (contact->given && strlen(contact->given))
+		return TRUE;
+	if (contact->additional && strlen(contact->additional))
+		return TRUE;
+
+	if (contact->prefix && strlen(contact->prefix))
+		return TRUE;
+
+	if (contact->suffix && strlen(contact->suffix))
+		return TRUE;
+
+	/* none of the personal data fields is present*/
+	return FALSE;
+}
+
 static void vcard_printf_begin(GString *vcards, uint8_t format)
 {
 	vcard_printf(vcards, "BEGIN:VCARD");
@@ -136,6 +157,12 @@ static void vcard_printf_begin(GString *vcards, uint8_t format)
 static void vcard_printf_name(GString *vcards,
 					struct phonebook_contact *contact)
 {
+	if (contact_fields_present(contact) == FALSE) {
+		/* if all fields are empty we need to have empty N: parameter */
+		vcard_printf(vcards, "N:");
+		return;
+	}
+
 	vcard_printf(vcards, "N:%s;%s;%s;%s;%s", contact->family,
 				contact->given, contact->additional,
 				contact->prefix, contact->suffix);
-- 
1.6.0.4

