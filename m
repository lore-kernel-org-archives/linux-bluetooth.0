Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pics: Add PICS and PIXIT for HSP
Date: Mon, 24 Feb 2014 12:54:55 +0100
Message-Id: <1393242895-19447-1-git-send-email-sebastian.chlad@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added PICS and PIXIT target Android 4.4
---
 android/Makefile.am   |   2 +
 android/pics-hsp.txt  | 103 ++++++++++++++++++++++++++++++++++++++++++++++++++
 android/pixit-hsp.txt |  30 +++++++++++++++
 3 files changed, 135 insertions(+)
 create mode 100644 android/pics-hsp.txt
 create mode 100644 android/pixit-hsp.txt

diff --git a/android/Makefile.am b/android/Makefile.am
index 50d0dc0..58cfbae 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -188,6 +188,7 @@ EXTRA_DIST += android/Android.mk android/README \
 				android/pics-a2dp.txt \
 				android/pics-avctp.txt \
 				android/pics-avrcp.txt \
+				android/pics-hsp.txt \
 				android/pixit-l2cap.txt \
 				android/pixit-gap.txt \
 				android/pixit-did.txt \
@@ -199,6 +200,7 @@ EXTRA_DIST += android/Android.mk android/README \
 				android/pixit-a2dp.txt \
 				android/pixit-avctp.txt \
 				android/pixit-avrcp.txt \
+				android/pixit-hsp.txt \
 				android/pts-l2cap.txt \
 				android/pts-gap.txt \
 				android/pts-did.txt \
