Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 06/17] emulator: Minor style fix
Date: Wed, 26 Feb 2014 02:57:17 +0100
Message-ID: <1393379848-4031-7-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1393379848-4031-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1393379848-4031-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 emulator/btdev.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index c7231dd..c6bf96c 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -708,8 +708,8 @@ static void inquiry_complete(struct btdev *btdev, uint8_t status)
 			ir.rssi = -60;
 			memcpy(ir.data, btdev_list[i]->ext_inquiry_rsp, 240);
 
-			send_event(btdev, BT_HCI_EVT_EXT_INQUIRY_RESULT,
-							&ir, sizeof(ir));
+			send_event(btdev, BT_HCI_EVT_EXT_INQUIRY_RESULT, &ir,
+								sizeof(ir));
 			continue;
 		}
 
@@ -737,8 +737,8 @@ static void inquiry_complete(struct btdev *btdev, uint8_t status)
 			memcpy(ir.dev_class, btdev_list[i]->dev_class, 3);
 			ir.clock_offset = 0x0000;
 
-			send_event(btdev, BT_HCI_EVT_INQUIRY_RESULT,
-							&ir, sizeof(ir));
+			send_event(btdev, BT_HCI_EVT_INQUIRY_RESULT, &ir,
+								sizeof(ir));
 		}
         }
 
-- 
1.8.4

