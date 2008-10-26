Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Sort devices by type in the treeviews
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-MTWOhQO9z/zrGHWqsRqB"
Date: Sun, 26 Oct 2008 12:39:30 +0000
Message-Id: <1225024770.1503.1398.camel@cookie.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-MTWOhQO9z/zrGHWqsRqB
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Sorting by RSSI means that the devices just around in the treeview
which is painfully annoying.

--=-MTWOhQO9z/zrGHWqsRqB
Content-Disposition: attachment; filename="0001-Sort-devices-by-type-in-the-treeviews.patch"
Content-Type: text/x-patch; name="0001-Sort-devices-by-type-in-the-treeviews.patch"; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From dcc41434b39493d97cd3ec36d07c8a59ae4f0211 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Sun, 26 Oct 2008 12:36:33 +0000
Subject: [PATCH] Sort devices by type in the treeviews

Sorting by RSSI means that the devices just around in the treeview
which is painfully annoying.
---
 common/helper.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/common/helper.c b/common/helper.c
index e53d4bc..7335b7f 100644
--- a/common/helper.c
+++ b/common/helper.c
@@ -185,7 +185,7 @@ gchar *show_browse_dialog(void)
 	model = bluetooth_client_get_device_model(client, NULL);
 	sorted = gtk_tree_model_sort_new_with_model(model);
 	gtk_tree_sortable_set_sort_column_id(GTK_TREE_SORTABLE(sorted),
-				BLUETOOTH_COLUMN_RSSI, GTK_SORT_DESCENDING);
+				BLUETOOTH_COLUMN_TYPE, GTK_SORT_DESCENDING);
 	tree = create_tree(sorted, TRUE);
 	g_object_unref(sorted);
 	g_object_unref(model);
-- 
1.6.0.3


--=-MTWOhQO9z/zrGHWqsRqB--

