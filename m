Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH 4/7 v2] Support for stop fetching data when maxlistcount is achieved
Date: Fri, 11 Feb 2011 16:05:36 +0200
Message-Id: <1297433139-10923-4-git-send-email-ext-jablonski.radoslaw@nokia.com>
In-Reply-To: <1297433139-10923-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
References: <1297433139-10923-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When desired number of results has been already processed,
then sending already collected data and stopping fetching
more results from tracker (previously in this scenario
unnecessarily processing data continued untill end of results
in db)
---
 plugins/phonebook-tracker.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index be94867..afd738c 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -1602,11 +1602,17 @@ static int pull_contacts(const char **reply, int num_fields, void *user_data)
 
 	last_index = params->liststartoffset + params->maxlistcount;
 
-	if ((data->index <= params->liststartoffset ||
-						data->index > last_index) &&
-						params->maxlistcount > 0)
+	if (data->index <= params->liststartoffset)
 		return 0;
 
+	/* max number of results achieved - need send vcards data that was
+	 * already collected and stop further data processing (these operations
+	 * will be invoked in "done" section) */
+	if (data->index > last_index && params->maxlistcount > 0) {
+		DBG("Maxlistcount achieved");
+		goto done;
+	}
+
 add_entry:
 	contact = g_new0(struct phonebook_contact, 1);
 	contact_init(contact, reply);
-- 
1.7.0.4

