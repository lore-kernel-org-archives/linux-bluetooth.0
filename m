Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 2/2] android: Set pairable mode only if it is not set
Date: Thu, 31 Oct 2013 14:15:09 +0100
Message-ID: <1383225309-7260-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1383225309-7260-1-git-send-email-szymon.janc@tieto.com>
References: <1383225309-7260-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no need to set already set setting.
---
 android/adapter.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/adapter.c b/android/adapter.c
index c6fcf96..f1a4258 100644
--- a/android/adapter.c
+++ b/android/adapter.c
@@ -536,7 +536,8 @@ static void read_info_complete(uint8_t status, uint16_t length, const void *para
 	if (missing_settings & MGMT_SETTING_SSP)
 		set_mode(MGMT_OP_SET_SSP, 0x01);
 
-	set_mode(MGMT_OP_SET_PAIRABLE, 0x01);
+	if (missing_settings & MGMT_SETTING_PAIRABLE)
+		set_mode(MGMT_OP_SET_PAIRABLE, 0x01);
 
 	return;
 
-- 
1.8.4.1

