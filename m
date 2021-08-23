Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD7EC4320A
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Aug 2021 21:57:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1EEE261262
	for <linux-bluetooth@archiver.kernel.org>; Mon, 23 Aug 2021 21:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232954AbhHWV6W (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 23 Aug 2021 17:58:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:48793 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232898AbhHWV6W (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 23 Aug 2021 17:58:22 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10085"; a="239330086"
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="239330086"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 14:57:39 -0700
X-IronPort-AV: E=Sophos;i="5.84,344,1620716400"; 
   d="scan'208";a="526284460"
Received: from yingliyu-mobl.amr.corp.intel.com (HELO bgi1-mobl2.amr.corp.intel.com) ([10.255.229.205])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2021 14:57:38 -0700
From:   Brian Gix <brian.gix@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     luiz.dentz@gmail.com, brian.gix@intel.com,
        luiz.von.dentz@intel.com, hj.tedd.an@gmail.com
Subject: [PATCH] bluetooth: mgmt: Disallow legacy MGMT_OP_READ_LOCAL_OOB_EXT_DATA
Date:   Mon, 23 Aug 2021 14:57:29 -0700
Message-Id: <20210823215729.87837-1-brian.gix@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Legacy (v2.0) controllers do not support Extended OOB Data used by SSP.

Signed-off-by: Brian Gix <brian.gix@intel.com>
---
 net/bluetooth/mgmt.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1e21e014efd2..77ea94403cd6 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -7315,6 +7315,11 @@ static int read_local_oob_ext_data(struct sock *sk, struct hci_dev *hdev,
 	if (!rp)
 		return -ENOMEM;
 
+	if (!status && !lmp_ssp_capable(hdev)) {
+		status = MGMT_STATUS_NOT_SUPPORTED;
+		eir_len = 0;
+	}
+
 	if (status)
 		goto complete;
 
-- 
2.31.1

