Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Whitespace characters
Date: Thu, 28 Nov 2013 10:34:51 +0100
Message-Id: <1385631296-2856-3-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1385631296-2856-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1385631296-2856-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bt-hal-tester.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/android/bt-hal-tester.c b/android/bt-hal-tester.c
index 8bcb901..fab987b 100644
--- a/android/bt-hal-tester.c
+++ b/android/bt-hal-tester.c
@@ -86,7 +86,7 @@ static void read_info_callback(uint8_t status, uint16_t length,
 		tester_pre_setup_failed();
 		return;
 	}
-	
+
 	tester_pre_setup_complete();
 }
 
@@ -275,24 +275,24 @@ static void setup(const void *test_data)
 	bt_status_t status;
 	const hw_module_t *module;
 	hw_device_t *device;
-	
+
 	clock_gettime(CLOCK_REALTIME, &ts);
 	ts.tv_sec += WAIT_FOR_CONDITION_TIME;
 
 	pthread_mutex_lock(&emulator_mutex);
-	
+
 	if (pthread_create(&data->emulator_thread, NULL, emulator, NULL)) {
 		tester_setup_failed();
 		return;
 	}
 	if (pthread_cond_timedwait(&emulator_started_cond, &emulator_mutex, &ts)
-																	< 0) {
+									< 0) {
 		tester_setup_failed();
 		return;
 	} else {
 		data->emulator_started = true;
 	}
-	
+
 	pthread_mutex_unlock(&emulator_mutex);
 
 	err = hw_get_module(BT_HARDWARE_MODULE_ID, &module);
@@ -320,14 +320,14 @@ static void setup(const void *test_data)
 		data->if_bluetooth = NULL;
 		tester_setup_failed();
 	}
-	
+
 	tester_setup_complete();
 }
 
 static void teardown(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
-	
+
 	if (data->if_bluetooth)
 		data->if_bluetooth->cleanup();
 
-- 
1.8.4.2

