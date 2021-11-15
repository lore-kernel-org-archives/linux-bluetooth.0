Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 537A1C433EF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 06:43:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D94C63219
	for <linux-bluetooth@archiver.kernel.org>; Mon, 15 Nov 2021 06:43:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbhKOGqm (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 15 Nov 2021 01:46:42 -0500
Received: from mga02.intel.com ([134.134.136.20]:7180 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229733AbhKOGqj (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 15 Nov 2021 01:46:39 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10168"; a="220598221"
X-IronPort-AV: E=Sophos;i="5.87,235,1631602800"; 
   d="scan'208";a="220598221"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2021 22:43:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,235,1631602800"; 
   d="scan'208";a="453725950"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga003.jf.intel.com with ESMTP; 14 Nov 2021 22:43:42 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.von.dentz@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v3 03/13] Bluetooth: btintel: cache offload use case data
Date:   Mon, 15 Nov 2021 12:19:04 +0530
Message-Id: <20211115064914.2345-3-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211115064914.2345-1-kiran.k@intel.com>
References: <20211115064914.2345-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Keep a copy of use cases preset information in
driver data. Use cases preset data can be re-used
later instead of reading from controller every time.

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
 drivers/bluetooth/btintel.c | 6 ++++++
 drivers/bluetooth/btintel.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 8f9109b40961..c8c5c7007094 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2221,6 +2221,7 @@ static int btintel_configure_offload(struct hci_dev *hdev)
 	struct sk_buff *skb;
 	int err = 0;
 	struct intel_offload_use_cases *use_cases;
+	struct btintel_data *intel_data;
 
 	skb = __hci_cmd_sync(hdev, 0xfc86, 0, NULL, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
@@ -2241,10 +2242,15 @@ static int btintel_configure_offload(struct hci_dev *hdev)
 		goto error;
 	}
 
+	intel_data = hci_get_priv((hdev));
+
+	intel_data->use_cases = *use_cases;
+
 	if (use_cases->preset[0] & 0x03) {
 		hdev->get_data_path_id = btintel_get_data_path_id;
 		hdev->get_codec_config_data = btintel_get_codec_config_data;
 	}
+
 error:
 	kfree_skb(skb);
 	return err;
diff --git a/drivers/bluetooth/btintel.h b/drivers/bluetooth/btintel.h
index e500c0d7a729..091528d75256 100644
--- a/drivers/bluetooth/btintel.h
+++ b/drivers/bluetooth/btintel.h
@@ -158,6 +158,7 @@ enum {
 
 struct btintel_data {
 	DECLARE_BITMAP(flags, __INTEL_NUM_FLAGS);
+	struct intel_offload_use_cases use_cases;
 };
 
 #define btintel_set_flag(hdev, nr)					\
-- 
2.17.1

