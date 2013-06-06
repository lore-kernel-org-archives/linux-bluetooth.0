Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [RFC v0 2/5] adapter: rename compare_discovery_sender
Date: Thu,  6 Jun 2013 15:18:56 +0100
Message-Id: <1370528339-7921-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1370528339-7921-1-git-send-email-gustavo@padovan.org>
References: <1370528339-7921-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

The new name "compare_sender" is more generic and will be used for more
than one purpose.
---
 src/adapter.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 0277057..bb5737e 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1478,7 +1478,7 @@ static void stop_discovery_complete(uint8_t status, uint16_t length,
 	}
 }
 
-static int compare_discovery_sender(gconstpointer a, gconstpointer b)
+static int compare_sender(gconstpointer a, gconstpointer b)
 {
 	const struct watch_client *client = a;
 	const char *sender = b;
@@ -1617,7 +1617,7 @@ static DBusMessage *start_discovery(DBusConnection *conn,
 	 * already started a discovery then return an error.
 	 */
 	list = g_slist_find_custom(adapter->discovery_list, sender,
-						compare_discovery_sender);
+						compare_sender);
 	if (list)
 		return btd_error_busy(msg);
 
@@ -1657,7 +1657,7 @@ static DBusMessage *stop_discovery(DBusConnection *conn,
 		return btd_error_not_ready(msg);
 
 	list = g_slist_find_custom(adapter->discovery_list, sender,
-						compare_discovery_sender);
+						compare_sender);
 	if (!list)
 		return btd_error_failed(msg, "No discovery started");
 
-- 
1.8.1.4

