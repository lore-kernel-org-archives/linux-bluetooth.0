Return-Path: <cyrus@holtmann.org>
From: Sheldon Demario <sheldon.demario@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Sheldon Demario <sheldon.demario@openbossa.org>
Subject: [PATCH] Fix Characteristic read by UUID on gatttool
Date: Tue,  5 Apr 2011 15:37:45 -0300
Message-Id: <1302028665-5227-1-git-send-email-sheldon.demario@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Characteristic read by UUID GATT procedure is not incremental, i.e. it
returns the entire list in a single Read By Type request. Therefore it
should not be called recursively.
---
 attrib/gatttool.c    |    6 ------
 attrib/interactive.c |    6 ------
 2 files changed, 0 insertions(+), 12 deletions(-)

diff --git a/attrib/gatttool.c b/attrib/gatttool.c
index 0dfbc04..be91967 100644
--- a/attrib/gatttool.c
+++ b/attrib/gatttool.c
@@ -273,12 +273,6 @@ static void char_read_by_uuid_cb(guint8 status, const guint8 *pdu,
 
 	att_data_list_free(list);
 
-	gatt_read_char_by_uuid(char_data->attrib, char_data->start,
-					char_data->end, opt_uuid,
-					char_read_by_uuid_cb,
-					char_data);
-
-	return;
 done:
 	g_free(char_data);
 	g_main_loop_quit(event_loop);
diff --git a/attrib/interactive.c b/attrib/interactive.c
index 3fafb1e..9a55641 100644
--- a/attrib/interactive.c
+++ b/attrib/interactive.c
@@ -315,14 +315,8 @@ static void char_read_by_uuid_cb(guint8 status, const guint8 *pdu,
 
 	att_data_list_free(list);
 
-	gatt_read_char_by_uuid(attrib, char_data->start, char_data->end,
-					&char_data->uuid, char_read_by_uuid_cb,
-					char_data);
-
 	rl_forced_update_display();
 
-	return;
-
 done:
 	g_free(char_data);
 }
-- 
1.7.1

