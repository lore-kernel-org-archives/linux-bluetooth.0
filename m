Return-Path: <cyrus@holtmann.org>
From: Atul Rai <a.rai@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: sachin.dev@samsung.com, anupam.r@samsung.com,
	Atul Rai <a.rai@samsung.com>
Subject: [PATCH] android/client/if-bt.c: Fix memory leak while using realloc()
Date: Tue, 23 Jun 2015 13:38:46 +0530
Message-id: <1435046926-15622-1-git-send-email-a.rai@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

While reallocating space to store additional "remote device set" using
realloc, if realloc() fails, the original block is left untouched but
reference to that block is lost as NULL is assigned to remote_devices.
The original block needs to be freed before return.

Signed-off-by: Atul Rai <a.rai@samsung.com>
---
 android/client/if-bt.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/android/client/if-bt.c b/android/client/if-bt.c
index 4723024..4f0c2e9 100644
--- a/android/client/if-bt.c
+++ b/android/client/if-bt.c
@@ -94,6 +94,7 @@ static int remote_devices_capacity = 0;
 void add_remote_device(const bt_bdaddr_t *addr)
 {
 	int i;
+	bt_bdaddr_t *tmp = NULL;
 
 	if (remote_devices == NULL) {
 		remote_devices = malloc(4 * sizeof(bt_bdaddr_t));
@@ -119,9 +120,17 @@ void add_remote_device(const bt_bdaddr_t *addr)
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
+			if (NULL != tmp)
+				free(tmp);
 			remote_devices_capacity = 0;
 			remote_devices_cnt = 0;
 			return;
-- 
2.1.4

