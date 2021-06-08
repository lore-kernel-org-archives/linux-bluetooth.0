Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE712C4743F
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jun 2021 12:21:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 980DA6124C
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jun 2021 12:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbhFHMWy (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Jun 2021 08:22:54 -0400
Received: from mga04.intel.com ([192.55.52.120]:22782 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232547AbhFHMWy (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Jun 2021 08:22:54 -0400
IronPort-SDR: bhYvZxwPd2Gcbt0O+YaQ2htVZOVOLlNFh7KBWIGenodQo7p/Gpystp3tybWhUjtPxyoe18nNVS
 /CLgpOYUokqQ==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="202973582"
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="202973582"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 05:21:01 -0700
IronPort-SDR: 2y4CNobpSwUuBVnMHx4LVa+wibnIwvompQLXnpeKX2wR8gajdWZZv40keO/IJysIRJFVLHRonc
 URue8+aFyNqw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="619283524"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga005.jf.intel.com with ESMTP; 08 Jun 2021 05:21:01 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Kiran K <kiran.k@intel.com>
Subject: [PATCH v9 10/10] Bluetooth: Add support for msbc coding format
Date:   Tue,  8 Jun 2021 17:54:55 +0530
Message-Id: <20210608122455.19583-10-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210608122455.19583-1-kiran.k@intel.com>
References: <20210608122455.19583-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In Enhanced_Setup_Synchronous_Command, add support for msbc
coding format

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
 include/net/bluetooth/bluetooth.h |  1 +
 net/bluetooth/hci_conn.c          | 27 ++++++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index af2809121571..056699224da7 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -175,6 +175,7 @@ struct bt_codecs {
 
 #define CODING_FORMAT_CVSD		0x02
 #define CODING_FORMAT_TRANSPARENT	0x03
+#define CODING_FORMAT_MSBC		0x05
 
 __printf(1, 2)
 void bt_info(const char *fmt, ...);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 9569b21adb88..73c134459361 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -328,6 +328,32 @@ bool hci_enhanced_setup_sync(struct hci_conn *conn, __u16 handle)
 	cp.rx_bandwidth   = cpu_to_le32(0x00001f40);
 
 	switch (conn->codec.id) {
+	case CODING_FORMAT_MSBC:
+		if (!find_next_esco_param(conn, esco_param_msbc,
+					  ARRAY_SIZE(esco_param_msbc)))
+			return false;
+
+		param = &esco_param_msbc[conn->attempt - 1];
+		cp.tx_coding_format.id = 0x05;
+		cp.rx_coding_format.id = 0x05;
+		cp.tx_codec_frame_size = __cpu_to_le16(60);
+		cp.rx_codec_frame_size = __cpu_to_le16(60);
+		cp.in_bandwidth = __cpu_to_le32(32000);
+		cp.out_bandwidth = __cpu_to_le32(32000);
+		cp.in_coding_format.id = 0x04;
+		cp.out_coding_format.id = 0x04;
+		cp.in_coded_data_size = __cpu_to_le16(16);
+		cp.out_coded_data_size = __cpu_to_le16(16);
+		cp.in_pcm_data_format = 2;
+		cp.out_pcm_data_format = 2;
+		cp.in_pcm_sample_payload_msb_pos = 0;
+		cp.out_pcm_sample_payload_msb_pos = 0;
+		cp.in_data_path = conn->codec.data_path;
+		cp.out_data_path = conn->codec.data_path;
+		cp.in_trasnport_unit_size = 1;
+		cp.out_trasnport_unit_size = 1;
+		break;
+
 	case CODING_FORMAT_TRANSPARENT:
 		if (!find_next_esco_param(conn, esco_param_msbc,
 					  ARRAY_SIZE(esco_param_msbc)))
@@ -383,7 +409,6 @@ bool hci_enhanced_setup_sync(struct hci_conn *conn, __u16 handle)
 		cp.in_trasnport_unit_size = 16;
 		cp.out_trasnport_unit_size = 16;
 		break;
-
 	default:
 		return false;
 	}
-- 
2.17.1

