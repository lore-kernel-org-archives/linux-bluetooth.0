Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 8/8] android/pts: Add PTS PIXIT for PBAP
Date: Wed, 11 Dec 2013 16:27:18 +0100
Message-Id: <1386775638-24941-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1386775638-24941-1-git-send-email-szymon.janc@tieto.com>
References: <1386775638-24941-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This complements PTS PICS configuration.
---
 android/Makefile.am    |  3 ++-
 android/pixit-pbap.txt | 33 +++++++++++++++++++++++++++++++++
 2 files changed, 35 insertions(+), 1 deletion(-)
 create mode 100644 android/pixit-pbap.txt

diff --git a/android/Makefile.am b/android/Makefile.am
index a9b09da..0bcab2f 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -109,4 +109,5 @@ EXTRA_DIST += android/Android.mk android/hal-ipc-api.txt android/README \
 		android/pics-opp.txt android/pics-pbap.txt \
 		android/pixit-did.txt android/pts-did.txt \
 		android/pixit-gap.txt android/pixit-hid.txt \
-		android/pixit-opp.txt android/pixit-pan.txt
+		android/pixit-opp.txt android/pixit-pan.txt \
+		android/pixit-pbap.txt
diff --git a/android/pixit-pbap.txt b/android/pixit-pbap.txt
new file mode 100644
index 0000000..272cbc3
--- /dev/null
+++ b/android/pixit-pbap.txt
@@ -0,0 +1,33 @@
+PBAP PIXIT for the PTS tool.
+
+* - different than PTS defaults
+& - should be set to IUT Bluetooth address
+
+		Required PIXIT settings
+-------------------------------------------------------------------------------
+Parameter Name						Value
+-------------------------------------------------------------------------------
+TSPX_auth_password					0000
+TSPX_auth_user_id					PTS
+TSPX_security_enabled					True
+TSPX_bd_addr_iut					112233445566 (*&)
+TSPX_pin_code						0000
+TSPX_time_guard						100000
+TSPX_use_implicit_send					True
+TSPX_client_class_of_device				100204
+TSPX_server_class_of_device				100204
+TSPX_PSE_vCardSelector					0000000000000001
+TSPX_delete_link_key					False
+TSPX_PBAP_profile_version				1
+TSPX_PBAP_supported_repositories			1
+TSPX_PBAP_rfcomm_channel				1
+TSPX_telecom_folder_path				telecom
+TSPX_secure_simple_pairing_pass_key_confirmation	False
+TSPX_check_downloaded_contents_after_disconnect		False
+TSPX_SPP_rfcomm_channel					03
+TSPX_l2cap_psm						1005
+TSPX_rfcomm_channel					2
+TSPX_obex_auth_password					0000
+TSPX_no_confirmations					False
+TSPX_PSE_vCardSelector					0000000000000001
+-------------------------------------------------------------------------------
-- 
1.8.3.2

