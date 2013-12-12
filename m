Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] android/tester: Add Socket data to generic test data struct
Date: Thu, 12 Dec 2013 12:49:09 +0200
Message-Id: <1386845350-13982-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1386845350-13982-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1386845350-13982-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Socket data will be used in generic Socket HAL tests
---
 android/android-tester.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index 185f57b..15fd29e 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -61,6 +61,14 @@ enum hal_bluetooth_callbacks_id {
 };
 
 struct generic_data {
+	/* Socket data */
+	btsock_type_t sock_type;
+	const char *service_name;
+	const uint8_t *service_uuid;
+	int channel;
+	int flags;
+	bt_status_t expected_status;
+
 	uint8_t expected_adapter_status;
 	uint32_t expect_settings_set;
 	uint8_t expected_hal_callbacks[];
-- 
1.8.3.2

