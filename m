Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 5/8] android/pts: Add PTS PIXIT for HID
Date: Wed, 11 Dec 2013 16:27:15 +0100
Message-Id: <1386775638-24941-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1386775638-24941-1-git-send-email-szymon.janc@tieto.com>
References: <1386775638-24941-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This complements PTS PICS configuration.
---
 android/Makefile.am   |  2 +-
 android/pixit-hid.txt | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)
 create mode 100644 android/pixit-hid.txt

diff --git a/android/Makefile.am b/android/Makefile.am
index 66c3dba..60d46b5 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -108,4 +108,4 @@ EXTRA_DIST += android/Android.mk android/hal-ipc-api.txt android/README \
 		android/pics-pan.txt android/pics-did.txt \
 		android/pics-opp.txt android/pics-pbap.txt \
 		android/pixit-did.txt android/pts-did.txt \
-		android/pixit-gap.txt
+		android/pixit-gap.txt android/pixit-hid.txt
diff --git a/android/pixit-hid.txt b/android/pixit-hid.txt
new file mode 100644
index 0000000..f306615
--- /dev/null
+++ b/android/pixit-hid.txt
@@ -0,0 +1,28 @@
+HID PIXIT for the PTS tool.
+
+* - different than PTS defaults
+& - should be set to IUT Bluetooth address
+
+		Required PIXIT settings
+-------------------------------------------------------------------------------
+Parameter Name						Value
+-------------------------------------------------------------------------------
+TSPX_security_enabled					True
+TSPX_delete_link_key					True
+TSPX_query_iut_sdp					True
+TSPX_bd_addr_iut					112233445566 (*&)
+TSPX_pointing_device_class_of_device			002580
+TSPX_keyboard_device_class_of_device			002540
+TSPX_host_class_of_device				100108
+TSPX_pts_device_role					MOUSE
+TSPX_pin_code						0000
+TSPX_use_dynamic_pin_code				False
+TSPX_time_guard						6000000
+TSPX_hid_data_interval					1000
+TSPX_use_implicit_send					True
+TSPX_verbose_implicit_send				False
+TSPX_no_fail_verdicts					False
+TSPX_time_reconnect					30000
+TSPX_secure_simple_pairing_pass_key_confirmation	False
+TSPX_hid_report_id					1
+-------------------------------------------------------------------------------
-- 
1.8.3.2

