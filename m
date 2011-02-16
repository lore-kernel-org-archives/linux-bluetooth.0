Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH] Add increasing query OFFSET in phonebook_pull_read
Date: Wed, 16 Feb 2011 11:34:15 +0200
Message-Id: <1297848855-29991-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It is needed to properly move starting index in tracker
for next invocations of phonebook_pull_read - without that
pull result for bigger queries (over one part of data) will
be wrong (it will include duplicate vcard entries).
---
 plugins/phonebook-tracker.c |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index eb38a46..28d5c7d 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -1964,6 +1964,7 @@ int phonebook_pull_read(void *request)
 	struct phonebook_data *data = request;
 	reply_list_foreach_t pull_cb;
 	const char *query;
+	char *offset_query;
 	int col_amount;
 	int ret;
 
@@ -1987,6 +1988,19 @@ int phonebook_pull_read(void *request)
 	if (query == NULL)
 		return -ENOENT;
 
+	if (pull_cb == pull_contacts && data->tracker_index > 0) {
+		/* Adding offset to pull query to download next parts of data
+		 * from tracker (phonebook_pull_read may be called many times
+		 * from PBAP core to fetch data partially) */
+		offset_query = g_strdup_printf(QUERY_OFFSET_FORMAT, query,
+							data->tracker_index);
+		ret = query_tracker(offset_query, col_amount, pull_cb, data);
+
+		g_free(offset_query);
+
+		return ret;
+	}
+
 	ret = query_tracker(query, col_amount, pull_cb, data);
 
 	return ret;
-- 
1.7.0.4

