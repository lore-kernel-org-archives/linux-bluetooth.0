Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/tester: Fix NULL dereference in socket setup
Date: Fri,  3 Jan 2014 12:26:14 +0200
Message-Id: <1388744774-17418-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add return statement to avoid NULL dereference in socket setup.
---
 android/android-tester.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/android-tester.c b/android/android-tester.c
index e34d1bd..9a161ad 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -1567,6 +1567,7 @@ static void setup_socket_interface(const void *test_data)
 	if (status != BT_STATUS_SUCCESS) {
 		data->if_bluetooth = NULL;
 		tester_setup_failed();
+		return;
 	}
 
 	sock = data->if_bluetooth->get_profile_interface(BT_PROFILE_SOCKETS_ID);
@@ -1592,6 +1593,7 @@ static void setup_socket_interface_enabled(const void *test_data)
 	if (status != BT_STATUS_SUCCESS) {
 		data->if_bluetooth = NULL;
 		tester_setup_failed();
+		return;
 	}
 
 	sock = data->if_bluetooth->get_profile_interface(BT_PROFILE_SOCKETS_ID);
-- 
1.8.3.2

