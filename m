Return-Path: <SRS0=ddeR=OI=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBC50C04EB9
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Nov 2018 23:24:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 96B022146D
	for <linux-bluetooth@archiver.kernel.org>; Thu, 29 Nov 2018 23:24:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B022146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-bluetooth-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726451AbeK3Kbi (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Fri, 30 Nov 2018 05:31:38 -0500
Received: from mga06.intel.com ([134.134.136.31]:51259 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbeK3Kbh (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Fri, 30 Nov 2018 05:31:37 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 29 Nov 2018 15:24:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,296,1539673200"; 
   d="scan'208";a="94275614"
Received: from han1-mac01.ra.intel.com (HELO fedora-linux.shared.localdomain) ([10.72.72.205])
  by orsmga007.jf.intel.com with ESMTP; 29 Nov 2018 15:24:25 -0800
From:   Tedd Ho-Jeong An <tedd.an@intel.com>
To:     linux-bluetooth@vger.kernel.org
Cc:     grzegorz.kolodziejczyk@codecoup.pl, ruslan.mstoi@intel.com
Subject: [PATCH] tools/btpclient: Fix compile warning with strncpy
Date:   Thu, 29 Nov 2018 15:24:26 -0800
Message-Id: <20181129232426.5027-1-tedd.an@intel.com>
X-Mailer: git-send-email 2.17.2
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

This patch fixes the boundry warning-to-error in GCC 8.1.1 with strncpy.
---
 tools/btpclient.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/btpclient.c b/tools/btpclient.c
index b217df58f..e77720ed1 100644
--- a/tools/btpclient.c
+++ b/tools/btpclient.c
@@ -376,8 +376,8 @@ static void btp_gap_read_info(uint8_t index, const void *param, uint16_t length,
 		goto failed;
 	}
 
-	strncpy((char *) rp.name, str, sizeof(rp.name));
-	strncpy((char *) rp.short_name, str, sizeof(rp.short_name));
+	snprintf((char *)rp.name, sizeof(rp.name), "%s", str);
+	snprintf((char *)rp.short_name, sizeof(rp.short_name), "%s", str);
 	rp.supported_settings = L_CPU_TO_LE32(adapter->supported_settings);
 	rp.current_settings = L_CPU_TO_LE32(adapter->current_settings);
 
-- 
2.17.2

