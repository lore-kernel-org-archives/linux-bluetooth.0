Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC318CDB474
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Oct 2023 14:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377534AbjJTONr (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Oct 2023 10:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377530AbjJTONq (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Oct 2023 10:13:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73004D46
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Oct 2023 07:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697811224; x=1729347224;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Jq5lz68o6ZCwQcCpPIOUbVYd5NuT91qf36kzbJgwtXQ=;
  b=JenEjpcThpGiO7nnZ22zYSEVpc4Za8w0WXu/s9HYcMD/uiDA/Wk6ej68
   wiJzoEGZUrCmXMGfrjNBz6eI1qcaG/5a0QQLTAvGJ2O61Kxvgk3Iu151T
   WhQYK93UTU6nNmRjLb19+9e2NNBunuPSMGKR0+O7VrNmHhXQdrLTHRDsD
   pMxiM7JLz3MDv7eG6X1ucg9qncdcbFSw23VwFzrX/sc580M/uPyN1jYBI
   T2anpICQ3lwMt4JYyXdbZ340VU9n1KLoWtG5S18ugZL+ufaXFkqHQ295D
   MC3mW8tNCfPh6TeNlXvRJTDs4r0eabDUma+T7r9NoThn2L1YHF5Vgr/kT
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="365840874"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="365840874"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 07:13:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="1088756508"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="1088756508"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga005.fm.intel.com with ESMTP; 20 Oct 2023 07:13:43 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 3/5] bap: Do not set default location for sink and source
Date:   Fri, 20 Oct 2023 19:55:52 +0530
Message-Id: <20231020142554.486629-3-kiran.k@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020142554.486629-1-kiran.k@intel.com>
References: <20231020142554.486629-1-kiran.k@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

let the clients register the required location for source
and sink endpoints.
---
 src/shared/bap.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 2fd21b81b72d..5cb8b5aba659 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -474,9 +474,8 @@ static struct bt_pacs *pacs_new(struct gatt_db *db)
 
 	pacs = new0(struct bt_pacs, 1);
 
-	/* Set default values */
-	pacs->sink_loc_value = PACS_SNK_LOCATION;
-	pacs->source_loc_value = PACS_SRC_LOCATION;
+	pacs->sink_loc_value = 0;
+	pacs->source_loc_value = 0;
 	pacs->sink_context_value = PACS_SNK_CTXT;
 	pacs->source_context_value = PACS_SRC_CTXT;
 	pacs->supported_sink_context_value = PACS_SUPPORTED_SNK_CTXT;
-- 
2.34.1

