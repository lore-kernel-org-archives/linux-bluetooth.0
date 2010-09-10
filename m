Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH] Removing role field from ORG tag
Date: Fri, 10 Sep 2010 16:12:54 +0200
Message-Id: <1284127974-8230-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously role field was under ORG tag. Now it's single field under
ROLE tag.
---
 plugins/phonebook-tracker.c |    2 +-
 plugins/vcard.c             |   12 ++++++------
 plugins/vcard.h             |    2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 41df840..43c2e28 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -863,7 +863,7 @@ add_entry:
 	contact->photo = g_strdup(reply[21]);
 	contact->company = g_strdup(reply[22]);
 	contact->department = g_strdup(reply[23]);
-	contact->title = g_strdup(reply[24]);
+	contact->role = g_strdup(reply[24]);
 	contact->uid = g_strdup(reply[32]);
 
 	set_call_type(contact, reply[COL_DATE], reply[COL_SENT],
diff --git a/plugins/vcard.c b/plugins/vcard.c
index 4a77eb3..e277ced 100644
--- a/plugins/vcard.c
+++ b/plugins/vcard.c
@@ -357,9 +357,6 @@ static gboolean org_fields_present(struct phonebook_contact *contact)
 	if (contact->department && strlen(contact->department))
 		return TRUE;
 
-	if (contact->title && strlen(contact->title))
-		return TRUE;
-
 	return FALSE;
 }
 
@@ -371,8 +368,8 @@ static void vcard_printf_org(GString *vcards,
 		return;
 	}
 
-	vcard_printf(vcards, "ORG:%s;%s;%s", contact->company,
-				contact->department, contact->title);
+	vcard_printf(vcards, "ORG:%s;%s", contact->company,
+				contact->department);
 }
 
 static void vcard_printf_address(GString *vcards, uint8_t format,
@@ -539,6 +536,9 @@ void phonebook_add_contact(GString *vcards, struct phonebook_contact *contact,
 	if (filter & FILTER_ORG)
 		vcard_printf_org(vcards, contact);
 
+	if (filter & FILTER_ROLE)
+		vcard_printf_tag(vcards, format, "ROLE", NULL, contact->role);
+
 	if (filter & FILTER_X_IRMC_CALL_DATETIME)
 		vcard_printf_datetime(vcards, contact);
 
@@ -596,7 +596,7 @@ void phonebook_contact_free(struct phonebook_contact *contact)
 	g_free(contact->photo);
 	g_free(contact->company);
 	g_free(contact->department);
-	g_free(contact->title);
+	g_free(contact->role);
 	g_free(contact->datetime);
 	g_free(contact);
 }
diff --git a/plugins/vcard.h b/plugins/vcard.h
index 4d134c2..0ed51b9 100644
--- a/plugins/vcard.h
+++ b/plugins/vcard.h
@@ -78,7 +78,7 @@ struct phonebook_contact {
 	char *photo;
 	char *company;
 	char *department;
-	char *title;
+	char *role;
 	char *datetime;
 	int calltype;
 };
-- 
1.6.3.3

