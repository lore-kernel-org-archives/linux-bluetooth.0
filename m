Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 01/10] gatt: Remove useless debug
Date: Mon, 18 Sep 2017 15:39:52 +0300
Message-Id: <20170918124001.2617-2-luiz.dentz@gmail.com>
In-Reply-To: <20170918124001.2617-1-luiz.dentz@gmail.com>
References: <20170918124001.2617-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/gatt-client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index 419dadb99..d523b883a 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -1229,7 +1229,7 @@ static DBusMessage *characteristic_acquire_write(DBusConnection *conn,
 	chrc->write_io = new0(struct pipe_io, 1);
 
 	if (!bt_gatt_client_is_ready(gatt)) {
-		DBG("GATT not ready, wait until it becomes read");
+		/* GATT not ready, wait until it becomes ready */
 		if (!chrc->ready_id)
 			chrc->ready_id = bt_gatt_client_ready_register(gatt,
 							characteristic_ready,
-- 
2.13.5

