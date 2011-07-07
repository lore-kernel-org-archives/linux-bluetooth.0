Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org, radoslawjablonski@gmail.com
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH obexd v2] Fix invalid memory read when pulling phone book
Date: Thu,  7 Jul 2011 15:01:40 +0300
Message-Id: <1310040100-31241-2-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1310040100-31241-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1310040100-31241-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Data contacts are freed ones in finalize function which is called in
query_result callback function. Calling free_data_contacts(data) twice
for last phone book part causes invalid memory read when dereferencing
data->contacts.
---
 plugins/phonebook-tracker.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index d396203..e4e7779 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -1154,7 +1154,8 @@ static void send_pull_part(struct phonebook_data *data,
 	data->cb(vcards->str, vcards->len, g_slist_length(data->contacts),
 			data->newmissedcalls, lastpart, data->user_data);
 
-	free_data_contacts(data);
+	if (!lastpart)
+		free_data_contacts(data);
 	g_string_free(vcards, TRUE);
 }
 
-- 
1.7.4.1

