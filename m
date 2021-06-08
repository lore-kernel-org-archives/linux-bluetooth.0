Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9043DC4743E
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jun 2021 12:20:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79AAF61351
	for <linux-bluetooth@archiver.kernel.org>; Tue,  8 Jun 2021 12:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbhFHMWv (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Tue, 8 Jun 2021 08:22:51 -0400
Received: from mga11.intel.com ([192.55.52.93]:54897 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232547AbhFHMWv (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Tue, 8 Jun 2021 08:22:51 -0400
IronPort-SDR: uNg8fPT3Rh5pVRlYCuxxffRjbUvF82Si8cVCa2/3uv/sYWea2JCurA9HgFlFJ9h3dsE7SS8q8F
 u8mIuIi5QN4A==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="201811665"
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="201811665"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2021 05:20:56 -0700
IronPort-SDR: ygwOf6pUcckhc2HayX7tLuGNlXDp5I/WyH2gEF7vcuriCCG3KJukfkhyBV7Dt1EwB8n+TJPFsg
 9TwT699jssTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,258,1616482800"; 
   d="scan'208";a="619283473"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by orsmga005.jf.intel.com with ESMTP; 08 Jun 2021 05:20:55 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Kiran K <kiran.k@intel.com>
Subject: [PATCH v9 06/10] Bluetooth: Add a callback function to set data path
Date:   Tue,  8 Jun 2021 17:54:51 +0530
Message-Id: <20210608122455.19583-6-kiran.k@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210608122455.19583-1-kiran.k@intel.com>
References: <20210608122455.19583-1-kiran.k@intel.com>
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

In HFP offload usecase, Intel controllers require offload use
case id (NBS or WBS) to be set before opening SCO connection. Define
a new callback which gets called on setsockopt SCO socket. User space
audio module is expected to set codec via setsockopt(sk, BT_CODEC, ....)
before opening SCO connection.

Signed-off-by: Kiran K <kiran.k@intel.com>
Reviewed-by: Chethan T N <chethan.tumkur.narayan@intel.com>
Reviewed-by: Srivatsa Ravishankar <ravishankar.srivatsa@intel.com>
---
 include/net/bluetooth/hci_core.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 641477396da3..ad0024891447 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -618,6 +618,8 @@ struct hci_dev {
 	void (*cmd_timeout)(struct hci_dev *hdev);
 	bool (*prevent_wake)(struct hci_dev *hdev);
 	int (*get_data_path)(struct hci_dev *hdev);
+	int (*set_data_path)(struct hci_dev *hdev, __u8 type,
+			     struct bt_codec *codec);
 };
 
 #define HCI_PHY_HANDLE(handle)	(handle & 0xff)
-- 
2.17.1

