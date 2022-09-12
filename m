Return-Path: <linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DE6AC6FA83
	for <linux-bluetooth@archiver.kernel.org>; Mon, 12 Sep 2022 12:45:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229789AbiILMpo (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 12 Sep 2022 08:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbiILMpl (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 12 Sep 2022 08:45:41 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DB913FAA
        for <linux-bluetooth@vger.kernel.org>; Mon, 12 Sep 2022 05:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662986737; x=1694522737;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ht6nn4WcjjYgyhJ/X9moFdKrEdk9j0FtChwAwCGQYEs=;
  b=e4YkT30Den98SQXDnxUNb65Gvnn/ga/C2yOqx9TX0R7ywtF87ztI/Jya
   cnhReslSCF7qjWjySw5ge223QHDokKcZMUvk1Qh1NxyR+OcShrB2RdF5P
   zccI7IYmWxD1H16Dar23h3NzYqwL/bQi12VN03OEGEhzNVh3YgrD3O8cV
   IKdemjJ2DEun+jyx9mCpv+qwoXT0qbastcclJaUPqcdotTFX15p9B+/Ep
   WCcRxM1mKMF0iBBYYDP6ut6lJ/CfhXlOTwRZbFj5RwsrXlwO1B4dC2TlK
   EDWD8/qfFGQOtO+zymTrdLYwu7n9AvYOLp+yUc4OiJMkXZeyKZfHFto8D
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10468"; a="361806042"
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="361806042"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2022 05:45:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,310,1654585200"; 
   d="scan'208";a="758382798"
Received: from bsblt022.iind.intel.com ([10.224.186.21])
  by fmsmga001.fm.intel.com with ESMTP; 12 Sep 2022 05:45:27 -0700
From:   Sathish Narasimman <sathish.narasimman@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     Sathish Narasimman <sathish.narasimman@intel.com>
Subject: [PATCH BlueZ 1/4] lib/uuid: Add VCS UUIDs
Date:   Mon, 12 Sep 2022 18:16:54 +0530
Message-Id: <20220912124657.404551-2-sathish.narasimman@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220912124657.404551-1-sathish.narasimman@intel.com>
References: <20220912124657.404551-1-sathish.narasimman@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This adds Volume Control Service UUIDs which will be used by
Volume Control Profile.
---
 lib/uuid.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/lib/uuid.h b/lib/uuid.h
index cb9294be8c6e..f667a74b9b73 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -164,6 +164,13 @@ extern "C" {
 #define ASE_SOURCE_UUID					0x2bc5
 #define ASE_CP_UUID					0x2bc6
 
+#define VCS_UUID					0x1844
+#define VOL_OFFSET_CS_UUID				0x1845
+#define AUDIO_INPUT_CS_UUID				0x1843
+#define VOL_STATE_CHRC_UUID				0x2B7D
+#define VOL_CP_CHRC_UUID				0x2B7E
+#define VOL_FLAG_CHRC_UUID				0x2B7F
+
 typedef struct {
 	enum {
 		BT_UUID_UNSPEC = 0,
-- 
2.25.1

