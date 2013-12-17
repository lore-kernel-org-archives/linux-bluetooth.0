Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/tester: Fix not returning in failure
Date: Tue, 17 Dec 2013 16:17:33 +0200
Message-Id: <1387289853-8942-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/android-tester.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/android/android-tester.c b/android/android-tester.c
index 2a8c8d0..c193921 100644
--- a/android/android-tester.c
+++ b/android/android-tester.c
@@ -851,8 +851,10 @@ static void setup_socket_interface(const void *test_data)
 	setup(data);
 
 	sock = data->if_bluetooth->get_profile_interface(BT_PROFILE_SOCKETS_ID);
-	if (!sock)
+	if (!sock) {
 		tester_setup_failed();
+		return;
+	}
 
 	data->if_sock = sock;
 
-- 
1.8.3.2

