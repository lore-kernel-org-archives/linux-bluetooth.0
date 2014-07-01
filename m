Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] android/pts: Update PIXIT for HOGP
Date: Tue,  1 Jul 2014 15:44:19 +0200
Message-Id: <1404222260-3936-2-git-send-email-grzegorz.kolodziejczyk@tieto.com>
In-Reply-To: <1404222260-3936-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
References: <1404222260-3936-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This changes write report data.
---
 android/pixit-hogp.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/android/pixit-hogp.txt b/android/pixit-hogp.txt
index 4fe1e0f..20ec723 100644
--- a/android/pixit-hogp.txt
+++ b/android/pixit-hogp.txt
@@ -21,8 +21,8 @@ TSPX_pin_code						0000
 TSPX_use_dynamic_pin					FALSE
 TSPX_delete_ltk						FALSE
 TSPX_security_enabled					TRUE
-TSPX_input_report_data					CDA6F8B3AA
-TSPX_output_report_data					001234567890EF
-TSPX_feature_report_data				872D3F45EA
+TSPX_input_report_data					0123ABA2 (*)
+TSPX_output_report_data					4567CDA2 (*)
+TSPX_feature_report_data				8901EFA2 (*)
 TSPX_tester_appearance					03C0
 -------------------------------------------------------------------------------
-- 
1.9.3

