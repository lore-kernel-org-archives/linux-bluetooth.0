Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/hal: Use debug helpers from hal client
Date: Fri, 25 Oct 2013 16:28:46 +0300
Message-Id: <1382707726-20118-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1382707726-20118-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1382707726-20118-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Debug helpers really helps a lot when debugging on Android target. The
patch uses helper functions already defined for hal test tool so
we do not need to reimplement them.
---
 android/Android.mk      |    1 +
 android/hal-bluetooth.c |    6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/android/Android.mk b/android/Android.mk
index 946e9cd..56c43cb 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -73,6 +73,7 @@ LOCAL_SRC_FILES := \
 	hal-hidhost.c \
 	hal-pan.c \
 	hal-av.c \
+	client/textconv.c \
 
 LOCAL_C_INCLUDES += \
 	$(call include-path-for, system-core) \
diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 282a680..5929fff 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -25,6 +25,8 @@
 #include "hal-msg.h"
 #include "hal-ipc.h"
 
+#include "client/textconv.h"
+
 static const bt_callbacks_t *bt_hal_cbacks = NULL;
 
 static void handle_adapter_state_changed(void *buf)
@@ -192,7 +194,7 @@ static int get_adapter_property(bt_property_type_t type)
 {
 	struct hal_cmd_get_adapter_prop cmd;
 
-	DBG("");
+	DBG("prop: %s", bt_property_type_t2str(type));
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
@@ -224,7 +226,7 @@ static int set_adapter_property(const bt_property_t *property)
 	char buf[sizeof(struct hal_cmd_set_adapter_prop) + property->len];
 	struct hal_cmd_set_adapter_prop *cmd = (void *) buf;
 
-	DBG("");
+	DBG("prop: %s", bt_property_type_t2str(property->type));
 
 	if (!interface_ready())
 		return BT_STATUS_NOT_READY;
-- 
1.7.10.4

