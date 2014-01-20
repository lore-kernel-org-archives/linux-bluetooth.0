Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 5/5] device: Match Dualshock4 with name and class
Date: Mon, 20 Jan 2014 01:31:54 +0100
Message-Id: <1390177914-13529-5-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1390177914-13529-1-git-send-email-szymon.janc@gmail.com>
References: <1390177914-13529-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This allows to use DS4 with legacy adapters. This seems to require
general bonding to work correctly i.e. after dedicated bonding
connection is rejected with "Authentication Failure" error.
---
 src/device.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/device.c b/src/device.c
index 6ae14b2..43d5876 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3513,6 +3513,14 @@ static uint16_t get_sdp_flags(struct btd_device *device)
 	if (vid == 0x054c && pid == 0x05c4)
 		return SDP_DOUBLE_IMTU;
 
+	if (btd_adapter_ssp_enabled(device->adapter))
+		return 0;
+
+	/* if no EIR try matching Sony DualShock 4 with name and class */
+	if (!strncmp(device->name, "Wireless Controller", MAX_NAME_LENGTH) &&
+			device->class == 0x2508)
+		return SDP_DOUBLE_IMTU;
+
 	return 0;
 }
 
-- 
1.8.5.3

