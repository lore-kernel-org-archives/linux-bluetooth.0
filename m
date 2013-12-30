Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 2/7] android/hal-bluetooth: Update snoop service name
Date: Mon, 30 Dec 2013 23:43:36 +0100
Message-Id: <1388443421-6295-2-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1388443421-6295-1-git-send-email-szymon.janc@gmail.com>
References: <1388443421-6295-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Match service name with android snoop binary name. It is more common
to use '-' instead of '_' in the code for binaries name.
---
 android/hal-bluetooth.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 9f9814a..a95c4ea 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -28,7 +28,7 @@
 #include "hal-ipc.h"
 #include "hal-utils.h"
 
-#define SNOOP_SERVICE_NAME "bluetoothd_snoop"
+#define SNOOP_SERVICE_NAME "bluetoothd-snoop"
 
 static const bt_callbacks_t *bt_hal_cbacks = NULL;
 
-- 
1.8.5.2

