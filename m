Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 7/8] android/pts: Add PTS PIXIT for PAN
Date: Wed, 11 Dec 2013 16:27:17 +0100
Message-Id: <1386775638-24941-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1386775638-24941-1-git-send-email-szymon.janc@tieto.com>
References: <1386775638-24941-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This complements PTS PICS configuration.
---
 android/Makefile.am   |  2 +-
 android/pixit-pan.txt | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)
 create mode 100644 android/pixit-pan.txt

diff --git a/android/Makefile.am b/android/Makefile.am
index 1bba128..a9b09da 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -109,4 +109,4 @@ EXTRA_DIST += android/Android.mk android/hal-ipc-api.txt android/README \
 		android/pics-opp.txt android/pics-pbap.txt \
 		android/pixit-did.txt android/pts-did.txt \
 		android/pixit-gap.txt android/pixit-hid.txt \
-		android/pixit-opp.txt
+		android/pixit-opp.txt android/pixit-pan.txt
diff --git a/android/pixit-pan.txt b/android/pixit-pan.txt
new file mode 100644
index 0000000..2d180da
--- /dev/null
+++ b/android/pixit-pan.txt
@@ -0,0 +1,28 @@
+PAN PIXIT for the PTS tool.
+
+* - different than PTS defaults
+& - should be set to IUT Bluetooth address
+
+		Required PIXIT settings
+-------------------------------------------------------------------------------
+Parameter Name						Value
+-------------------------------------------------------------------------------
+TSPX_GN_class_of_device					020104
+TSPX_NAP_class_of_device				020300
+TSPX_PANU_class_of_device				020104
+TSPX_time_guard						300000
+TSPX_bd_addr_iut					112233445566 (*&)
+TSPX_security_enabled					False
+TSPX_pin_code						0000
+TSPX_delete_link_key					False
+TSPX_use_implicit_send					True
+TSPX_iut_ip_address					192.168.167.152
+TSPX_iut_port_number					4242
+TSPX_PTS_ip_address					192.168.168.100
+TSPX_PTS_port_number					4242
+TSPX_bd_addr_PTS					000000000000
+TSPX_checksum						E851
+TSPX_secure_simple_pairing_pass_key_confirmation	False
+TSPX_iut_friendly_bt_name				gprs-pc
+TSPX_PTS_role_when_iut_is_PANU				default
+-------------------------------------------------------------------------------
-- 
1.8.3.2

