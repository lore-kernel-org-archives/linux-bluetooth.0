Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] android/pts: Update SPP TC_DevA_APP_BV_01_C instruction
Date: Mon,  2 Feb 2015 16:37:38 +0100
Message-Id: <1422891458-13997-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch updates SPP test case instruction. Use haltest socket connect
command instead of rctest.
---
 android/pts-spp.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/pts-spp.txt b/android/pts-spp.txt
index 6972020..2d2815b 100644
--- a/android/pts-spp.txt
+++ b/android/pts-spp.txt
@@ -13,8 +13,8 @@ N/A	test is disabled due to PICS setup
 -------------------------------------------------------------------------------
 Test Name		Result	Notes
 -------------------------------------------------------------------------------
-TC_DevA_APP_BV_01_C	PASS	sdptool browse <bdaddr> - check RFCOMM channel
-				rctest -n -P <channel> <bdaddr>
+TC_DevA_APP_BV_01_C	PASS	haltest: socket connect <PTS addr>
+					BTSOCK_RFCOMM 00001101 0
 TC_DevB_APP_BV_02_C	PASS	haltest: socket listen BTSOCK_RFCOMM SerialPort
 					00001101
 				Note: IUT must be in connectable, discoverable
-- 
1.9.3

