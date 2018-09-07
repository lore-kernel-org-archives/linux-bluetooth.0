Return-Path: <lramos.prof@yahoo.com.br>
Date: Fri, 7 Sep 2018 20:35:49 -0300
From: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: [PATCH] ath3k: add warning when switch pid is not working
Message-ID: <20180907233549.GE3379@giustizia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds a warning message in the ath3k driver when
ath3k_switch_pid() returns error.

This event happens in a specific laptop, with an adapter which
identifies itself as 0cf3:0036. Surprisingly, the adapter works even
after this event - hence a warning is chosen instead of an error.

The current version of ath3k doesn't check the return value of
ath3k_switch_pid() and so this event may remain undetected in the
original version.

Signed-off-by: Luiz Carlos Ramos <lramos.prof@yahoo.com.br>
---
 drivers/bluetooth/ath3k.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index 3d7a5c149af3..3a8c47efea55 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -546,7 +546,10 @@ static int ath3k_probe(struct usb_interface *intf,
 			BT_ERR("Set normal mode failed");
 			return ret;
 		}
-		ath3k_switch_pid(udev);
+		ret = ath3k_switch_pid(udev);
+		if (ret < 0)
+			BT_WARN("Warning: switch pid failed (ret=%d)", ret);
+
 		return 0;
 	}
 
-- 
2.14.4
