Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH v2] Fix newmissedcalls handling for large responses
Date: Thu, 19 May 2011 10:29:22 +0300
Message-Id: <1305790162-14888-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Previously pull_newmissedcalls was called for every part when
processing large response (more that one part of results) and
number of 'newmissedcalls' was wrong in that scenario.
Now newmissedcalls will be counted only once (during generating
first part of mch results).
---
 plugins/phonebook-tracker.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index eec1e5d..0d49342 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -1544,7 +1544,11 @@ int phonebook_pull_read(void *request)
 	if(!data)
 		return -ENOENT;
 
-	if (g_strcmp0(data->req_name, "/telecom/mch.vcf") == 0) {
+	if (g_strcmp0(data->req_name,"/telecom/mch.vcf") == 0 &&
+			data->tracker_index == 0) {
+		/* new missed calls amount should be counted only once - it
+		 * will be done during generating first part of results of
+		 * missed calls history */
 		query = NEW_MISSED_CALLS_LIST;
 		col_amount = NEW_MISSED_CALLS_COL_AMOUNT;
 		pull_cb = pull_newmissedcalls;
-- 
1.7.0.4

