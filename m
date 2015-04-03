Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCHv2 23/27] android/bas: Enable Battery Level notifications after reconnection
Date: Fri,  3 Apr 2015 15:43:52 +0200
Message-Id: <1428068636-13073-24-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1428068636-13073-1-git-send-email-mariusz.skamra@tieto.com>
References: <1428068636-13073-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bas.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/android/bas.c b/android/bas.c
index d70a44d..145d4da 100644
--- a/android/bas.c
+++ b/android/bas.c
@@ -149,6 +149,10 @@ bool bt_bas_attach(struct bt_bas *bas, struct bt_gatt_client *client)
 
 	if (!bas->handle)
 		gatt_db_service_foreach_char(attrib, bas_discovered_cb, bas);
+	else
+		bas->id = bt_gatt_client_register_notify(bas->client,
+						bas->handle, ccc_written_cb,
+						notification_cb, bas, NULL);
 
 	return true;
 }
-- 
1.9.1

