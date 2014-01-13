Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] android/pics: Add PICS and PIXIT for A2DP
Date: Mon, 13 Jan 2014 09:11:36 +0100
Message-Id: <1389600696-32598-2-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1389600696-32598-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1389600696-32598-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add PICS/PIXIT for A2DP targeting Android 4.4.
---
 android/Makefile.am    |  1 +
 android/pics-a2dp.txt  | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++
 android/pixit-a2dp.txt | 30 ++++++++++++++++++
 3 files changed, 117 insertions(+)
 create mode 100644 android/pics-a2dp.txt
 create mode 100644 android/pixit-a2dp.txt

diff --git a/android/Makefile.am b/android/Makefile.am
index 98d21d8..356f932 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -148,4 +148,5 @@ EXTRA_DIST += android/Android.mk android/hal-ipc-api.txt android/README \
 		android/pixit-map.txt android/pts-map.txt \
 		android/pics-l2cap.txt android/pixit-l2cap.txt \
 		android/pics-avrcp.txt android/pixit-avrcp.txt \
+		android/pics-a2dp.txt android/pixit-a2dp.txt \
 		android/pts-l2cap.txt
diff --git a/android/pics-a2dp.txt b/android/pics-a2dp.txt
new file mode 100644
index 0000000..1579567
--- /dev/null
+++ b/android/pics-a2dp.txt
@@ -0,0 +1,86 @@
+A2DP PICS for the PTS tool.
+
+PTS version: 5.0
+
+* - different than PTS defaults
+# - not yet implemented/supported
+
+M - mandatory if such role selected
+O - optional
+
+		Roles
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_A2DP_1_1	True		Role: Source (C.1)
+TSPC_A2DP_1_2	False (*)	Role: Sink (C.1)
+-------------------------------------------------------------------------------
+C.1: It is mandatory to support at least one of the defined roles.
+-------------------------------------------------------------------------------
+
+
+		A2DP SRC Features
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_A2DP_2_1	True		SRC: Initiate connection establishment (M)
+TSPC_A2DP_2_2	True		SRC: Accept connection establishment (M)
+TSPC_A2DP_2_3	True		SRC: Initiate start streaming (M)
+TSPC_A2DP_2_4	True		SRC: Accept start streaming (M)
+TSPC_A2DP_2_5	True		SRC: Send audio stream (M)
+TSPC_A2DP_2_6	True		SRC: Initiate connection release (M)
+TSPC_A2DP_2_7	True		SRC: Accept connection release (M)
+TSPC_A2DP_2_8	True (*)	SRC: Initiate suspend (O)
+TSPC_A2DP_2_9	True (*)	SRC: Accept suspend (O)
+TSPC_A2DP_2_10	True		SRC: SBC encoder (M)
+TSPC_A2DP_2_10a	False		SRC: Encode Audio Stream (O)
+TSPC_A2DP_2_11	False		SRC: SBC Configurations in 16 KHz sampling (O)
+TSPC_A2DP_2_12	False		SRC: SBC Configurations in 32 KHz sampling (O)
+TSPC_A2DP_2_13	True		SRC: SBC Configurations in 44.1 KHz sampling
+					(C.1)
+TSPC_A2DP_2_14	False		SRC: SBC Configurations in 48 KHz sampling
+					(C.1)
+-------------------------------------------------------------------------------
+C.1: At least one of the values shall be supported.
+-------------------------------------------------------------------------------
+
+
+		Supported Codecs in SRC
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_A2DP_3_1	True		SRC: SBC encoder Codec (M)
+TSPC_A2DP_3_2	False		SRC: Additional encoder Codec (O)
+-------------------------------------------------------------------------------
+
+
+		A2DP Sink Features
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_A2DP_4_1	False		SNK: Initiate connection establishment (O)
+TSPC_A2DP_4_2	False (*)	SNK: Accept connection establishment (M)
+TSPC_A2DP_4_3	False		SNK: Initiate start streaming (O)
+TSPC_A2DP_4_4	False (*)	SNK: Accept start streaming (M)
+TSPC_A2DP_4_5	False (*)	SNK: Receive audio stream (M)
+TSPC_A2DP_4_6	False		SNK: Initiate connection release (O)
+TSPC_A2DP_4_7	False (*)	SNK: Accept connection release (M)
+TSPC_A2DP_4_8	False		SNK: Initiate suspend (O)
+TSPC_A2DP_4_9	False		SNK: Accept suspend (O)
+TSPC_A2DP_4_10	False (*)	SNK: SBC decoder (M)
+TSPC_A2DP_4_10a	False (*)	SNK: Decode Audio Stream (O)
+TSPC_A2DP_4_11	False		SNK: SBC Configurations in 16 KHz sampling (O)
+TSPC_A2DP_4_12	False		SNK: SBC Configurations in 32 KHz sampling (O)
+TSPC_A2DP_4_13	False (*)	SNK: SBC Configurations in 44.1 KHz sampling (M)
+TSPC_A2DP_4_14	False (*)	SNK: SBC Configurations in 48 KHz sampling (M)
+-------------------------------------------------------------------------------
+
+
+		Supported codecs in SNK
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_A2DP_5_1	False		SNK: SBC decoder Codec (M)
+TSPC_A2DP_5_2	False		SNK: Additional decoder Coded (O)
+TSPC_ALL	False		Enable all test cases when set to False.
+-------------------------------------------------------------------------------
diff --git a/android/pixit-a2dp.txt b/android/pixit-a2dp.txt
new file mode 100644
index 0000000..d060045
--- /dev/null
+++ b/android/pixit-a2dp.txt
@@ -0,0 +1,30 @@
+A2DP PIXIT for the PTS tool.
+
+PTS version: 5.0
+
+* - different than PTS defaults
+& - should be set to IUT Bluetooth address
+# - should be set to PTS's bin/audio folder
+
+Required PIXIT settings
+-------------------------------------------------------------------------------
+Parameter Name			Value
+-------------------------------------------------------------------------------
+TSPX_security_enabled		FALSE
+TSPX_bd_addr_iut		112233445566 (*&)
+TSPX_SRC_class_of_device	080418
+TSPX_SNK_class_of_device	04041C
+TSPX_pin_code			0000
+TSPX_delete_link_key		FALSE
+TSPX_time_guard			300000
+TSPX_use_implicit_send		TRUE
+TSPX_media_directory		C:\Program Files\Bluetooth SIG\Bluetooth PTS\
+					bin\audio (#)
+TSPX_no_avrcp			TRUE
+TSPX_auth_password		0000
+TSPX_auth_user_id		PTS
+TSPX_rfcomm_channel		8
+TSPX_l2cap_psm			1011
+TSPX_no_confirmations		FALSE
+TSPX_cover_art_uuid		3EEE
+-------------------------------------------------------------------------------
-- 
1.8.5

