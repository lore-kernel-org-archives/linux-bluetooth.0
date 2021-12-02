Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E32C433EF
	for <linux-bluetooth@archiver.kernel.org>; Thu,  2 Dec 2021 22:26:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbhLBW3v (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 2 Dec 2021 17:29:51 -0500
Received: from mga04.intel.com ([192.55.52.120]:49807 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347664AbhLBW3v (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 2 Dec 2021 17:29:51 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="235591264"
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="235591264"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 14:26:28 -0800
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="513398897"
Received: from srami-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.212.228.98])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 14:26:28 -0800
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     marcel@holtmann.org, brian.gix@intel.com, luiz.dentz@gmail.com
Subject: [PATCH 1/2] Bluetooth: Add management API for Mesh support
Date:   Thu,  2 Dec 2021 14:26:18 -0800
Message-Id: <20211202222619.626678-2-brian.gix@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211202222619.626678-1-brian.gix@intel.com>
References: <20211202222619.626678-1-brian.gix@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

MGMT_OP_SET_MESH - Puts the controller into Mesh mode so that it will
always be passively scanning, without filtering duplicates, for ADV
packets that include a list of AD types.

MGMT_OP_MESH_SEND - Requests the transmission (Advertisement) of a
single PDU.

MGMT_EV_MESH_DEVICE_FOUND - MGMT Event indicating an incoming ADV packet
has been received, which includes at least one of the AD Types requested
by MGMT_OP_SET_MESH.

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 include/net/bluetooth/mgmt.h | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 107b25deae68..ac813767dcf4 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -837,6 +837,22 @@ struct mgmt_cp_add_adv_patterns_monitor_rssi {
 	struct mgmt_adv_pattern patterns[];
 } __packed;
 #define MGMT_ADD_ADV_PATTERNS_MONITOR_RSSI_SIZE	8
+#define MGMT_OP_SET_MESH		0x0057
+struct mgmt_cp_set_mesh {
+	__u8   enable;
+	__u8   active;
+	__u8   ad_types[];
+} __packed;
+#define MGMT_SET_MESH_SIZE		2
+
+#define MGMT_OP_MESH_SEND		0x0058
+struct mgmt_cp_mesh_send {
+	__u32  instant;
+	__u16  delay;
+	__u8   cnt;
+	__u8   data[];
+} __packed;
+#define MGMT_MESH_SEND_SIZE		7
 
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
@@ -1104,3 +1120,13 @@ struct mgmt_ev_controller_resume {
 #define MGMT_WAKE_REASON_NON_BT_WAKE		0x0
 #define MGMT_WAKE_REASON_UNEXPECTED		0x1
 #define MGMT_WAKE_REASON_REMOTE_WAKE		0x2
+
+#define MGMT_EV_MESH_DEVICE_FOUND	0x002f
+struct mgmt_ev_mesh_device_found {
+	struct mgmt_addr_info addr;
+	__s8	rssi;
+	__le32	instant;
+	__le32	flags;
+	__le16	eir_len;
+	__u8	eir[];
+} __packed;
-- 
2.31.1

