Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] core/device: Fix not setting BT_ATT_SECURITY_AUTO
Date: Wed,  2 Mar 2016 16:19:35 +0200
Message-Id: <1456928375-9415-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

BT_ATT_SECURITY_AUTO shall be used whenever possible since it enables the
old behavior of escalating the security on demand.
---
 src/device.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/device.c b/src/device.c
index 14e850e..6bc44b6 100644
--- a/src/device.c
+++ b/src/device.c
@@ -4710,6 +4710,7 @@ bool device_attach_att(struct btd_device *dev, GIOChannel *io)
 	dev->att = g_attrib_get_att(attrib);
 
 	bt_att_ref(dev->att);
+	bt_att_set_security(dev->att, BT_ATT_SECURITY_AUTO);
 
 	dev->att_disconn_id = bt_att_register_disconnect(dev->att,
 						att_disconnected_cb, dev, NULL);
-- 
2.5.0

