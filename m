Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH 3/7 v3] Remove unnecessary checking for num_fields in pull_contact
Date: Mon, 14 Feb 2011 11:19:47 +0200
Message-Id: <1297675191-8046-3-git-send-email-ext-jablonski.radoslaw@nokia.com>
In-Reply-To: <1297675191-8046-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
References: <1297675191-8046-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This check is no longer needed - it was used to ensure that no
error occured in querying tracker. This is redundant because
checking for that case is located in the beginning of pull_contacts
function.
---
 plugins/phonebook-tracker.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index 6b9bb2f..c80ee68 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -1634,9 +1634,7 @@ add_numbers:
 done:
 	vcards = gen_vcards(data->contacts, params);
 
-	if (num_fields == 0)
-		data->cb(vcards->str, vcards->len,
-					g_slist_length(data->contacts),
+	data->cb(vcards->str, vcards->len, g_slist_length(data->contacts),
 					data->newmissedcalls, data->user_data);
 
 	g_string_free(vcards, TRUE);
-- 
1.7.0.4

