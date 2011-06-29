Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/6] Make use of g_slist_free_full on hciops plugin
Date: Wed, 29 Jun 2011 11:52:53 +0300
Message-Id: <1309337573-8295-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1309337573-8295-1-git-send-email-luiz.dentz@gmail.com>
References: <1309337573-8295-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 plugins/hciops.c |   11 +++--------
 1 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/plugins/hciops.c b/plugins/hciops.c
index 147f7ea..92f976a 100644
--- a/plugins/hciops.c
+++ b/plugins/hciops.c
@@ -2236,14 +2236,9 @@ static void stop_hci_dev(int index)
 
 	hci_close_dev(dev->sk);
 
-	g_slist_foreach(dev->keys, (GFunc) g_free, NULL);
-	g_slist_free(dev->keys);
-
-	g_slist_foreach(dev->uuids, (GFunc) g_free, NULL);
-	g_slist_free(dev->uuids);
-
-	g_slist_foreach(dev->connections, (GFunc) conn_free, NULL);
-	g_slist_free(dev->connections);
+	g_slist_free_full(dev->keys, g_free);
+	g_slist_free_full(dev->uuids, g_free);
+	g_slist_free_full(dev->connections, g_free);
 
 	init_dev_info(index, -1, dev->registered, dev->already_up);
 }
-- 
1.7.5.4

