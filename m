Return-Path: <cyrus@holtmann.org>
From: Sebastian Chlad <sebastian.chlad@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sebastian Chlad <sebastian.chlad@tieto.com>
Subject: [PATCH] android/pts: Add PICS and PIXITs for SM
Date: Tue,  6 May 2014 16:02:16 +0200
Message-Id: <1399384936-25756-2-git-send-email-sebastian.chlad@tieto.com>
In-Reply-To: <1399384936-25756-1-git-send-email-sebastian.chlad@tieto.com>
References: <1399384936-25756-1-git-send-email-sebastian.chlad@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/pics-sm.txt  | 91 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 android/pixit-sm.txt | 70 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 161 insertions(+)
 create mode 100644 android/pics-sm.txt
 create mode 100644 android/pixit-sm.txt

diff --git a/android/pics-sm.txt b/android/pics-sm.txt
new file mode 100644
index 0000000..3060d40
--- /dev/null
+++ b/android/pics-sm.txt
@@ -0,0 +1,91 @@
+SM PICS for the PTS tool.
+
+PTS version: 5.1
+
+* - different than PTS defaults
+
+M - mandatory
+O - optional
+
+		Connection Roles
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_SM_1_1	True		Master Role (Initiator) (C.1)
+TSPC_SM_1_2	True		Slave Role (Responder) (C.1)
+-------------------------------------------------------------------------------
+C.1: At least one of these features shall be supported.
+-------------------------------------------------------------------------------
+
+
+		Security Properties
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_SM_2_1	True		Authenticated MITM protection (O)
+TSPC_SM_2_2	True		Unauthenticated no MITM protection (C.1)
+TSPC_SM_2_3	True		No security requirements (M)
+TSPC_SM_2_4	True		OOB supported (O)
+-------------------------------------------------------------------------------
+C.1: If TSPC_SM_2_1 is supported then Mandatory, else Optional
+-------------------------------------------------------------------------------
+
+
+		Encryption Key Size
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_SM_3_1	True		Encryption Key Size Negotiation (M)
+-------------------------------------------------------------------------------
+
+
+		Pairing Method
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_SM_4_1	True		Just Works (O)
+TSPC_SM_4_2	True		Passkey Entry (C.1)
+TSPC_SM_4_3	True		Out of Band (C.1)
+-------------------------------------------------------------------------------
+C.1: If TSPC_SM_2_1 is supported, at least one of these features shall be
+	supported.
+-------------------------------------------------------------------------------
+
+
+		Security Initiation
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_SM_5_1	True		Encryption Setup using STK (C.3)
+TSPC_SM_5_2	True		Encryption Setup using LTK (O)
+TSPC_SM_5_3	True		Slave Initiated Security (C.1)
+TSPC_SM_5_4	True		Slave Initiated Security – Master response(C.2)
+-------------------------------------------------------------------------------
+C.1: Mandatory if TSPC_SM_1_2 is supported, otherwise Excluded
+C.2: Mandatory if TSPC_SM_1_1 is supported, otherwise Excluded
+C.3: Mandatory IF TSPC_SM_2_1 OR TSPC_SM_2_1 OR TSPC_SM_2_4 is supported,
+	otherwise Excluded
+-------------------------------------------------------------------------------
+
+
+		Signing Algorithm
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_SM_6_1	True		Signing Algorithm - Generation (O)
+TSPC_SM_6_2	True		Signing Algorithm - Resolving (O)
+-------------------------------------------------------------------------------
+
+
+		Key Distribution
+-------------------------------------------------------------------------------
+Parameter Name	Selected	Description
+-------------------------------------------------------------------------------
+TSPC_SM_7_1	True		Encryption Key (C.1)
+TSPC_SM_7_2	True		Identity Key (C.2)
+TSPC_SM_7_3	True		Signing Key (C.3)
+-------------------------------------------------------------------------------
+C.1: Mandatory if GAP (24/2 OR 42/6) is supported, ELSE Optional
+C.2: Mandatory if GAP (26/3) is supported, ELSE Optional
+C.3: Mandatory if GAP (25/6 OR 35/6) is supported, ELSE Optional
+-------------------------------------------------------------------------------
diff --git a/android/pixit-sm.txt b/android/pixit-sm.txt
new file mode 100644
index 0000000..2f5e244
--- /dev/null
+++ b/android/pixit-sm.txt
@@ -0,0 +1,70 @@
+GAP PIXIT for the PTS tool.
+
+PTS version: 5.1
+
+* - different than PTS defaults
+& - should be set to IUT Bluetooth address
+
+		Required PIXIT settings
+-------------------------------------------------------------------------------
+Parameter Name						Value
+-------------------------------------------------------------------------------
+TSPX_bd_addr_iut					112233445566 (*&)
+TSPX_SMP_pin_code					111111
+TSPX_OOB_Data						000000000000FE12036E5A
+							889F4D
+TSPX_peer_addr_type					00
+TSPX_own_addr_type					00
+TSPX_conn_interval_min					0190
+TSPX_conn_interval_max					0190
+TSPX_con_latency					0000
+TSPX_client_class_of_device				100104
+TSPX_server_class_of_device				100104
+TSPX_security_enabled					TRUE
+TSPX_delete_link_key					TRUE
+TSPX_pin_code						1234
+TSPX_ATTR_HANDLE					0000
+TSPX_ATTR_VALUE						000000000000000
+TSPX_delay_variation_in					FFFFFFFF
+TSPX_delay_variation_out				FFFFFFFF
+TSPX_flushto						FFFF
+TSPX_inmtu						02A0
+TSPX_inquiry_length					17
+TSPX_latency_in						FFFFFFFF
+TSPX_latency_out					FFFFFFFF
+TSPX_linkto						3000
+TSPX_max_nbr_retransmission				10
+TSPX_no_fail_verdicts					FALSE
+TSPX_outmtu						02A0
+TSPX_tester_role_optional				L2CAP_ROLE_INITIATOR
+TSPX_page_scan_mode					00
+TSPX_page_scan_repetition_mode				00
+TSPX_peak_bandwidth_in					00000000
+TSPX_peak_bandwidth_out					00000000
+TSPX_psm						0011
+TSPX_service_type_in					01
+TSPX_service_type_out					01
+TSPX_support_retransmissions				TRUE
+TSPX_time_guard						180000
+TSPX_timer_ertx						120000
+TSPX_timer_ertx_max					300000
+TSPX_timer_ertx_min					60000
+TSPX_timer_rtx						10000
+TSPX_timer_rtx_max					60000
+TSPX_timer_rtx_min					1000
+TSPX_token_bucket_size_in				00000000
+TSPX_token_bucket_size_out				00000000
+TSPX_token_rate_in					00000000
+TSPX_token_rate_out					00000000
+TSPX_rfc_mode_mode					03
+TSPX_rfc_mode_tx_window_size				08
+TSPX_rfc_mode_max_transmit				03
+TSPX_rfc_mode_retransmission_timeout			07D0
+TSPX_rfc_mode_monitor_timeout				2EE0
+TSPX_rfc_mode_maximum_pdu_size				02A0
+TSPX_extended_window_size				0012
+TSPX_use_implicit_send					TRUE
+TSPX_use_dynamic_pin					FALSE
+TSPX_iut_SDU_size_in_bytes				144
+TSPX_secure_simple_pairing_pass_key_confirmation	FALSE
+-------------------------------------------------------------------------------
-- 
1.8.5.3

