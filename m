Return-Path: <SRS0=zRH5=6U=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32C7C4725B
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 07:58:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC33420714
	for <linux-bluetooth@archiver.kernel.org>; Wed,  6 May 2020 07:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgEFH6B (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 6 May 2020 03:58:01 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:38994 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728377AbgEFH6A (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 6 May 2020 03:58:00 -0400
Received: from localhost.localdomain (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 64DCCCED04
        for <linux-bluetooth@vger.kernel.org>; Wed,  6 May 2020 10:07:40 +0200 (CEST)
From:   Marcel Holtmann <marcel@holtmann.org>
To:     linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 3/7] Bluetooth: replace zero-length array with flexible-array member
Date:   Wed,  6 May 2020 09:57:48 +0200
Message-Id: <c1c28c073acf0c37cb7804d33a43c42486c9e796.1588751831.git.marcel@holtmann.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <15b523289abcb258505f094dc2c26f317bd9caa5.1588751831.git.marcel@holtmann.org>
References: <cover.1588751831.git.marcel@holtmann.org> <4470adb873fbc0f5874038e1d99a63df3a7b59b8.1588751831.git.marcel@holtmann.org> <15b523289abcb258505f094dc2c26f317bd9caa5.1588751831.git.marcel@holtmann.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

The current codebase makes use of the zero-length array language extension
to the C90 standard, but the preferred mechanism to declare variable-length
types such as these ones is a flexible array member.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/mgmt.h | 42 ++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 65dd6fd1fff3..9d4d87c6028e 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -70,14 +70,14 @@ struct mgmt_rp_read_version {
 struct mgmt_rp_read_commands {
 	__le16	num_commands;
 	__le16	num_events;
-	__le16	opcodes[0];
+	__le16	opcodes[];
 } __packed;
 
 #define MGMT_OP_READ_INDEX_LIST		0x0003
 #define MGMT_READ_INDEX_LIST_SIZE	0
 struct mgmt_rp_read_index_list {
 	__le16	num_controllers;
-	__le16	index[0];
+	__le16	index[];
 } __packed;
 
 /* Reserve one extra byte for names in management messages so that they
@@ -183,7 +183,7 @@ struct mgmt_link_key_info {
 struct mgmt_cp_load_link_keys {
 	__u8	debug_keys;
 	__le16	key_count;
-	struct	mgmt_link_key_info keys[0];
+	struct	mgmt_link_key_info keys[];
 } __packed;
 #define MGMT_LOAD_LINK_KEYS_SIZE	3
 
@@ -206,7 +206,7 @@ struct mgmt_ltk_info {
 #define MGMT_OP_LOAD_LONG_TERM_KEYS	0x0013
 struct mgmt_cp_load_long_term_keys {
 	__le16	key_count;
-	struct	mgmt_ltk_info keys[0];
+	struct	mgmt_ltk_info keys[];
 } __packed;
 #define MGMT_LOAD_LONG_TERM_KEYS_SIZE	2
 
@@ -223,7 +223,7 @@ struct mgmt_rp_disconnect {
 #define MGMT_GET_CONNECTIONS_SIZE	0
 struct mgmt_rp_get_connections {
 	__le16 conn_count;
-	struct mgmt_addr_info addr[0];
+	struct mgmt_addr_info addr[];
 } __packed;
 
 #define MGMT_OP_PIN_CODE_REPLY		0x0016
@@ -413,7 +413,7 @@ struct mgmt_irk_info {
 #define MGMT_OP_LOAD_IRKS		0x0030
 struct mgmt_cp_load_irks {
 	__le16 irk_count;
-	struct mgmt_irk_info irks[0];
+	struct mgmt_irk_info irks[];
 } __packed;
 #define MGMT_LOAD_IRKS_SIZE		2
 
@@ -465,7 +465,7 @@ struct mgmt_conn_param {
 #define MGMT_OP_LOAD_CONN_PARAM		0x0035
 struct mgmt_cp_load_conn_param {
 	__le16 param_count;
-	struct mgmt_conn_param params[0];
+	struct mgmt_conn_param params[];
 } __packed;
 #define MGMT_LOAD_CONN_PARAM_SIZE	2
 
@@ -473,7 +473,7 @@ struct mgmt_cp_load_conn_param {
 #define MGMT_READ_UNCONF_INDEX_LIST_SIZE 0
 struct mgmt_rp_read_unconf_index_list {
 	__le16	num_controllers;
-	__le16	index[0];
+	__le16	index[];
 } __packed;
 
 #define MGMT_OPTION_EXTERNAL_CONFIG	0x00000001
@@ -504,7 +504,7 @@ struct mgmt_cp_start_service_discovery {
 	__u8 type;
 	__s8 rssi;
 	__le16 uuid_count;
-	__u8 uuids[0][16];
+	__u8 uuids[][16];
 } __packed;
 #define MGMT_START_SERVICE_DISCOVERY_SIZE 4
 
@@ -516,7 +516,7 @@ struct mgmt_cp_read_local_oob_ext_data {
 struct mgmt_rp_read_local_oob_ext_data {
 	__u8    type;
 	__le16	eir_len;
-	__u8	eir[0];
+	__u8	eir[];
 } __packed;
 
 #define MGMT_OP_READ_EXT_INDEX_LIST	0x003C
@@ -527,7 +527,7 @@ struct mgmt_rp_read_ext_index_list {
 		__le16 index;
 		__u8   type;
 		__u8   bus;
-	} entry[0];
+	} entry[];
 } __packed;
 
 #define MGMT_OP_READ_ADV_FEATURES	0x0003D
@@ -538,7 +538,7 @@ struct mgmt_rp_read_adv_features {
 	__u8   max_scan_rsp_len;
 	__u8   max_instances;
 	__u8   num_instances;
-	__u8   instance[0];
+	__u8   instance[];
 } __packed;
 
 #define MGMT_OP_ADD_ADVERTISING		0x003E
@@ -549,7 +549,7 @@ struct mgmt_cp_add_advertising {
 	__le16	timeout;
 	__u8	adv_data_len;
 	__u8	scan_rsp_len;
-	__u8	data[0];
+	__u8	data[];
 } __packed;
 #define MGMT_ADD_ADVERTISING_SIZE	11
 struct mgmt_rp_add_advertising {
@@ -603,7 +603,7 @@ struct mgmt_rp_read_ext_info {
 	__le32   supported_settings;
 	__le32   current_settings;
 	__le16   eir_len;
-	__u8     eir[0];
+	__u8     eir[];
 } __packed;
 
 #define MGMT_OP_SET_APPEARANCE		0x0043
@@ -668,7 +668,7 @@ struct mgmt_blocked_key_info {
 
 struct mgmt_cp_set_blocked_keys {
 	__le16 key_count;
-	struct mgmt_blocked_key_info keys[0];
+	struct mgmt_blocked_key_info keys[];
 } __packed;
 #define MGMT_OP_SET_BLOCKED_KEYS_SIZE 2
 
@@ -678,14 +678,14 @@ struct mgmt_cp_set_blocked_keys {
 #define MGMT_READ_SECURITY_INFO_SIZE	0
 struct mgmt_rp_read_security_info {
 	__le16   sec_len;
-	__u8     sec[0];
+	__u8     sec[];
 } __packed;
 
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
 	__u8	status;
-	__u8	data[0];
+	__u8	data[];
 } __packed;
 
 #define MGMT_EV_CMD_STATUS		0x0002
@@ -733,7 +733,7 @@ struct mgmt_ev_device_connected {
 	struct mgmt_addr_info addr;
 	__le32	flags;
 	__le16	eir_len;
-	__u8	eir[0];
+	__u8	eir[];
 } __packed;
 
 #define MGMT_DEV_DISCONN_UNKNOWN	0x00
@@ -788,7 +788,7 @@ struct mgmt_ev_device_found {
 	__s8	rssi;
 	__le32	flags;
 	__le16	eir_len;
-	__u8	eir[0];
+	__u8	eir[];
 } __packed;
 
 #define MGMT_EV_DISCOVERING		0x0013
@@ -883,7 +883,7 @@ struct mgmt_ev_ext_index {
 struct mgmt_ev_local_oob_data_updated {
 	__u8    type;
 	__le16	eir_len;
-	__u8	eir[0];
+	__u8	eir[];
 } __packed;
 
 #define MGMT_EV_ADVERTISING_ADDED	0x0023
@@ -899,7 +899,7 @@ struct mgmt_ev_advertising_removed {
 #define MGMT_EV_EXT_INFO_CHANGED	0x0025
 struct mgmt_ev_ext_info_changed {
 	__le16	eir_len;
-	__u8	eir[0];
+	__u8	eir[];
 } __packed;
 
 #define MGMT_EV_PHY_CONFIGURATION_CHANGED	0x0026
-- 
2.26.2

