Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android: Fix sending scan mode property
Date: Wed, 30 Oct 2013 12:23:04 +0100
Message-ID: <1383132184-31087-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This fix setting adapter discoverable from Android UI.

This type is enum on HAL side and we need to pass right number of
bytes. Otherwise will get exceptions from Java TLV handling code.

This patch makes assumption that size of enum is 4 bytes.
---
 android/adapter.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index 15b65e5..16db4dd 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -87,7 +87,7 @@ static void powered_changed(void)
 			HAL_EV_ADAPTER_STATE_CHANGED, sizeof(ev), &ev, -1);
 }
 
-static uint8_t settings2scan_mode(void)
+static uint32_t settings2scan_mode(void)
 {
 	bool connectable, discoverable;
 
@@ -106,9 +106,9 @@ static uint8_t settings2scan_mode(void)
 static void scan_mode_changed(void)
 {
 	struct hal_ev_adapter_props_changed *ev;
-	uint8_t *mode;
+	uint32_t mode;
 	int len;
-	len = sizeof(*ev) + sizeof(struct hal_property) + 1;
+	len = sizeof(*ev) + sizeof(struct hal_property) + sizeof(mode);
 
 	ev = g_malloc(len);
 
@@ -116,12 +116,12 @@ static void scan_mode_changed(void)
 	ev->status = HAL_STATUS_SUCCESS;
 
 	ev->props[0].type = HAL_PROP_ADAPTER_SCAN_MODE;
-	ev->props[0].len = 1;
+	ev->props[0].len = sizeof(mode);
 
-	mode = ev->props[0].val;
-	*mode = settings2scan_mode();
+	mode = settings2scan_mode();
+	memcpy(ev->props[0].val, &mode, sizeof(mode));
 
-	DBG("mode %u", *mode);
+	DBG("mode %u", mode);
 
 	ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH,
 				HAL_EV_ADAPTER_PROPS_CHANGED, len, ev, -1);
-- 
1.8.4.1

