Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ 2/8] Fix doing SDP service discovery for LE devices
Date: Fri, 19 Aug 2011 21:09:23 -0300
Message-Id: <1313798969-8772-3-git-send-email-vinicius.gomes@openbossa.org>
In-Reply-To: <1313798969-8772-1-git-send-email-vinicius.gomes@openbossa.org>
References: <1313798969-8772-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

After the bonding is complete, the SDP service discovery was being made
not matter the type of the device. Now, we check the type of the device
and do the correct type of Service discovery.
---
 src/device.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/device.c b/src/device.c
index 1a333de..44d2586 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2217,8 +2217,12 @@ void device_bonding_complete(struct btd_device *device, uint8_t status)
 			device->discov_timer = 0;
 		}
 
-		device_browse_sdp(device, bonding->conn, bonding->msg,
-				NULL, FALSE);
+		if (device->type != DEVICE_TYPE_LE)
+			device_browse_sdp(device, bonding->conn, bonding->msg,
+								NULL, FALSE);
+		else
+			device_browse_primary(device, bonding->conn,
+							bonding->msg, FALSE);
 
 		bonding_request_free(bonding);
 	} else {
-- 
1.7.6

