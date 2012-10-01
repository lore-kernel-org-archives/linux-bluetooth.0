Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 01/10] gdbus: Fix not freeing list node by using g_slist_delete_link
Date: Mon,  1 Oct 2012 20:53:32 +0300
Message-Id: <1349114021-19067-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

g_slist_remove_link does not free the node which can cause leaks so
replace that with g_slist_delete_link which does free memory properly.
---
 gdbus/watch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gdbus/watch.c b/gdbus/watch.c
index a402ca9..07feb61 100644
--- a/gdbus/watch.c
+++ b/gdbus/watch.c
@@ -574,7 +574,7 @@ static DBusHandlerResult message_filter(DBusConnection *connection,
 			continue;
 
 		remove_match(data);
-		listeners = g_slist_remove_link(listeners, l);
+		listeners = g_slist_delete_link(listeners, l);
 
 		filter_data_free(data);
 	}
-- 
1.7.11.4

