Return-Path: <cyrus@holtmann.org>
From: Slawomir Bochenski <lkslawek@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Slawomir Bochenski <lkslawek@gmail.com>
Subject: [PATCH obexd 1/2] PBAP/Tracker: Fix wrong results field reference
Date: Fri,  3 Feb 2012 12:03:25 +0100
Message-Id: <1328267006-29847-1-git-send-email-lkslawek@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The field passed for a phone number was actually a nickname field.
---
 plugins/phonebook-tracker.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/plugins/phonebook-tracker.c b/plugins/phonebook-tracker.c
index da82ff5..d358c9f 100644
--- a/plugins/phonebook-tracker.c
+++ b/plugins/phonebook-tracker.c
@@ -1409,10 +1409,10 @@ static int add_to_cache(const char **reply, int num_fields, void *user_data)
 	/* The owner vCard must have the 0 handle */
 	if (strcmp(reply[0], TRACKER_DEFAULT_CONTACT_ME) == 0)
 		data->entry_cb(reply[0], 0, formatted, "",
-						reply[6], data->user_data);
+						reply[7], data->user_data);
 	else
 		data->entry_cb(reply[0], PHONEBOOK_INVALID_HANDLE, formatted,
-					"", reply[6], data->user_data);
+					"", reply[7], data->user_data);
 
 	g_free(formatted);
 
-- 
1.7.4.1

