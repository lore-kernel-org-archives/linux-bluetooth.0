Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 801DAC0032E
	for <linux-bluetooth@archiver.kernel.org>; Fri, 20 Oct 2023 14:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377531AbjJTONp (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 20 Oct 2023 10:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377530AbjJTONo (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 20 Oct 2023 10:13:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B94B1A8
        for <linux-bluetooth@vger.kernel.org>; Fri, 20 Oct 2023 07:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697811223; x=1729347223;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aBVfpb1kYIWESCE+iWgnY0qK9+sW7PPcGg7TBzMu0OA=;
  b=RMgu5prW18gPLUD8oug2wZ1v1Woin56Orvvf0P2GhQDqFSilpKrjOYzQ
   U/p5TbLnq35E7TpQMT0KBxKKe9lAd5egM+BdI8ij+tjIIBRjkG3x9tGcq
   yDXHz8nWtoHmD6NGJ08OVgESSP1ZCGP6RvkBnOc/iA+rHfJesfzHoSKcc
   l8ydBcVH7+5PWnCgwYJv8qcNk2oT5FjSp8+B4LM7DL1SwOC7Enm7ghGK0
   apzwNxdN2u5c2Wa4goPRnh0XSIsPG0whTv7T49UP5r/NpkI2Zl9ctE5LZ
   Fux/gq409neBymxWSjYMttSHkks9v4HdxBPBn4WjH/u0iNmLQsxVWGTMZ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="365840862"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="365840862"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 07:13:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="1088756485"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="1088756485"
Received: from intel-lenovo-legion-y540-15irh-pg0.iind.intel.com ([10.224.186.95])
  by fmsmga005.fm.intel.com with ESMTP; 20 Oct 2023 07:13:41 -0700
From:   Kiran K <kiran.k@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, Kiran K <kiran.k@intel.com>
Subject: [PATCH v1 2/5] bap: Fix update of sink location value
Date:   Fri, 20 Oct 2023 19:55:51 +0530
Message-Id: <20231020142554.486629-2-kiran.k@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020142554.486629-1-kiran.k@intel.com>
References: <20231020142554.486629-1-kiran.k@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

pac->sink_loc needs to be updated only if there is a change.
---
 src/shared/bap.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/src/shared/bap.c b/src/shared/bap.c
index 925501c48d98..2fd21b81b72d 100644
--- a/src/shared/bap.c
+++ b/src/shared/bap.c
@@ -2491,13 +2491,11 @@ static void pacs_sink_location_changed(struct bt_pacs *pacs)
 
 static void pacs_add_sink_location(struct bt_pacs *pacs, uint32_t location)
 {
-	location |= pacs->sink_loc_value;
-
 	/* Check if location value needs updating */
 	if (location == pacs->sink_loc_value)
 		return;
 
-	pacs->sink_loc_value = location;
+	pacs->sink_loc_value |= location;
 
 	pacs_sink_location_changed(pacs);
 }
-- 
2.34.1

