Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/6] android/hal-bluetooth: Implement set_os_callouts
Date: Fri, 21 Nov 2014 12:16:39 +0100
Message-Id: <1416568603-3666-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1416568603-3666-1-git-send-email-marcin.kraglak@tieto.com>
References: <1416568603-3666-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-bluetooth.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index defaef1..50e3f07 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -30,6 +30,7 @@
 #include "hal-utils.h"
 
 static const bt_callbacks_t *bt_hal_cbacks = NULL;
+static const bt_os_callouts_t *bt_os_callouts = NULL;
 
 #define enum_prop_to_hal(prop, hal_prop, type) do { \
 	static type e; \
@@ -981,9 +982,14 @@ static int get_connection_state(const bt_bdaddr_t *bd_addr)
 
 static int set_os_callouts(bt_os_callouts_t *callouts)
 {
-	DBG("callouts: %p", callouts);
+	DBG("");
 
-	/* TODO: implement */
+	/* TODO investigate how expose callouts for daemon */
+
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
+
+	bt_os_callouts = callouts;
 
 	return BT_STATUS_SUCCESS;
 }
-- 
1.9.3

