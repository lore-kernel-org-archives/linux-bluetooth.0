Return-Path: <cyrus@holtmann.org>
From: Atul Rai <a.rai@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: sachin.dev@samsung.com
Subject: [PATCH] android/client: Fix memory leak while using realloc()
Date: Wed, 22 Jul 2015 14:03:03 +0530
Message-id: <1437553983-11102-1-git-send-email-a.rai@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

While reallocating space to store additional "remote device set" using
realloc, if realloc() fails, the original block is left untouched but
reference to that block is lost as NULL is assigned to remote_devices.
The original block needs to be freed before return.
---
 android/client/if-bt.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index 4723024..4249f78 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -94,6 +94,7 @@ static int remote_devices_capacity = 0;
 void add_remote_device(const bt_bdaddr_t *addr)
 {
 	int i;
+	bt_bdaddr_t *tmp;
 
 	if (remote_devices == NULL) {
 		remote_devices = malloc(4 * sizeof(bt_bdaddr_t));
@@ -119,9 +120,16 @@ void add_remote_device(const bt_bdaddr_t *addr)
 	/* Realloc space if needed */
 	if (remote_devices_cnt >= remote_devices_capacity) {
 		remote_devices_capacity *= 2;
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

