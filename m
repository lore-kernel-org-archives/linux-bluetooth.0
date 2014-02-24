Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pixit: Add PIXIT for HFP
Date: Mon, 24 Feb 2014 16:11:54 +0100
Message-Id: <1393254714-4657-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/Makefile.am   |  1 +
 android/pixit-hfp.txt | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)
 create mode 100644 android/pixit-hfp.txt

diff --git a/android/Makefile.am b/android/Makefile.am
index 58cfbae..b17b9fe 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -201,6 +201,7 @@ EXTRA_DIST += android/Android.mk android/README \
 				android/pixit-avctp.txt \
 				android/pixit-avrcp.txt \
 				android/pixit-hsp.txt \
+				android/pixit-hfp.txt \
 				android/pts-l2cap.txt \
 				android/pts-gap.txt \
 				android/pts-did.txt \
diff --git a/android/pixit-hfp.txt b/android/pixit-hfp.txt
new file mode 100644
index 0000000..aa50b1f
--- /dev/null
+++ b/android/pixit-hfp.txt
@@ -0,0 +1,37 @@
+HFP PIXIT for the PTS tool.
+
+PTS version: 5.0
+
+* - different than PTS defaults
+& - should be set to IUT Bluetooth address
+# - should be set to the respective phone numbers
+
+		Required PIXIT settings
+-------------------------------------------------------------------------------
+Parameter Name						Value
+-------------------------------------------------------------------------------
+TSPX_security_enabled					TRUE
+TSPX_bd_addr_iut					08606E414394 (&)
+TSPX_hf_class_of_device					200408
+TSPX_ag_class_of_device					400204
+TSPX_packet_type_sco					00A0
+TSPX_phone_number					1234567 (#)
+TSPX_second_phone_number				7654321 (#)
+TSPX_phone_number_type					129
+TSPX_second_phone_number_type				129
+TSPX_phone_number_memory				1
+TSPX_phone_number_memory_invalid_index			9999
+TSPX_scan_all_memory_dial_locations			FALSE
+TSPX_pin_code						0000
+TSPX_time_guard						300000
+TSPX_use_implicit_send					TRUE
+TSPX_verbose_implicit_send				FALSE
+TSPX_delete_link_key					FALSE
+TSPX_server_channel_tester				01
+TSPX_server_channel_iut					00
+TSPX_verify_CLIP_information				TRUE
+TSPX_no_fail_verdict					FALSE
+TSPX_network_supports_correct_call_and_callstatus	TRUE
+TSPX_secure_simple_pairing_pass_key_confirmation	FALSE
+TSPX_AG_match_tester_BRSF_codec_negotiation_bit		FALSE
+-------------------------------------------------------------------------------
-- 
1.8.5.3

