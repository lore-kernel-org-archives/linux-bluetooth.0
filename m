Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 14/15] android/gatt: Set proper status of write_data
Date: Wed, 24 Sep 2014 13:37:59 +0200
Message-Id: <1411558680-26856-15-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1411558680-26856-1-git-send-email-marcin.kraglak@tieto.com>
References: <1411558680-26856-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Set proper status in write characteristic callback data struct.
---
 android/gatt.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/gatt.c b/android/gatt.c
index 32db2af..1d9971c 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -3127,6 +3127,7 @@ static void send_client_write_char_notify(int32_t status, int32_t conn_id,
 
 	ev.conn_id = conn_id;
 	ev.status = status;
+	ev.data.status = status;
 
 	element_id_to_hal_srvc_id(srvc_id, primary, &ev.data.srvc_id);
 	element_id_to_hal_gatt_id(char_id, &ev.data.char_id);
-- 
1.9.3

