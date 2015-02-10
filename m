Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/5] android/pts: Update MCAP test pics, pixits for PTS 6.0
Date: Tue, 10 Feb 2015 18:17:29 +0100
Message-Id: <1423588650-12191-4-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1423588650-12191-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1423588650-12191-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch updates test pixits, pics, for MCAP profile against android
5.0
---
 android/pics-mcap.txt  | 2 +-
 android/pixit-mcap.txt | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/android/pics-mcap.txt b/android/pics-mcap.txt
index dd71ab4..70e0b66 100644
--- a/android/pics-mcap.txt
+++ b/android/pics-mcap.txt
@@ -1,6 +1,6 @@
 MCAP PICS for the PTS tool.
 
-PTS version: 5.3
+PTS version: 6.0
 
 * - different than PTS defaults
 # - not yet implemented/supported
diff --git a/android/pixit-mcap.txt b/android/pixit-mcap.txt
index d05a953..f3d33a1 100644
--- a/android/pixit-mcap.txt
+++ b/android/pixit-mcap.txt
@@ -1,6 +1,6 @@
 MCAP PIXIT for the PTS tool.
 
-PTS version: 5.3
+PTS version: 6.0
 
 * - different than PTS defaults
 & - should be set to IUT Bluetooth address
@@ -11,7 +11,7 @@ Parameter Name						Value
 -------------------------------------------------------------------------------
 TSPX_bd_addr_iut					112233445566 (*&)
 TSPX_delete_link_key					FALSE
-TSPX_MCAP_DC_max					1
+TSPX_MCAP_DC_max					1 (*)
 TSPX_MCAP_l2cap_psm_control				1003
 TSPX_MCAP_l2cap_psm_control_B
 TSPX_MCAP_l2cap_psm_data				1005
-- 
1.9.3

