Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v3 15/20] gatt: Add result callback for Write Request
Date: Thu, 13 Mar 2014 17:22:43 -0300
Message-Id: <1394742168-31073-16-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1394742168-31073-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1394721533-6932-1-git-send-email-claudio.takahasi@openbossa.org>
 <1394742168-31073-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds an extra callback to inform the result of the write
operation on an external entity to allow the core to reply properly
for the ATT request.
---
 src/gatt-dbus.c | 4 +++-
 src/gatt.h      | 5 ++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
index 7e81dc6..d703355 100644
--- a/src/gatt-dbus.c
+++ b/src/gatt-dbus.c
@@ -186,7 +186,9 @@ static void proxy_write_reply(const DBusError *derr, void *user_data)
 }
 
 static void proxy_write_cb(struct btd_attribute *attr,
-					const uint8_t *value, size_t len)
+					const uint8_t *value, size_t len,
+					btd_attr_write_result_t result,
+					void *user_data)
 {
 	GDBusProxy *proxy;
 
diff --git a/src/gatt.h b/src/gatt.h
index f4eebe5..ed5fe80 100644
--- a/src/gatt.h
+++ b/src/gatt.h
@@ -48,8 +48,11 @@ typedef void (*btd_attr_read_t) (struct btd_attribute *attr,
  * @err:	error in errno format.
  * @user_data:	user_data passed in btd_attr_write_t callback
  */
+typedef void (*btd_attr_write_result_t) (int err, void *user_data);
 typedef void (*btd_attr_write_t) (struct btd_attribute *attr,
-					const uint8_t *value, size_t len);
+					const uint8_t *value, size_t len,
+					btd_attr_write_result_t result,
+					void *user_data);
 
 /* btd_gatt_add_service - Add a service declaration to local attribute database.
  * @uuid:	Service UUID.
-- 
1.8.3.1

