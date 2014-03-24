Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org
Subject: [PATCH BlueZ v8 3/8] gatt: Add result callback for Write Request
Date: Mon, 24 Mar 2014 10:30:04 -0300
Message-Id: <1395667809-17602-4-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1395667809-17602-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1395429403-493-1-git-send-email-claudio.takahasi@openbossa.org>
 <1395667809-17602-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a callback to allow the service implementation to inform
the core (ATT layer) the result of the write operation. Used to handle
ATT Write Request procedure, which requires ATT response.
---
 src/gatt-dbus.c |  4 +++-
 src/gatt.h      | 16 +++++++++++++++-
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/src/gatt-dbus.c b/src/gatt-dbus.c
index cdb46c4..9ab7b8b 100644
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
index d5dc7e6..8137e81 100644
--- a/src/gatt.h
+++ b/src/gatt.h
@@ -42,15 +42,29 @@ typedef void (*btd_attr_read_result_t) (int err, uint8_t *value, size_t len,
 typedef void (*btd_attr_read_t) (struct btd_attribute *attr,
 						btd_attr_read_result_t result,
 						void *user_data);
+
+/*
+ * Write operation result callback. Called from the service implementation
+ * informing the core (ATT layer) the result of the write operation. It is used
+ * to manage Write Request operations.
+ * @err:	error in -errno format.
+ * @user_data:	user_data passed in btd_attr_write_t callback.
+ */
+typedef void (*btd_attr_write_result_t) (int err, void *user_data);
 /*
  * Service implementation callback passed to core (ATT layer). It manages write
  * operations received from remote devices.
  * @attr:	reference of the attribute to be changed.
  * @value:	new attribute value.
  * @len:	length of value.
+ * @result:	callback called from the service implementation informing the
+ *		result of the write operation.
+ * @user_data:	user_data passed in btd_attr_write_result_t callback.
  */
 typedef void (*btd_attr_write_t) (struct btd_attribute *attr,
-					const uint8_t *value, size_t len);
+					const uint8_t *value, size_t len,
+					btd_attr_write_result_t result,
+					void *user_data);
 
 /* btd_gatt_add_service - Add a service declaration to local attribute database.
  * @uuid:	Service UUID.
-- 
1.8.3.1

