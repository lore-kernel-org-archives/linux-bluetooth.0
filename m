Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 2/9] android/bluetooth: Add support for adapter bonded devices property
Date: Wed, 11 Dec 2013 11:31:20 +0100
Message-Id: <1386757887-29018-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1386757887-29018-1-git-send-email-szymon.janc@tieto.com>
References: <1386757887-29018-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to get property with list of bonded devices.
---
 android/bluetooth.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 82003fd..b6ef3e6 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1729,11 +1729,26 @@ static uint8_t get_adapter_scan_mode(void)
 
 static uint8_t get_adapter_bonded_devices(void)
 {
-	DBG("Not implemented");
+	uint8_t buf[sizeof(bdaddr_t) * g_slist_length(devices)];
+	int i = 0;
+	GSList *l;
 
-	/* TODO: Add implementation */
+	DBG("");
 
-	return HAL_STATUS_FAILED;
+	for (l = devices; l; l = g_slist_next(l)) {
+		struct device *dev = l->data;
+
+		if (dev->bond_state != HAL_BOND_STATE_BONDED)
+			continue;
+
+		bdaddr2android(&dev->bdaddr, buf + (i * sizeof(bdaddr_t)));
+		i++;
+	}
+
+	send_adapter_property(HAL_PROP_ADAPTER_BONDED_DEVICES,
+						i * sizeof(bdaddr_t), buf);
+
+	return HAL_STATUS_SUCCESS;
 }
 
 static uint8_t get_adapter_discoverable_timeout(void)
-- 
1.8.3.2