diff --git a/android/pics-hsp.txt b/android/pics-hsp.txt
new file mode 100644
index 0000000..015b619
--- /dev/null
+++ b/android/pics-hsp.txt
@@ -0,0 +1,103 @@
+HSP PICS for the PTS tool.
+
+PTS version: 5.0
+
+* - different than PTS defaults
+# - not yet implemented/supported
+
+M - mandatory
+O - optional
+
+		Version
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_HSP_0_1	False		Version: Headset Profile v1.1 (C.1)
+TSPC_HSP_0_2	True		Version: Headset Profile v1.2 (C.1)
+-------------------------------------------------------------------------------
+C.1: Mandatory to support one and only one of these versions.
+-------------------------------------------------------------------------------
+
+
+		Roles
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_HSP_1_1	True		Role: Audio Gateway (AG) (C.1)
+TSPC_HSP_1_2	False		Role: Headset (HS) (C.1)
+-------------------------------------------------------------------------------
+C.1: Mandatory to support at least one of the defined roles.
+-------------------------------------------------------------------------------
+
+
+		Audio Gateway Role
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_HSP_2_1	True		Incoming audio connection establishment (M)
+TSPC_HSP_2_2	True		Ring (AT command) (C.3)
+TSPC_HSP_2_3	False		Inband ring tone (O)
+TSPC_HSP_2_4	True		Outgoing audio connection establishment (O)
+TSPC_HSP_2_5	True		Audio connection release from HS (C.5)
+TSPC_HSP_2_6	True		Audio connection release from AG (M)
+TSPC_HSP_2_7	True		Audio connection transfer: AG to HS (M)
+TSPC_HSP_2_8	True		Audio connection transfer: HS to AG (M)
+TSPC_HSP_2_9	False		Remote audio volume control (C.1)
+TSPC_HSP_2_10	False		HS informs AG about local changes of audio
+					volume (O)
+TSPC_HSP_2_11	False		Audio volume setting storage by HS (O)
+TSPC_HSP_2_12	False		Remote microphone gain control (C.2)
+TSPC_HSP_2_13	False		HS informs AG about local changes of microphone
+					gain (O)
+TSPC_HSP_2_14	False		Microphone gain setting storage by HS (O)
+TSPC_HSP_2_15	True		Connection handling with Detach/Page (M)
+TSPC_HSP_2_16	False		Connection handling with Park Mode (C.4)
+-------------------------------------------------------------------------------
+C.1: Mandatory if TSPC_HSP_2_10 is supported, otherwise optional
+C:2: Mandatory if TSPC_HSP_2_13 is supported, otherwise optional
+C.3: Excluded if TSPC_HSP_2_3 and TSPC_HSP_4_1 ("Show that in-band
+	ringing and RING are mutually exclusive") are supported,
+	otherwise optional
+C.4: Excluded if TSPC_HSP_0_2 is supported, otherwise optional
+C.5: Mandatory if TSPC_HSP_0_1 is supported, otherwise optional
+-------------------------------------------------------------------------------
+
+
+		Headset Application Features
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_HSP_3_1	False		Incoming audio connection establishment (M)
+TSPC_HSP_3_2	False		Ring (AT command) (M)
+TSPC_HSP_3_3	False		Inband ring tone (M)
+TSPC_HSP_3_4	False		Outgoing audio connection establishment (M)
+TSPC_HSP_3_5	False		Audio connection release from HS (M)
+TSPC_HSP_3_6	False		Audio connection release from AG (M)
+TSPC_HSP_3_7	False		Audio connection transfer: AG to HS (M)
+TSPC_HSP_3_8	False		Audio connection transfer: HS to AG (M)
+TSPC_HSP_3_9	False		Remote audio volume control (C.1)
+TSPC_HSP_3_10	False		HS informs AG about local changes of audio
+                                        volume (O)
+TSPC_HSP_3_11	False		Audio volume setting storage by HS (O)
+TSPC_HSP_3_12	False		Remote microphone gain control (C.2)
+TSPC_HSP_3_13	False		HS informs AG about local changes of microphone
+                                        gain (O)
+TSPC_HSP_3_14	False		Microphone gain setting storage by HS (O)
+TSPC_HSP_3_15	False		Connection handling with Detach/Page (M)
+TSPC_HSP_3_16	False		Connection handling with Park Mode (C.3)
+-------------------------------------------------------------------------------
+C.1: Mandatory if TSPC_HSP_3_10 is supported, otherwise optional
+C.2: Mandatory if TSPC_HSP_2_13 is supported, otherwise optional
+C.3: Excluded if TSPC_HSP_0_2 is supported, otherwise optional
+-------------------------------------------------------------------------------
+
+
+		Errata Service Releases
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_HSP_4_1	False		Show that in-band ringing and RING are
+					mutually exclusive (C.1)
+-------------------------------------------------------------------------------
+C.1: Excluded if TSPC_HSP_0_2 is supported, otherwise optional
+-------------------------------------------------------------------------------
diff --git a/android/pixit-hsp.txt b/android/pixit-hsp.txt
new file mode 100644
index 0000000..2bda4fa
--- /dev/null
+++ b/android/pixit-hsp.txt
@@ -0,0 +1,30 @@
+HSP PIXIT for the PTS tool.
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
+TSPX_bd_addr_iut					08606E414394 (&)
+TSPX_hs_class_of_device					200404
+TSPX_ag_class_of_device					400204
+TSPX_packet_type_sco					00A0
+TSPX_pin_code						0000
+TSPX_time_guard						20000000
+TSPX_use_implicit_send					TRUE
+TSPX_verbose_implicit_send				FALSE
+TSPX_delete_link_key					FALSE
+TSPX_server_channel_tester				01
+TSPX_server_channel_iut					00
+TSPX_no_fail_verdict					FALSE
+TSPX_remote_audio_volume_control			TRUE
+TSPX_secure_simple_pairing_pass_key_confirmation	FALSE
+TSPX_inband_ring_only					FALSE
+TSPX_no_ring_or_inband_ring_tone			FALSE
+TSPX_iut_establish_audio_before_RING			FALSE
+-------------------------------------------------------------------------------
-- 
1.8.5.3

