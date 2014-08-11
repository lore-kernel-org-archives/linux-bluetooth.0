Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 2/7] android/tester: Load audio module
Date: Mon, 11 Aug 2014 13:13:31 +0300
Message-Id: <1407752016-14863-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1407752016-14863-1-git-send-email-luiz.dentz@gmail.com>
References: <1407752016-14863-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is necessary to be able to do A2DP tests.
---
 android/tester-main.c | 11 ++++++++++-
 android/tester-main.h |  2 ++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/android/tester-main.c b/android/tester-main.c
index a9ccfcd..7d17470 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -1169,6 +1169,15 @@ static bool setup_base(struct test_data *data)
 
 	close(signal_fd[0]);
 
+	err = hw_get_module_by_class(AUDIO_HARDWARE_MODULE_ID,
+					AUDIO_HARDWARE_MODULE_ID_A2DP, &module);
+	if (err)
+		return false;
+
+	err = audio_hw_device_open(module, &data->audio);
+	if (err)
+		return false;
+
 	err = hw_get_module(BT_HARDWARE_MODULE_ID, &module);
 	if (err)
 		return false;
@@ -1187,7 +1196,6 @@ static bool setup_base(struct test_data *data)
 	if (!(data->steps = queue_new()))
 		return false;
 
-
 	return true;
 }
 
@@ -1418,6 +1426,7 @@ static void teardown(const void *test_data)
 	}
 
 	data->device->close(data->device);
+	audio_hw_device_close(data->audio);
 
 	if (!data->bluetoothd_pid)
 		tester_teardown_complete();
diff --git a/android/tester-main.h b/android/tester-main.h
index bdf54b2..ddca69c 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -43,6 +43,7 @@
 #include "src/shared/queue.h"
 
 #include <hardware/hardware.h>
+#include <hardware/audio.h>
 #include <hardware/bluetooth.h>
 #include <hardware/bt_sock.h>
 #include <hardware/bt_hh.h>
@@ -279,6 +280,7 @@ typedef enum {
 
 struct test_data {
 	struct mgmt *mgmt;
+	audio_hw_device_t *audio;
 	struct hw_device_t *device;
 	struct hciemu *hciemu;
 	enum hciemu_type hciemu_type;
-- 
1.9.3

