Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 2/3] android/bluetooth: Do not enable BT LE by default
Date: Wed, 23 Apr 2014 18:53:26 +0200
Message-Id: <1398272007-15338-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398272007-15338-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398272007-15338-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetooth.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 5782e4d..476339e 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -2394,9 +2394,6 @@ static void read_info_complete(uint8_t status, uint16_t length,
 	if (missing_settings & MGMT_SETTING_PAIRABLE)
 		set_mode(MGMT_OP_SET_PAIRABLE, 0x01);
 
-	if (missing_settings & MGMT_SETTING_LE)
-		set_mode(MGMT_OP_SET_LE, 0x01);
-
 	load_devices_info(cb);
 	load_devices_cache();
 
-- 
1.8.4

