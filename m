Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] android: Always enable SSP if supported by controller
Date: Thu, 31 Oct 2013 11:50:31 +0100
Message-ID: <1383216631-28187-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no HAL function to enable/disable SSP so always enable it if
supported by controller.
---
 android/adapter.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/android/adapter.c b/android/adapter.c
index a3f9aa6..9f2e019 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -528,6 +528,11 @@ static void read_info_complete(uint8_t status, uint16_t length, const void *para
 	load_link_keys(NULL);
 
 	set_io_capability();
+
+	if ((adapter->supported_settings & MGMT_SETTING_SSP) &&
+			!(adapter->current_settings & MGMT_SETTING_SSP))
+		set_mode(MGMT_OP_SET_SSP, 0x01);
+
 	set_mode(MGMT_OP_SET_PAIRABLE, 0x01);
 
 	return;
-- 
1.8.4.1

