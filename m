Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH] Change order of freeing contacts data in send_pull_part
Date: Fri, 11 Mar 2011 12:24:55 +0200
Message-Id: <1299839095-12008-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Moved freeing data->contacts before asynchronous data sending
is triggered via data->cb callback.
This data is no longer needed anyway after vcards are generated
and freeing it later may cause race condition (because freeing
this data need to be handled also in phonebook_req_finalize to
avoid memory leaks when client disconnects in the middle of
retrieving contacts from db).
---
 plugins/phonebook-tracker.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 2fced7a..f241cb4 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -1576,13 +1576,16 @@ static void send_pull_part(struct phonebook_data *data,
 			const struct apparam_field *params, gboolean lastpart)
 {
 	GString *vcards;
+	int amount;
 
 	DBG("");
 	vcards = gen_vcards(data->contacts, params);
-	data->cb(vcards->str, vcards->len, g_slist_length(data->contacts),
-			data->newmissedcalls, lastpart, data->user_data);
-
+	amount = g_slist_length(data->contacts);
 	free_data_contacts(data);
+
+	data->cb(vcards->str, vcards->len, amount, data->newmissedcalls,
+						lastpart, data->user_data);
+
 	g_string_free(vcards, TRUE);
 }
 
-- 
1.7.0.4

