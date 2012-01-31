Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 3/6] device: Fix doing SDP discovery for LE devices after the bonding is complete
Date: Tue, 31 Jan 2012 14:10:50 -0300
Message-Id: <1328029853-21134-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1328029853-21134-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1328029853-21134-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/device.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index 596ec0b..88cd4cc 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2380,8 +2380,12 @@ void device_bonding_complete(struct btd_device *device, uint8_t status)
 			device->discov_timer = 0;
 		}
 
-		device_browse_sdp(device, bonding->conn, bonding->msg,
-				NULL, FALSE);
+		if (device_is_bredr(device))
+			device_browse_sdp(device, bonding->conn, bonding->msg,
+								NULL, FALSE);
+		else
+			device_browse_primary(device, bonding->conn,
+							bonding->msg, FALSE);
 
 		bonding_request_free(bonding);
 	} else {
-- 
1.7.8.1

