Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] android/bluetooth: Clear CSRK information after unpair
Date: Tue, 17 Jun 2014 08:54:49 +0200
Message-Id: <1402988090-15544-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

CSRK information should be removed when unpaired.
---
 android/bluetooth.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index bc10b38..092bdd7 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -796,6 +796,12 @@ static void update_le_state(struct device *dev, bool pairing, bool paired,
 	} else if (!paired && !dev->bredr_paired) {
 		bonded_devices = g_slist_remove(bonded_devices, dev);
 		remove_device_info(dev, DEVICES_FILE);
+		dev->valid_local_csrk = false;
+		dev->valid_remote_csrk = false;
+		dev->local_sign_cnt = 0;
+		dev->remote_sign_cnt = 0;
+		memset(dev->local_csrk, 0, sizeof(dev->local_csrk));
+		memset(dev->remote_csrk, 0, sizeof(dev->remote_csrk));
 		cache_device(dev);
 	}
 
-- 
1.9.3

