Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ v1 01/17] shared/gatt: Call bt_att_cancel_all in unref
Date: Wed, 25 Feb 2015 21:13:14 -0800
Message-Id: <1424927610-26226-2-git-send-email-armansito@chromium.org>
In-Reply-To: <1424927610-26226-1-git-send-email-armansito@chromium.org>
References: <1424927610-26226-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes a potential invalid access that can occur if bt_att
outlives bt_gatt_client and if there are pending discovery requests
when bt_gatt_client_unref is called.

This patch fixes this by canceling all ATT operations that are handled
by the bt_att in bt_gatt_client_unref. The proper fix, however, is to
make the discovery procedures cancelable and to cancel those instead of
canceling everything. A TODO has been added to fix this later.
---
 src/shared/gatt-client.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index cc972d6..92e72e2 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -1529,6 +1529,15 @@ static void bt_gatt_client_free(struct bt_gatt_client *client)
 		bt_att_unregister_disconnect(client->att, client->disc_id);
 		bt_att_unregister(client->att, client->notify_id);
 		bt_att_unregister(client->att, client->ind_id);
+
+		/*
+		 * TODO: If we free bt_gatt_client while there is an ongoing
+		 * discovery procedure, the discovery callback may cause an
+		 * invalid access. To avoid this, we cancel all ongoing ATT
+		 * operations but the proper fix here is to make discovery
+		 * procedures cancelable.
+		 */
+		bt_att_cancel_all(client->att);
 		bt_att_unref(client->att);
 	}
 
-- 
2.2.0.rc0.207.ga3a616c

