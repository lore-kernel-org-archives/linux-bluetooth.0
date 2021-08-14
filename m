Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A077FC432BE
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Aug 2021 07:22:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FC7460F51
	for <linux-bluetooth@archiver.kernel.org>; Sat, 14 Aug 2021 07:22:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237241AbhHNHWw (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Sat, 14 Aug 2021 03:22:52 -0400
Received: from mga04.intel.com ([192.55.52.120]:42835 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237240AbhHNHWs (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Sat, 14 Aug 2021 03:22:48 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10075"; a="213817674"
X-IronPort-AV: E=Sophos;i="5.84,321,1620716400"; 
   d="scan'208";a="213817674"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2021 00:22:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,321,1620716400"; 
   d="scan'208";a="640022056"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga005.jf.intel.com with ESMTP; 14 Aug 2021 00:22:19 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Kiran K <kiran.k@intel.com>
Subject: [PATCH v12 09/10] Bluetooth: Add support for msbc coding format
Date:   Sat, 14 Aug 2021 12:56:28 +0530
Message-Id: <20210814072629.11748-9-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210814072629.11748-1-kiran.k@intel.com>
References: <20210814072629.11748-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In Enhanced_Setup_Synchronous_Command, add support for msbc
coding format

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---

* changes in v12:
  - No change

* changes in v11:
  - Remove Kconfig

* changes on v10:
  - Fix typos and unwanted chunks

 include/net/bluetooth/bluetooth.h |  1 +
 net/bluetooth/hci_conn.c          | 25 +++++++++++++++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index f2df8bb108d9..c1fa90fb7502 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -175,6 +175,7 @@ struct bt_codecs {
 
 #define CODING_FORMAT_CVSD		0x02
 #define CODING_FORMAT_TRANSPARENT	0x03
+#define CODING_FORMAT_MSBC		0x05
 
 __printf(1, 2)
 void bt_info(const char *fmt, ...);
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 48943b01a356..95ffff4da885 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -328,6 +328,31 @@ static bool hci_enhanced_setup_sync_conn(struct hci_conn *conn, __u16 handle)
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
+		cp.in_transport_unit_size = 1;
+		cp.out_transport_unit_size = 1;
+		break;
 	case CODING_FORMAT_TRANSPARENT:
 		if (!find_next_esco_param(conn, esco_param_msbc,
 					  ARRAY_SIZE(esco_param_msbc)))
-- 
2.17.1

