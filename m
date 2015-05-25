Return-Path: <cyrus@holtmann.org>
From: Shailendra Verma <shailendra.capricorn@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Shailendra Verma <shailendra.capricorn@gmail.com>
Subject: [PATCH] bluetooth:btusb - Change 1 to true in bool type variable assignment.
Date: Mon, 25 May 2015 23:53:40 +0530
Message-Id: <1432578220-4216-1-git-send-email-shailendra.capricorn@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

The reset is a bool type variable.So assigning true to reset instead
of 1.

Signed-off-by: Shailendra Verma <shailendra.capricorn@gmail.com>
---
 drivers/bluetooth/btusb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3c10d4d..0ce5c32 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -37,7 +37,7 @@
 static bool disable_scofix;
 static bool force_scofix;
 
-static bool reset = 1;
+static bool reset = true;
 
 static struct usb_driver btusb_driver;
 
-- 
1.7.9.5
