Return-Path: <linux-bluetooth-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494B1C41513
	for <linux-bluetooth@archiver.kernel.org>; Thu, 17 Aug 2023 11:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234565AbjHQLtA (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Thu, 17 Aug 2023 07:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350496AbjHQLsu (ORCPT
        <rfc822;linux-bluetooth@vger.kernel.org>);
        Thu, 17 Aug 2023 07:48:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A59F3583
        for <linux-bluetooth@vger.kernel.org>; Thu, 17 Aug 2023 04:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692272881; x=1723808881;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pD86HDDrLbJ3APR5EcjlOBLI2NkAfEKh8TjLysAoFr4=;
  b=BuRBkmvBUYS+mNtXOhxt3DvUaSEqPui3mpmE4SGSEckp8KBS4zDapk2O
   iH9AwX6gvWOk1pxmJOjLksJAVWDsY28fDf+G8Ct73MS7bVmh3Q3fCjPRp
   hHgwwoRV+pD7kYLMhdj/KhFYuasU3APkevdvlpDobjIQMkCeLwhYBNo2+
   PUqv7/KAjp77fqJhDCYtcJNCZaq2MiE4eVwE4sL6jZR1IWKDenZGZn8hV
   oUj6lsg/3qngpUSoMQ+d1/Vpl2k/istcBtebKgTQ3KNu4e95IuVMI0X0O
   BSHjWrHD9XSh3yr589ZvB+8lhfwJMnmKObWVFcW5UkTi1as+z4Gobr7Sz
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="436689482"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="436689482"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 04:48:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="734630081"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="734630081"
Received: from castle-black.iind.intel.com ([10.66.185.63])
  by orsmga002.jf.intel.com with ESMTP; 17 Aug 2023 04:47:58 -0700
From:   Lokendra Singh <lokendra.singh@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     ravishankar.srivatsa@intel.com, chethan.tumkur.narayan@intel.com,
        luiz.von.dentz@intel.com, tedd.an@intel.com, kiran.k@intel.com,
        Lokendra Singh <lokendra.singh@intel.com>
Subject: [PATCH v1] monitor/intel: Add decoding of PPAG Enable command
Date:   Thu, 17 Aug 2023 17:21:45 +0530
Message-Id: <20230817115144.76097-1-lokendra.singh@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

Add decoding support for Intel PPAG Enable
command.

btmon log:
< HCI Command: Intel PPAG Enable (0x3f|0x020b) plen 4
        Enable: 0x00000002 (China)
> HCI Event: Command Complete (0x0e) plen 4
      Intel PPAG Enable (0x3f|0x020b) ncmd 1
        Status: Success (0x00)

Signed-off-by: Lokendra Singh <lokendra.singh@intel.com>
---
 monitor/intel.c | 27 ++++++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/monitor/intel.c b/monitor/intel.c
index bdb95b7a79c0..dfd2a48bc29b 100644
--- a/monitor/intel.c
+++ b/monitor/intel.c
@@ -712,6 +712,29 @@ static void read_supported_features_rsp(uint16_t index, const void *data,
 	packet_hexdump(data + 3, size - 3);
 }
 
+static void ppag_enable(const void *data, uint8_t size)
+{
+	uint32_t enable = get_le32(data);
+	char *ppag_enable_flags;
+
+	switch (enable) {
+		case 0x01:
+			ppag_enable_flags = "EU";
+			break;
+		case 0x02:
+			ppag_enable_flags = "China";
+			break;
+		case 0x03:
+			ppag_enable_flags = "EU and China";
+			break;
+		default:
+			ppag_enable_flags = "Unknown";
+			break;
+	}
+
+	print_field("Enable: %s (0x%8.8x)", ppag_enable_flags, enable);
+}
+
 static const struct vendor_ocf vendor_ocf_table[] = {
 	{ 0x001, "Reset",
 			reset_cmd, 8, true,
@@ -777,7 +800,9 @@ static const struct vendor_ocf vendor_ocf_table[] = {
 	{ 0x0a6, "Read Supported Features",
 			read_supported_features_cmd, 1, true,
 			read_supported_features_rsp, 19, true },
-
+	{ 0x20b, "PPAG Enable",
+			ppag_enable, 4, true,
+			status_rsp, 1, true },
 	{ }
 };
 
-- 
2.25.1

