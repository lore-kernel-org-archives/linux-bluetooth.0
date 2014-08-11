Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Android/pts: Update PTS files for IOPT
Date: Mon, 11 Aug 2014 10:06:52 +0200
Message-Id: <1407744412-3768-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

PICS and PIXITs updated to PTS 5.2. Regression done for Android
4.4.4.
---
 android/pics-iopt.txt  | 12 ++++++------
 android/pixit-iopt.txt |  2 +-
 android/pts-iopt.txt   | 10 +++++-----
 3 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/android/pics-iopt.txt b/android/pics-iopt.txt
index a1289ef..61b5697 100644
--- a/android/pics-iopt.txt
+++ b/android/pics-iopt.txt
@@ -1,6 +1,6 @@
 IOPT PICS for the PTS tool.
 
-PTS version: 5.1
+PTS version: 5.2
 
 * - different than PTS defaults
 # - not yet implemented/supported
@@ -69,13 +69,13 @@ TSPC_support_DialUpNetworkingProfile_GW	False		Support for: Dial-Up
 							Networking Profile.
 							Role: Gateway
 
-TSPC_support_				True (*)	Support for: Extended
+TSPC_support_				False		Support for: Extended
 ExtendedServiceDiscoveryProfile_IP_LAP			SDP. Version: IP-LAP
 
-TSPC_support_				True (*)	Support for: Extended
+TSPC_support_				False		Support for: Extended
 ExtendedServiceDiscoveryProfile_IP_PAN			SDP. Version: IP-PAN
 
-TSPC_support_				True (*)	Support for: Extended
+TSPC_support_				False		Support for: Extended
 ExtendedServiceDiscoveryProfile_L2CAP			SDP. Version: L2CAP
 
 TSPC_support_FAXProfile_DE		False		Support for: FAX Profile
@@ -90,10 +90,10 @@ TSPC_support_FileTransferProfile_CLIENT	False		Support for: FTP
 TSPC_support_FileTransferProfile_SERVER	False		Support for: FTP
 							Role: Server
 
-TSPC_support_HealthDeviceProfile_Sink	False (#)	Support for: HDP
+TSPC_support_HealthDeviceProfile_Sink	True (*)	Support for: HDP
 							Role: Sink
 
-TSPC_support_HealthDeviceProfile_Source	False (#)	Support for: HDP
+TSPC_support_HealthDeviceProfile_Source	False		Support for: HDP
 							Role: Source
 
 TSPC_support_NewHandsFreeProfile_AG	False		Support for: HFP
diff --git a/android/pixit-iopt.txt b/android/pixit-iopt.txt
index a4bb581..85a8fcb 100644
--- a/android/pixit-iopt.txt
+++ b/android/pixit-iopt.txt
@@ -1,6 +1,6 @@
 IOPT PIXIT for the PTS tool.
 
-PTS version: 5.1
+PTS version: 5.2
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
diff --git a/android/pts-iopt.txt b/android/pts-iopt.txt
index 815740d..20962af 100644
--- a/android/pts-iopt.txt
+++ b/android/pts-iopt.txt
@@ -1,8 +1,8 @@
 PTS test results for IOPT
 
-PTS version: 5.1
-Tested: 08-May-2014
-Android version: 4.4.2
+PTS version: 5.2
+Tested: 11-August-2014
+Android version: 4.4.4
 
 Results:
 PASS	test passed
@@ -18,6 +18,6 @@ TC_COD_BV_02_I	N/A	Under PTS 5.1 test shall be disabled as there is
 			matching test case in HFP test suit (test No. 15)
 			PICS settings for HFP shall be disabled for IOPT
 TC_SDSS_BV_02_I	PASS
-TC_SDSA_BV_03_I	PASS
-TC_SDR_BV_04_I	PASS
+TC_SDSA_BV_03_I	FAIL	JIRA #BA-92
+TC_SDR_BV_04_I	FAIL	JIRA #BA-95
 -------------------------------------------------------------------------------
-- 
1.9.3

