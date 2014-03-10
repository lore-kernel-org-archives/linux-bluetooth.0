Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v0 11/16] gatt: Add result callback for Write Request
Date: Mon, 10 Mar 2014 15:50:40 -0300
Message-Id: <1394477445-8987-12-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1394477445-8987-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1394477445-8987-1-git-send-email-claudio.takahasi@openbossa.org>
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
index d71d993..7bc19c8 100644
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
index f6b4aca..296258e 100644
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

