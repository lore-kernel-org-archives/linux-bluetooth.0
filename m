Return-Path: <SRS0=1bSD=25=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDE14C33C99
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 00:33:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9FE63206F0
	for <linux-bluetooth@archiver.kernel.org>; Wed,  8 Jan 2020 00:33:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YBNQNoF1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgAHAdr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 7 Jan 2020 19:33:47 -0500
Received: from mail-pf1-f174.google.com ([209.85.210.174]:34323 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725908AbgAHAdr (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 7 Jan 2020 19:33:47 -0500
Received: by mail-pf1-f174.google.com with SMTP id i6so708082pfc.1
        for <linux-bluetooth@vger.kernel.org>; Tue, 07 Jan 2020 16:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OtGIg+upfi83jFubCAO7a3hWykXzOrSzRIRbQRKIQI0=;
        b=YBNQNoF1YbjfFlYcRwSLCS3t0L6+w1C4/wuMsNnZ26JwWn7mj6kNzZUQjQ4sd0ylsF
         Pg0fog6oOdBfU4H36k2qXalORiHZ1OffZKqAYJTqHIQ15J5Hm8g/pjnXmvFcSGgnszRs
         EWKBRU1b82WxwplB8qPbZflSQmA5FxHVwqfb/SZBeu9IAFqIBfZ6esmhrMpaPPtGXMUz
         ybDQ1t/QmHxf7e5eNMXiJ0uXMEAHpuifdblUOxuPEZHGiWdNBIDe5BNhzRjAZ1MddYyh
         zTir2SRrOQ9nuCLoZNvTbj24ARCxybhLdhVmg/bA/jT/lWUEcv3czl2RPLX7DI7vexp/
         iflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OtGIg+upfi83jFubCAO7a3hWykXzOrSzRIRbQRKIQI0=;
        b=KMJNaD8KYuwHbMHigIVOeHK0t94AKY4DQ5VvmkIrQVObOuGT2THvvRnZFfceY2ZlVj
         N8rB1IEuY2UvZOU/ZpBGmyzYkBXW3qmzg8hve62jX7sOL4BmZkgCjPfm1oRnG+Vck2Bb
         jOul2df4xsWTb18thjSMzYnY1OcK7HemP3oR7xE+Ik2eyQkvObm9NpmO5ya65lgrEVIe
         hO6aSZPEQmioMlb8c2jvXy7BiuAAzTLV7tV8ekZ64qzHdpBWA7OF89fyHWs0wBGchLZI
         US1xw8OXjeOoRsG+oxC8Oyq0oE5BPKsedAe8ABlVWMUj4e6jXpZwKqNDoyUZvIbGPt5z
         xq9w==
X-Gm-Message-State: APjAAAXwwyMtzEkS+LifSADo5CctVJD1FO5DbJNCKgJ/d643Wvcelwzm
        k4ipa735Ro2ZUjZJOVatw583JBuuw6Q=
X-Google-Smtp-Source: APXvYqwf8wg1KnIDBCMiiL5PVHuJStwA2w4ijtVuIkRMUqytnVC59lsYIOXi+mPyTRNcSqdcdtHO9A==
X-Received: by 2002:aa7:8708:: with SMTP id b8mr2206157pfo.184.1578443624948;
        Tue, 07 Jan 2020 16:33:44 -0800 (PST)
Received: from localhost.localdomain ([192.102.209.43])
        by smtp.gmail.com with ESMTPSA id u10sm925805pgg.41.2020.01.07.16.33.43
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2020 16:33:44 -0800 (PST)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 01/22] monitor: Add support for decoding ISO related commands
Date:   Tue,  7 Jan 2020 16:33:21 -0800
Message-Id: <20200108003342.15458-2-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200108003342.15458-1-luiz.dentz@gmail.com>
References: <20200108003342.15458-1-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds parsing of ISO related commands.
---
 monitor/bt.h     | 300 ++++++++++++++++++++++
 monitor/packet.c | 652 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 952 insertions(+)

diff --git a/monitor/bt.h b/monitor/bt.h
index 8edc895e8..04ad34ea9 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -24,6 +24,12 @@
 
 #include <stdint.h>
 
+#define BT_HCI_CMD_5_2		0x2060
+#define BT_HCI_BIT_5_2		(8 * 41) + 5
+#define BT_HCI_SUBEVT_5_2	0x19
+
+#define BT_LL_CMD_MILAN		0x1f
+
 struct bt_ll_hdr {
 	uint8_t  preamble;
 	uint32_t access_addr;
@@ -443,6 +449,7 @@ struct bt_lmp_power_control_res {
 #define BT_H4_ACL_PKT	0x02
 #define BT_H4_SCO_PKT	0x03
 #define BT_H4_EVT_PKT	0x04
+#define BT_H4_ISO_PKT	0x05
 
 struct bt_hci_cmd_hdr {
 	uint16_t opcode;
@@ -459,6 +466,16 @@ struct bt_hci_sco_hdr {
 	uint8_t  dlen;
 } __attribute__ ((packed));
 
+struct bt_hci_iso_hdr {
+	uint16_t handle;
+	uint8_t  dlen;
+} __attribute__ ((packed));
+
+struct bt_hci_iso_data_start {
+	uint16_t sn;
+	uint16_t slen;
+} __attribute__ ((packed));
+
 struct bt_hci_evt_hdr {
 	uint8_t  evt;
 	uint8_t  plen;
@@ -2461,6 +2478,231 @@ struct bt_hci_cmd_le_tx_test_v3 {
 	uint8_t  antenna_ids[0];
 } __attribute__ ((packed));
 
+#define BT_HCI_CMD_LE_READ_BUFFER_SIZE_V2	BT_HCI_CMD_5_2
+#define BT_HCI_BIT_LE_READ_BUFFER_SIZE_V2	BT_HCI_BIT_5_2
+struct bt_hci_rsp_le_read_buffer_size_v2 {
+	uint8_t  status;
+	uint16_t acl_mtu;
+	uint8_t  acl_max_pkt;
+	uint16_t iso_mtu;
+	uint8_t  iso_max_pkt;
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_READ_ISO_TX_SYNC		BT_HCI_CMD_5_2 + 1
+#define BT_HCI_BIT_LE_READ_ISO_TX_SYNC		BT_HCI_BIT_5_2 + 1
+struct bt_hci_cmd_le_read_iso_tx_sync {
+	uint16_t handle;
+} __attribute__ ((packed));
+
+struct bt_hci_rsp_le_read_iso_tx_sync {
+	uint8_t  status;
+	uint16_t handle;
+	uint16_t seq;
+	uint32_t timestamp;
+	uint8_t  offset[3];
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_SET_CIG_PARAMS		BT_HCI_CMD_5_2 + 2
+#define BT_HCI_BIT_LE_SET_CIG_PARAMS		BT_HCI_BIT_5_2 + 2
+struct bt_hci_cis_params {
+	uint8_t  cis_id;
+	uint16_t m_sdu;
+	uint16_t s_sdu;
+	uint8_t  m_phy;
+	uint8_t  s_phy;
+	uint8_t  m_rtn;
+	uint8_t  s_rtn;
+} __attribute__ ((packed));
+
+struct bt_hci_cmd_le_set_cig_params {
+	uint8_t  cig_id;
+	uint8_t  m_interval[3];
+	uint8_t  s_interval[3];
+	uint8_t  sca;
+	uint8_t  packing;
+	uint8_t  framing;
+	uint16_t m_latency;
+	uint16_t s_latency;
+	uint8_t  num_cis;
+	struct bt_hci_cis_params cis[0];
+} __attribute__ ((packed));
+
+struct bt_hci_rsp_le_set_cig_params {
+	uint8_t  status;
+	uint8_t  cig_id;
+	uint8_t  num_handles;
+	uint16_t handle[0];
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_SET_CIG_PARAMS_TEST	BT_HCI_CMD_5_2 + 3
+#define BT_HCI_BIT_LE_SET_CIG_PARAMS_TEST	BT_HCI_BIT_5_2 + 3
+struct bt_hci_cis_params_test {
+	uint8_t  cis_id;
+	uint8_t  nse;
+	uint16_t m_sdu;
+	uint16_t s_sdu;
+	uint8_t  m_pdu;
+	uint8_t  s_pdu;
+	uint8_t  m_phy;
+	uint8_t  s_phy;
+	uint8_t  m_bn;
+	uint8_t  s_bn;
+} __attribute__ ((packed));
+
+struct bt_hci_cmd_le_set_cig_params_test {
+	uint8_t  cig_id;
+	uint8_t  m_interval[3];
+	uint8_t  s_interval[3];
+	uint8_t  m_ft;
+	uint8_t  s_ft;
+	uint16_t iso_interval;
+	uint8_t  sca;
+	uint8_t  packing;
+	uint8_t  framing;
+	uint8_t  num_cis;
+	struct bt_hci_cis_params_test cis[0];
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_CREATE_CIS		BT_HCI_CMD_5_2 + 4
+#define BT_HCI_BIT_LE_CREATE_CIS		BT_HCI_BIT_5_2 + 4
+struct bt_hci_cis {
+	uint16_t  cis_handle;
+	uint16_t  acl_handle;
+} __attribute__ ((packed));
+
+struct bt_hci_cmd_le_create_cis {
+	uint8_t  num_cis;
+	struct bt_hci_cis cis[0];
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_REMOVE_CIG		BT_HCI_CMD_5_2 + 5
+#define BT_HCI_BIT_LE_REMOVE_CIG		BT_HCI_BIT_5_2 + 5
+struct bt_hci_cmd_le_remove_cig {
+	uint8_t  cig_id;
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_ACCEPT_CIS		BT_HCI_CMD_5_2 + 6
+#define BT_HCI_BIT_LE_ACCEPT_CIS		BT_HCI_BIT_5_2 + 6
+struct bt_hci_cmd_le_accept_cis {
+	uint16_t handle;
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_REJECT_CIS		BT_HCI_CMD_5_2 + 7
+#define BT_HCI_BIT_LE_REJECT_CIS		BT_HCI_BIT_5_2 + 7
+struct bt_hci_cmd_le_reject_cis {
+	uint16_t handle;
+	uint8_t  reason;
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_CREATE_BIG		BT_HCI_CMD_5_2 + 8
+#define BT_HCI_BIT_LE_CREATE_BIG		BT_HCI_BIT_5_2 + 8
+struct bt_hci_bis {
+	uint8_t  sdu_interval[3];
+	uint16_t sdu;
+	uint16_t latency;
+	uint8_t  rtn;
+	uint8_t  phy;
+	uint8_t  packing;
+	uint8_t  framing;
+	uint8_t  encryption;
+	uint8_t  bcode[16];
+} __attribute__ ((packed));
+
+struct bt_hci_cmd_le_create_big {
+	uint8_t  big_id;
+	uint8_t  adv_handle;
+	uint8_t  num_bis;
+	struct bt_hci_bis bis[0];
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_CREATE_BIG_TEST		BT_HCI_CMD_5_2 + 9
+#define BT_HCI_BIT_LE_CREATE_BIG_TEST		BT_HCI_BIT_5_2 + 9
+struct bt_hci_bis_test {
+	uint8_t  sdu_interval[3];
+	uint16_t iso_interval;
+	uint8_t  nse;
+	uint16_t sdu;
+	uint8_t  pdu;
+	uint8_t  phy;
+	uint8_t  packing;
+	uint8_t  framing;
+	uint8_t  bn;
+	uint8_t  irc;
+	uint8_t  pto;
+	uint8_t  adv_handle;
+	uint8_t  encryption;
+	uint8_t  bcode[16];
+} __attribute__ ((packed));
+
+struct bt_hci_cmd_le_create_big_test {
+	uint8_t  big_id;
+	uint8_t  adv_handle;
+	uint8_t  num_bis;
+	struct bt_hci_bis_test bis[0];
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_TERM_BIG			BT_HCI_CMD_5_2 + 10
+#define BT_HCI_BIT_LE_TERM_BIG			BT_HCI_BIT_5_2 + 10
+struct bt_hci_cmd_le_term_big {
+	uint8_t  big_id;
+	uint8_t  reason;
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_BIG_CREATE_SYNC		BT_HCI_CMD_5_2 + 11
+#define BT_HCI_BIT_LE_BIG_CREATE_SYNC		BT_HCI_BIT_5_2 + 11
+struct bt_hci_bis_sync {
+} __attribute__ ((packed));
+
+struct bt_hci_cmd_le_big_create_sync {
+	uint8_t  big_id;
+	uint16_t sync_handle;
+	uint8_t  num_bis;
+	uint8_t  encryption;
+	uint8_t  bcode[16];
+	uint8_t  mse;
+	uint16_t timeout;
+	struct bt_hci_bis_sync bis[0];
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_BIG_TERM_SYNC		BT_HCI_CMD_5_2 + 12
+#define BT_HCI_BIT_LE_BIG_TERM_SYNC		BT_HCI_BIT_5_2 + 12
+struct bt_hci_cmd_le_big_term_sync {
+	uint8_t  big_id;
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_REQ_PEER_SCA		BT_HCI_CMD_5_2 + 13
+#define BT_HCI_BIT_LE_REQ_PEER_SCA		BT_HCI_BIT_5_2 + 13
+struct bt_hci_cmd_le_req_peer_sca {
+	uint16_t handle;
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_SETUP_ISO_PATH		BT_HCI_CMD_5_2 + 14
+#define BT_HCI_BIT_LE_SETUP_ISO_PATH		BT_HCI_BIT_5_2 + 14
+struct bt_hci_cmd_le_setup_iso_path {
+	uint16_t handle;
+	uint8_t  input_path;
+	uint8_t  output_path;
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_REMOVE_ISO_PATH		BT_HCI_CMD_5_2 + 15
+#define BT_HCI_BIT_LE_REMOVE_ISO_PATH		BT_HCI_BIT_5_2 + 15
+struct bt_hci_cmd_le_remove_iso_path {
+	uint16_t handle;
+	uint8_t  path_dir;
+} __attribute__ ((packed));
+
+#define BT_HCI_CMD_LE_ISO_TX_TEST		BT_HCI_CMD_5_2 + 16
+#define BT_HCI_BIT_LE_ISO_TX_TEST		BT_HCI_BIT_5_2 + 16
+
+#define BT_HCI_CMD_LE_ISO_RX_TEST		BT_HCI_CMD_5_2 + 17
+#define BT_HCI_BIT_LE_ISO_RX_TEST		BT_HCI_BIT_5_2 + 17
+
+#define BT_HCI_CMD_LE_ISO_READ_TEST_COUNTER	BT_HCI_CMD_5_2 + 18
+#define BT_HCI_BIT_LE_ISO_READ_TEST_COUNTER	BT_HCI_BIT_5_2 + 18
+
+#define BT_HCI_CMD_LE_ISO_TEST_END		BT_HCI_CMD_5_2 + 19
+#define BT_HCI_BIT_LE_ISO_TEST_END		BT_HCI_BIT_5_2 + 19
+
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
 	uint8_t  status;
@@ -3140,6 +3382,64 @@ struct bt_hci_evt_le_chan_select_alg {
 	uint8_t  algorithm;
 } __attribute__ ((packed));
 
+#define BT_HCI_EVT_LE_CIS_ESTABLISHED		BT_HCI_SUBEVT_5_2
+struct bt_hci_evt_le_cis_established {
+	uint8_t  status;
+	uint16_t conn_handle;
+	uint8_t  cig_sync_delay[3];
+	uint8_t  cis_sync_delay[3];
+	uint8_t  latency[3];
+	uint8_t  m_phy;
+	uint8_t  s_phy;
+} __attribute__ ((packed));
+
+#define BT_HCI_EVT_LE_CIS_REQ			BT_HCI_SUBEVT_5_2 + 1
+struct bt_hci_evt_le_cis_req {
+	uint16_t acl_handle;
+	uint16_t cis_handle;
+	uint8_t  cig_id;
+	uint8_t  cis_id;
+} __attribute__ ((packed));
+
+#define BT_HCI_EVT_LE_BIG_COMPLETE		BT_HCI_SUBEVT_5_2 + 2
+struct bt_hci_evt_le_big_complete {
+	uint8_t  status;
+	uint8_t  big_id;
+	uint8_t  sync_delay[3];
+	uint8_t  latency[3];
+	uint8_t  phy;
+	uint8_t  num_bis;
+	uint16_t handle[0];
+} __attribute__ ((packed));
+
+#define BT_HCI_EVT_LE_BIG_TERMINATE		BT_HCI_SUBEVT_5_2 + 3
+struct bt_hci_evt_le_big_terminate {
+	uint8_t  reason;
+	uint8_t  big_id;
+} __attribute__ ((packed));
+
+#define BT_HCI_EVT_LE_BIG_SYNC_ESTABILISHED	BT_HCI_SUBEVT_5_2 + 4
+struct bt_hci_evt_le_big_sync_estabilished {
+	uint8_t  status;
+	uint8_t  big_id;
+	uint8_t  latency[3];
+	uint8_t  num_bis;
+	uint16_t handle[0];
+} __attribute__ ((packed));
+
+#define BT_HCI_EVT_LE_BIG_SYNC_LOST		BT_HCI_SUBEVT_5_2 + 5
+struct bt_hci_evt_le_big_sync_lost {
+	uint8_t  big_id;
+	uint8_t  reason;
+} __attribute__ ((packed));
+
+#define BT_HCI_EVT_LE_REQ_PEER_SCA_COMPLETE	BT_HCI_SUBEVT_5_2 + 6
+struct bt_hci_evt_le_req_peer_sca_complete {
+	uint8_t  status;
+	uint16_t handle;
+	uint8_t  sca;
+} __attribute__ ((packed));
+
 #define BT_HCI_ERR_SUCCESS			0x00
 #define BT_HCI_ERR_UNKNOWN_COMMAND		0x01
 #define BT_HCI_ERR_UNKNOWN_CONN_ID		0x02
diff --git a/monitor/packet.c b/monitor/packet.c
index ab8bbdee5..8987ed703 100644
--- a/monitor/packet.c
+++ b/monitor/packet.c
@@ -2617,6 +2617,11 @@ static const struct bitfield_data features_le[] = {
 	{ 25, "Periodic Advertising Sync Transfer - Recipient"	},
 	{ 26, "Sleep Clock Accuracy Updates"			},
 	{ 27, "Remote Public Key Validation"			},
+	{ 28, "Connected Isochronous Stream - Master"		},
+	{ 29, "Connected Isochronous Stream - Slave"		},
+	{ 30, "Isochronous Broadcaster"				},
+	{ 31, "Synchronized Receiver"				},
+	{ 32, "Isochronous Channels (Host Support)"		},
 	{ }
 };
 
@@ -2977,6 +2982,12 @@ static const struct bitfield_data events_le_table[] = {
 	{ 17, "LE Extended Advertising Set Terminated"	},
 	{ 18, "LE Scan Request Received"		},
 	{ 19, "LE Channel Selection Algorithm"		},
+	{ 24, "LE CIS Established"			},
+	{ 25, "LE CIS Request"				},
+	{ 26, "LE Create BIG Complete"			},
+	{ 27, "LE Terminate BIG Complete"		},
+	{ 28, "LE BIG Sync Estabilished Complete"	},
+	{ 29, "LE BIG Sync Lost"			},
 	{ }
 };
 
@@ -7538,6 +7549,437 @@ static void le_tx_test_cmd_v3(const void *data, uint8_t size)
 		print_field("  Antenna ID: %u", cmd->antenna_ids[i]);
 }
 
+static void print_sca(uint8_t sca)
+{
+	switch (sca) {
+	case 0x00:
+		print_field("SCA: 201 - 500 ppm (0x%2.2x)", sca);
+		return;
+	case 0x01:
+		print_field("SCA: 151 - 200 ppm (0x%2.2x)", sca);
+		return;
+	case 0x02:
+		print_field("SCA: 101 - 150 ppm (0x%2.2x)", sca);
+		return;
+	case 0x03:
+		print_field("SCA: 76 - 100 ppm (0x%2.2x)", sca);
+		return;
+	case 0x04:
+		print_field("SCA: 51 - 75 ppm (0x%2.2x)", sca);
+		return;
+	case 0x05:
+		print_field("SCA: 31 - 50 ppm (0x%2.2x)", sca);
+		return;
+	case 0x06:
+		print_field("SCA: 21 - 30 ppm (0x%2.2x)", sca);
+		return;
+	case 0x07:
+		print_field("SCA: 0 - 20 ppm (0x%2.2x)", sca);
+		return;
+	default:
+		print_field("SCA: Reserved (0x%2.2x)", sca);
+	}
+}
+
+static void print_packing(uint8_t value)
+{
+	switch (value) {
+	case 0x00:
+		print_field("Packing: Sequential (0x%2.2x)", value);
+		return;
+	case 0x01:
+		print_field("Packing: Interleaved (0x%2.2x)", value);
+		return;
+	default:
+		print_field("Packing: Reserved (0x%2.2x)", value);
+	}
+}
+
+static void print_framing(uint8_t value)
+{
+	switch (value) {
+	case 0x00:
+		print_field("Framing: Unframed (0x%2.2x)", value);
+		return;
+	case 0x01:
+		print_field("Framing: Framed (0x%2.2x)", value);
+		return;
+	default:
+		print_field("Packing: Reserved (0x%2.2x)", value);
+	}
+}
+
+static void le_read_buffer_size_v2_rsp(const void *data, uint8_t size)
+{
+	const struct bt_hci_rsp_le_read_buffer_size_v2 *rsp = data;
+
+	print_status(rsp->status);
+
+	if (size == 1)
+		return;
+
+	print_field("ACL MTU: %d", le16_to_cpu(rsp->acl_mtu));
+	print_field("ACL max packet: %d", rsp->acl_max_pkt);
+	print_field("ISO MTU: %d", le16_to_cpu(rsp->iso_mtu));
+	print_field("ISO max packet: %d", rsp->iso_max_pkt);
+}
+
+static void le_read_iso_tx_sync_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_read_iso_tx_sync *cmd = data;
+
+	print_field("Handle: %d", le16_to_cpu(cmd->handle));
+}
+
+static void le_read_iso_tx_sync_rsp(const void *data, uint8_t size)
+{
+	const struct bt_hci_rsp_le_read_iso_tx_sync *rsp = data;
+	uint32_t offset = 0;
+
+	print_status(rsp->status);
+
+	if (size == 1)
+		return;
+
+	print_field("Handle: %d", le16_to_cpu(rsp->handle));
+	print_field("Sequence Number: %d", le16_to_cpu(rsp->seq));
+	print_field("Timestamp: %d", le32_to_cpu(rsp->timestamp));
+
+	memcpy(&offset, rsp->offset, sizeof(rsp->offset));
+
+	print_field("Offset: %d", le32_to_cpu(offset));
+}
+
+static void print_cis_params(const void *data)
+{
+	const struct bt_hci_cis_params *cis = data;
+
+	print_field("CIS ID: 0x%2.2x", cis->cis_id);
+	print_field("Master to Slave Maximum SDU Size: %u",
+						le16_to_cpu(cis->m_sdu));
+	print_field("Slave to Master Maximum SDU Size: %u",
+						le16_to_cpu(cis->s_sdu));
+	print_le_phy("Master to Slave PHY", cis->m_phy);
+	print_le_phy("Slave to Master PHY", cis->s_phy);
+	print_field("Master to Slave Retransmission attempts: 0x%2.2x",
+							cis->m_rtn);
+	print_field("Slave to Master Retransmission attempts: 0x%2.2x",
+							cis->s_rtn);
+}
+
+static void print_list(const void *data, uint8_t size, int num_items,
+			size_t item_size, void (*callback)(const void *data))
+{
+	while (size >= item_size && num_items) {
+		callback(data);
+		data += item_size;
+		size -= item_size;
+		num_items--;
+	}
+
+	if (num_items)
+		print_hex_field("", data, size);
+}
+
+static void print_usec_interval(const char *prefix, const uint8_t interval[3])
+{
+	uint32_t u24 = 0;
+
+	memcpy(&u24, interval, 3);
+	print_field("%s: %u us (0x%6.6x)", prefix, le32_to_cpu(u24),
+						le32_to_cpu(u24));
+}
+
+static void le_set_cig_params_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_set_cig_params *cmd = data;
+
+	print_field("CIG ID: 0x%2.2x", cmd->cig_id);
+	print_usec_interval("Master to Slave SDU Interval", cmd->m_interval);
+	print_usec_interval("Slave to Master SDU Interval", cmd->s_interval);
+	print_sca(cmd->sca);
+	print_packing(cmd->packing);
+	print_framing(cmd->framing);
+	print_field("Master to Slave Maximum Latency: %d ms (0x%4.4x)",
+		le16_to_cpu(cmd->m_latency), le16_to_cpu(cmd->m_latency));
+	print_field("Slave to Master Maximum Latency: %d ms (0x%4.4x)",
+		le16_to_cpu(cmd->s_latency), le16_to_cpu(cmd->s_latency));
+	print_field("Number of CIS: %u", cmd->num_cis);
+
+	size -= sizeof(*cmd);
+
+	print_list(cmd->cis, size, cmd->num_cis, sizeof(*cmd->cis),
+						print_cis_params);
+}
+
+static void print_cis_params_test(const void *data)
+{
+	const struct bt_hci_cis_params_test *cis = data;
+
+	print_field("CIS ID: 0x%2.2x", cis->cis_id);
+	print_field("NSE: 0x%2.2x", cis->nse);
+	print_field("Master to Slave Maximum SDU: 0x%4.4x", cis->m_sdu);
+	print_field("Slave to Master Maximum SDU: 0x%4.4x",
+						le16_to_cpu(cis->s_sdu));
+	print_field("Master to Slave Maximum PDU: 0x%2.2x",
+						le16_to_cpu(cis->m_pdu));
+	print_field("Slave to Master Maximum PDU: 0x%2.2x", cis->s_pdu);
+	print_le_phy("Master to Slave PHY", cis->m_phy);
+	print_le_phy("Slave to Master PHY", cis->s_phy);
+	print_field("Master to Slave Burst Number: 0x%2.2x", cis->m_bn);
+	print_field("Slave to Master Burst Number: 0x%2.2x", cis->s_bn);
+}
+
+static void le_set_cig_params_test_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_set_cig_params_test *cmd = data;
+
+	print_field("CIG ID: 0x%2.2x", cmd->cig_id);
+	print_usec_interval("Master to Slave SDU Interval", cmd->m_interval);
+	print_usec_interval("Master to Slave SDU Interval", cmd->s_interval);
+	print_field("Master to Slave Flush Timeout: 0x%2.2x", cmd->m_ft);
+	print_field("Slave to Master Flush Timeout: 0x%2.2x", cmd->s_ft);
+	print_field("ISO Interval: %.2f ms (0x%4.4x)",
+				le16_to_cpu(cmd->iso_interval) * 1.25,
+				le16_to_cpu(cmd->iso_interval));
+	print_sca(cmd->sca);
+	print_packing(cmd->packing);
+	print_framing(cmd->framing);
+	print_field("Number of CIS: %u", cmd->num_cis);
+
+	size -= sizeof(*cmd);
+
+	print_list(cmd->cis, size, cmd->num_cis, sizeof(*cmd->cis),
+						print_cis_params_test);
+}
+
+static void print_cig_handle(const void *data)
+{
+	const uint16_t *handle = data;
+
+	print_field("Connection Handle: %d", le16_to_cpu(*handle));
+}
+
+static void le_set_cig_params_rsp(const void *data, uint8_t size)
+{
+	const struct bt_hci_rsp_le_set_cig_params *rsp = data;
+
+	print_status(rsp->status);
+
+	if (size == 1)
+		return;
+
+	print_field("CIG ID: 0x%2.2x", rsp->cig_id);
+	print_field("Number of Handles: %u", rsp->num_handles);
+
+	size -= sizeof(*rsp);
+
+	print_list(rsp->handle, size, rsp->num_handles, sizeof(*rsp->handle),
+						print_cig_handle);
+}
+
+static void print_cis(const void *data)
+{
+	const struct bt_hci_cis *cis = data;
+
+	print_field("CIS Handle: %d", cis->cis_handle);
+	print_field("ACL Handle: %d", cis->acl_handle);
+}
+
+static void le_create_cis_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_create_cis *cmd = data;
+
+	print_field("Number of CIS: %u", cmd->num_cis);
+
+	size -= sizeof(*cmd);
+
+	print_list(cmd->cis, size, cmd->num_cis, sizeof(*cmd->cis), print_cis);
+}
+
+static void le_remove_cig_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_remove_cig *cmd = data;
+
+	print_field("CIG ID: 0x%02x", cmd->cig_id);
+}
+
+static void le_accept_cis_req_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_accept_cis *cmd = data;
+
+	print_field("CIS Handle: %d", le16_to_cpu(cmd->handle));
+}
+
+static void le_reject_cis_req_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_reject_cis *cmd = data;
+
+	print_field("CIS Handle: %d", le16_to_cpu(cmd->handle));
+	print_reason(cmd->reason);
+}
+
+static void print_bis(const void *data)
+{
+	const struct bt_hci_bis *bis = data;
+
+	print_usec_interval("SDU Interval", bis->sdu_interval);
+	print_field("Maximum SDU size: %u", le16_to_cpu(bis->sdu));
+	print_field("Maximum Latency: %u ms (0x%4.4x)",
+			le16_to_cpu(bis->latency), le16_to_cpu(bis->latency));
+	print_field("RTN: 0x%2.2x", bis->rtn);
+	print_le_phy("PHY", bis->phy);
+	print_packing(bis->packing);
+	print_framing(bis->framing);
+	print_field("Encryption: 0x%2.2x", bis->encryption);
+	print_hex_field("Broadcast Code", bis->bcode, 16);
+}
+
+static void le_create_big_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_create_big *cmd = data;
+
+	print_field("BIG ID: 0x%2.2x", cmd->big_id);
+	print_field("Advertising Handle: 0x%2.2x", cmd->adv_handle);
+	print_field("Number of BIS: %u", cmd->num_bis);
+
+	size -= sizeof(*cmd);
+
+	print_list(cmd->bis, size, cmd->num_bis, sizeof(*cmd->bis), print_bis);
+}
+
+static void print_bis_test(const void *data)
+{
+	const struct bt_hci_bis_test *bis = data;
+
+	print_usec_interval("SDU Interval", bis->sdu_interval);
+	print_field("ISO Interval: %.2f ms (0x%4.4x)",
+				le16_to_cpu(bis->iso_interval) * 1.25,
+				le16_to_cpu(bis->iso_interval));
+	print_field("Number of Subevents: %u", bis->nse);
+	print_field("Maximum SDU: %u", bis->sdu);
+	print_field("Maximum PDU: %u", bis->pdu);
+	print_packing(bis->packing);
+	print_framing(bis->framing);
+	print_le_phy("PHY", bis->phy);
+	print_field("Burst Number: %u", bis->bn);
+	print_field("Immediate Repetition Count: %u", bis->irc);
+	print_field("Pre Transmission Offset: 0x%2.2x", bis->pto);
+	print_field("Encryption: 0x%2.2x", bis->encryption);
+	print_hex_field("Broadcast Code", bis->bcode, 16);
+}
+
+static void le_create_big_cmd_test_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_create_big_test *cmd = data;
+
+	print_field("BIG ID: 0x%2.2x", cmd->big_id);
+	print_field("Advertising Handle: 0x%2.2x", cmd->adv_handle);
+	print_field("Number of BIS: %u", cmd->num_bis);
+
+	size -= sizeof(*cmd);
+
+	print_list(cmd->bis, size, cmd->num_bis, sizeof(*cmd->bis),
+						print_bis_test);
+}
+
+static void le_terminate_big_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_term_big *cmd = data;
+
+	print_field("BIG ID: 0x%2.2x", cmd->big_id);
+	print_reason(cmd->reason);
+}
+
+static void print_bis_sync(const void *data)
+{
+	const uint8_t *bis_id = data;
+
+	print_field("BIS ID: 0x%2.2x", *bis_id);
+}
+
+static void le_big_create_sync_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_big_create_sync *cmd = data;
+
+	print_field("BIG ID: 0x%2.2x", cmd->big_id);
+	print_field("Number of BIS: %u", cmd->num_bis);
+	print_field("Encryption: 0x%2.2x", cmd->encryption);
+	print_hex_field("Broadcast Code", cmd->bcode, 16);
+	print_field("Number Subevents: 0x%2.2x", cmd->mse);
+	print_field("Timeout: %d ms (0x%4.4x)", le16_to_cpu(cmd->timeout) * 10,
+						le16_to_cpu(cmd->timeout));
+
+	size -= sizeof(*cmd);
+
+	print_list(cmd->bis, size, cmd->num_bis, sizeof(*cmd->bis),
+						print_bis_sync);
+}
+
+static void le_big_term_sync_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_big_term_sync *cmd = data;
+
+	print_field("BIG ID: 0x%2.2x", cmd->big_id);
+}
+
+static void print_iso_path(const char *prefix, uint8_t path)
+{
+	switch (path) {
+	case 0x00:
+		print_field("%s Data Path: Disabled (0x%2.2x)", prefix, path);
+		return;
+	case 0x01:
+		print_field("%s Data Path: HCI (0x%2.2x)", prefix, path);
+		return;
+	case 0xff:
+		print_field("%s Data Path: Test Mode (0x%2.2x)", prefix, path);
+		return;
+	default:
+		print_field("%s Data Path: Logical Channel Number (0x%2.2x)",
+							prefix, path);
+	}
+}
+
+static void le_setup_iso_path_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_setup_iso_path *cmd = data;
+
+	print_field("Handle: %d", le16_to_cpu(cmd->handle));
+	print_iso_path("Input", cmd->input_path);
+	print_iso_path("Output", cmd->output_path);
+}
+
+static void print_iso_dir(uint8_t path_dir)
+{
+	switch (path_dir) {
+	case 0x00:
+		print_field("Data Path Direction: Input (0x%2.2x)", path_dir);
+		return;
+	case 0x01:
+		print_field("Data Path Direction: Output (0x%2.2x)", path_dir);
+		return;
+	default:
+		print_field("Data Path Direction: Reserved (0x%2.2x)",
+							path_dir);
+	}
+}
+
+static void le_remove_iso_path_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_remove_iso_path *cmd = data;
+
+	print_field("Connection Handle: %d", le16_to_cpu(cmd->handle));
+	print_iso_dir(cmd->path_dir);
+}
+
+static void le_req_peer_sca_cmd(const void *data, uint8_t size)
+{
+	const struct bt_hci_cmd_le_req_peer_sca *cmd = data;
+
+	print_field("Connection Handle: %d", le16_to_cpu(cmd->handle));
+}
+
 struct opcode_data {
 	uint16_t opcode;
 	int bit;
@@ -8331,6 +8773,107 @@ static const struct opcode_data opcode_table[] = {
 	{ 0x2050, 316, "LE Transmitter Test command [v3]",
 				le_tx_test_cmd_v3, 9, false,
 				status_rsp, 1, true },
+	{ BT_HCI_CMD_LE_READ_BUFFER_SIZE_V2,
+				BT_HCI_BIT_LE_READ_BUFFER_SIZE_V2,
+				"LE Read Buffer v2",
+				null_cmd, 0, true,
+				le_read_buffer_size_v2_rsp,
+				sizeof(
+				struct bt_hci_rsp_le_read_buffer_size_v2),
+				true },
+	{ BT_HCI_CMD_LE_READ_ISO_TX_SYNC,
+				BT_HCI_BIT_LE_READ_ISO_TX_SYNC,
+				"LE Read ISO TX Sync",
+				le_read_iso_tx_sync_cmd,
+				sizeof(struct bt_hci_cmd_le_read_iso_tx_sync),
+				true,
+				le_read_iso_tx_sync_rsp,
+				sizeof(struct bt_hci_rsp_le_read_iso_tx_sync),
+				true },
+	{ BT_HCI_CMD_LE_SET_CIG_PARAMS, BT_HCI_BIT_LE_SET_CIG_PARAMS,
+				"LE Set Connected Isochronous Group Parameters",
+				le_set_cig_params_cmd,
+				sizeof(struct bt_hci_cmd_le_set_cig_params),
+				false,
+				le_set_cig_params_rsp,
+				sizeof(struct bt_hci_rsp_le_set_cig_params),
+				false },
+	{ BT_HCI_CMD_LE_SET_CIG_PARAMS_TEST, BT_HCI_BIT_LE_SET_CIG_PARAMS_TEST,
+				"LE Set Connected Isochronous Group Parameters"
+				" Test", le_set_cig_params_test_cmd,
+				sizeof(
+				struct bt_hci_cmd_le_set_cig_params_test),
+				false,
+				le_set_cig_params_rsp,
+				sizeof(struct bt_hci_rsp_le_set_cig_params),
+				false },
+	{ BT_HCI_CMD_LE_CREATE_CIS, BT_HCI_BIT_LE_CREATE_CIS,
+				"LE Create Connected Isochronous Stream",
+				le_create_cis_cmd,
+				sizeof(struct bt_hci_cmd_le_create_cis),
+				false },
+	{ BT_HCI_CMD_LE_REMOVE_CIG, BT_HCI_BIT_LE_REMOVE_CIG,
+				"LE Remove Connected Isochronous Group",
+				le_remove_cig_cmd,
+				sizeof(struct bt_hci_cmd_le_remove_cig), false,
+				status_rsp, 1, true },
+	{ BT_HCI_CMD_LE_ACCEPT_CIS, BT_HCI_BIT_LE_ACCEPT_CIS,
+				"LE Accept Connected Isochronous Stream Request",
+				le_accept_cis_req_cmd,
+				sizeof(struct bt_hci_cmd_le_accept_cis), true },
+	{ BT_HCI_CMD_LE_REJECT_CIS, BT_HCI_BIT_LE_REJECT_CIS,
+				"LE Reject Connected Isochronous Stream Request",
+				le_reject_cis_req_cmd,
+				sizeof(struct bt_hci_cmd_le_reject_cis), true,
+				status_rsp, 1, true },
+	{ BT_HCI_CMD_LE_CREATE_BIG, BT_HCI_BIT_LE_CREATE_BIG,
+				"LE Create Broadcast Isochronous Group",
+				le_create_big_cmd },
+	{ BT_HCI_CMD_LE_CREATE_BIG_TEST, BT_HCI_BIT_LE_CREATE_BIG_TEST,
+				"LE Create Broadcast Isochronous Group Test",
+				le_create_big_cmd_test_cmd },
+	{ BT_HCI_CMD_LE_TERM_BIG, BT_HCI_BIT_LE_TERM_BIG,
+				"LE Terminate Broadcast Isochronous Group",
+				le_terminate_big_cmd,
+				sizeof(struct bt_hci_cmd_le_term_big), true,
+				status_rsp, 1, true},
+	{ BT_HCI_CMD_LE_BIG_CREATE_SYNC, BT_HCI_BIT_LE_BIG_CREATE_SYNC,
+				"LE Broadcast Isochronous Group Create Sync",
+				le_big_create_sync_cmd,
+				sizeof(struct bt_hci_cmd_le_big_create_sync),
+				true },
+	{ BT_HCI_CMD_LE_BIG_TERM_SYNC, BT_HCI_BIT_LE_BIG_TERM_SYNC,
+				"LE Broadcast Isochronous Group Terminate Sync",
+				le_big_term_sync_cmd,
+				sizeof(struct bt_hci_cmd_le_big_term_sync),
+				true },
+	{ BT_HCI_CMD_LE_REQ_PEER_SCA, BT_HCI_BIT_LE_REQ_PEER_SCA,
+				"LE Request Peer SCA", le_req_peer_sca_cmd,
+				sizeof(struct bt_hci_cmd_le_req_peer_sca),
+				true },
+	{ BT_HCI_CMD_LE_SETUP_ISO_PATH, BT_HCI_BIT_LE_SETUP_ISO_PATH,
+				"LE Setup Isochronous Data Path",
+				le_setup_iso_path_cmd,
+				sizeof(struct bt_hci_cmd_le_setup_iso_path),
+				true, status_rsp, 1, true },
+	{ BT_HCI_CMD_LE_REMOVE_ISO_PATH, BT_HCI_BIT_LE_REMOVE_ISO_PATH,
+				"LE Remove Isochronous Data Path",
+				le_remove_iso_path_cmd,
+				sizeof(struct bt_hci_cmd_le_remove_iso_path),
+				true, status_rsp, 1, true },
+	{ BT_HCI_CMD_LE_ISO_TX_TEST, BT_HCI_BIT_LE_ISO_TX_TEST,
+				"LE Isochronous Transmit Test", NULL, 0,
+				false },
+	{ BT_HCI_CMD_LE_ISO_RX_TEST, BT_HCI_BIT_LE_ISO_RX_TEST,
+				"LE Isochronous Receive Test", NULL, 0,
+				false },
+	{ BT_HCI_CMD_LE_ISO_READ_TEST_COUNTER,
+				BT_HCI_BIT_LE_ISO_READ_TEST_COUNTER,
+				"LE Isochronous Read Test Counters", NULL, 0,
+				false },
+	{ BT_HCI_CMD_LE_ISO_TEST_END, BT_HCI_BIT_LE_ISO_TEST_END,
+				"LE Isochronous Read Test Counters", NULL, 0,
+				false },
 	{ }
 };
 
@@ -9724,6 +10267,85 @@ static void le_chan_select_alg_evt(const void *data, uint8_t size)
 	print_field("Algorithm: %s (0x%2.2x)", str, evt->algorithm);
 }
 
+static void le_cis_established_evt(const void *data, uint8_t size)
+{
+	const struct bt_hci_evt_le_cis_established *evt = data;
+
+	print_status(evt->status);
+	print_field("Connection Handle: %d", le16_to_cpu(evt->status));
+	print_usec_interval("CIG Synchronization Delay", evt->cig_sync_delay);
+	print_usec_interval("CIS Synchronization Delay", evt->cis_sync_delay);
+	print_usec_interval("Latency", evt->latency);
+	print_le_phy("Master to Slave PHY", evt->m_phy);
+	print_le_phy("Slave to Master PHY", evt->m_phy);
+}
+
+static void le_req_cis_evt(const void *data, uint8_t size)
+{
+	const struct bt_hci_evt_le_cis_req *evt = data;
+
+	print_field("ACL Handle: %d", le16_to_cpu(evt->acl_handle));
+	print_field("CIS Handle: %d", le16_to_cpu(evt->cis_handle));
+	print_field("CIG ID: 0x%2.2x", evt->cig_id);
+	print_field("CIS ID: 0x%2.2x", evt->cis_id);
+}
+
+static void print_bis_handle(const void *data)
+{
+	const uint16_t *handle = data;
+
+	print_field("Connection Handle: %d", le16_to_cpu(*handle));
+}
+
+static void le_big_complete_evt(const void *data, uint8_t size)
+{
+	const struct bt_hci_evt_le_big_complete *evt = data;
+
+	print_status(evt->status);
+	print_field("BIG ID: 0x%2.2x", evt->big_id);
+	print_usec_interval("BIG Synchronization Delay", evt->sync_delay);
+	print_usec_interval("Transport Latency", evt->latency);
+	print_le_phy("PHY", evt->phy);
+	print_list(evt->handle, size, evt->num_bis, sizeof(*evt->handle),
+						print_bis_handle);
+}
+
+static void le_big_terminate_evt(const void *data, uint8_t size)
+{
+	const struct bt_hci_evt_le_big_terminate *evt = data;
+
+	print_reason(evt->reason);
+	print_field("BIG ID: 0x%2.2x", evt->big_id);
+}
+
+static void le_big_sync_estabilished_evt(const void *data, uint8_t size)
+{
+	const struct bt_hci_evt_le_big_sync_estabilished *evt = data;
+
+	print_status(evt->status);
+	print_field("BIG ID: 0x%2.2x", evt->big_id);
+	print_usec_interval("Transport Latency", evt->latency);
+	print_list(evt->handle, size, evt->num_bis, sizeof(*evt->handle),
+						print_bis_handle);
+}
+
+static void le_big_sync_lost_evt(const void *data, uint8_t size)
+{
+	const struct bt_hci_evt_le_big_sync_lost *evt = data;
+
+	print_field("BIG ID: 0x%2.2x", evt->big_id);
+	print_reason(evt->reason);
+}
+
+static void le_req_sca_complete_evt(const void *data, uint8_t size)
+{
+	const struct bt_hci_evt_le_req_peer_sca_complete *evt = data;
+
+	print_status(evt->status);
+	print_field("Connection Handle: %d", le16_to_cpu(evt->handle));
+	print_sca(evt->sca);
+}
+
 struct subevent_data {
 	uint8_t subevent;
 	const char *str;
@@ -9807,6 +10429,36 @@ static const struct subevent_data le_meta_event_table[] = {
 				le_scan_req_received_evt, 8, true},
 	{ 0x14, "LE Channel Selection Algorithm",
 				le_chan_select_alg_evt, 3, true},
+	{ BT_HCI_EVT_LE_CIS_ESTABLISHED,
+				"LE Connected Isochronous Stream Established",
+				le_cis_established_evt,
+				sizeof(struct bt_hci_evt_le_cis_established),
+				true },
+	{ BT_HCI_EVT_LE_CIS_REQ, "LE Connected Isochronous Stream Request",
+				le_req_cis_evt,
+				sizeof(struct bt_hci_evt_le_cis_req),
+				true },
+	{ BT_HCI_EVT_LE_BIG_COMPLETE,
+				"LE Broadcast Isochronous Group Complete",
+				le_big_complete_evt,
+				sizeof(struct bt_hci_evt_le_big_complete) },
+	{ BT_HCI_EVT_LE_BIG_TERMINATE,
+				"LE Broadcast Isochronous Group Terminate",
+				le_big_terminate_evt,
+				sizeof(struct bt_hci_evt_le_big_terminate) },
+	{ BT_HCI_EVT_LE_BIG_SYNC_ESTABILISHED,
+				"LE Broadcast Isochronous Group Sync "
+				"Estabilished", le_big_sync_estabilished_evt,
+				sizeof(struct bt_hci_evt_le_big_sync_lost) },
+	{ BT_HCI_EVT_LE_BIG_SYNC_LOST,
+				"LE Broadcast Isochronous Group Sync Lost",
+				le_big_sync_lost_evt,
+				sizeof(struct bt_hci_evt_le_big_sync_lost) },
+	{ BT_HCI_EVT_LE_REQ_PEER_SCA_COMPLETE,
+				"LE Request Peer SCA Complete",
+				le_req_sca_complete_evt,
+				sizeof(
+				struct bt_hci_evt_le_req_peer_sca_complete)},
 	{ }
 };
 
-- 
2.21.0

