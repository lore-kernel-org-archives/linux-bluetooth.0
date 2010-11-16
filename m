Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH v2 2/2] Split pull_contacts to smaller functions
Date: Tue, 16 Nov 2010 14:59:55 +0100
Message-Id: <1289915995-2749-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Parts of pull_contact responsible for filling contact fields moved
to new functions.
---
 plugins/phonebook-tracker.c |  159 ++++++++++++++++++++++++------------------
 1 files changed, 91 insertions(+), 68 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 71ed2f0..e7de001 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -1395,6 +1395,92 @@ static void add_affiliation(char **field, const char *value)
 	*field = g_strdup(value);
 }
 
+static void contact_init(struct phonebook_contact **contact, char **reply)
+{
+	if (*contact == NULL)
+		*contact = g_new0(struct phonebook_contact, 1);
+
+	(*contact)->fullname = g_strdup(reply[COL_FULL_NAME]);
+	(*contact)->family = g_strdup(reply[COL_FAMILY_NAME]);
+	(*contact)->given = g_strdup(reply[COL_GIVEN_NAME]);
+	(*contact)->additional = g_strdup(reply[COL_ADDITIONAL_NAME]);
+	(*contact)->prefix = g_strdup(reply[COL_NAME_PREFIX]);
+	(*contact)->suffix = g_strdup(reply[COL_NAME_SUFFIX]);
+	(*contact)->birthday = g_strdup(reply[COL_BIRTH_DATE]);
+	(*contact)->nickname = g_strdup(reply[COL_NICKNAME]);
+	(*contact)->website = g_strdup(reply[COL_URL]);
+	(*contact)->photo = g_strdup(reply[COL_PHOTO]);
+	(*contact)->company = g_strdup(reply[COL_ORG_NAME]);
+	(*contact)->department = g_strdup(reply[COL_ORG_DEPARTMENT]);
+	(*contact)->role = g_strdup(reply[COL_ORG_ROLE]);
+	(*contact)->uid = g_strdup(reply[COL_UID]);
+	(*contact)->title = g_strdup(reply[COL_TITLE]);
+
+	set_call_type(*contact, reply[COL_DATE], reply[COL_SENT],
+							reply[COL_ANSWERED]);
+}
+
+static void contact_add_numbers(struct phonebook_contact **contact, char **reply)
+{
+	add_phone_number(*contact, reply[COL_HOME_NUMBER], TEL_TYPE_HOME);
+	add_phone_number(*contact, reply[COL_WORK_NUMBER], TEL_TYPE_WORK);
+	add_phone_number(*contact, reply[COL_FAX_NUMBER], TEL_TYPE_FAX);
+	add_phone_number(*contact, reply[COL_CELL_NUMBER], TEL_TYPE_MOBILE);
+	if ((g_strcmp0(reply[COL_OTHER_NUMBER], reply[COL_CELL_NUMBER]) != 0) &&
+			(g_strcmp0(reply[COL_OTHER_NUMBER], reply[COL_WORK_NUMBER]) != 0) &&
+			(g_strcmp0(reply[COL_OTHER_NUMBER], reply[COL_HOME_NUMBER]) != 0))
+		add_phone_number(*contact, reply[COL_OTHER_NUMBER], TEL_TYPE_OTHER);
+}
+
+static void contact_add_emails(struct phonebook_contact **contact, char **reply)
+{
+	add_email(*contact, reply[COL_HOME_EMAIL], EMAIL_TYPE_HOME);
+	add_email(*contact, reply[COL_WORK_EMAIL], EMAIL_TYPE_WORK);
+	add_email(*contact, reply[COL_OTHER_EMAIL], EMAIL_TYPE_OTHER);
+}
+
+static void contact_add_addresses(struct phonebook_contact **contact, char **reply)
+{
+
+	char *home_addr, *work_addr, *other_addr;
+
+	home_addr = g_strdup_printf("%s;%s;%s;%s;%s;%s;%s",
+				reply[COL_HOME_ADDR_POBOX], reply[COL_HOME_ADDR_EXT],
+				reply[COL_HOME_ADDR_STREET], reply[COL_HOME_ADDR_LOCALITY],
+				reply[COL_HOME_ADDR_REGION], reply[COL_HOME_ADDR_CODE],
+				reply[COL_HOME_ADDR_COUNTRY]);
+
+	work_addr = g_strdup_printf("%s;%s;%s;%s;%s;%s;%s",
+				reply[COL_WORK_ADDR_POBOX], reply[COL_WORK_ADDR_EXT],
+				reply[COL_WORK_ADDR_STREET], reply[COL_WORK_ADDR_LOCALITY],
+				reply[COL_WORK_ADDR_REGION], reply[COL_WORK_ADDR_CODE],
+				reply[COL_WORK_ADDR_COUNTRY]);
+
+	other_addr = g_strdup_printf("%s;%s;%s;%s;%s;%s;%s",
+				reply[COL_OTHER_ADDR_POBOX], reply[COL_OTHER_ADDR_EXT],
+				reply[COL_OTHER_ADDR_STREET], reply[COL_OTHER_ADDR_LOCALITY],
+				reply[COL_OTHER_ADDR_REGION], reply[COL_OTHER_ADDR_CODE],
+				reply[COL_OTHER_ADDR_COUNTRY]);
+
+	add_address(*contact, home_addr, ADDR_TYPE_HOME);
+	add_address(*contact, work_addr, ADDR_TYPE_WORK);
+	add_address(*contact, other_addr, ADDR_TYPE_OTHER);
+
+	g_free(home_addr);
+	g_free(work_addr);
+	g_free(other_addr);
+}
+
+static void contact_add_organization(struct phonebook_contact **contact, char **reply)
+{
+	/* Adding fields connected by nco:hasAffiliation - they may be in
+	 * separate replies */
+	add_affiliation(&(*contact)->title, reply[COL_TITLE]);
+	add_affiliation(&(*contact)->company, reply[COL_ORG_NAME]);
+	add_affiliation(&(*contact)->department, reply[COL_ORG_DEPARTMENT]);
+	add_affiliation(&(*contact)->role, reply[COL_ORG_ROLE]);
+}
+
 static void pull_contacts(char **reply, int num_fields, void *user_data)
 {
 	struct phonebook_data *data = user_data;
@@ -1404,7 +1490,6 @@ static void pull_contacts(char **reply, int num_fields, void *user_data)
 	GString *vcards;
 	int last_index, i;
 	gboolean cdata_present = FALSE;
-	char *home_addr, *work_addr, *other_addr;
 	static char *temp_id = NULL;
 
 	if (num_fields < 0) {
@@ -1455,75 +1540,13 @@ static void pull_contacts(char **reply, int num_fields, void *user_data)
 		return;
 
 add_entry:
-	contact = g_new0(struct phonebook_contact, 1);
-	contact->fullname = g_strdup(reply[COL_FULL_NAME]);
-	contact->family = g_strdup(reply[COL_FAMILY_NAME]);
-	contact->given = g_strdup(reply[COL_GIVEN_NAME]);
-	contact->additional = g_strdup(reply[COL_ADDITIONAL_NAME]);
-	contact->prefix = g_strdup(reply[COL_NAME_PREFIX]);
-	contact->suffix = g_strdup(reply[COL_NAME_SUFFIX]);
-	contact->birthday = g_strdup(reply[COL_BIRTH_DATE]);
-	contact->nickname = g_strdup(reply[COL_NICKNAME]);
-	contact->website = g_strdup(reply[COL_URL]);
-	contact->photo = g_strdup(reply[COL_PHOTO]);
-	contact->company = g_strdup(reply[COL_ORG_NAME]);
-	contact->department = g_strdup(reply[COL_ORG_DEPARTMENT]);
-	contact->role = g_strdup(reply[COL_ORG_ROLE]);
-	contact->uid = g_strdup(reply[COL_UID]);
-	contact->title = g_strdup(reply[COL_TITLE]);
-
-	set_call_type(contact, reply[COL_DATE], reply[COL_SENT],
-							reply[COL_ANSWERED]);
+	contact_init(&contact, reply);
 
 add_numbers:
-	/* Adding phone numbers to contact struct */
-	add_phone_number(contact, reply[COL_HOME_NUMBER], TEL_TYPE_HOME);
-	add_phone_number(contact, reply[COL_WORK_NUMBER], TEL_TYPE_WORK);
-	add_phone_number(contact, reply[COL_FAX_NUMBER], TEL_TYPE_FAX);
-	add_phone_number(contact, reply[COL_CELL_NUMBER], TEL_TYPE_MOBILE);
-	if ((g_strcmp0(reply[COL_OTHER_NUMBER], reply[COL_CELL_NUMBER]) != 0) &&
-			(g_strcmp0(reply[COL_OTHER_NUMBER], reply[COL_WORK_NUMBER]) != 0) &&
-			(g_strcmp0(reply[COL_OTHER_NUMBER], reply[COL_HOME_NUMBER]) != 0))
-		add_phone_number(contact, reply[COL_OTHER_NUMBER], TEL_TYPE_OTHER);
-
-	/* Adding emails */
-	add_email(contact, reply[COL_HOME_EMAIL], EMAIL_TYPE_HOME);
-	add_email(contact, reply[COL_WORK_EMAIL], EMAIL_TYPE_WORK);
-	add_email(contact, reply[COL_OTHER_EMAIL], EMAIL_TYPE_OTHER);
-
-	/* Adding addresses */
-	home_addr = g_strdup_printf("%s;%s;%s;%s;%s;%s;%s",
-				reply[COL_HOME_ADDR_POBOX], reply[COL_HOME_ADDR_EXT],
-				reply[COL_HOME_ADDR_STREET], reply[COL_HOME_ADDR_LOCALITY],
-				reply[COL_HOME_ADDR_REGION], reply[COL_HOME_ADDR_CODE],
-				reply[COL_HOME_ADDR_COUNTRY]);
-
-	work_addr = g_strdup_printf("%s;%s;%s;%s;%s;%s;%s",
-				reply[COL_WORK_ADDR_POBOX], reply[COL_WORK_ADDR_EXT],
-				reply[COL_WORK_ADDR_STREET], reply[COL_WORK_ADDR_LOCALITY],
-				reply[COL_WORK_ADDR_REGION], reply[COL_WORK_ADDR_CODE],
-				reply[COL_WORK_ADDR_COUNTRY]);
-
-	other_addr = g_strdup_printf("%s;%s;%s;%s;%s;%s;%s",
-				reply[COL_OTHER_ADDR_POBOX], reply[COL_OTHER_ADDR_EXT],
-				reply[COL_OTHER_ADDR_STREET], reply[COL_OTHER_ADDR_LOCALITY],
-				reply[COL_OTHER_ADDR_REGION], reply[COL_OTHER_ADDR_CODE],
-				reply[COL_OTHER_ADDR_COUNTRY]);
-
-	add_address(contact, home_addr, ADDR_TYPE_HOME);
-	add_address(contact, work_addr, ADDR_TYPE_WORK);
-	add_address(contact, other_addr, ADDR_TYPE_OTHER);
-
-	g_free(home_addr);
-	g_free(work_addr);
-	g_free(other_addr);
-
-	/* Adding fields connected by nco:hasAffiliation - they may be in
-	 * separate replies */
-	add_affiliation(&contact->title, reply[COL_TITLE]);
-	add_affiliation(&contact->company, reply[COL_ORG_NAME]);
-	add_affiliation(&contact->department, reply[COL_ORG_DEPARTMENT]);
-	add_affiliation(&contact->role, reply[COL_ORG_ROLE]);
+	contact_add_numbers(&contact, reply);
+	contact_add_emails(&contact, reply);
+	contact_add_addresses(&contact, reply);
+	contact_add_organization(&contact, reply);
 
 	DBG("contact %p", contact);
 
-- 
1.7.0.4

