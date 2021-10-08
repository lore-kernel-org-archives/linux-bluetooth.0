Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C640C433FE
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 13:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03B836101E
	for <linux-bluetooth@archiver.kernel.org>; Fri,  8 Oct 2021 13:53:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235647AbhJHNzY (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 8 Oct 2021 09:55:24 -0400
Received: from mga18.intel.com ([134.134.136.126]:60420 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234337AbhJHNzW (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 8 Oct 2021 09:55:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10130"; a="213457764"
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; 
   d="scan'208";a="213457764"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2021 06:53:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,357,1624345200"; 
   d="scan'208";a="624744966"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga001.fm.intel.com with ESMTP; 08 Oct 2021 06:53:25 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.von.dentz@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 3/7] Bluetooth: btintel: cache offload use case data
Date:   Fri,  8 Oct 2021 19:28:49 +0530
Message-Id: <20211008135853.8604-3-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211008135853.8604-1-kiran.k@intel.com>
References: <20211008135853.8604-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Keep a copy of use cases preset information in
driver data. Use cases preset data can be re-used
later instead of reading from controller every time.

Signed-off-by: Kiran K <kiran.k@intel.com>
Change-Id: I4057eb3ce1412baf0f0ba1bb83bbe71aaefaf9fc
---
 drivers/bluetooth/btintel.c | 6 ++++++
 drivers/bluetooth/btintel.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 9359bff47296..f1431143eff5 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -2219,6 +2219,7 @@ static int btintel_configure_offload(struct hci_dev *hdev)
 	struct sk_buff *skb;
 	int err = 0;
 	struct intel_offload_use_cases *use_cases;
+	struct btintel_data *intel_data;
 
 	skb = __hci_cmd_sync(hdev, 0xfc86, 0, NULL, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
@@ -2239,10 +2240,15 @@ static int btintel_configure_offload(struct hci_dev *hdev)
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

