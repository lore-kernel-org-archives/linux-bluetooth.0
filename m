Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <johan.hedberg@gmail.com>, <szymon.janc@tieto.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 1/2 v2] android: Use BASELEN define for property changed
Date: Thu, 7 Nov 2013 10:19:50 +0100
Message-ID: <1383815991-18523-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/adapter.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/android/adapter.c b/android/adapter.c
index 1d462c8..45a40f9 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -47,6 +47,8 @@
 
 /* Default to DisplayYesNo */
 #define DEFAULT_IO_CAPABILITY 0x01
+#define BASELEN_PROP_CHANGED sizeof(struct hal_ev_adapter_props_changed) \
+				+ (sizeof(struct hal_property))
 
 static GIOChannel *notification_io = NULL;
 /* This list contains addresses which are asked for records */
@@ -90,7 +92,7 @@ static void adapter_name_changed(const uint8_t *name)
 {
 	struct hal_ev_adapter_props_changed *ev;
 	size_t len = strlen((const char *) name);
-	uint8_t buf[sizeof(*ev) + sizeof(struct hal_property) + len];
+	uint8_t buf[BASELEN_PROP_CHANGED + len];
 
 	memset(buf, 0, sizeof(buf));
 	ev = (void *) buf;
-- 
1.8.4

