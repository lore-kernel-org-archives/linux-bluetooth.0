Return-Path: <cyrus@holtmann.org>
From: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Subject: [PATCH BlueZ] Fix not marking a reverse SDP discovery as "reverse"
Date: Tue, 20 Mar 2012 14:49:33 -0300
Message-Id: <1332265773-32279-1-git-send-email-vinicius.gomes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some devices "hide" some of their records while connected to other
devices. Setting a service discovery as reverse makes BlueZ to not
remove the records that are "hidden".

This patch fixes a mistake that reverse parameter was changed to false
when it should be true.
---
 src/device.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 0a1de7c..2bc0620 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2204,7 +2204,7 @@ static gboolean start_discovery(gpointer user_data)
 	struct btd_device *device = user_data;
 
 	if (device_is_bredr(device))
-		device_browse_sdp(device, NULL, NULL, NULL, FALSE);
+		device_browse_sdp(device, NULL, NULL, NULL, TRUE);
 	else
 		device_browse_primary(device, NULL, NULL, FALSE);
 
-- 
1.7.9.4

