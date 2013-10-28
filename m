Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android/hal: Set callbacks before initializing IPC
Date: Mon, 28 Oct 2013 16:45:37 +0100
Message-ID: <1382975137-12604-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Notification thread is started on IPC init and it can be scheduled
before main thread.

Fix following crash on HAL init:

pid: 3392, tid: 3492, name: droid.bluetooth  >>> com.android.bluetooth <<<
signal 11 (SIGSEGV), code 1 (SEGV_MAPERR), fault addr 00000028
    eax 00000000  ebx ce047f64  ecx ce0405d0  edx f7763724
    esi cdf3af00  edi f837fb90
    xcs 00000023  xds 0000002b  xes 0000002b  xfs 00000000  xss 0000002b
    eip ce042289  ebp cdf3a9f8  esp cdf3a9e0  flags 00010292

backtrace:
    #00  pc 00003289  /system/lib/hw/bluetooth.default.so (bt_thread_associate+25)
    #01  pc 000015f8  /system/lib/hw/bluetooth.default.so (notification_handler+40)
    #02  pc 0000f804  /system/lib/libc.so (__thread_entry+276)
    #03  pc 0002999d  /system/lib/libc.so
    #04  pc 00082ae7  /system/lib/libdvm.so (dvmThreadSelf()+39)
    #05  pc 00010db9  /system/lib/libc.so (pthread_mutex_unlock+25)
---
 android/hal-bluetooth.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 5929fff..5f6dcbe 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -114,11 +114,13 @@ static int init(bt_callbacks_t *callbacks)
 	if (interface_ready())
 		return BT_STATUS_SUCCESS;
 
-	if (!hal_ipc_init())
-		return BT_STATUS_FAIL;
-
 	bt_hal_cbacks = callbacks;
 
+	if (!hal_ipc_init()) {
+		bt_hal_cbacks = NULL;
+		return BT_STATUS_FAIL;
+	}
+
 	cmd.service_id = HAL_SERVICE_ID_BLUETOOTH;
 
 	status = hal_ipc_cmd(HAL_SERVICE_ID_CORE, HAL_OP_REGISTER_MODULE,
-- 
1.8.4.1

