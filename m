Return-Path: <SRS0=JHfm=6F=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 536E0C54FCC
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Apr 2020 22:25:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20DFF20724
	for <linux-bluetooth@archiver.kernel.org>; Tue, 21 Apr 2020 22:25:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AB+iOEZW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgDUWZZ (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 21 Apr 2020 18:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgDUWZZ (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 21 Apr 2020 18:25:25 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE544C0610D5
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2020 15:25:24 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id t11so75790pgg.2
        for <linux-bluetooth@vger.kernel.org>; Tue, 21 Apr 2020 15:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lP+631COW6aFNFs0v6TbSms4KI0UWz+drlcU41V6z0I=;
        b=AB+iOEZWV6F0FoWgqwBu2cqpPIbmbsMpZpbJ0iBUoX3no0Q2R0MVEnWJ0G805/tqQl
         vlfd9WN8KZ+khHOviMy+MOWJHaiD++YslMIe4LufB8oj5JfFzT8Yh/6vjy+bWiuG6cDv
         IiXAX0vhbuVVawYE0g/+cYuyO+Bc1B+q1lXQJRwGee8SAF8RK+RBD08w3FpgLyXJi57t
         hQKI1fsmJTqIc0ZLft0SUkVNqcoXpbq3OaoQVOvue6sIvHNsIuh6lc0NzDMN8pp1A2Fs
         ILk51kD1PhELyzv2eCKMuLIZXHBKYxoyXCewF0lRLTJ8hcwb4Q3GxvDnLq95vhmlqSqT
         st/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lP+631COW6aFNFs0v6TbSms4KI0UWz+drlcU41V6z0I=;
        b=ErXUXROiUtTeAbRkXWAo8tvU4mN1IOSDEGsv6fcoZOZkeJzGNW5siQFrEqYTeatSXC
         50zYQk1O1MMX884uNNp49WPqH19y54ExojFm7/r7q6GWpySycrfKDQ9u8olOWink3+zL
         9R5MOT9mEp8YKt/XGGvze9QTuPJwRxUp1TCC89BoCxX6T2VNPyLu8Ja27eF1tk7xq+kl
         yddryLJOn8trzbAxcbezTNOb1npraDLZ/bfgVMNMSeUAeSXBV+PXYMffE5V02/w4CGB8
         1fcBRLeGge/g8gL6smH+8bfXgUXK6UZJsu0vUxwSxkcmqpszPRMYNsIsCIkPefPBYbT+
         ACZA==
X-Gm-Message-State: AGi0PuZWq1MBS6Mfz9dPrItwMCpuEEGMkKjWps/r1HI1WE+l0lEN5+w1
        z6bHcQ+qDlf0xN+SaSNl6Py92o0vX4U=
X-Google-Smtp-Source: APiQypLRkXENcU6/f46BAQ/+eHojxHlWaSSknYyRu0j5N9VSmtlP9b3q/zLsHX5Rn1kwhXW/2hvycg==
X-Received: by 2002:a65:4548:: with SMTP id x8mr23309327pgr.223.1587507923814;
        Tue, 21 Apr 2020 15:25:23 -0700 (PDT)
Received: from localhost.localdomain (c-71-56-157-77.hsd1.or.comcast.net. [71.56.157.77])
        by smtp.gmail.com with ESMTPSA id e196sm3384040pfh.43.2020.04.21.15.25.22
        for <linux-bluetooth@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2020 15:25:22 -0700 (PDT)
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/4] monitor: Remove use of base defines for 5.2
Date:   Tue, 21 Apr 2020 15:25:18 -0700
Message-Id: <20200421222521.226385-1-luiz.dentz@gmail.com>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Use the allocated value directly instead of base value + offset.
---
 monitor/bt.h | 117 ++++++++++++++++++++++++++-------------------------
 1 file changed, 60 insertions(+), 57 deletions(-)

diff --git a/monitor/bt.h b/monitor/bt.h
index f9ac6b180..39ca1e39a 100644
--- a/monitor/bt.h
+++ b/monitor/bt.h
@@ -24,11 +24,7 @@
 
 #include <stdint.h>
 
-#define BT_HCI_CMD_5_2		0x2060
-#define BT_HCI_BIT_5_2		(8 * 41) + 5
-#define BT_HCI_SUBEVT_5_2	0x19
-
-#define BT_LL_CMD_5_2		0x1f
+#define BT_HCI_CMD_BIT(_byte, _bit) ((8 * _byte) + _bit)
 
 struct bt_ll_hdr {
 	uint8_t  preamble;
@@ -181,7 +177,7 @@ struct bt_ll_clock_acc {
 
 #define BT_LL_CLOCK_ACCURACY_RSP 0x1e
 
-#define BT_LL_CIS_REQ		BT_LL_CMD_5_2
+#define BT_LL_CIS_REQ		0x1f
 struct bt_ll_cis_req {
 	uint8_t  cig;
 	uint8_t  cis;
@@ -204,14 +200,14 @@ struct bt_ll_cis_req {
 	uint16_t conn_event_count;
 } __attribute__ ((packed));
 
-#define BT_LL_CIS_RSP		BT_LL_CMD_5_2 + 1
+#define BT_LL_CIS_RSP		0x20
 struct bt_ll_cis_rsp {
 	uint8_t  offset_min[3];
 	uint8_t  offset_max[3];
 	uint16_t conn_event_count;
 } __attribute__ ((packed));
 
-#define BT_LL_CIS_IND		BT_LL_CMD_5_2 + 2
+#define BT_LL_CIS_IND		0x21
 struct bt_ll_cis_ind {
 	uint32_t addr;
 	uint8_t  cis_offset[3];
@@ -220,7 +216,7 @@ struct bt_ll_cis_ind {
 	uint16_t conn_event_count;
 } __attribute__ ((packed));
 
-#define BT_LL_CIS_TERMINATE_IND	BT_LL_CMD_5_2 + 3
+#define BT_LL_CIS_TERMINATE_IND	0x22
 struct bt_ll_cis_term_ind {
 	uint8_t  cig;
 	uint8_t  cis;
@@ -2568,8 +2564,8 @@ struct bt_hci_cmd_default_periodic_adv_sync_trans_params {
 	uint8_t  cte_type;
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_LE_READ_BUFFER_SIZE_V2	BT_HCI_CMD_5_2
-#define BT_HCI_BIT_LE_READ_BUFFER_SIZE_V2	BT_HCI_BIT_5_2
+#define BT_HCI_CMD_LE_READ_BUFFER_SIZE_V2	0x2060
+#define BT_HCI_BIT_LE_READ_BUFFER_SIZE_V2	BT_HCI_CMD_BIT(41, 5)
 struct bt_hci_rsp_le_read_buffer_size_v2 {
 	uint8_t  status;
 	uint16_t acl_mtu;
@@ -2578,8 +2574,8 @@ struct bt_hci_rsp_le_read_buffer_size_v2 {
 	uint8_t  iso_max_pkt;
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_LE_READ_ISO_TX_SYNC		BT_HCI_CMD_5_2 + 1
-#define BT_HCI_BIT_LE_READ_ISO_TX_SYNC		BT_HCI_BIT_5_2 + 1
+#define BT_HCI_CMD_LE_READ_ISO_TX_SYNC		0x2061
+#define BT_HCI_BIT_LE_READ_ISO_TX_SYNC		BT_HCI_CMD_BIT(41, 6)
 struct bt_hci_cmd_le_read_iso_tx_sync {
 	uint16_t handle;
 } __attribute__ ((packed));
@@ -2592,8 +2588,8 @@ struct bt_hci_rsp_le_read_iso_tx_sync {
 	uint8_t  offset[3];
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_LE_SET_CIG_PARAMS		BT_HCI_CMD_5_2 + 2
-#define BT_HCI_BIT_LE_SET_CIG_PARAMS		BT_HCI_BIT_5_2 + 2
+#define BT_HCI_CMD_LE_SET_CIG_PARAMS		0x2062
+#define BT_HCI_BIT_LE_SET_CIG_PARAMS		BT_HCI_CMD_BIT(41, 7)
 struct bt_hci_cis_params {
 	uint8_t  cis_id;
 	uint16_t m_sdu;
@@ -2624,8 +2620,8 @@ struct bt_hci_rsp_le_set_cig_params {
 	uint16_t handle[0];
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_LE_SET_CIG_PARAMS_TEST	BT_HCI_CMD_5_2 + 3
-#define BT_HCI_BIT_LE_SET_CIG_PARAMS_TEST	BT_HCI_BIT_5_2 + 3
+#define BT_HCI_CMD_LE_SET_CIG_PARAMS_TEST	0x2063
+#define BT_HCI_BIT_LE_SET_CIG_PARAMS_TEST	BT_HCI_CMD_BIT(42, 0)
 struct bt_hci_cis_params_test {
 	uint8_t  cis_id;
 	uint8_t  nse;
@@ -2653,8 +2649,8 @@ struct bt_hci_cmd_le_set_cig_params_test {
 	struct bt_hci_cis_params_test cis[0];
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_LE_CREATE_CIS		BT_HCI_CMD_5_2 + 4
-#define BT_HCI_BIT_LE_CREATE_CIS		BT_HCI_BIT_5_2 + 4
+#define BT_HCI_CMD_LE_CREATE_CIS		0x2064
+#define BT_HCI_BIT_LE_CREATE_CIS		BT_HCI_CMD_BIT(42, 1)
 struct bt_hci_cis {
 	uint16_t  cis_handle;
 	uint16_t  acl_handle;
@@ -2665,27 +2661,27 @@ struct bt_hci_cmd_le_create_cis {
 	struct bt_hci_cis cis[0];
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_LE_REMOVE_CIG		BT_HCI_CMD_5_2 + 5
-#define BT_HCI_BIT_LE_REMOVE_CIG		BT_HCI_BIT_5_2 + 5
+#define BT_HCI_CMD_LE_REMOVE_CIG		0x2065
+#define BT_HCI_BIT_LE_REMOVE_CIG		BT_HCI_CMD_BIT(42, 2)
 struct bt_hci_cmd_le_remove_cig {
 	uint8_t  cig_id;
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_LE_ACCEPT_CIS		BT_HCI_CMD_5_2 + 6
-#define BT_HCI_BIT_LE_ACCEPT_CIS		BT_HCI_BIT_5_2 + 6
+#define BT_HCI_CMD_LE_ACCEPT_CIS		0x2066
+#define BT_HCI_BIT_LE_ACCEPT_CIS		BT_HCI_CMD_BIT(42, 3)
 struct bt_hci_cmd_le_accept_cis {
 	uint16_t handle;
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_LE_REJECT_CIS		BT_HCI_CMD_5_2 + 7
-#define BT_HCI_BIT_LE_REJECT_CIS		BT_HCI_BIT_5_2 + 7
+#define BT_HCI_CMD_LE_REJECT_CIS		0x2067
+#define BT_HCI_BIT_LE_REJECT_CIS		BT_HCI_CMD_BIT(42, 4)
 struct bt_hci_cmd_le_reject_cis {
 	uint16_t handle;
 	uint8_t  reason;
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_LE_CREATE_BIG		BT_HCI_CMD_5_2 + 8
-#define BT_HCI_BIT_LE_CREATE_BIG		BT_HCI_BIT_5_2 + 8
+#define BT_HCI_CMD_LE_CREATE_BIG		0x2068
+#define BT_HCI_BIT_LE_CREATE_BIG		BT_HCI_CMD_BIT(42, 5)
 struct bt_hci_bis {
 	uint8_t  sdu_interval[3];
 	uint16_t sdu;
@@ -2705,8 +2701,8 @@ struct bt_hci_cmd_le_create_big {
 	struct bt_hci_bis bis[0];
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_LE_CREATE_BIG_TEST		BT_HCI_CMD_5_2 + 9
-#define BT_HCI_BIT_LE_CREATE_BIG_TEST		BT_HCI_BIT_5_2 + 9
+#define BT_HCI_CMD_LE_CREATE_BIG_TEST		0x2069
+#define BT_HCI_BIT_LE_CREATE_BIG_TEST		BT_HCI_CMD_BIT(42, 6)
 struct bt_hci_bis_test {
 	uint8_t  sdu_interval[3];
 	uint16_t iso_interval;
@@ -2731,15 +2727,15 @@ struct bt_hci_cmd_le_create_big_test {
 	struct bt_hci_bis_test bis[0];
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_LE_TERM_BIG			BT_HCI_CMD_5_2 + 10
-#define BT_HCI_BIT_LE_TERM_BIG			BT_HCI_BIT_5_2 + 10
+#define BT_HCI_CMD_LE_TERM_BIG			0x206a
+#define BT_HCI_BIT_LE_TERM_BIG			BT_HCI_CMD_BIT(42, 7)
 struct bt_hci_cmd_le_term_big {
 	uint8_t  big_id;
 	uint8_t  reason;
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_LE_BIG_CREATE_SYNC		BT_HCI_CMD_5_2 + 11
-#define BT_HCI_BIT_LE_BIG_CREATE_SYNC		BT_HCI_BIT_5_2 + 11
+#define BT_HCI_CMD_LE_BIG_CREATE_SYNC		0x206b
+#define BT_HCI_BIT_LE_BIG_CREATE_SYNC		BT_HCI_CMD_BIT(43, 0)
 struct bt_hci_bis_sync {
 } __attribute__ ((packed));
 
@@ -2754,20 +2750,20 @@ struct bt_hci_cmd_le_big_create_sync {
 	struct bt_hci_bis_sync bis[0];
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_LE_BIG_TERM_SYNC		BT_HCI_CMD_5_2 + 12
-#define BT_HCI_BIT_LE_BIG_TERM_SYNC		BT_HCI_BIT_5_2 + 12
+#define BT_HCI_CMD_LE_BIG_TERM_SYNC		0x206c
+#define BT_HCI_BIT_LE_BIG_TERM_SYNC		BT_HCI_CMD_BIT(43, 1)
 struct bt_hci_cmd_le_big_term_sync {
 	uint8_t  big_id;
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_LE_REQ_PEER_SCA		BT_HCI_CMD_5_2 + 13
-#define BT_HCI_BIT_LE_REQ_PEER_SCA		BT_HCI_BIT_5_2 + 13
+#define BT_HCI_CMD_LE_REQ_PEER_SCA		0x206d
+#define BT_HCI_BIT_LE_REQ_PEER_SCA		BT_HCI_CMD_BIT(43, 2)
 struct bt_hci_cmd_le_req_peer_sca {
 	uint16_t handle;
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_LE_SETUP_ISO_PATH		BT_HCI_CMD_5_2 + 14
-#define BT_HCI_BIT_LE_SETUP_ISO_PATH		BT_HCI_BIT_5_2 + 14
+#define BT_HCI_CMD_LE_SETUP_ISO_PATH		0x206e
+#define BT_HCI_BIT_LE_SETUP_ISO_PATH		BT_HCI_CMD_BIT(43, 3)
 struct bt_hci_cmd_le_setup_iso_path {
 	uint16_t handle;
 	uint8_t  direction;
@@ -2780,24 +2776,31 @@ struct bt_hci_cmd_le_setup_iso_path {
 	uint8_t  codec_cfg[0];
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_LE_REMOVE_ISO_PATH		BT_HCI_CMD_5_2 + 15
-#define BT_HCI_BIT_LE_REMOVE_ISO_PATH		BT_HCI_BIT_5_2 + 15
+#define BT_HCI_CMD_LE_REMOVE_ISO_PATH		0x206f
+#define BT_HCI_BIT_LE_REMOVE_ISO_PATH		BT_HCI_CMD_BIT(43, 4)
 struct bt_hci_cmd_le_remove_iso_path {
 	uint16_t handle;
 	uint8_t  path_dir;
 } __attribute__ ((packed));
 
-#define BT_HCI_CMD_LE_ISO_TX_TEST		BT_HCI_CMD_5_2 + 16
-#define BT_HCI_BIT_LE_ISO_TX_TEST		BT_HCI_BIT_5_2 + 16
+#define BT_HCI_CMD_LE_ISO_TX_TEST		0x2070
+#define BT_HCI_BIT_LE_ISO_TX_TEST		BT_HCI_CMD_BIT(43, 5)
+
+#define BT_HCI_CMD_LE_ISO_RX_TEST		0x2071
+#define BT_HCI_BIT_LE_ISO_RX_TEST		BT_HCI_CMD_BIT(43, 6)
 
-#define BT_HCI_CMD_LE_ISO_RX_TEST		BT_HCI_CMD_5_2 + 17
-#define BT_HCI_BIT_LE_ISO_RX_TEST		BT_HCI_BIT_5_2 + 17
+#define BT_HCI_CMD_LE_ISO_READ_TEST_COUNTER	0x2072
+#define BT_HCI_BIT_LE_ISO_READ_TEST_COUNTER	BT_HCI_CMD_BIT(43, 7)
 
-#define BT_HCI_CMD_LE_ISO_READ_TEST_COUNTER	BT_HCI_CMD_5_2 + 18
-#define BT_HCI_BIT_LE_ISO_READ_TEST_COUNTER	BT_HCI_BIT_5_2 + 18
+#define BT_HCI_CMD_LE_ISO_TEST_END		0x2073
+#define BT_HCI_BIT_LE_ISO_TEST_END		BT_HCI_CMD_BIT(44, 0)
 
-#define BT_HCI_CMD_LE_ISO_TEST_END		BT_HCI_CMD_5_2 + 19
-#define BT_HCI_BIT_LE_ISO_TEST_END		BT_HCI_BIT_5_2 + 19
+#define BT_HCI_CMD_LE_SET_HOST_FEATURE		0x2074
+#define BT_HCI_BIT_LE_SET_HOST_FEATURE		BT_HCI_CMD_BIT(44, 1)
+struct bt_hci_cmd_le_set_host_feature {
+	uint8_t  bit_number;
+	uint8_t  bit_value;
+} __packed;
 
 #define BT_HCI_EVT_INQUIRY_COMPLETE		0x01
 struct bt_hci_evt_inquiry_complete {
@@ -3155,7 +3158,7 @@ struct bt_hci_evt_keypress_notify {
 
 #define BT_HCI_EVT_REMOTE_HOST_FEATURES_NOTIFY	0x3d
 struct bt_hci_evt_remote_host_features_notify {
-	uint8_t  bdaddr[6];
+uint8_t  bdaddr[6];
 	uint8_t  features[8];
 } __attribute__ ((packed));
 
@@ -3498,7 +3501,7 @@ struct bt_hci_evt_le_per_adv_sync_trans_rec {
 	uint8_t  clock_accuracy;
 } __attribute__ ((packed));
 
-#define BT_HCI_EVT_LE_CIS_ESTABLISHED		BT_HCI_SUBEVT_5_2
+#define BT_HCI_EVT_LE_CIS_ESTABLISHED			0x19
 struct bt_hci_evt_le_cis_established {
 	uint8_t  status;
 	uint16_t conn_handle;
@@ -3518,7 +3521,7 @@ struct bt_hci_evt_le_cis_established {
 	uint16_t interval;
 } __attribute__ ((packed));
 
-#define BT_HCI_EVT_LE_CIS_REQ			BT_HCI_SUBEVT_5_2 + 1
+#define BT_HCI_EVT_LE_CIS_REQ				0x1a
 struct bt_hci_evt_le_cis_req {
 	uint16_t acl_handle;
 	uint16_t cis_handle;
@@ -3526,7 +3529,7 @@ struct bt_hci_evt_le_cis_req {
 	uint8_t  cis_id;
 } __attribute__ ((packed));
 
-#define BT_HCI_EVT_LE_BIG_COMPLETE		BT_HCI_SUBEVT_5_2 + 2
+#define BT_HCI_EVT_LE_BIG_COMPLETE			0x1b
 struct bt_hci_evt_le_big_complete {
 	uint8_t  status;
 	uint8_t  big_id;
@@ -3537,13 +3540,13 @@ struct bt_hci_evt_le_big_complete {
 	uint16_t handle[0];
 } __attribute__ ((packed));
 
-#define BT_HCI_EVT_LE_BIG_TERMINATE		BT_HCI_SUBEVT_5_2 + 3
+#define BT_HCI_EVT_LE_BIG_TERMINATE			0x1c
 struct bt_hci_evt_le_big_terminate {
 	uint8_t  reason;
 	uint8_t  big_id;
 } __attribute__ ((packed));
 
-#define BT_HCI_EVT_LE_BIG_SYNC_ESTABILISHED	BT_HCI_SUBEVT_5_2 + 4
+#define BT_HCI_EVT_LE_BIG_SYNC_ESTABILISHED		0x1d
 struct bt_hci_evt_le_big_sync_estabilished {
 	uint8_t  status;
 	uint8_t  big_id;
@@ -3552,13 +3555,13 @@ struct bt_hci_evt_le_big_sync_estabilished {
 	uint16_t handle[0];
 } __attribute__ ((packed));
 
-#define BT_HCI_EVT_LE_BIG_SYNC_LOST		BT_HCI_SUBEVT_5_2 + 5
+#define BT_HCI_EVT_LE_BIG_SYNC_LOST			0x1e
 struct bt_hci_evt_le_big_sync_lost {
 	uint8_t  big_id;
 	uint8_t  reason;
 } __attribute__ ((packed));
 
-#define BT_HCI_EVT_LE_REQ_PEER_SCA_COMPLETE	BT_HCI_SUBEVT_5_2 + 6
+#define BT_HCI_EVT_LE_REQ_PEER_SCA_COMPLETE		0x1f
 struct bt_hci_evt_le_req_peer_sca_complete {
 	uint8_t  status;
 	uint16_t handle;
-- 
2.25.3

