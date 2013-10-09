Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 6/7] tools/sdptool: Fix parsing for service class 0x110f
Date: Wed,  9 Oct 2013 14:11:44 +0300
Message-Id: <1381317105-10729-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1381317105-10729-1-git-send-email-luiz.dentz@gmail.com>
References: <1381317105-10729-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

According to assigned number 0x110f is AV Remote Controller not VCP.
---
 tools/sdptool.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/sdptool.c b/tools/sdptool.c
index c241655..f985b1e 100644
--- a/tools/sdptool.c
+++ b/tools/sdptool.c
@@ -286,7 +286,7 @@ static struct uuid_def uuid16_names[] = {
 	{ 0x110c, "RemoteControlTarget", NULL, 0 },
 	{ 0x110d, "AdvancedAudio", NULL, 0 },
 	{ 0x110e, "RemoteControl", NULL, 0 },
-	{ 0x110f, "VideoConferencing", NULL, 0 },
+	{ 0x110f, "RemoteControlController", NULL, 0 },
 	{ 0x1110, "Intercom", NULL, 0 },
 	{ 0x1111, "Fax", NULL, 0 },
 	{ 0x1112, "HeadsetAudioGateway", NULL, 0 },
@@ -316,7 +316,6 @@ static struct uuid_def uuid16_names[] = {
 	{ 0x1126, "HCR_Print (HCR)", NULL, 0 },
 	{ 0x1127, "HCR_Scan (HCR)", NULL, 0 },
 	{ 0x1128, "Common ISDN Access (CIP)", NULL, 0 },
-	{ 0x1129, "VideoConferencingGW (VCP)", NULL, 0 },
 	{ 0x112a, "UDI-MT", NULL, 0 },
 	{ 0x112b, "UDI-TA", NULL, 0 },
 	{ 0x112c, "Audio/Video", NULL, 0 },
-- 
1.8.3.1

