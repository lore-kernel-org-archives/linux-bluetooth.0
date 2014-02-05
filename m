Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 4/4] android: Disconnect AVRCP once A2DP is disconnected
Date: Wed,  5 Feb 2014 12:27:00 +0200
Message-Id: <1391596020-27679-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1391596020-27679-1-git-send-email-luiz.dentz@gmail.com>
References: <1391596020-27679-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If A2DP is disconnected also disconnect AVRCP.
---
 android/a2dp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/android/a2dp.c b/android/a2dp.c
index 962e7f5..731fa16 100644
--- a/android/a2dp.c
+++ b/android/a2dp.c
@@ -227,6 +227,8 @@ static void bt_a2dp_notify_state(struct a2dp_device *dev, uint8_t state)
 	if (state != HAL_A2DP_STATE_DISCONNECTED)
 		return;
 
+	bt_avrcp_disconnect(&dev->dst);
+
 	a2dp_device_free(dev);
 }
 
-- 
1.8.5.3

