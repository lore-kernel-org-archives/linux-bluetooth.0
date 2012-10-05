Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 5/5] device: Move auth_type_t definition to device.c
Date: Fri, 5 Oct 2012 14:54:39 +0200
Message-ID: <1349441679-18557-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1349441679-18557-1-git-send-email-szymon.janc@tieto.com>
References: <1349441679-18557-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bonding is handled in device.c and auth_type_t is private device data
not used outside of it.

---
 src/device.c |    8 ++++++++
 src/device.h |    8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/device.c b/src/device.c
index 1615747..28fc989 100644
--- a/src/device.c
+++ b/src/device.c
@@ -82,6 +82,14 @@ struct bonding_req {
 	struct btd_device *device;
 };
 
+typedef enum {
+	AUTH_TYPE_PINCODE,
+	AUTH_TYPE_PASSKEY,
+	AUTH_TYPE_CONFIRM,
+	AUTH_TYPE_NOTIFY_PASSKEY,
+	AUTH_TYPE_NOTIFY_PINCODE,
+} auth_type_t;
+
 struct authentication_req {
 	auth_type_t type;
 	void *cb;
diff --git a/src/device.h b/src/device.h
index 0c16c18..d23f40d 100644
--- a/src/device.h
+++ b/src/device.h
@@ -26,14 +26,6 @@
 
 struct btd_device;
 
-typedef enum {
-	AUTH_TYPE_PINCODE,
-	AUTH_TYPE_PASSKEY,
-	AUTH_TYPE_CONFIRM,
-	AUTH_TYPE_NOTIFY_PASSKEY,
-	AUTH_TYPE_NOTIFY_PINCODE,
-} auth_type_t;
-
 struct btd_device *device_create(struct btd_adapter *adapter,
 				const char *address, uint8_t bdaddr_type);
 
-- 
1.7.9.5

