Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 2/2] android/daemon: Fix setting adapter name
Date: Mon,  4 Nov 2013 12:49:40 +0200
Message-Id: <1383562180-21646-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1383562180-21646-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1383562180-21646-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Android use the full string returned even if we terminate it with '\0'.
---
 android/adapter.c |   11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/android/adapter.c b/android/adapter.c
index fdac82e..1b84956 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -145,8 +145,8 @@ static void scan_mode_changed(void)
 static void adapter_name_changed(const uint8_t *name)
 {
 	struct hal_ev_adapter_props_changed *ev;
-	uint8_t buf[sizeof(*ev) + sizeof(struct hal_property) +
-							HAL_MAX_NAME_LENGTH];
+	size_t len = strlen((const char *) name);
+	uint8_t buf[sizeof(*ev) + sizeof(struct hal_property) + len];
 
 	memset(buf, 0, sizeof(buf));
 	ev = (void *) buf;
@@ -154,10 +154,11 @@ static void adapter_name_changed(const uint8_t *name)
 	ev->num_props = 1;
 	ev->status = HAL_STATUS_SUCCESS;
 	ev->props[0].type = HAL_PROP_ADAPTER_NAME;
-	ev->props[0].len = HAL_MAX_NAME_LENGTH;
-	memcpy(ev->props->val, name, HAL_MAX_NAME_LENGTH);
+	/* Android expects value without NULL terminator */
+	ev->props[0].len = len;
+	memcpy(ev->props->val, name, len);
 
-	DBG("Adapter name changed to: %s", ev->props->val);
+	DBG("Adapter name changed to: %s", name);
 
 	ipc_send(notification_io, HAL_SERVICE_ID_BLUETOOTH,
 			HAL_EV_ADAPTER_PROPS_CHANGED, sizeof(buf), ev, -1);
-- 
1.7.10.4

