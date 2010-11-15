Return-Path: <cyrus@holtmann.org>
From: Rafal Michalski <michalski.raf@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Rafal Michalski <michalski.raf@gmail.com>
Subject: [PATCH v2] Fix pull phonebook with non-zero offset parameter
Date: Mon, 15 Nov 2010 11:41:40 +0100
Message-Id: <1289817700-32136-1-git-send-email-michalski.raf@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For non-zero liststartoffset parameter, contacts which index was before
offset were indexed more than once (e.g. when contact had more than one
phone number or address etc.), so pulling was started earlier - before
offset index was reached. This patch fix this problem and each contact
is indexed only once.
---
 plugins/phonebook-tracker.c |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 672d59f..4309e28 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -1361,6 +1361,7 @@ static void pull_contacts(char **reply, int num_fields, void *user_data)
 	int last_index, i;
 	gboolean cdata_present = FALSE;
 	char *home_addr, *work_addr, *other_addr;
+	static char *temp_id = NULL;
 
 	if (num_fields < 0) {
 		data->cb(NULL, 0, num_fields, 0, data->user_data);
@@ -1396,7 +1397,11 @@ static void pull_contacts(char **reply, int num_fields, void *user_data)
 						TRACKER_DEFAULT_CONTACT_ME))
 		return;
 
-	data->index++;
+	if (g_strcmp0(temp_id, reply[CONTACTS_ID_COL])) {
+		data->index++;
+		g_free(temp_id);
+		temp_id = g_strdup(reply[CONTACTS_ID_COL]);
+	}
 
 	last_index = params->liststartoffset + params->maxlistcount;
 
@@ -1495,6 +1500,8 @@ done:
 fail:
 	g_slist_free(data->contacts);
 	g_free(data);
+	g_free(temp_id);
+	temp_id = NULL;
 }
 
 static void add_to_cache(char **reply, int num_fields, void *user_data)
-- 
1.6.3.3

