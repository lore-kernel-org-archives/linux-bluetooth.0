Return-Path: <cyrus@holtmann.org>
From: Nick Pelly <npelly@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Nick Pelly <npelly@google.com>
Subject: [PATCH] Add TI wl1271 to texas instruments chip list
Date: Thu, 11 Jun 2009 11:30:32 -0700
Message-Id: <1244745032-18997-1-git-send-email-npelly@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Nick Pelly <npelly@google.com>
---
 tools/hciattach_tialt.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/tools/hciattach_tialt.c b/tools/hciattach_tialt.c
index 1abf2f8..72633ad 100644
--- a/tools/hciattach_tialt.c
+++ b/tools/hciattach_tialt.c
@@ -239,12 +239,15 @@ int texasalt_init(int fd, int speed, struct termios *ti)
 	{
 		unsigned short lmp_subv = resp[13] | (resp[14] << 8);
 		unsigned short brf_chip = (lmp_subv & 0x7c00) >> 10;
-		static const char *c_brf_chip[5] = {
+		static const char *c_brf_chip[8] = {
 			"unknown",
 			"unknown",
 			"brf6100",
 			"brf6150",
-			"brf6300"
+			"brf6300",
+			"unknown",
+			"unknown",
+			"wl1271"
 		};
 		char fw[100];
 
@@ -256,7 +259,7 @@ int texasalt_init(int fd, int speed, struct termios *ti)
 				"\tchip: %s (%d)\n",
 				lmp_subv & 0x7f,
 				((lmp_subv & 0x8000) >> (15-3)) | ((lmp_subv & 0x380) >> 7),
-				((brf_chip > 4) ? "unknown" : c_brf_chip[brf_chip]),
+				((brf_chip > 7) ? "unknown" : c_brf_chip[brf_chip]),
 				brf_chip);
 
 		sprintf(fw, "/etc/firmware/%s.bin", c_brf_chip[brf_chip]);
-- 
1.6.3.1

