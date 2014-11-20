Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 1/2] shared/gatt-server: Fix bug in bt_gatt_server_unref.
Date: Wed, 19 Nov 2014 21:03:40 -0800
Message-Id: <1416459821-16478-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a check for NULL argument in bt_gatt_server_unref.
---
 src/shared/gatt-server.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 2ef9269..ef91289 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -1215,6 +1215,9 @@ struct bt_gatt_server *bt_gatt_server_ref(struct bt_gatt_server *server)
 
 void bt_gatt_server_unref(struct bt_gatt_server *server)
 {
+	if (!server)
+		return;
+
 	if (__sync_sub_and_fetch(&server->ref_count, 1))
 		return;
 
-- 
2.1.0.rc2.206.gedb03e5

