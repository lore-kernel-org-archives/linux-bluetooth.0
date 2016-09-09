Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Tobias Svehagen <tobias.svehagen@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Tobias Svehagen <tobias.svehagen@gmail.com>
Subject: [PATCH BlueZ] src/device: Use BT_ATT_DEFAULT_LE_MTU as default MTU
Date: Fri,  9 Sep 2016 14:27:20 +0200
Message-Id: <20160909122720.2404-1-tobias.svehagen@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use the default MTU until an MTU exchange has taken place and
something else has been negotiated. If either side does not support
MTU exchange, the connection shall continue to use this default
value instead of the device maximum which was the previous behavior.
---
 src/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/device.c b/src/device.c
index 9586022..ea36848 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4778,7 +4778,7 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
 	}
 
 	dev->att_mtu = MIN(mtu, BT_ATT_MAX_LE_MTU);
-	attrib = g_attrib_new(io, dev->att_mtu, false);
+	attrib = g_attrib_new(io, BT_ATT_DEFAULT_LE_MTU, false);
 	if (!attrib) {
 		error("Unable to create new GAttrib instance");
 		return false;
-- 
2.8.3

