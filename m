Return-Path: <cyrus@holtmann.org>
From: Atul Rai <a.rai@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: sachin.dev@samsung.com
Subject: [PATCH v2] android/client: Fix memory leak while using realloc()
Date: Mon, 27 Jul 2015 09:44:40 +0530
Message-id: <1437970480-2619-1-git-send-email-a.rai@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

While reallocating space to store additional "remote device set" using
realloc, if realloc() fails, the original block is left untouched but
reference to that block is lost as NULL is assigned to remote_devices.
The original block needs to be freed before return.
---
 android/client/if-bt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index 4723024..34611b9 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -119,9 +119,18 @@ void add_remote_device(const bt_bdaddr_t *addr)
 	/* Realloc space if needed */
 	if (remote_devices_cnt >= remote_devices_capacity) {
 		remote_devices_capacity *= 2;
+		bt_bdaddr_t *tmp;
+
+		/*
+		 * Save reference to previously allocated memory block so that
+		 * it can be freed in case realloc fails.
+		 */
+		tmp = remote_devices;
+
 		remote_devices = realloc(remote_devices, sizeof(bt_bdaddr_t) *
 						remote_devices_capacity);
 		if (remote_devices == NULL) {
+			free(tmp);
 			remote_devices_capacity = 0;
 			remote_devices_cnt = 0;
 			return;
-- 
2.1.4

