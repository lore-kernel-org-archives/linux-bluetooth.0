Return-Path: <cyrus@holtmann.org>
From: Jaikumar Ganesh <jaikumar@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaikumar Ganesh <jaikumar@google.com>
Subject: [PATCH] Fix setting of mode after discovery times out.
Date: Tue,  5 Apr 2011 17:44:52 -0700
Message-Id: <1302050692-24497-1-git-send-email-jaikumar@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When discovery times out, we were not setting the mode appropriately.
Thus, if the adapter is turned off and on, we will get the incorrect mode.
Also add a forward declaration for the introduced circular dependency.
---
 src/adapter.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index c400bfd..014cc0c 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -156,6 +156,8 @@ struct btd_adapter {
 
 static void adapter_set_pairable_timeout(struct btd_adapter *adapter,
 					guint interval);
+static DBusMessage *set_discoverable(DBusConnection *conn, DBusMessage *msg,
+				gboolean discoverable, void *data);
 
 static int found_device_cmp(const struct remote_dev_info *d1,
 			const struct remote_dev_info *d2)
@@ -374,7 +376,7 @@ static gboolean discov_timeout_handler(gpointer user_data)
 
 	adapter->discov_timeout_id = 0;
 
-	adapter_ops->set_discoverable(adapter->dev_id, FALSE);
+	set_discoverable(NULL, NULL, FALSE, user_data);
 
 	return FALSE;
 }
-- 
1.7.3.1

