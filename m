Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH 24/28] android/bas: Enable Battery Level notifications after reconnection
Date: Wed,  1 Apr 2015 18:40:40 +0200
Message-Id: <1427906444-11769-25-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1427906444-11769-1-git-send-email-mariusz.skamra@tieto.com>
References: <1427906444-11769-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bas.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/android/bas.c b/android/bas.c
index 3b641eb..ab33d59 100644
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

