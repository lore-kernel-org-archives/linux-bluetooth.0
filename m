Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd] Do not send empty vCard attributes
Date: Wed, 29 Jun 2011 13:13:53 +0200
Message-Id: <1309346033-20242-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PBAP specification v1.1, chap. 5.1.4.1 and 5.4.4.1 states that
non-mandatory attributes shall be sent only when their value is not NULL.
In case of vCards this can be simply understood as non-empty, therefore
the patch makes phonebook_add_contact add only mandatory attributes for
specified vCard version as well as those for which values are of non-zero
length.
---
 plugins/vcard.c |   31 +++++++++----------------------
 1 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/plugins/vcard.c b/plugins/vcard.c
index efeba17..4fb7b94 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -398,10 +398,8 @@ static gboolean org_fields_present(struct phonebook_contact *contact)
 static void vcard_printf_org(GString *vcards,
 					struct phonebook_contact *contact)
 {
-	if (org_fields_present(contact) == FALSE){
-		vcard_printf(vcards, "ORG:");
+	if (org_fields_present(contact) == FALSE)
 		return;
-	}
 
 	vcard_printf(vcards, "ORG:%s;%s", contact->company,
 				contact->department);
@@ -505,13 +503,14 @@ void phonebook_add_contact(GString *vcards, struct phonebook_contact *contact,
 
 	vcard_printf_begin(vcards, format);
 
-	if (filter & FILTER_UID)
+	if (filter & FILTER_UID && *contact->uid)
 		vcard_printf_tag(vcards, format, "UID", NULL, contact->uid);
 
 	if (filter & FILTER_N)
 		vcard_printf_name(vcards, contact);
 
-	if (filter & FILTER_FN)
+	if (filter & FILTER_FN && (*contact->fullname ||
+					format == FORMAT_VCARD30))
 		vcard_printf_fullname(vcards, contact->fullname);
 
 	if (filter & FILTER_TEL) {
@@ -532,10 +531,6 @@ void phonebook_add_contact(GString *vcards, struct phonebook_contact *contact,
 	if (filter & FILTER_EMAIL) {
 		GSList *l = contact->emails;
 
-		if (g_slist_length(l) == 0)
-			vcard_printf_email(vcards, format, NULL,
-							FIELD_TYPE_OTHER);
-
 		for (; l; l = l->next){
 			struct phonebook_field *email = l->data;
 			vcard_printf_email(vcards, format, email->text,
@@ -546,10 +541,6 @@ void phonebook_add_contact(GString *vcards, struct phonebook_contact *contact,
 	if (filter & FILTER_ADR) {
 		GSList *l = contact->addresses;
 
-		if (g_slist_length(l) == 0)
-			vcard_printf_address(vcards, format, NULL,
-							FIELD_TYPE_OTHER);
-
 		for (; l; l = l->next) {
 			struct phonebook_field *addr = l->data;
 			vcard_printf_address(vcards, format, addr->text,
@@ -557,38 +548,34 @@ void phonebook_add_contact(GString *vcards, struct phonebook_contact *contact,
 		}
 	}
 
-	if (filter & FILTER_BDAY)
+	if (filter & FILTER_BDAY && *contact->birthday)
 		vcard_printf_tag(vcards, format, "BDAY", NULL,
 						contact->birthday);
 
-	if (filter & FILTER_NICKNAME)
+	if (filter & FILTER_NICKNAME && *contact->nickname)
 		vcard_printf_slash_tag(vcards, format, "NICKNAME", NULL,
 							contact->nickname);
 
 	if (filter & FILTER_URL) {
 		GSList *l = contact->urls;
 
-		if (g_slist_length(l) == 0)
-			vcard_printf_url(vcards, format, NULL,
-							FIELD_TYPE_OTHER);
-
 		for (; l; l = l->next) {
 			struct phonebook_field *url = l->data;
 			vcard_printf_url(vcards, format, url->text, url->type);
 		}
 	}
 
-	if (filter & FILTER_PHOTO)
+	if (filter & FILTER_PHOTO && *contact->photo)
 		vcard_printf_tag(vcards, format, "PHOTO", NULL,
 							contact->photo);
 
 	if (filter & FILTER_ORG)
 		vcard_printf_org(vcards, contact);
 
-	if (filter & FILTER_ROLE)
+	if (filter & FILTER_ROLE && *contact->role)
 		vcard_printf_tag(vcards, format, "ROLE", NULL, contact->role);
 
-	if (filter & FILTER_TITLE)
+	if (filter & FILTER_TITLE && *contact->title)
 		vcard_printf_tag(vcards, format, "TITLE", NULL, contact->title);
 
 	if (filter & FILTER_X_IRMC_CALL_DATETIME)
-- 
1.7.4.1

