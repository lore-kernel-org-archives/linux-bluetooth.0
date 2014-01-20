Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH v2 5/5] device: Match Dualshock4 with name and class
Date: Mon, 20 Jan 2014 12:08:36 +0100
Message-Id: <1390216116-23670-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1390216116-23670-1-git-send-email-szymon.janc@tieto.com>
References: <1390216116-23670-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Szymon Janc <szymon.janc@gmail.com>

This allows to use DS4 with legacy adapters. This seems to require
general bonding to work correctly i.e. after dedicated bonding
connection is rejected with "Authentication Failure" error.
---
 src/device.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/device.c b/src/device.c
index 76b876e..8e2a515 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3514,6 +3514,14 @@ static uint16_t get_sdp_flags(struct btd_device *device)
 	if (vid == 0x054c && pid == 0x05c4)
 		return SDP_LARGE_MTU;
 
+	if (btd_adapter_ssp_enabled(device->adapter))
+		return 0;
+
+	/* if no EIR try matching Sony DualShock 4 with name and class */
+	if (!strncmp(device->name, "Wireless Controller", MAX_NAME_LENGTH) &&
+			device->class == 0x2508)
+		return SDP_LARGE_MTU;
+
 	return 0;
 }
 
-- 
1.8.3.2

