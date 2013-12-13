Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android/bluetooth: Fix missing property change notification
Date: Fri, 13 Dec 2013 13:38:11 +0100
Message-Id: <1386938291-26279-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

After setting new discoverable timeout property change notification
with new value should be send.
---
 android/bluetooth.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 4bb2c92..c60c9a2 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -1387,6 +1387,10 @@ static uint8_t set_adapter_discoverable_timeout(const void *buf, uint16_t len)
 	/* TODO: This should be in some storage */
 	memcpy(&adapter.discoverable_timeout, timeout, sizeof(uint32_t));
 
+	send_adapter_property(HAL_PROP_ADAPTER_DISC_TIMEOUT,
+					sizeof(adapter.discoverable_timeout),
+					&adapter.discoverable_timeout);
+
 	return HAL_STATUS_SUCCESS;
 }
 
-- 
1.8.3.2

