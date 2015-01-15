Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 1/3] core: device: Fix connect bearer selection
Date: Wed, 14 Jan 2015 19:52:13 -0800
Message-Id: <1421293935-24092-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For dual-mode devices created from storage, trying to connect without
a scan sometimes causes the incorrect bearer to be connected. This
patch modifies device.c:select_conn_bearer so that it simply returns the
stored bdaddr_type of a device if neither bredr nor le have been seen
in a while.
---
 src/device.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/device.c b/src/device.c
index 1e13565..b5c19dd 100644
--- a/src/device.c
+++ b/src/device.c
@@ -1537,6 +1537,9 @@ static uint8_t select_conn_bearer(struct btd_device *dev)
 			le_last = NVAL_TIME;
 	}
 
+	if (le_last == NVAL_TIME && bredr_last == NVAL_TIME)
+		return dev->bdaddr_type;
+
 	if (dev->bredr && (!dev->le || le_last == NVAL_TIME))
 		return BDADDR_BREDR;
 
-- 
2.2.0.rc0.207.ga3a616c

