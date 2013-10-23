Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <andrei.emeltchenko@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android: Check that service is started
Date: Wed, 23 Oct 2013 13:26:38 +0300
Message-Id: <1382523998-30722-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Add check that we are able to start Bluetooth service in
Android. If service is not started we should not try to connect to it.
---
 android/hal-ipc.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/android/hal-ipc.c b/android/hal-ipc.c
index 2d58038..a7948a6 100644
--- a/android/hal-ipc.c
+++ b/android/hal-ipc.c
@@ -204,7 +204,11 @@ bool hal_ipc_init(void)
 	}
 
 	/* Start Android Bluetooth daemon service */
-	property_set("ctl.start", SERVICE_NAME);
+	if (property_set("ctl.start", SERVICE_NAME) < 0) {
+		error("Failed to start service %s", SERVICE_NAME);
+		close(sk);
+		return false;
+	}
 
 	cmd_sk = accept_connection(sk);
 	if (cmd_sk < 0) {
-- 
1.8.1.2

