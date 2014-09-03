Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] android/bluetooth: Set unpaired cb list to NULL while unregistering bt
Date: Wed,  3 Sep 2014 15:17:12 +0200
Message-Id: <1409750233-23314-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Unpaired callback list for profiles needs to be set to NULL while
unregistering bluetooth. Other profiles may try to unregister and remove
its unpair cb, this cause invalid read callback list.
---
 android/bluetooth.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 8b47015..d275dea 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -5281,4 +5281,5 @@ void bt_bluetooth_unregister(void)
 	hal_ipc = NULL;
 
 	queue_destroy(unpaired_cb_list, NULL);
+	unpaired_cb_list = NULL;
 }
-- 
1.9.3

