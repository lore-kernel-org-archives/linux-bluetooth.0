Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F3AC07E9D
	for <linux-bluetooth@archiver.kernel.org>; Tue, 27 Sep 2022 22:55:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230185AbiI0Wza (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 27 Sep 2022 18:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiI0Wz3 (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 27 Sep 2022 18:55:29 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 790935A164
        for <linux-bluetooth@vger.kernel.org>; Tue, 27 Sep 2022 15:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664319327; x=1695855327;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NTRAptC/smVuJof5wj901qLP6v+A64VfyAxbA1gGSXM=;
  b=Jx2BwFN+mtjtbohx5Rs5DYBu/ypODM1qC+gcUMkq/Uin7WbbRlzta/nH
   eDkV6UJD/g4K9baN5ZrdB+g7ZRzM9Sno5ZisEiyRLIrlf19S7/ENJl9gL
   kazXJfJo8+YmAq+0iD6lzgGlxM5icVwBjDpsK31oon+H/5CMgKLHSDjSq
   eRotZof47BTCKUM53JvVvXqUhmmD/XU3TUojJWK55Lh5zy2Mk8gNroN+/
   hyJAfzXmZT5heVm2lVoWom4umGVVaH/tuSwnRi5ula/kkBJ5A9YDdQe1k
   f7WaH0Oqksc2nsV7+bt+DGav12jGDnBA4jlowEx4DfLS7R+nhl3uM4Vvz
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="284579886"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="284579886"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 15:55:25 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="690169766"
X-IronPort-AV: E=Sophos;i="5.93,350,1654585200"; 
   d="scan'208";a="690169766"
Received: from jlawton.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.209.172.226])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2022 15:55:24 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     brian.gix@intel.com, hj.tedd.an@gmail.com, tedd.an@intel.com
Subject: [PATCH BlueZ] tools: Fix mesh-tester to expect end of ADV
Date:   Tue, 27 Sep 2022 15:55:14 -0700
Message-Id: <20220927225514.278400-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Tester was failing by not clearing the HCI queue of expected events
---
 tools/mesh-tester.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tools/mesh-tester.c b/tools/mesh-tester.c
index 6781bd565..d7b3b6f9b 100644
--- a/tools/mesh-tester.c
+++ b/tools/mesh-tester.c
@@ -1345,6 +1345,10 @@ static const uint8_t send_mesh_cancel_2[] = {
 	0x02
 };
 
+static const uint8_t mesh_cancel_rsp_param_mesh[] = {
+	0x00
+};
+
 static const struct generic_data mesh_send_mesh_cancel_1 = {
 	.send_opcode = MGMT_OP_MESH_SEND_CANCEL,
 	.send_param = send_mesh_cancel_1,
@@ -1353,6 +1357,10 @@ static const struct generic_data mesh_send_mesh_cancel_1 = {
 	.expect_alt_ev = MGMT_EV_MESH_PACKET_CMPLT,
 	.expect_alt_ev_param = send_mesh_cancel_1,
 	.expect_alt_ev_len = sizeof(send_mesh_cancel_1),
+
+	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_ENABLE,
+	.expect_hci_param = mesh_cancel_rsp_param_mesh,
+	.expect_hci_len = sizeof(mesh_cancel_rsp_param_mesh),
 };
 
 static const struct generic_data mesh_send_mesh_cancel_2 = {
@@ -1363,6 +1371,10 @@ static const struct generic_data mesh_send_mesh_cancel_2 = {
 	.expect_alt_ev = MGMT_EV_MESH_PACKET_CMPLT,
 	.expect_alt_ev_param = send_mesh_cancel_2,
 	.expect_alt_ev_len = sizeof(send_mesh_cancel_2),
+
+	.expect_hci_command = BT_HCI_CMD_LE_SET_ADV_ENABLE,
+	.expect_hci_param = mesh_cancel_rsp_param_mesh,
+	.expect_hci_len = sizeof(mesh_cancel_rsp_param_mesh),
 };
 
 static void setup_multi_mesh_send(const void *test_data)
-- 
2.37.3

