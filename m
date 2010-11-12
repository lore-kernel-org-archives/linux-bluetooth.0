Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH] Fix pull phonebook with non-zero offset parameter
Date: Fri, 12 Nov 2010 11:39:17 +0100
Message-Id: <1289558357-25724-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For non-zero liststartoffset parameter, contacts which index was before
offset were indexed more than once (e.g. when contact had more than one
phone number or address etc.), so pulling was started earlier - before
offset index was reached. This patch fix this problem and each contact
is indexed only once.
---
 plugins/phonebook-tracker.c |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 672d59f..811e4f0 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -1361,6 +1361,7 @@ static void pull_contacts(char **reply, int num_fields, void *user_data)
 	int last_index, i;
 	gboolean cdata_present = FALSE;
 	char *home_addr, *work_addr, *other_addr;
+	static gchar *temp_id;
 
 	if (num_fields < 0) {
 		data->cb(NULL, 0, num_fields, 0, data->user_data);
@@ -1396,7 +1397,14 @@ static void pull_contacts(char **reply, int num_fields, void *user_data)
 						TRACKER_DEFAULT_CONTACT_ME))
 		return;
 
-	data->index++;
+	if (data->index == 0)
+		temp_id = NULL;
+
+	if (g_strcmp0(temp_id, reply[CONTACTS_ID_COL])) {
+		data->index++;
+		g_free(temp_id);
+		temp_id = g_strdup(reply[CONTACTS_ID_COL]);
+	}
 
 	last_index = params->liststartoffset + params->maxlistcount;
 
@@ -1495,6 +1503,7 @@ done:
 fail:
 	g_slist_free(data->contacts);
 	g_free(data);
+	g_free(temp_id);
 }
 
 static void add_to_cache(char **reply, int num_fields, void *user_data)
-- 
1.6.3.3

