Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCH 1/2] Using field names instead of numbers in PBAP
Date: Mon, 15 Nov 2010 13:01:36 +0100
Message-Id: <1289822497-5338-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously addressing via field numbers and field names were mixed in PBAP
query replies. Now there is defined name for each data base reply field.
---
 plugins/phonebook-tracker.c |  104 +++++++++++++++++++++++++++++++-----------
 1 files changed, 77 insertions(+), 27 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 672d59f..8f8a6e2 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -43,21 +43,65 @@
 #define TRACKER_RESOURCES_INTERFACE "org.freedesktop.Tracker1.Resources"
 
 #define TRACKER_DEFAULT_CONTACT_ME "http://www.semanticdesktop.org/ontologies/2007/03/22/nco#default-contact-me"
-#define CONTACTS_ID_COL 47
+#define ADDR_FIELD_AMOUNT 7
 #define PULL_QUERY_COL_AMOUNT 48
 #define COUNT_QUERY_COL_AMOUNT 1
+
 #define COL_HOME_NUMBER 0
+#define COL_FULL_NAME 1
+#define COL_FAMILY_NAME 2
+#define COL_GIVEN_NAME 3
+#define COL_ADDITIONAL_NAME 4
+#define COL_NAME_PREFIX 5
+#define COL_NAME_SUFFIX 6
 #define COL_HOME_EMAIL 7
 #define COL_WORK_NUMBER 8
+
+#define COL_HOME_ADDR_POBOX 9
+#define COL_HOME_ADDR_EXT 10
+#define COL_HOME_ADDR_STREET 11
+#define COL_HOME_ADDR_LOCALITY 12
+#define COL_HOME_ADDR_REGION 13
+#define COL_HOME_ADDR_CODE 14
+#define COL_HOME_ADDR_COUNTRY 15
+
 #define COL_FAX_NUMBER 16
 #define COL_WORK_EMAIL 17
+#define COL_BIRTH_DATE 18
+#define COL_NICKNAME 19
+#define COL_URL 20
+#define COL_PHOTO 21
+
+#define COL_ORG_NAME 22
+#define COL_ORG_DEPARTMENT 23
+#define COL_ORG_ROLE 24
+
+#define COL_WORK_ADDR_POBOX 25
+#define COL_WORK_ADDR_EXT 26
+#define COL_WORK_ADDR_STREET 27
+#define COL_WORK_ADDR_LOCALITY 28
+#define COL_WORK_ADDR_REGION 29
+#define COL_WORK_ADDR_CODE 30
+#define COL_WORK_ADDR_COUNTRY 31
+
+#define COL_UID 32
+#define COL_TITLE 33
 #define COL_OTHER_NUMBER 34
+
+#define COL_OTHER_ADDR_POBOX 35
+#define COL_OTHER_ADDR_EXT 36
+#define COL_OTHER_ADDR_STREET 37
+#define COL_OTHER_ADDR_LOCALITY 38
+#define COL_OTHER_ADDR_REGION 39
+#define COL_OTHER_ADDR_CODE 40
+#define COL_OTHER_ADDR_COUNTRY 41
+
 #define COL_OTHER_EMAIL 42
 #define COL_CELL_NUMBER 43
 #define COL_DATE 44
 #define COL_SENT 45
 #define COL_ANSWERED 46
-#define ADDR_FIELD_AMOUNT 7
+#define CONTACTS_ID_COL 47
 #define CONTACT_ID_PREFIX "contact:"
 
 #define CONTACTS_QUERY_ALL						\
@@ -1407,21 +1451,21 @@ static void pull_contacts(char **reply, int num_fields, void *user_data)
 
 add_entry:
 	contact = g_new0(struct phonebook_contact, 1);
