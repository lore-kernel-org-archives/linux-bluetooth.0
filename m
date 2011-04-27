Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH] Remove grouping by phone number in call-history results
Date: Wed, 27 Apr 2011 13:52:00 +0300
Message-Id: <1303901520-6508-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Now call history entries are distinguished also by call
date (previously only contact-id was compared, so calls with
different date were grouped into one entry in pull results).
This change is needed for headsets with PBAP support that are
confused when number of "new missed calls" is different than
number of returned entries by pull call-history response (by
example Nokia BH-903 hangs when this happens).
---
 plugins/phonebook-tracker.c |   30 +++++++++++++++++++++++++++---
 1 files changed, 27 insertions(+), 3 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 2fced7a..d72c04e 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -1208,13 +1208,36 @@ static void set_call_type(struct phonebook_contact *contact,
 	contact->datetime = iso8601_utc_to_localtime(datetime);
 }
 
-static struct phonebook_contact *find_contact(GSList *contacts, const char *id)
+static gboolean contact_matches(struct contact_data *c_data, const char *id,
+							const char *datetime)
+{
+	char *localtime;
+	int cmp_ret;
+
+	if (g_strcmp0(c_data->id, id) != 0)
+		return FALSE;
+
+	/* id is equal and not call history entry => contact matches */
+	if (c_data->contact->calltype == CALL_TYPE_NOT_A_CALL)
+		return TRUE;
+
+	/* for call history entries have to compare also timestamps of calls */
+	localtime = iso8601_utc_to_localtime(datetime);
+	cmp_ret = g_strcmp0(c_data->contact->datetime, localtime);
+	g_free(localtime);
+
+	return (cmp_ret == 0) ? TRUE : FALSE;
+}
+
+static struct phonebook_contact *find_contact(GSList *contacts, const char *id,
+							const char *datetime)
 {
 	GSList *l;
 
 	for (l = contacts; l; l = l->next) {
 		struct contact_data *c_data = l->data;
-		if (g_strcmp0(c_data->id, id) == 0)
+
+		if (contact_matches(c_data, id, datetime))
 			return c_data->contact;
 	}
 
@@ -1609,7 +1632,8 @@ static int pull_contacts(const char **reply, int num_fields, void *user_data)
 
 	/* Trying to find contact in recently added contacts. It is needed for
 	 * contacts that have more than one telephone number filled */
-	contact = find_contact(data->contacts, reply[CONTACTS_ID_COL]);
+	contact = find_contact(data->contacts, reply[CONTACTS_ID_COL],
+							reply[COL_DATE]);
 
 	/* If contact is already created then adding only new phone numbers */
 	if (contact) {
-- 
1.7.0.4

