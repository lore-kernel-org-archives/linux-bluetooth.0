Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F228BC433F5
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 09:37:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB56561B1E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 19 Nov 2021 09:37:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbhKSJkH (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 19 Nov 2021 04:40:07 -0500
Received: from mga07.intel.com ([134.134.136.100]:62588 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232969AbhKSJkH (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 19 Nov 2021 04:40:07 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10172"; a="297804840"
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="297804840"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 01:37:05 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,246,1631602800"; 
   d="scan'208";a="594179358"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga002.fm.intel.com with ESMTP; 19 Nov 2021 01:37:03 -0800
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.von.dentz@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v2 4/9] adapter: API to check if MSFT a2dp codec is enabled
Date:   Fri, 19 Nov 2021 15:12:30 +0530
Message-Id: <20211119094235.2432-4-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211119094235.2432-1-kiran.k@intel.com>
References: <20211119094235.2432-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add an utility API to check if MSFT a2dp codec feature is
enabled in Kernel.
---
 src/adapter.c | 6 ++++++
 src/adapter.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/src/adapter.c b/src/adapter.c
index 1627cc127057..fd5ce614bec5 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -9796,6 +9796,12 @@ static void codec_offload_func(struct btd_adapter *adapter, uint8_t action)
 	btd_error(adapter->dev_id, "Failed to set Codec Offload");
 }
 
+bool is_msft_a2dp_offload_supported(struct btd_adapter *adapter)
+{
+	return queue_find(adapter->exps, is_exp_feature_uuid_the_same,
+			(void *)msft_a2dp_offload_codecs_uuid.val) != NULL;
+}
+
 static void msft_a2dp_offload_complete(uint8_t status, uint16_t len,
 				       const void *param, void *user_data)
 {
diff --git a/src/adapter.h b/src/adapter.h
index d191daf5dc12..3857126b4dff 100644
--- a/src/adapter.h
+++ b/src/adapter.h
@@ -261,3 +261,5 @@ bool btd_adapter_set_allowed_uuids(struct btd_adapter *adapter,
 							struct queue *uuids);
 bool btd_adapter_is_uuid_allowed(struct btd_adapter *adapter,
 							const char *uuid_str);
+
+bool is_msft_a2dp_offload_supported(struct btd_adapter *adapter);
-- 
2.17.1

