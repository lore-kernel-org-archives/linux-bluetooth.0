Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 3/5] android/bluetooth: Fix unpairing dual mode device
Date: Sun, 18 May 2014 13:53:58 +0200
Message-Id: <1400414040-30913-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1400414040-30913-1-git-send-email-szymon.janc@tieto.com>
References: <1400414040-30913-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If device is paired on LE and BR/EDR it should be unpaired on both
bearers.
---
 android/bluetooth.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 6743b81..29c4ab6 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -3374,13 +3374,26 @@ static void handle_remove_bond_cmd(const void *buf, uint16_t len)
 		goto failed;
 	}
 
-	cp.addr.type = select_device_bearer(dev);
+	if (dev->le_paired) {
+		cp.addr.type = dev->bdaddr_type;
 
-	if (mgmt_send(mgmt_if, MGMT_OP_UNPAIR_DEVICE, adapter.index,
-				sizeof(cp), &cp, unpair_device_complete,
-				NULL, NULL) ==  0) {
-		status = HAL_STATUS_FAILED;
-		goto failed;
+		if (mgmt_send(mgmt_if, MGMT_OP_UNPAIR_DEVICE, adapter.index,
+					sizeof(cp), &cp, unpair_device_complete,
+					NULL, NULL) == 0) {
+			status = HAL_STATUS_FAILED;
+			goto failed;
+		}
+	}
+
+	if (dev->bredr_paired) {
+		cp.addr.type = BDADDR_BREDR;
+
+		if (mgmt_send(mgmt_if, MGMT_OP_UNPAIR_DEVICE, adapter.index,
+					sizeof(cp), &cp, unpair_device_complete,
+					NULL, NULL) == 0) {
+			status = HAL_STATUS_FAILED;
+			goto failed;
+		}
 	}
 
 	status = HAL_STATUS_SUCCESS;
-- 
1.9.0

