Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/12] android/tester: Remove unused assignment
Date: Fri,  4 Jul 2014 16:43:58 +0300
Message-Id: <1404481441-734-10-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1404481441-734-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1404481441-734-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Fixes clang warning:
...
android/android-tester.c:1014:2: warning: Value stored to 'status' is
never read
        status =
data->if_bluetooth->get_remote_device_property(&remote_addr, prop.type);
1 warning generated.
...
---
 android/android-tester.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index bf39517..ff29675 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -1011,7 +1011,7 @@ static void remote_setprop_device_found_cb(int num_properties,
 									&prop);
 	check_expected_status(status);
 
-	status = data->if_bluetooth->get_remote_device_property(&remote_addr, prop.type);
+	data->if_bluetooth->get_remote_device_property(&remote_addr, prop.type);
 }
 
 static void remote_setprop_fail_device_found_cb(int num_properties,
-- 
1.9.1