-	contact->fullname = g_strdup(reply[1]);
-	contact->family = g_strdup(reply[2]);
-	contact->given = g_strdup(reply[3]);
-	contact->additional = g_strdup(reply[4]);
-	contact->prefix = g_strdup(reply[5]);
-	contact->suffix = g_strdup(reply[6]);
-	contact->birthday = g_strdup(reply[18]);
-	contact->nickname = g_strdup(reply[19]);
-	contact->website = g_strdup(reply[20]);
-	contact->photo = g_strdup(reply[21]);
-	contact->company = g_strdup(reply[22]);
-	contact->department = g_strdup(reply[23]);
-	contact->role = g_strdup(reply[24]);
-	contact->uid = g_strdup(reply[32]);
-	contact->title = g_strdup(reply[33]);
+	contact->fullname = g_strdup(reply[COL_FULL_NAME]);
+	contact->family = g_strdup(reply[COL_FAMILY_NAME]);
+	contact->given = g_strdup(reply[COL_GIVEN_NAME]);
+	contact->additional = g_strdup(reply[COL_ADDITIONAL_NAME]);
+	contact->prefix = g_strdup(reply[COL_NAME_PREFIX]);
+	contact->suffix = g_strdup(reply[COL_NAME_SUFFIX]);
+	contact->birthday = g_strdup(reply[COL_BIRTH_DATE]);
+	contact->nickname = g_strdup(reply[COL_NICKNAME]);
+	contact->website = g_strdup(reply[COL_URL]);
+	contact->photo = g_strdup(reply[COL_PHOTO]);
+	contact->company = g_strdup(reply[COL_ORG_NAME]);
+	contact->department = g_strdup(reply[COL_ORG_DEPARTMENT]);
+	contact->role = g_strdup(reply[COL_ORG_ROLE]);
+	contact->uid = g_strdup(reply[COL_UID]);
+	contact->title = g_strdup(reply[COL_TITLE]);
 
 	set_call_type(contact, reply[COL_DATE], reply[COL_SENT],
 							reply[COL_ANSWERED]);
@@ -1444,16 +1488,22 @@ add_numbers:
 
 	/* Adding addresses */
 	home_addr = g_strdup_printf("%s;%s;%s;%s;%s;%s;%s",
-				reply[9], reply[10], reply[11], reply[12],
-				reply[13], reply[14], reply[15]);
+				reply[COL_HOME_ADDR_POBOX], reply[COL_HOME_ADDR_EXT],
+				reply[COL_HOME_ADDR_STREET], reply[COL_HOME_ADDR_LOCALITY],
+				reply[COL_HOME_ADDR_REGION], reply[COL_HOME_ADDR_CODE],
+				reply[COL_HOME_ADDR_COUNTRY]);
 
 	work_addr = g_strdup_printf("%s;%s;%s;%s;%s;%s;%s",
-				reply[25], reply[26], reply[27], reply[28],
-				reply[29], reply[30], reply[31]);
+				reply[COL_WORK_ADDR_POBOX], reply[COL_WORK_ADDR_EXT],
+				reply[COL_WORK_ADDR_STREET], reply[COL_WORK_ADDR_LOCALITY],
+				reply[COL_WORK_ADDR_REGION], reply[COL_WORK_ADDR_CODE],
+				reply[COL_WORK_ADDR_COUNTRY]);
 
 	other_addr = g_strdup_printf("%s;%s;%s;%s;%s;%s;%s",
-				reply[35], reply[36], reply[37], reply[38],
-				reply[39], reply[40], reply[41]);
+				reply[COL_OTHER_ADDR_POBOX], reply[COL_OTHER_ADDR_EXT],
+				reply[COL_OTHER_ADDR_STREET], reply[COL_OTHER_ADDR_LOCALITY],
+				reply[COL_OTHER_ADDR_REGION], reply[COL_OTHER_ADDR_CODE],
+				reply[COL_OTHER_ADDR_COUNTRY]);
 
 	add_address(contact, home_addr, ADDR_TYPE_HOME);
 	add_address(contact, work_addr, ADDR_TYPE_WORK);
@@ -1465,10 +1515,10 @@ add_numbers:
 
 	/* Adding fields connected by nco:hasAffiliation - they may be in
 	 * separate replies */
-	add_affiliation(&contact->title, reply[33]);
-	add_affiliation(&contact->company, reply[22]);
-	add_affiliation(&contact->department, reply[23]);
-	add_affiliation(&contact->role, reply[24]);
+	add_affiliation(&contact->title, reply[COL_TITLE]);
+	add_affiliation(&contact->company, reply[COL_ORG_NAME]);
+	add_affiliation(&contact->department, reply[COL_ORG_DEPARTMENT]);
+	add_affiliation(&contact->role, reply[COL_ORG_ROLE]);
 
 	DBG("contact %p", contact);
 
-- 
1.7.0.4

