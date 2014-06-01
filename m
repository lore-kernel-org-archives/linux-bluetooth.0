Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RCF BlueZ] android/gatt: Initial prototype for profile API
Date: Sun,  1 Jun 2014 18:52:41 +0300
Message-Id: <1401637961-31220-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
The idea behind it is that HoG would use this API to register a callback
and internally Register App could also make use of it to register its own
callbacks, futhermore we can use the list of registered profiles to do
scanning and advertising handling.


 android/gatt.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/android/gatt.h b/android/gatt.h
index d4392d9..b91038a 100644
--- a/android/gatt.h
+++ b/android/gatt.h
@@ -23,3 +23,9 @@
 
 bool bt_gatt_register(struct ipc *ipc, const bdaddr_t *addr);
 void bt_gatt_unregister(void);
+
+typedef void (*gatt_conn_cb_t)(void *conn, int status, void *user_data);
+
+unsigned int bt_gatt_register_profile(const uint8_t *uuid, gatt_conn_cb_t func,
+							void *user_data);
+bool bt_gatt_unregister_profile(unsigned int id);
-- 
1.9.0

