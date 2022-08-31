Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95F5FECAAD1
	for <linux-bluetooth@archiver.kernel.org>; Wed, 31 Aug 2022 21:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiHaVsc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Wed, 31 Aug 2022 17:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230456AbiHaVsa (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Wed, 31 Aug 2022 17:48:30 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACB0B5A47
        for <linux-bluetooth@vger.kernel.org>; Wed, 31 Aug 2022 14:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661982509; x=1693518509;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g57sxFhXzJrzY0Gv8u3zMfMvR5OY/zQrQ9RNiULVqnc=;
  b=ZDU5eUDU+KJJ0vXuch33ZthVpkU6UVYs80j9ZV/TFYVIWDgYzMmJtlbh
   NMKsIYNa/8LUCDOa+pX7yq/LqNxg4hG53aBbtQHmpsIHr+NwC3aOFwZ9E
   kndZ/ZS+1olcnfCtWbVxjqJhH0Bw4tUgD49x0RIolL7OoNrbcgbwfih4s
   rFfTE6EHYGvtoxOqP+WxL7DcFaQuvJg44Y5DkXw9M3r/20xMDMetmwuhE
   yl8WXaCDt8KUzohhgQQKibUJl3yRdTLdpD7oPa8PIYm7f/Q904YVAGrcE
   EBnkqmGcJWwzp2gL8u9lr7UQPNLDFE8l2cdk36z4Dkt8n/CGqJ1hCMdAT
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="275953669"
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="275953669"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 14:48:29 -0700
X-IronPort-AV: E=Sophos;i="5.93,279,1654585200"; 
   d="scan'208";a="857599878"
Received: from sbhatia4-mobl2.amr.corp.intel.com (HELO bgi1-mobl2.attlocal.net) ([10.213.189.113])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 14:48:28 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, luiz.dentz@gmail.com, brian.gix@intel.com
Subject: [PATCH BlueZ v3 1/2] lib: Add mgmt opcodes and events for Mesh
Date:   Wed, 31 Aug 2022 14:48:20 -0700
Message-Id: <20220831214821.274797-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220831214821.274797-1-brian.gix@intel.com>
References: <20220831214821.274797-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

---
 lib/mgmt.h | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/lib/mgmt.h b/lib/mgmt.h
index 430bd0ef6..79b77d31a 100644
--- a/lib/mgmt.h
+++ b/lib/mgmt.h
@@ -760,6 +760,38 @@ struct mgmt_cp_add_adv_patterns_monitor_rssi {
 	struct mgmt_adv_pattern patterns[0];
 } __packed;
 
+#define MGMT_OP_SET_MESH_RECEIVER		0x0057
+struct mgmt_cp_set_mesh {
+	uint8_t enable;
+	uint16_t window;
+	uint16_t period;
+	uint8_t num_ad_types;
+	uint8_t ad_types[];
+} __packed;
+
+#define MGMT_OP_MESH_READ_FEATURES	0x0058
+struct mgmt_rp_mesh_read_features {
+	uint16_t index;
+	uint8_t max_handles;
+	uint8_t used_handles;
+	uint8_t handles[];
+} __packed;
+
+#define MGMT_OP_MESH_SEND		0x0059
+struct mgmt_cp_mesh_send {
+	struct mgmt_addr_info addr;
+	uint64_t instant;
+	uint16_t delay;
+	uint8_t cnt;
+	uint8_t adv_data_len;
+	uint8_t adv_data[];
+} __packed;
+
+#define MGMT_OP_MESH_SEND_CANCEL	0x005A
+struct mgmt_cp_mesh_send_cancel {
+	uint8_t handle;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	uint16_t opcode;
@@ -1035,6 +1067,21 @@ struct mgmt_ev_adv_monitor_device_lost {
 	struct mgmt_addr_info addr;
 } __packed;
 
+#define MGMT_EV_MESH_DEVICE_FOUND	0x0031
+struct mgmt_ev_mesh_device_found {
+	struct mgmt_addr_info addr;
+	int8_t rssi;
+	uint64_t instant;
+	uint32_t flags;
+	uint16_t eir_len;
+	uint8_t	eir[];
+} __packed;
+
+#define MGMT_EV_MESH_PACKET_CMPLT		0x0032
+struct mgmt_ev_mesh_pkt_cmplt {
+	uint8_t	handle;
+} __packed;
+
 static const char *mgmt_op[] = {
 	"<0x0000>",
 	"Read Version",
-- 
2.37.2

