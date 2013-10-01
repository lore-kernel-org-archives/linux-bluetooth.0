Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?=
	<jprvita@openbossa.org>
Subject: [PATCH BlueZ] monitor: Fix EIR Data Type / AD Type assigned numbers
Date: Tue,  1 Oct 2013 20:04:37 -0300
Message-Id: <1380668677-5259-1-git-send-email-jprvita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: João Paulo Rechi Vita <jprvita@openbossa.org>

The values for Public Target Address and Random Target Address were
swapped. This information can be verified in the Bluetooth SIG Assigned
numbers webpage:

https://www.bluetooth.org/en-us/specification/assigned-numbers/generic-access-profile
---
 monitor/packet.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/monitor/packet.c b/monitor/packet.c
index ddd3742..942d3de 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -2002,8 +2002,8 @@ static void print_fec(uint8_t fec)
 #define BT_EIR_SERVICE_UUID16		0x14
 #define BT_EIR_SERVICE_UUID128		0x15
 #define BT_EIR_SERVICE_DATA		0x16
-#define BT_EIR_RANDOM_ADDRESS		0x17
-#define BT_EIR_PUBLIC_ADDRESS		0x18
+#define BT_EIR_PUBLIC_ADDRESS		0x17
+#define BT_EIR_RANDOM_ADDRESS		0x18
 #define BT_EIR_GAP_APPEARANCE		0x19
 #define BT_EIR_MANUFACTURER_DATA	0xff
 
-- 
1.8.3.1

