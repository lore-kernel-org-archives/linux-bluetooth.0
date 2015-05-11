Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/pts: Update BNEP PTS 6.1 results for android 5.1
Date: Mon, 11 May 2015 17:17:34 +0200
Message-Id: <1431357454-30227-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1431357454-30227-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1431357454-30227-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch updates BNEP PTS 6.1 results for android 5.1 and kernel
4.1.0-rc1+.
---
 android/pics-bnep.txt  |  2 +-
 android/pixit-bnep.txt |  2 +-
 android/pts-bnep.txt   | 20 ++++++++++++--------
 3 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/android/pics-bnep.txt b/android/pics-bnep.txt
index 09aa725..289e470 100644
--- a/android/pics-bnep.txt
+++ b/android/pics-bnep.txt
@@ -1,6 +1,6 @@
 BNEP PICS for the PTS tool.
 
-PTS version: 6.0
+PTS version: 6.1
 
 * - different than PTS defaults
 # - not yet implemented/supported
diff --git a/android/pixit-bnep.txt b/android/pixit-bnep.txt
index 9a26cd2..1366535 100644
--- a/android/pixit-bnep.txt
+++ b/android/pixit-bnep.txt
@@ -1,6 +1,6 @@
 BNEP PIXIT for the PTS tool.
 
-PTS version: 6.0
+PTS version: 6.1
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
diff --git a/android/pts-bnep.txt b/android/pts-bnep.txt
index 42f6438..8b6986a 100644
--- a/android/pts-bnep.txt
+++ b/android/pts-bnep.txt
@@ -1,9 +1,9 @@
 PTS test results for BNEP
 
-PTS version: 6.0
-Tested: 09-April-2015
-Android version: 5.0
-Kernel version: 3.20
+PTS version: 6.1
+Tested: 11-May-2015
+Android version: 5.1
+Kernel version: 4.1
 
 Results:
 PASS	test passed
@@ -34,10 +34,14 @@ TC_CTRL_BV_09_C		PASS	bneptest -c <PTS addr> -b <bridge> -n <iface>
 TC_CTRL_BV_10_C		PASS	PTS issue #13169
 				bneptest -s -b <bridge> -n <iface>
 TC_CTRL_BV_19_C		PASS	bneptest -s -b <bridge> -n <iface>
-TC_RX_TYPE_0_BV_11_C	PASS	bneptest -s -b <bridge> -n <iface>
-TC_RX_C_BV_12_C		PASS	bneptest -s -b <bridge> -n <iface>
-TC_RX_C_S_BV_13_C	PASS	bneptest -s -b <bridge> -n <iface>
-TC_RX_C_S_BV_14_C	PASS	bneptest -s -b <bridge> -n <iface>
+TC_RX_TYPE_0_BV_11_C	PASS	PTS issue #13171
+				bneptest -s -b <bridge> -n <iface>
+TC_RX_C_BV_12_C		PASS	PTS issue #13171
+				bneptest -s -b <bridge> -n <iface>
+TC_RX_C_S_BV_13_C	PASS	PTS issue #13171
+				bneptest -s -b <bridge> -n <iface>
+TC_RX_C_S_BV_14_C	PASS	PTS issue #13171
+				bneptest -s -b <bridge> -n <iface>
 TC_RX_TYPE_0_BV_15_C	PASS	PTS issue #13169
 				bneptest -s -b <bridge> -n <iface>
 TC_RX_TYPE_0_BV_16_C	PASS	PTS issue #13171
-- 
2.1.0

