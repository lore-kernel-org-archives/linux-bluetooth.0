Return-Path: <mussitantesmortem@gmail.com>
From: Maxim Zhukov <mussitantesmortem@gmail.com>
To: marcel@holtmann.org
Cc: johan.hedberg@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maxim Zhukov <mussitantesmortem@gmail.com>
Subject: [PATCH 5/5] drivers: bluetooth: ath3k: fix
Date: Sun,  4 Feb 2018 23:59:34 +0300
Message-Id: <20180204205934.12117-5-mussitantesmortem@gmail.com>
In-Reply-To: <20180204205934.12117-1-mussitantesmortem@gmail.com>
References: <20180204205934.12117-1-mussitantesmortem@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixed warning:
 WARNING: Prefer using '"%s...", __func__' to using 'ath3k_disconnect', this function's name, in a string
 #568: FILE: drivers/bluetooth/ath3k.c:568:
 +	BT_DBG("ath3k_disconnect intf %p", intf);

Signed-off-by: Maxim Zhukov <mussitantesmortem@gmail.com>
---
 drivers/bluetooth/ath3k.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 8fe5ec4bb342..3d7a5c149af3 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -569,7 +569,7 @@ static int ath3k_probe(struct usb_interface *intf,
 
 static void ath3k_disconnect(struct usb_interface *intf)
 {
-	BT_DBG("ath3k_disconnect intf %p", intf);
+	BT_DBG("%s intf %p", __func__, intf);
 }
 
 static struct usb_driver ath3k_driver = {
-- 
2.16.1
