Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH v2] Fix incorrect number of expected columns in a response to NEW_MISSED_CALLS_LIST
Date: Wed, 18 May 2011 11:17:50 +0200
Message-Id: <1305710270-31716-1-git-send-email-lkslawek@gmail.com>
In-Reply-To: <1305710013-31563-1-git-send-email-lkslawek@gmail.com>
References: <1305710013-31563-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fixes error "GLIB CRITICAL ** Tracker -
tracker_db_cursor_get_value_type: assertion `column < n_columns' failed"
occurring when pulling phone book or doing listing for missed calls. The
number of expected columns in reply to NEW_MISSED_CALLS_LIST query was
incorrectly set to PULL_QUERY_COL_AMOUNT (23) but the query actually
returns 3 columns.
---
Just a little modification of a commit message.

 plugins/phonebook-tracker.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 9431d8a..8da8b80 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -49,6 +49,7 @@
 #define ADDR_FIELD_AMOUNT 7
 #define PULL_QUERY_COL_AMOUNT 23
 #define COUNT_QUERY_COL_AMOUNT 1
+#define NEW_MISSED_CALLS_COL_AMOUNT 3
 
 #define COL_PHONE_AFF 0 /* work/home phone numbers */
 #define COL_FULL_NAME 1
@@ -2029,7 +2030,7 @@ int phonebook_pull_read(void *request)
 
 	if (g_strcmp0(data->req_name, "/telecom/mch.vcf") == 0) {
 		query = NEW_MISSED_CALLS_LIST;
-		col_amount = PULL_QUERY_COL_AMOUNT;
+		col_amount = NEW_MISSED_CALLS_COL_AMOUNT;
 		pull_cb = pull_newmissedcalls;
 	} else if (data->params->maxlistcount == 0) {
 		query = name2count_query(data->req_name);
-- 
1.7.4.1

