Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH BlueZ v0] gatt: Fix read callback description
Date: Mon, 24 Mar 2014 10:34:18 -0300
Message-Id: <1395668058-30311-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/gatt.h | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/src/gatt.h b/src/gatt.h
index daa8d54..fafbddb 100644
--- a/src/gatt.h
+++ b/src/gatt.h
@@ -28,17 +28,23 @@ void gatt_init(void);
 void gatt_cleanup(void);
 
 /*
- * Callbacks of this type are called once the value from the attribute is
- * ready to be read from the service implementation. Result callback is
- * the asynchronous function that should be used to inform the caller
- * the read value.
+ * Read operation result callback. Called from the service implementation
+ * informing the core (ATT layer) the result of read operation.
  * @err:	error in -errno format.
- * @value:	pointer to value
- * @len:	length of value
- * @user_data:	user_data passed in btd_attr_read_t callback
+ * @value:	value of the attribute read.
+ * @len:	length of value.
+ * @user_data:	user_data passed in btd_attr_read_t callback.
  */
 typedef void (*btd_attr_read_result_t) (int err, uint8_t *value, size_t len,
 							void *user_data);
+/*
+ * Service implementation callback passed to core (ATT layer). It manages read
+ * operations received from remote devices.
+ * @attr:	reference of the attribute to be read.
+ * @result:	callback called from the service implementation informing the
+ *		value of attribute read.
+ * @user_data:	user_data passed in btd_attr_read_result_t callback.
+ */
 typedef void (*btd_attr_read_t) (struct btd_attribute *attr,
 						btd_attr_read_result_t result,
 						void *user_data);
-- 
1.8.3.1

