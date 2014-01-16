Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 01/11] android/hidhost: Fix connection state notification on profile unregister
Date: Fri, 17 Jan 2014 01:25:41 +0200
Message-Id: <1389914751-18545-2-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1389914751-18545-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1389914751-18545-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Issue found while writing end2end tests. Usually profile unregister is
called when final cleanup of bluetoothd. Freeing connected hid devices
through g_slist_foreach is a asynchronous call. Profile is cleaned up
and and ipc also complete cleanup. But free_hid_devices tries to notify
hal which doesn't exist that time. So behaviour is unexpected.
---
 android/hidhost.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/android/hidhost.c b/android/hidhost.c
index aed9899..c004063 100644
--- a/android/hidhost.c
+++ b/android/hidhost.c
@@ -1328,7 +1328,6 @@ static void free_hid_devices(gpointer data, gpointer user_data)
 {
 	struct hid_device *dev = data;
 
-	bt_hid_notify_state(dev, HAL_HIDHOST_STATE_DISCONNECTED);
 	hid_device_free(dev);
 }
 
-- 
1.8.3.2

