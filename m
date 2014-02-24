Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pixit: Correct symbols in PIXIT
Date: Mon, 24 Feb 2014 16:33:04 +0100
Message-Id: <1393255984-6165-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Trivial patch correcting PIXIT files for HFP and HSP
---
 android/pixit-hfp.txt | 2 +-
 android/pixit-hsp.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/android/pixit-hfp.txt b/android/pixit-hfp.txt
index aa50b1f..3134b26 100644
--- a/android/pixit-hfp.txt
+++ b/android/pixit-hfp.txt
@@ -11,7 +11,7 @@ PTS version: 5.0
 Parameter Name						Value
 -------------------------------------------------------------------------------
 TSPX_security_enabled					TRUE
-TSPX_bd_addr_iut					08606E414394 (&)
+TSPX_bd_addr_iut					08606E414394 (*&)
 TSPX_hf_class_of_device					200408
 TSPX_ag_class_of_device					400204
 TSPX_packet_type_sco					00A0
diff --git a/android/pixit-hsp.txt b/android/pixit-hsp.txt
index 2bda4fa..62293a6 100644
--- a/android/pixit-hsp.txt
+++ b/android/pixit-hsp.txt
@@ -10,7 +10,7 @@ PTS version: 5.0
 Parameter Name						Value
 -------------------------------------------------------------------------------
 TSPX_security_enabled					TRUE
-TSPX_bd_addr_iut					08606E414394 (&)
+TSPX_bd_addr_iut					08606E414394 (*&)
 TSPX_hs_class_of_device					200404
 TSPX_ag_class_of_device					400204
 TSPX_packet_type_sco					00A0
-- 
1.8.5.3

