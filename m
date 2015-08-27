Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH 2/5] emulator: Update LE supported commands
Date: Thu, 27 Aug 2015 17:54:50 +0200
Message-Id: <1440690893-30384-2-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1440690893-30384-1-git-send-email-mariusz.skamra@tieto.com>
References: <1440690893-30384-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 emulator/btdev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index 319d434..b285b2a 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -420,15 +420,24 @@ static void set_le_commands(struct btdev *btdev)
 	btdev->commands[25] |= 0x01;	/* LE Set Event Mask */
 	btdev->commands[25] |= 0x02;	/* LE Read Buffer Size */
 	btdev->commands[25] |= 0x04;	/* LE Read Local Features */
+	btdev->commands[25] |= 0x10;	/* LE Set Random Address */
 	btdev->commands[25] |= 0x20;	/* LE Set Adv Parameters */
 	btdev->commands[25] |= 0x40;	/* LE Read Adv TX Power */
 	btdev->commands[25] |= 0x80;	/* LE Set Adv Data */
+	btdev->commands[26] |= 0x01;	/* LE Set Scan Response Data */
 	btdev->commands[26] |= 0x02;	/* LE Set Adv Enable */
 	btdev->commands[26] |= 0x04;	/* LE Set Scan Parameters */
 	btdev->commands[26] |= 0x08;	/* LE Set Scan Enable */
+	btdev->commands[26] |= 0x10;	/* LE Create Connection */
 	btdev->commands[26] |= 0x40;	/* LE Read White List Size */
+	btdev->commands[26] |= 0x80;	/* LE Clear White List */
+	btdev->commands[27] |= 0x04;	/* LE Connection Update */
+	btdev->commands[27] |= 0x20;	/* LE Read Remote Used Features */
 	btdev->commands[27] |= 0x40;	/* LE Encrypt */
 	btdev->commands[27] |= 0x80;	/* LE Rand */
+	btdev->commands[28] |= 0x01;	/* LE Start Encryption */
+	btdev->commands[28] |= 0x02;	/* LE Long Term Key Request Reply */
+	btdev->commands[28] |= 0x04;	/* LE Long Term Key Request Neg Reply */
 	btdev->commands[28] |= 0x08;	/* LE Read Supported States */
 	btdev->commands[28] |= 0x10;	/* LE Receiver Test */
 	btdev->commands[28] |= 0x20;	/* LE Transmitter Test */
-- 
2.4.3

