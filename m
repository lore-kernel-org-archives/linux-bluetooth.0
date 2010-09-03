Return-Path: <cyrus@holtmann.org>
From: Lukasz Pawlik <lucas.pawlik@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Pawlik <lucas.pawlik@gmail.com>
Subject: [PATCH] Fix problem with phonebook size
Date: Fri,  3 Sep 2010 12:21:51 +0200
Message-Id: <1283509311-3965-1-git-send-email-lucas.pawlik@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fix problem with phonebook size during phonebook
pull request. Now obexd "combine" the raw results from tracker DB
to match with that what phonebook pull returns.
---
 plugins/phonebook-tracker.c |   13 ++++++-------
 1 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index bdd9587..2bb5c4f 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -842,13 +842,11 @@ static void pull_contacts(char **reply, int num_fields, void *user_data)
 
 	data->index++;
 
-	/* Just interested in knowing the phonebook size */
-	if (!data->vcardentry && params->maxlistcount == 0)
-		return;
-
 	last_index = params->liststartoffset + params->maxlistcount;
 
-	if (data->index <= params->liststartoffset || data->index > last_index)
+	if ((data->index <= params->liststartoffset ||
+			data->index > last_index) &&
+			params->maxlistcount > 0)
 		return;
 
 add_entry:
@@ -910,8 +908,9 @@ done:
 	vcards = gen_vcards(data->contacts, params);
 
 	if (num_fields == 0)
-		data->cb(vcards->str, vcards->len, data->index, 0,
-							data->user_data);
+		data->cb(vcards->str, vcards->len,
+				g_slist_length(data->contacts), 0,
+				data->user_data);
 
 	g_slist_free(data->contacts);
 	g_string_free(vcards, TRUE);
-- 
1.7.0.4

