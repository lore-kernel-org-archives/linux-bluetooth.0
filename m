Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] android: Enable LE if controller supports it
Date: Tue, 11 Mar 2014 15:25:03 +0100
Message-Id: <1394547904-19100-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1394547904-19100-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1394547904-19100-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetooth.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index ba4f14b..2732390 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -2015,6 +2015,9 @@ static void read_info_complete(uint8_t status, uint16_t length,
 	if (missing_settings & MGMT_SETTING_PAIRABLE)
 		set_mode(MGMT_OP_SET_PAIRABLE, 0x01);
 
+	if (missing_settings & MGMT_SETTING_LE)
+		set_mode(MGMT_OP_SET_LE, 0x01);
+
 	return;
 
 failed:
-- 
1.8.5.2

