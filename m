Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCB6C433B4
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 10:39:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 01D0861355
	for <linux-bluetooth@archiver.kernel.org>; Tue, 18 May 2021 10:39:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348564AbhERKkc (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 18 May 2021 06:40:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:23234 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1348579AbhERKk1 (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 18 May 2021 06:40:27 -0400
IronPort-SDR: xr1RjZEei430bR5FXBabxkUSkRijxkCfdlnxlM27uVaSkOyCzJF4DveZY6CdtRA6QY+hr+mqK5
 aTpf0sbMhJfA==
X-IronPort-AV: E=McAfee;i="6200,9189,9987"; a="187804846"
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="187804846"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2021 03:39:01 -0700
IronPort-SDR: Tyb0XlW6512nSc9pNKVrDRSllobOkR//pFwE9LaSlhKMV0mQLHaByBx0hHawz1NdqpSZoBX5Gc
 1mgOJrCvtLRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.82,309,1613462400"; 
   d="scan'208";a="433017891"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga007.jf.intel.com with ESMTP; 18 May 2021 03:39:00 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        Kiran K <kiran.k@intel.com>
Subject: [PATCH v8 9/9] Bluetooth: Add support for msbc coding format
Date:   Tue, 18 May 2021 16:12:32 +0530
Message-Id: <20210518104232.5431-9-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210518104232.5431-1-kiran.k@intel.com>
References: <20210518104232.5431-1-kiran.k@intel.com>
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
 net/bluetooth/hci_conn.c          | 24 ++++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 4e58d275c72c..817245d1046f 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -175,6 +175,7 @@ struct bt_codecs {
 
 #define CODING_FORMAT_CVSD	0x02
 #define CODING_FORMAT_TRANS	0x03
+#define CODING_FORMAT_MSBC	0x05
 
 __printf(1, 2)
 void bt_info(const char *fmt, ...);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index e2435b5abeca..edacf791d663 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -383,6 +383,30 @@ bool hci_enhanced_setup_sync(struct hci_conn *conn, __u16 handle)
 		cp.out_trasnport_unit_size = 1;
 		break;
 
+	case CODING_FORMAT_MSBC:
+		if (conn->attempt > ARRAY_SIZE(esco_param_msbc))
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
 	default:
 		return false;
 	}
-- 
2.17.1

