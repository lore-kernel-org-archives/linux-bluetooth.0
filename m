Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastianx.chlad@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastianx.chlad@intel.com>
Subject: [PATCH] android/pixit: Add PIXIT for HDP and MCAP
Date: Mon, 17 Mar 2014 15:22:44 +0200
Message-Id: <1395062564-8589-1-git-send-email-sebastianx.chlad@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Adding PIXIT settings for HDP and MCAP targetting Android 4.4
---
 android/Makefile.am    |  2 ++
 android/pixit-hdp.txt  | 32 ++++++++++++++++++++++++++++++++
 android/pixit-mcap.txt | 37 +++++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+)
 create mode 100644 android/pixit-hdp.txt
 create mode 100644 android/pixit-mcap.txt

diff --git a/android/Makefile.am b/android/Makefile.am
index 3c503da..37f97a1 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -216,6 +216,8 @@ EXTRA_DIST += android/Android.mk android/README \
 				android/pixit-hsp.txt \
 				android/pixit-hfp.txt \
 				android/pixit-gatt.txt \
+				android/pixit-hdp.txt \
+				android/pixit-mcap.txt \
 				android/pts-l2cap.txt \
 				android/pts-gap.txt \
 				android/pts-did.txt \
diff --git a/android/pixit-hdp.txt b/android/pixit-hdp.txt
new file mode 100644
index 0000000..1474ddf
--- /dev/null
+++ b/android/pixit-hdp.txt
@@ -0,0 +1,32 @@
+HDP PIXIT for the PTS tool.
+
+PTS version: 5.0
+
+* - different than PTS defaults
+& - should be set to IUT Bluetooth address
+
+		Required PIXIT settings
+-------------------------------------------------------------------------------
+Parameter Name						Value
+-------------------------------------------------------------------------------
+TSPX_security_enabled					TRUE
+TSPX_delete_link_key					FALSE
+TSPX_bd_addr_iut					112233445566 (*&)
+TSPX_sink_device_class_of_device			000900
+TSPX_source_class_of_device				000900
+TSPX_pin_code						0000
+TSPX_use_dynamic_pin_code				FALSE
+TSPX_use_implicit_send					TRUE
+TSPX_MCAP_l2cap_psm_control				1001
+TSPX_MCAP_l2cap_psm_data				1003
+TSPX_MCAP_sync_lead_time				0BB8
+TSPX_MCAP_timestamp_native_resolution			2233
+TSPX_MCAP_timestamp_native_accuracy			1400
+TSPX_MCAP_timestamp_required_accuracy			6400
+TSPX_DC_max						1
+TSPX_secure_simple_pairing_pass_key_confirmation	FALSE
+TSPX_time_guard						60000000
+TSPX_ieee_device_specialization				10417
+TSPX_ieee_standard_configuration			TRUE
+TSPX_MCAP_bluetooth_clock_access_resolution		55
+-------------------------------------------------------------------------------
diff --git a/android/pixit-mcap.txt b/android/pixit-mcap.txt
new file mode 100644
index 0000000..24250e4
--- /dev/null
+++ b/android/pixit-mcap.txt
@@ -0,0 +1,37 @@
+MCAP PIXIT for the PTS tool.
+
+PTS version: 5.0
+
+* - different than PTS defaults
+& - should be set to IUT Bluetooth address
+
+		Required PIXIT settings
+-------------------------------------------------------------------------------
+Parameter Name						Value
+-------------------------------------------------------------------------------
+TSPX_bd_addr_iut					112233445566 (*&)
+TSPX_delete_link_key					FALSE
+TSPX_MCAP_DC_max					2
+TSPX_MCAP_l2cap_psm_control				1003
+TSPX_MCAP_l2cap_psm_control_B
+TSPX_MCAP_l2cap_psm_data				1005
+TSPX_MCAP_l2cap_psm_data_B
+TSPX_MCAP_bluetooth_clock_access_resolution		55
+TSPX_MCAP_create_mdl_configuration
+TSPX_MCAP_data_channel_setup_mode
+TSPX_MCAP_iut_initiate_connection			FALSE
+TSPX_mdep_id						12
+TSPX_MCAP_profile_name
+TSPX_MCAP_sync_lead_time				0BB8
+TSPX_MCAP_tester_role
+TSPX_MCAP_timestamp_native_accuracy			1400
+TSPX_MCAP_timestamp_native_resolution			2233
+TSPX_MCAP_timestamp_required_accuracy			6400
+TSPX_host_class_of_devices				100108
+TSPX_pin_code						0000
+TSPX_security_enabled					TRUE (*)
+TSPX_time_guard						60000000
+TSPX_use_dynamic_pin_code				FALSE
+TSPX_use_implicit_send					TRUE
+TSPX_verbose_implicit_send				TRUE
+-------------------------------------------------------------------------------
-- 
1.8.3.2

---------------------------------------------------------------------
Intel Finland Oy
Registered Address: PL 281, 00181 Helsinki 
Business Identity Code: 0357606 - 4 
Domiciled in Helsinki 

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.

