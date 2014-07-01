Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] android/gatt: Fix duplicate const
Date: Tue,  1 Jul 2014 15:50:43 +0300
Message-Id: <1404219043-4216-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1404219043-4216-1-git-send-email-luiz.dentz@gmail.com>
References: <1404219043-4216-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 android/gatt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/gatt.c b/android/gatt.c
index 677a337..95de221 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -82,7 +82,7 @@ typedef enum {
 	DEVICE_CONNECTED,		/* connection has been established */
 } gatt_device_state_t;
 
-static const char const *device_state_str[] = {
+static const char *device_state_str[] = {
 	"DISCONNECTED",
 	"CONNECT INIT",
 	"CONNECT READY",
-- 
1.9.3

