Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] android/hal-bluetooth: Free device on close()
Date: Fri, 20 Dec 2013 14:03:14 +0200
Message-Id: <1387540995-1509-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-bluetooth.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 4ef2ebe..2232ebe 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -891,6 +891,8 @@ static int close_bluetooth(struct hw_device_t *device)
 
 	cleanup();
 
+	free(device);
+
 	return 0;
 }
 
-- 
1.8.3.2

