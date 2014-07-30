Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix sparse warning from HID new leds handling
Date: Wed, 30 Jul 2014 08:08:45 +0200
Message-Id: <1406700525-18066-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The new leds bit handling produces this spares warning.

  CHECK   net/bluetooth/hidp/core.c
net/bluetooth/hidp/core.c:156:60: warning: dubious: x | !y

Just fix it by doing an explicit x << 0 shift operation.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hidp/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
index 8181ea4bc2f2..6c7ecf116e74 100644
--- a/net/bluetooth/hidp/core.c
+++ b/net/bluetooth/hidp/core.c
@@ -154,7 +154,7 @@ static int hidp_input_event(struct input_dev *dev, unsigned int type,
 		  (!!test_bit(LED_COMPOSE, dev->led) << 3) |
 		  (!!test_bit(LED_SCROLLL, dev->led) << 2) |
 		  (!!test_bit(LED_CAPSL,   dev->led) << 1) |
-		  (!!test_bit(LED_NUML,    dev->led));
+		  (!!test_bit(LED_NUML,    dev->led) << 0);
 
 	if (session->leds == newleds)
 		return 0;
-- 
1.9.3

