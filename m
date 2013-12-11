Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 6/8] android/pts: Add PTS PIXIT for OPP
Date: Wed, 11 Dec 2013 16:27:16 +0100
Message-Id: <1386775638-24941-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1386775638-24941-1-git-send-email-szymon.janc@tieto.com>
References: <1386775638-24941-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This complements PTS PICS configuration.
---
 android/Makefile.am   |  3 ++-
 android/pixit-opp.txt | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)
 create mode 100644 android/pixit-opp.txt

diff --git a/android/Makefile.am b/android/Makefile.am
index 60d46b5..1bba128 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -108,4 +108,5 @@ EXTRA_DIST += android/Android.mk android/hal-ipc-api.txt android/README \
 		android/pics-pan.txt android/pics-did.txt \
 		android/pics-opp.txt android/pics-pbap.txt \
 		android/pixit-did.txt android/pts-did.txt \
-		android/pixit-gap.txt android/pixit-hid.txt
+		android/pixit-gap.txt android/pixit-hid.txt \
+		android/pixit-opp.txt
diff --git a/android/pixit-opp.txt b/android/pixit-opp.txt
new file mode 100644
index 0000000..1b1e834
--- /dev/null
+++ b/android/pixit-opp.txt
@@ -0,0 +1,25 @@
+OPP PIXIT for the PTS tool.
+
+* - different than PTS defaults
+& - should be set to IUT Bluetooth address
+
+		Required PIXIT settings
+-------------------------------------------------------------------------------
+Parameter Name						Value
+-------------------------------------------------------------------------------
+TSPX_unsupported_extension				dat
+TSPX_supported_extension				jpg
+TSPX_security_enabled					False
+TSPX_bd_addr_iut					112233445566 (*&)
+TSPX_client_class_of_device				100104
+TSPX_server_class_of_device				100104
+TSPX_rfcomm_channel					8
+TSPX_pin_code						0000
+TSPX_reply_reject_push					True
+TSPX_delete_link_key					False
+TSPX_time_guard						180000
+TSPX_use_implicit_send					True
+TSPX_secure_simple_pairing_pass_key_confirmation	False
+TSPX_PTS_sends_real_jpg_data				True
+TSPX_confirm_received_objects				True
+-------------------------------------------------------------------------------
-- 
1.8.3.2

