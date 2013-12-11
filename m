Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 4/8] android/pts: Add PTS PIXIT for GAP
Date: Wed, 11 Dec 2013 16:27:14 +0100
Message-Id: <1386775638-24941-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1386775638-24941-1-git-send-email-szymon.janc@tieto.com>
References: <1386775638-24941-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This complements PTS PICS configuration.
---
 android/Makefile.am   |  3 ++-
 android/pixit-gap.txt | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 1 deletion(-)
 create mode 100644 android/pixit-gap.txt

diff --git a/android/Makefile.am b/android/Makefile.am
index b505c33..66c3dba 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -107,4 +107,5 @@ EXTRA_DIST += android/Android.mk android/hal-ipc-api.txt android/README \
 		android/pics-gap.txt android/pics-hid.txt \
 		android/pics-pan.txt android/pics-did.txt \
 		android/pics-opp.txt android/pics-pbap.txt \
-		android/pixit-did.txt android/pts-did.txt
+		android/pixit-did.txt android/pts-did.txt \
+		android/pixit-gap.txt
diff --git a/android/pixit-gap.txt b/android/pixit-gap.txt
new file mode 100644
index 0000000..786c55e
--- /dev/null
+++ b/android/pixit-gap.txt
@@ -0,0 +1,55 @@
+GAP PIXIT for the PTS tool.
+
+* - different than PTS defaults
+& - should be set to IUT Bluetooth address
+
+		Required PIXIT settings
+-------------------------------------------------------------------------------
+Parameter Name						Value
+-------------------------------------------------------------------------------
+TSPX_bd_addr_iut					112233445566 (*&)
+TSPX_bd_addr_PTS					000000000000
+TSPX_broadcaster_class_of_device			100104
+TSPX_observer_class_of_device				100104
+TSPX_peripheral_class_of_device				100104
+TSPX_central_class_of_device				100104
+TSPX_security_enabled					True
+TSPX_delete_link_key					True
+TSPX_pin_code						0000
+TSPX_time_guard						300000
+TSPX_use_implicit_send					True
+TSPX_use_dynamic_pin					False
+TSPX_secure_simple_pairing_pass_key_confirmation	False
+TSPX_using_public_device_address			True
+TSPX_using_random_device_address			False
+TSPX_lim_adv_timeout					30720
+TSPX_gen_disc_adv_min					30720
+TSPX_lim_disc_scan_min					10240
+TSPX_gen_disc_scan_min					10240
+TSPX_database_file					Database-GAP.sig
+TSPX_iut_rx_mtu						23
+TSPX_iut_private_address_interval			10000
+TSPX_iut_privacy_enabled				False
+TSPX_psm						1001
+TSPX_iut_valid_connection_interval_min			00C8
+TSPX_iut_valid_conneciton_interval_max			0960
+TSPX_iut_valid_connection_latency			0007
+TSPX_iut_valid_timeout_multiplier			0960
+TSPX_iut_connection_parameter_timeout			30000
+TSPX_iut_invalid_connection_interval_min		0000
+TSPX_iut_invalid_conneciton_interval_max		0000
+TSPX_iut_invalid_connection_latency			0000
+TSPX_iut_invalid_timeout_multiplier			0000
+TSPX_LE_scan_interval					0010
+TSPX_LE_scan_window					0010
+TSPX_con_interval_min					0032
+TSPX_con_interval_max					0046
+TSPX_con_latency					0000
+TSPX_supervision_timeout				07D0
+TSPX_minimum_ce_length					0000
+TSPX_maximum_ce_length					0000
+TSPX_pairing_before_service_request			False
+TSPX_iut_mandates_mitm					False
+TSPX_encryption_before_service_request			False
+TSPX_tester_appearance					0000
+-------------------------------------------------------------------------------
-- 
1.8.3.2

