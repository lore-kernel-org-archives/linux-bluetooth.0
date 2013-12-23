Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/6] android/tester: Whitespace and semicolon style correction
Date: Mon, 23 Dec 2013 12:50:27 +0100
Message-Id: <1387799429-6674-4-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1387799429-6674-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1387799429-6674-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch correct redundant semicolon (in other test cases there were
no semicolon at last struct element). Additional whitespace was removed
from function.
---
 android/android-tester.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 2a9323f..547488e 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -759,7 +759,7 @@ static const struct generic_data bluetooth_getprop_bdname_success_test = {
 	.expected_adapter_status = BT_STATUS_SUCCESS,
 	.expected_property.type = BT_PROPERTY_BDNAME,
 	.expected_property.val = test_bdname,
-	.expected_property.len = sizeof(test_bdname) - 1,
+	.expected_property.len = sizeof(test_bdname) - 1
 };
 
 static unsigned char setprop_uuids[] = { 0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00,
@@ -1483,7 +1483,6 @@ static void test_listen_close(const void *test_data)
 clean:
 	if (sock_fd >= 0)
 		close(sock_fd);
-
 }
 
 static void test_listen_listen(const void *test_data)
@@ -1551,7 +1550,6 @@ clean:
 		close(sock_fd);
 }
 
-
 static gboolean socket_chan_cb(GIOChannel *io, GIOCondition cond,
 							gpointer user_data)
 {
-- 
1.8.4.2

