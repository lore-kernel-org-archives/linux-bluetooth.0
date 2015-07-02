Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vcgomes@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vcgomes@gmail.com>
Subject: [RFC BlueZ 09/13] peripheral/gatt: Use LOW security level
Date: Thu,  2 Jul 2015 11:33:50 -0300
Message-Id: <1435847634-22831-10-git-send-email-vcgomes@gmail.com>
In-Reply-To: <1435847634-22831-1-git-send-email-vcgomes@gmail.com>
References: <1435847634-22831-1-git-send-email-vcgomes@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Mostly to help testing. And for heartrate, the profile being implemented
in later patches, this is a valid security level for useful use cases.
---
 peripheral/gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/peripheral/gatt.c b/peripheral/gatt.c
index 0cb4f6d..0b5d5fe 100644
--- a/peripheral/gatt.c
+++ b/peripheral/gatt.c
@@ -134,7 +134,7 @@ static struct gatt_conn *gatt_conn_new(int fd)
 	bt_att_set_close_on_unref(conn->att, true);
 	bt_att_register_disconnect(conn->att, gatt_conn_disconnect, conn, NULL);
 
-	bt_att_set_security(conn->att, BT_SECURITY_MEDIUM);
+	bt_att_set_security(conn->att, BT_SECURITY_LOW);
 
 	conn->gatt = bt_gatt_server_new(gatt_db, conn->att, mtu);
 	if (!conn->gatt) {
-- 
2.4.5

