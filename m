Return-Path: <cyrus@holtmann.org>
From: Lukasz Pawlik <lucas.pawlik@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Pawlik <lucas.pawlik@gmail.com>
Subject: [PATCH] Fix problem with filling ADR with unneeded semicolons
Date: Tue, 17 Aug 2010 14:10:44 +0300
Message-Id: <1282043444-20543-1-git-send-email-lucas.pawlik@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously in a phonebook pull request ADR was filled with six
semicolons when contact address entry was empty in phonebook. This
patch fixes this problem. Address is send as an empty string.
---
 plugins/vcard.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+), 0 deletions(-)

diff --git a/plugins/vcard.c b/plugins/vcard.c
index 80f8265..7333a68 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -155,6 +155,26 @@ static gboolean contact_fields_present(struct phonebook_contact * contact)
 	return FALSE;
 }
 
+static gboolean address_fields_present(struct phonebook_contact *contact)
+{
+	if (contact->pobox && strlen(contact->pobox))
+		return TRUE;
+	if (contact->extended && strlen(contact->extended))
+		return TRUE;
+	if (contact->street && strlen(contact->street))
+		return TRUE;
+	if (contact->locality && strlen(contact->locality))
+		return TRUE;
+	if (contact->region && strlen(contact->region))
+		return TRUE;
+	if (contact->postal && strlen(contact->postal))
+		return TRUE;
+	if (contact->country && strlen(contact->country))
+		return TRUE;
+
+	return FALSE;
+}
+
 static void vcard_printf_name(GString *vcards,
 					struct phonebook_contact *contact)
 {
@@ -253,6 +273,11 @@ static void vcard_printf_email(GString *vcards, const char *email)
 
 static void vcard_printf_adr(GString *vcards, struct phonebook_contact *contact)
 {
+	if (address_fields_present(contact) == FALSE) {
+		vcard_printf(vcards, "ADR:");
+		return;
+	}
+
 	vcard_printf(vcards, "ADR:%s;%s;%s;%s;%s;%s;%s", contact->pobox,
 					contact->extended, contact->street,
 					contact->locality, contact->region,
-- 
1.7.0.4

