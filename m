Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH obexd 1/2] Fix invalid memory read when pulling phone book
Date: Wed,  6 Jul 2011 18:57:06 +0300
Message-Id: <1309967827-23772-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Data contacts are freed already in finalize function which is called
in query_result callback function. Calling free_data_contacts(data)
twice causes invalid memory read when dereferencing data->contacts.
---
 plugins/phonebook-tracker.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index d396203..7a1a003 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -1154,7 +1154,6 @@ static void send_pull_part(struct phonebook_data *data,
 	data->cb(vcards->str, vcards->len, g_slist_length(data->contacts),
 			data->newmissedcalls, lastpart, data->user_data);
 
-	free_data_contacts(data);
 	g_string_free(vcards, TRUE);
 }
 
-- 
1.7.4.1

