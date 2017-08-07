Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Nicolas Werner <nicolas.werner@gmx.net>
To: linux-bluetooth@vger.kernel.org
Cc: Nicolas Werner <nicolas.werner@gmx.net>
Subject: [PATCH] plugins/sixaxis: Use the same device name as the kernel
Date: Tue,  8 Aug 2017 00:48:33 +0200
Message-Id: <20170807224833.17861-1-nicolas.werner@gmx.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some games check the device name to recognize a playstation controller.
This changes the device name, when using a PS3 controller over
bluetooth, to match the device name, that is advertised when using the
controller via USB.
---
 plugins/sixaxis.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/plugins/sixaxis.c b/plugins/sixaxis.c
index fcc93bc60..7e3c950b4 100644
--- a/plugins/sixaxis.c
+++ b/plugins/sixaxis.c
@@ -56,7 +56,7 @@ static const struct {
 	uint16_t version;
 } devices[] = {
 	{
-		.name = "PLAYSTATION(R)3 Controller",
+		.name = "Sony PLAYSTATION(R)3 Controller",
 		.source = 0x0002,
 		.vid = 0x054c,
 		.pid = 0x0268,
-- 
2.13.0

