Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF916C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu, 24 Feb 2022 02:06:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiBXCHG (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 23 Feb 2022 21:07:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiBXCHF (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 23 Feb 2022 21:07:05 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5979DB7C0
        for <linux-bluetooth@vger.kernel.org>; Wed, 23 Feb 2022 18:06:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645668395; x=1677204395;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KWtoRVa6DUZj876vQchwt43T6iq/a2fHQVwOF3bGLiw=;
  b=fJpzEp4/ztDKknw1BWM7O9ByZEeWMKIywVLlsI2HpQDrMRlqLiHGVIIR
   GbQGlOrdr14hzE4pER4w5zhQWrPXpcvdwymzFxNJLeYWx6o3EZ1HhzHdp
   pIhr+8/IBhQk7YFEztXRGV1xjka+NHSQcbb52/Es5pXFh0DDvu+TAuk2k
   g8U/lC6cOKKMimfamdgiT8pUr7QxJq+NRa4ubdktPTA12UhH75BTYOSBq
   zYGI4FKDRXozUzQX1s57s6qnsEuIUB9iXSnsJQAKDkErx4FYSoqeI2M5G
   rT9WWK7NIAfDs6+JY24nlM5FkbpZFY3E7Yzl/ce9mGcuo8owvG2dkRkun
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="239524999"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="239524999"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 18:06:33 -0800
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="607268565"
Received: from tjsmith-mobl1.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.209.34.213])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 18:06:33 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, inga.stotland@intel.com
Subject: [PATCH 2/7] mgmt: Mesh specific structures and defines
Date:   Wed, 23 Feb 2022 18:06:19 -0800
Message-Id: <20220224020624.159247-3-brian.gix@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220224020624.159247-1-brian.gix@intel.com>
References: <20220224020624.159247-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Adds the Mesh commands and events as described in mgmt-api.txt
---
 lib/mgmt.h | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 922a24367..d5ec58228 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -757,6 +757,39 @@ struct mgmt_cp_add_adv_patterns_monitor_rssi {
 	struct mgmt_adv_pattern patterns[0];
 } __packed;
 
+#define MGMT_OP_SET_MESH_RECEIVER	0x0057
+struct mgmt_cp_set_mesh {
+	uint8_t   enable;
+	uint16_t  window;
+	uint16_t  period;
+	uint8_t   num_ad_types;
+	uint8_t   ad_types[];
+} __packed;
+
+#define MGMT_OP_MESH_READ_FEATURES	0x0058
+struct mgmt_rp_mesh_read_features {
+	uint16_t index;
+	uint8_t	 max_handles;
+	uint8_t	 used_handles;
+	uint8_t	 handles[];
+} __packed;
+
+
+#define MGMT_OP_MESH_SEND		0x0059
+struct mgmt_cp_mesh_send {
+	struct mgmt_addr_info addr;
+	uint64_t  instant;
+	uint16_t  delay;
+	uint8_t   cnt;
+	uint8_t   data[];
+} __packed;
+
+#define MGMT_OP_MESH_SEND_CANCEL	0x005A
+struct mgmt_cp_mesh_send_cancel {
+	uint8_t  handle;
+} __packed;
+
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
@@ -1032,6 +1065,21 @@ struct mgmt_ev_adv_monitor_device_lost {
 	struct mgmt_addr_info addr;
 } __packed;
 
+#define MGMT_EV_MESH_DEVICE_FOUND		0x0031
+struct mgmt_ev_mesh_device_found {
+	struct mgmt_addr_info addr;
+	int8_t rssi;
+	uint32_t flags;
+	uint64_t instant;
+	uint16_t eir_len;
+	uint8_t eir[];
+} __packed;
+
+#define MGMT_EV_MESH_PACKET_CMPLT		0x0032
+struct mgmt_ev_mesh_pkt_cmplt {
+	uint8_t handle;
+} __packed;
+
 static const char *mgmt_op[] = {
 	"<0x0000>",
 	"Read Version",
@@ -1120,6 +1168,10 @@ static const char *mgmt_op[] = {
 	"Add Extended Advertisement Parameters",	/* 0x0054 */
 	"Add Extended Advertisement Data",
 	"Add Advertisement Patterns Monitor RSSI",
+	"Set Mesh Receiver",
+	"Read Mesh Features",
+	"Mesh Send",
+	"Mesh Send Cancel",
 };
 
 static const char *mgmt_ev[] = {
@@ -1172,6 +1224,8 @@ static const char *mgmt_ev[] = {
 	"Controller Resume",
 	"Advertisement Monitor Device Found",		/* 0x002f */
 	"Advertisement Monitor Device Lost",
+	"Mesh Packet Found",
+	"Mesh Packet Complete",
 };
 
 static const char *mgmt_status[] = {
-- 
2.35.1

