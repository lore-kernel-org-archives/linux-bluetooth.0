Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 2/2] core: Avoid unnecessary gboolean on pincode callback API
Date: Thu, 16 May 2013 12:25:10 -0400
Message-Id: <1368721510-14339-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1368721510-14339-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1368721510-14339-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use standard "bool" type instead. Callers in plugins/* are fixed on the
same commit to avoid compilation errors.
---
 plugins/autopair.c |    8 ++++----
 plugins/wiimote.c  |    3 ++-
 src/adapter.c      |    5 ++---
 src/adapter.h      |    2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/plugins/autopair.c b/plugins/autopair.c
index 63f906d..63c3400 100644
--- a/plugins/autopair.c
+++ b/plugins/autopair.c
@@ -51,9 +51,9 @@
  */
 
 static ssize_t autopair_pincb(struct btd_adapter *adapter,
-					struct btd_device *device,
-					char *pinbuf, gboolean *display,
-					unsigned int attempt)
+						struct btd_device *device,
+						char *pinbuf, bool *display,
+						unsigned int attempt)
 {
 	char addr[18];
 	char pinstr[7];
@@ -109,7 +109,7 @@ static ssize_t autopair_pincb(struct btd_adapter *adapter,
 
 			snprintf(pinstr, sizeof(pinstr), "%06d",
 						rand() % 1000000);
-			*display = TRUE;
+			*display = true;
 			memcpy(pinbuf, pinstr, 6);
 			return 6;
 
diff --git a/plugins/wiimote.c b/plugins/wiimote.c
index 12312b6..beda307 100644
--- a/plugins/wiimote.c
+++ b/plugins/wiimote.c
@@ -70,7 +70,8 @@ static const char *wii_names[] = {
 };
 
 static ssize_t wii_pincb(struct btd_adapter *adapter, struct btd_device *device,
-			char *pinbuf, gboolean *display, unsigned int attempt)
+						char *pinbuf, bool *display,
+						unsigned int attempt)
 {
 	uint16_t vendor, product;
 	char addr[18], name[25];
diff --git a/src/adapter.c b/src/adapter.c
index adb2a17..73e75a2 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -4810,8 +4810,7 @@ static ssize_t btd_adapter_pin_cb_iter_next(
 					struct btd_adapter_pin_cb_iter *iter,
 					struct btd_adapter *adapter,
 					struct btd_device *device,
-					char *pin_buf,
-					gboolean *display)
+					char *pin_buf, bool *display)
 {
 	btd_adapter_pin_cb_t cb;
 	ssize_t ret;
@@ -4836,7 +4835,7 @@ static void pin_code_request_callback(uint16_t index, uint16_t length,
 	const struct mgmt_ev_pin_code_request *ev = param;
 	struct btd_adapter *adapter = user_data;
 	struct btd_device *device;
-	gboolean display = FALSE;
+	bool display = false;
 	char pin[17];
 	ssize_t pinlen;
 	char addr[18];
diff --git a/src/adapter.h b/src/adapter.h
index 2de8730..32b12c0 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -132,7 +132,7 @@ int btd_cancel_authorization(guint id);
 int btd_adapter_restore_powered(struct btd_adapter *adapter);
 
 typedef ssize_t (*btd_adapter_pin_cb_t) (struct btd_adapter *adapter,
-			struct btd_device *dev, char *out, gboolean *display,
+			struct btd_device *dev, char *out, bool *display,
 							unsigned int attempt);
 void btd_adapter_register_pin_cb(struct btd_adapter *adapter,
 						btd_adapter_pin_cb_t cb);
-- 
1.7.9.5

