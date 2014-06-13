Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 11/11] android/gatt: Fix not setting medium security for paired devices
Date: Fri, 13 Jun 2014 14:33:59 +0300
Message-Id: <1402659239-26558-11-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1402659239-26558-1-git-send-email-luiz.dentz@gmail.com>
References: <1402659239-26558-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Always use medium security when connecting devices already paired since
some profiles like HoG do require encryption.
---
 android/gatt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index d63efc9..5505cd0 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -1430,8 +1430,8 @@ static int connect_le(struct gatt_device *dev)
 
 	DBG("Connection attempt to: %s", addr);
 
-	/* TODO: If we are bonded then we should use higier sec level */
-	sec_level = BT_IO_SEC_LOW;
+	sec_level = bt_device_is_bonded(&dev->bdaddr) ? BT_IO_SEC_MEDIUM :
+								BT_IO_SEC_LOW;
 
 	/*
 	 * This connection will help us catch any PDUs that comes before
-- 
1.9.3

