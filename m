Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 4/7] android/tester: Add Socket data to generic test data struct
Date: Thu, 12 Dec 2013 14:48:31 +0200
Message-Id: <1386852514-17270-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1386852514-17270-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1386852514-17270-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Socket data will be used in generic Socket HAL tests
---
 android/android-tester.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index c58b13a..11c3639 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -66,6 +66,15 @@ struct generic_data {
 	uint8_t expected_hal_callbacks[];
 };
 
+struct socket_data {
+	btsock_type_t sock_type;
+	const char *service_name;
+	const uint8_t *service_uuid;
+	int channel;
+	int flags;
+	bt_status_t expected_status;
+};
+
 #define WAIT_FOR_SIGNAL_TIME 2 /* in seconds */
 #define EMULATOR_SIGNAL "emulator_started"
 
-- 
1.8.3.2

